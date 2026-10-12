"""Consultas al diccionario ya generado (diccionario/diccionario.json), sin conectarse a la base.

Responde: qué tablas y columnas usa un SP o un reporte, y qué SP/reportes usan una tabla o columna.
"""

from __future__ import annotations

import json

from .config import DIR_DICCIONARIO


def cargar() -> dict:
    return json.loads((DIR_DICCIONARIO / "diccionario.json").read_text(encoding="utf-8"))


def _sp(d: dict, nombre: str) -> list[dict]:
    n = nombre.lower()
    return [p for p in d["procedimientos"] if p["nombre"].lower() == n or p["nombre"].lower().endswith("." + n)]


def de_procedimiento(d: dict, nombre: str) -> list[str]:
    salida = []
    for p in _sp(d, nombre):
        salida.append(f"{p['nombre']}  [{p['estado']}]  reportes: {', '.join(p['reportes'])}")
        if p["estado"] == "pendiente":
            salida.append("   sin cuerpo: python herramientas/bd.py extraer --sp " + p["nombre"].split(".")[-1])
            continue
        for t in p["tablas"]:
            cols = ", ".join(f"{c['nombre']}({c['confianza']})" for c in t["columnas"]) or "—"
            salida.append(f"   {t['nombre']}  [{', '.join(t['usos']) or '—'}]  {cols}")
        if p.get("invoca"):
            salida.append(f"   invoca: {', '.join(p['invoca'])}")
        for i, cols in enumerate(p.get("resultados") or [], 1):
            salida.append(f"   devuelve{f' ({i})' if len(p['resultados']) > 1 else ''}: {', '.join(cols)}")
    return salida or [f"No hay un SP '{nombre}' en el catálogo"]


def de_reporte(d: dict, codigo: str) -> list[str]:
    r = [x for x in d["reportes"] if x["codigo"].upper() == codigo.upper()]
    if not r:
        return [f"No hay un reporte '{codigo}' en el catálogo"]
    salida = [f"{codigo} → {r[0]['procedimiento']}  params: {', '.join(r[0]['parametros']) or '—'}"]
    if r[0]["front"]:
        salida.append(f"   front: {'; '.join(r[0]['front'])}")
    return salida + de_procedimiento(d, r[0]["procedimiento"])


def de_tabla(d: dict, nombre: str) -> list[str]:
    n = nombre.lower()
    ts = [t for t in d["tablas"] if t["nombre"].lower() == n or t["nombre"].lower().endswith("." + n)]
    salida = []
    for t in ts:
        salida.append(f"{t['nombre']}  usada por {len(t['procedimientos'])} SP")
        for c in t["columnas"]:
            salida.append(f"   {c['nombre']:<30} {c['confianza']:<10} {', '.join(c['procedimientos'])}")
    return salida or [f"Ninguna tabla '{nombre}' en el diccionario (¿falta extraer los SP que la usan?)"]


def de_columna(d: dict, columna: str) -> list[str]:
    salida = []
    for t in d["tablas"]:
        for c in t["columnas"]:
            if c["nombre"].lower() == columna.lower():
                salida.append(f"{t['nombre']}.{c['nombre']}  ({c['confianza']})  ← {', '.join(c['procedimientos'])}")
    return salida or [f"Ninguna columna '{columna}' en el diccionario"]
