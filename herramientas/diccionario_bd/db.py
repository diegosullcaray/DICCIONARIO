"""Único lugar que abre conexiones a SQL Server (regla `conexion-solo-en-db`, igual que en REPORTES-AUTOMATIZADOS).

Solo lectura: las conexiones piden ApplicationIntent=ReadOnly y ningún módulo ejecuta DML.
"""

from __future__ import annotations

import re
from contextlib import closing, contextmanager
from typing import Any, Iterator

from .config import ConfiguracionError, obtener_servidor


@contextmanager
def conexion(servidor: str, base: str | None = None, timeout: int = 15) -> Iterator[Any]:
    try:
        import pyodbc  # import local: el resto del paquete (y sus pruebas) funciona sin el driver
    except ImportError as exc:
        raise ConfiguracionError("Falta pyodbc: pip install -r herramientas/requirements.txt (y ODBC Driver 17)") from exc
    with closing(pyodbc.connect(obtener_servidor(servidor).cadena_odbc(base), autocommit=True, timeout=timeout)) as conn:
        yield conn


def filas(cursor) -> list[dict]:
    columnas = [c[0] for c in cursor.description]
    return [dict(zip(columnas, f)) for f in cursor.fetchall()]


def consultar(conn, sql: str, *params) -> list[dict]:
    """Una consulta parametrizada (`?`) → lista de dicts. Devuelve el último conjunto de resultados."""
    with closing(conn.cursor()) as cursor:
        cursor.execute(sql, *params)
        resultado: list[dict] = []
        while True:
            if cursor.description:
                resultado = filas(cursor)
            if not cursor.nextset():
                break
        return resultado


def partir_lotes(sql: str) -> list[str]:
    """Separa un script por las líneas `GO` (separador de SSMS, no T-SQL)."""
    return [b for b in re.split(r"(?im)^\s*GO\s*(?:--.*)?$", sql) if b.strip()]


def ejecutar_script(conn, sql: str) -> list[dict]:
    """Ejecuta un script con `GO` en una sola sesión y devuelve el último conjunto de resultados."""
    resultado: list[dict] = []
    with closing(conn.cursor()) as cursor:
        for lote in partir_lotes(sql):
            cursor.execute(lote)
            while True:
                if cursor.description:
                    resultado = filas(cursor)
                if not cursor.nextset():
                    break
    return resultado


def probar_conexiones() -> dict[str, str]:
    estado = {}
    from .config import SERVIDORES

    for nombre in SERVIDORES:
        try:
            with conexion(nombre, timeout=5) as conn:
                fila = consultar(conn, "SELECT @@VERSION AS v")[0]
            estado[nombre] = "OK · " + str(fila["v"]).splitlines()[0][:60]
        except Exception as exc:  # noqa: BLE001 - diagnóstico
            estado[nombre] = f"ERROR: {type(exc).__name__}: {str(exc)[:120]}"
    return estado
