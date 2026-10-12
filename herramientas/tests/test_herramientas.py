"""Pruebas sin servidor: una conexión simulada responde como pyodbc.

    python -m unittest discover -s herramientas/tests -t herramientas
"""

from __future__ import annotations

import csv
import io
import sys
import tempfile
import unittest
from contextlib import contextmanager
from datetime import datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from diccionario_bd import catalogo, config, dependencias, estructura, extraccion  # noqa: E402
from diccionario_bd.db import consultar, partir_lotes  # noqa: E402


class CursorFalso:
    def __init__(self, respuesta):
        self.respuesta = respuesta
        self.ejecutado: list[tuple] = []
        self.description = None
        self._filas = []

    def execute(self, sql, *params):
        self.ejecutado.append((sql, params))
        filas = self.respuesta(sql, params)
        if filas is None:
            self.description = None
            self._filas = []
        else:
            columnas = list(filas[0].keys()) if filas else ["x"]
            self.description = [(c,) for c in columnas]
            self._filas = [tuple(f[c] for c in columnas) for f in filas]

    def fetchall(self):
        return self._filas

    def nextset(self):
        return False

    def close(self):
        pass


class ConexionFalsa:
    def __init__(self, respuesta):
        self.cursores: list[CursorFalso] = []
        self.respuesta = respuesta

    def cursor(self):
        c = CursorFalso(self.respuesta)
        self.cursores.append(c)
        return c


def conectar_falso(respuesta, registro: list):
    @contextmanager
    def conectar(servidor, base=None, timeout=15):
        registro.append((servidor, base))
        yield ConexionFalsa(respuesta)
    return conectar


CUERPO = "CREATE PROCEDURE [com].[GSELREP002] @codmod int AS\r\nSELECT a.COD FROM storage.dbo.JEFES a\r\n"


class TestCatalogo(unittest.TestCase):
    def test_partes_nombre_quita_corchetes_y_espacios(self):
        self.assertEqual(catalogo.partes_nombre("[mod_rep].[com].[GCMGMORA001] "), ["mod_rep", "com", "GCMGMORA001"])
        self.assertEqual(catalogo.partes_nombre("mod_rep.[rep].[A.B]"), ["mod_rep", "rep", "A.B"])

    def test_catalogo_real_agrupa_por_sp(self):
        sps = catalogo.cargar()
        self.assertEqual(len(sps), 271)
        self.assertIn("SEL_EFEC_01", sps["mod_rep.com.gselrep001"].reportes)
        self.assertEqual(catalogo.filtrar(sps, reporte="sel_jefe_01")[0].nombre, "GSELREP002")

    def test_todas_las_bases_del_catalogo_tienen_servidor(self):
        for sp in catalogo.cargar().values():
            self.assertEqual(config.servidor_de_base(sp.base), "mish", sp.completo)


class TestConfig(unittest.TestCase):
    def test_sin_servidor_en_env_falla_claro(self):
        import os
        os.environ.pop("MISH_SERVER", None)
        with self.assertRaisesRegex(config.ConfiguracionError, "MISH_SERVER"):
            config.SERVIDORES["mish"].cadena_odbc("mod_rep")

    def test_cadena_windows_y_sql(self):
        import os
        os.environ.update(MISH_SERVER="srv-prueba", RCC_SERVER="srv-rcc", RCC_USER="u", RCC_PASSWORD="p}x")
        os.environ.pop("MISH_USER", None); os.environ.pop("MISH_PASSWORD", None)
        self.assertIn("Trusted_Connection=yes", config.SERVIDORES["mish"].cadena_odbc("mod_rep"))
        self.assertIn("DATABASE=mod_rep", config.SERVIDORES["mish"].cadena_odbc("mod_rep"))
        self.assertIn("PWD={p}}x}", config.SERVIDORES["rcc"].cadena_odbc())
        os.environ.pop("RCC_PASSWORD")
        with self.assertRaises(config.ConfiguracionError):
            config.SERVIDORES["rcc"].cadena_odbc()


