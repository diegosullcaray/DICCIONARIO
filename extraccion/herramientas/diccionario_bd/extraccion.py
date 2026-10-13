"""Baja el cuerpo (CREATE PROCEDURE) de los SP del catálogo a extraccion/procedimientos/<base>/<esquema>/<SP>.sql.

Usa OBJECT_DEFINITION, que a diferencia de sp_helptext no corta líneas de más de 255 caracteres.
Una conexión por base; en cada base, una sola consulta para todos sus SP.
"""

from __future__ import annotations

from dataclasses import dataclass
from datetime import date
from itertools import groupby

from .catalogo import Procedimiento, es_cuerpo_real
from .config import servidor_de_base
from .db import conexion, consultar

SQL_DEFINICIONES = """
SELECT s.name AS esquema, o.name AS nombre, o.modify_date AS modificado, OBJECT_DEFINITION(o.object_id) AS definicion
FROM sys.objects o
JOIN sys.schemas s ON s.schema_id = o.schema_id
WHERE o.type IN ('P', 'PC') AND o.object_id IN ({marcadores})
"""


@dataclass
class ResultadoExtraccion:
    escritos: list[str]
    sin_cambios: list[str]
    no_existen: list[str]
    sin_definicion: list[str]   # cifrados (WITH ENCRYPTION) o sin permiso VIEW DEFINITION
    errores: list[str]


def cabecera(servidor: str, base: str, modificado) -> str:
    # Solo el alias de la conexión (mish/slc/rcc), nunca el host: el repositorio no versiona servidores.
    return f"-- Extraído de {servidor}/{base} el {date.today():%Y-%m-%d} con extraccion/herramientas/bd.py · modificado en la base: {modificado}\n"


def normalizar(definicion: str) -> str:
    return definicion.replace("\r\n", "\n").replace("\r", "\n").rstrip() + "\n"


def cuerpo_sin_cabecera(texto: str) -> str:
    lineas = texto.replace("\r\n", "\n").split("\n")
    if lineas and lineas[0].startswith("-- Extraído de "):
        lineas = lineas[1:]
    return "\n".join(lineas).rstrip() + "\n"


def extraer(procedimientos: list[Procedimiento], sobrescribir: bool = False, conectar=conexion) -> ResultadoExtraccion:
    r = ResultadoExtraccion([], [], [], [], [])
    pendientes = [p for p in procedimientos if sobrescribir or not p.extraido]
    clave_base = lambda p: (p.base or "").lower()  # noqa: E731
    for base, grupo in groupby(sorted(pendientes, key=clave_base), key=clave_base):
        grupo = list(grupo)
        try:
            servidor = servidor_de_base(base)
            with conectar(servidor, base) as conn:
                objetos = [f"{p.esquema}.{p.nombre}" for p in grupo]
                marcadores = ", ".join("OBJECT_ID(?)" for _ in objetos)
                filas = consultar(conn, SQL_DEFINICIONES.format(marcadores=marcadores), *objetos)
        except Exception as exc:  # noqa: BLE001 - se informa por base y se sigue con las demás
            r.errores.append(f"{base}: {type(exc).__name__}: {str(exc)[:200]}")
            continue
        por_nombre = {(f["esquema"].lower(), f["nombre"].lower()): f for f in filas}
        for p in grupo:
            fila = por_nombre.get((p.esquema.lower(), p.nombre.lower()))
            if fila is None:
                r.no_existen.append(p.completo)
                continue
            if not fila["definicion"]:
                r.sin_definicion.append(p.completo)
                continue
            cuerpo = normalizar(fila["definicion"])
            if not es_cuerpo_real(cuerpo):
                r.sin_definicion.append(p.completo)
                continue
            if p.archivo.exists() and cuerpo_sin_cabecera(p.archivo.read_text(encoding="utf-8")) == cuerpo:
                r.sin_cambios.append(p.completo)
                continue
            p.archivo.parent.mkdir(parents=True, exist_ok=True)
            p.archivo.write_text(cabecera(servidor, base, fila["modificado"]) + cuerpo, encoding="utf-8", newline="\n")
            r.escritos.append(p.completo)
    return r
