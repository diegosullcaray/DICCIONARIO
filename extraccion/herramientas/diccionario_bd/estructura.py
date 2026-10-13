"""Estructura real de las tablas que usan los SP: tipo, largo y nulabilidad de cada columna.

Lee las tablas de diccionario/diccionario.json (las descubre el analizador y el motor), consulta
INFORMATION_SCHEMA.COLUMNS en el servidor de cada base y guarda extraccion/fuente/estructura/<base>.csv.
Con eso el generador muestra el tipo de cada columna y detecta columnas o tablas que no existen.
"""

from __future__ import annotations

import csv
import io
import json
from collections import defaultdict

from .config import DIR_DICCIONARIO, DIR_FUENTE, servidor_de_base
from .db import conexion, consultar

COLUMNAS = ["base", "esquema", "tabla", "tipo_objeto", "orden", "columna", "tipo", "largo", "precision", "escala", "acepta_nulos"]

SQL = """
SELECT DB_NAME() AS base, t.TABLE_SCHEMA AS esquema, t.TABLE_NAME AS tabla, t.TABLE_TYPE AS tipo_objeto,
       c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision, c.NUMERIC_SCALE AS escala,
       c.IS_NULLABLE AS acepta_nulos
FROM INFORMATION_SCHEMA.TABLES t
JOIN INFORMATION_SCHEMA.COLUMNS c ON c.TABLE_SCHEMA = t.TABLE_SCHEMA AND c.TABLE_NAME = t.TABLE_NAME
WHERE {filtro}
ORDER BY t.TABLE_SCHEMA, t.TABLE_NAME, c.ORDINAL_POSITION
"""


def tablas_por_base() -> dict[str, list[tuple[str, str]]]:
    datos = json.loads((DIR_DICCIONARIO / "diccionario.json").read_text(encoding="utf-8"))
    salida: dict[str, set[tuple[str, str]]] = defaultdict(set)
    for t in datos["tablas"]:
        partes = t["nombre"].split(".")
        if len(partes) != 3:   # linked server (4 partes) u otra forma: fuera de alcance
            continue
        base, esquema, tabla = partes
        salida[base.lower()].add((esquema, tabla))
    return {b: sorted(v) for b, v in sorted(salida.items())}


def a_csv(filas: list[dict]) -> str:
    salida = io.StringIO()
    w = csv.DictWriter(salida, fieldnames=COLUMNAS, extrasaction="ignore", lineterminator="\n")
    w.writeheader()
    for f in filas:
        w.writerow({k: "" if f.get(k) is None else f[k] for k in COLUMNAS})
    return salida.getvalue()


def obtener(base: str, tablas: list[tuple[str, str]], conectar=conexion, tramo: int = 500) -> int:
    """Devuelve cuántas de las tablas pedidas existen. Pide de a `tramo` tablas (límite de 2100 parámetros)."""
    filas: list[dict] = []
    with conectar(servidor_de_base(base), base) as conn:
        for i in range(0, len(tablas), tramo):
            parte = tablas[i:i + tramo]
            filtro = " OR ".join("(t.TABLE_SCHEMA = ? AND t.TABLE_NAME = ?)" for _ in parte)
            filas += consultar(conn, SQL.format(filtro=filtro), *[x for par in parte for x in par])
    destino = DIR_FUENTE / "estructura" / f"{base}.csv"
    destino.parent.mkdir(parents=True, exist_ok=True)
    destino.write_text(a_csv(filas), encoding="utf-8", newline="")
    return len({(f["esquema"], f["tabla"]) for f in filas})