class TestExtraccion(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.original = catalogo.DIR_PROCEDIMIENTOS
        catalogo.DIR_PROCEDIMIENTOS = Path(self.tmp.name)

    def tearDown(self):
        catalogo.DIR_PROCEDIMIENTOS = self.original
        self.tmp.cleanup()

    def test_escribe_cuerpo_informa_inexistentes_y_es_idempotente(self):
        sps = [catalogo.Procedimiento("mod_rep", "com", "GSELREP002"), catalogo.Procedimiento("mod_rep", "com", "NO_EXISTE")]
        respuesta = lambda sql, params: [{"esquema": "com", "nombre": "GSELREP002", "modificado": datetime(2026, 9, 1), "definicion": CUERPO}]
        conexiones: list = []
        r = extraccion.extraer(sps, conectar=conectar_falso(respuesta, conexiones))
        self.assertEqual(conexiones, [("mish", "mod_rep")])        # una conexión por base, al servidor correcto
        self.assertEqual(r.escritos, ["mod_rep.com.GSELREP002"])
        self.assertEqual(r.no_existen, ["mod_rep.com.NO_EXISTE"])
        texto = sps[0].archivo.read_text(encoding="utf-8")
        self.assertTrue(texto.startswith("-- Extraído de mish/mod_rep"))
        self.assertNotIn("\r", texto)
        self.assertTrue(sps[0].extraido)
        # Segunda vez: ya extraído → no se pide; con sobrescribir y mismo cuerpo → sin cambios.
        r2 = extraccion.extraer(sps[:1], conectar=conectar_falso(respuesta, conexiones))
        self.assertEqual((r2.escritos, r2.sin_cambios), ([], []))
        r3 = extraccion.extraer(sps[:1], sobrescribir=True, conectar=conectar_falso(respuesta, conexiones))
        self.assertEqual(r3.sin_cambios, ["mod_rep.com.GSELREP002"])

    def test_definicion_nula_es_cifrado_o_sin_permiso(self):
        sps = [catalogo.Procedimiento("mod_rep", "com", "CIFRADO")]
        respuesta = lambda sql, params: [{"esquema": "com", "nombre": "CIFRADO", "modificado": None, "definicion": None}]
        r = extraccion.extraer(sps, conectar=conectar_falso(respuesta, []))
        self.assertEqual(r.sin_definicion, ["mod_rep.com.CIFRADO"])
        self.assertFalse(sps[0].archivo.exists())

    def test_error_de_una_base_no_corta_las_demas(self):
        @contextmanager
        def conectar(servidor, base=None, timeout=15):
            if base == "mod_gpa":
                raise RuntimeError("login failed")
            yield ConexionFalsa(lambda s, p: [])
        sps = [catalogo.Procedimiento("mod_gpa", "vac", "A"), catalogo.Procedimiento("mod_rep", "com", "B")]
        r = extraccion.extraer(sps, conectar=conectar)
        self.assertEqual(len(r.errores), 1)
        self.assertEqual(r.no_existen, ["mod_rep.com.B"])


class TestDependenciasYEstructura(unittest.TestCase):
    def test_partir_lotes_por_go(self):
        self.assertEqual(len(partir_lotes("USE mod_rep;\nGO\nSELECT 1\n  go  -- fin\nSELECT 2")), 3)

    def test_csv_de_dependencias_lo_lee_el_generador(self):
        texto = dependencias.a_csv([{"sp_base": "mod_rep", "sp_esquema": "com", "sp_nombre": "X", "ref_columna": None,
                                     "es_lectura": True, "origen": "dm_sql_referenced_entities", "error": None}])
        filas = list(csv.DictReader(io.StringIO(texto)))
        self.assertEqual(filas[0]["es_lectura"], "1")     # el importador de Node compara con '1'
        self.assertEqual(filas[0]["ref_columna"], "")
        self.assertEqual(list(filas[0].keys()), dependencias.COLUMNAS)

    def test_estructura_pide_por_tramos(self):
        tablas = [("dbo", f"T{i}") for i in range(7)]
        llamadas: list = []

        def respuesta(sql, params):
            llamadas.append(len(params))
            return [{"base": "storage", "esquema": "dbo", "tabla": params[1], "tipo_objeto": "BASE TABLE", "orden": 1,
                     "columna": "C", "tipo": "int", "largo": None, "precision": 10, "escala": 0, "acepta_nulos": "NO"}]
        tmp = tempfile.TemporaryDirectory()
        original = estructura.DIR_FUENTE
        estructura.DIR_FUENTE = Path(tmp.name)
        try:
            existen = estructura.obtener("storage", tablas, conectar=conectar_falso(respuesta, []), tramo=3)
        finally:
            estructura.DIR_FUENTE = original
            tmp.cleanup()
        self.assertEqual(llamadas, [6, 6, 2])
        self.assertEqual(existen, 3)

    def test_consultar_devuelve_dicts(self):
        conn = ConexionFalsa(lambda s, p: [{"a": 1, "b": "x"}])
        self.assertEqual(consultar(conn, "SELECT ?", 1), [{"a": 1, "b": "x"}])


class TestReglas(unittest.TestCase):
    def test_conexion_solo_en_db(self):
        raiz = Path(__file__).resolve().parents[1] / "diccionario_bd"
        for archivo in raiz.glob("*.py"):
            if archivo.name != "db.py":
                self.assertNotIn("pyodbc.connect", archivo.read_text(encoding="utf-8"), archivo.name)


if __name__ == "__main__":
    unittest.main()
