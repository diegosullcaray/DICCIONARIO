#!/usr/bin/env python3
"""Herramientas de base de datos del DICCIONARIO.

    python extraccion/herramientas/bd.py probar                              # ¿llego a los 3 servidores?
    python extraccion/herramientas/bd.py extraer [--base mod_rep] [--sp GSREVA01] [--reporte SEL_JEFE_01] [--sobrescribir]
    python extraccion/herramientas/bd.py dependencias [--base mod_rep]       # motor → extraccion/fuente/dependencias/<base>.csv
    python extraccion/herramientas/bd.py estructura [--base storage]         # tipos reales → extraccion/fuente/estructura/<base>.csv
    python extraccion/herramientas/bd.py todo [--base mod_rep]               # extraer + generar + dependencias + estructura + generar
    python extraccion/herramientas/bd.py generar                             # npm run generar (Node)
    python extraccion/herramientas/bd.py estado                              # avance, sin conectarse
    python extraccion/herramientas/bd.py mapa --reporte SEL_EFEC_01 | --sp GSELREP001 | --tabla WCED001 | --columna HFCRES

Opciones globales: --env <ruta al .env> (por defecto, el de la raíz de DICCIONARIO).
Todo es de solo lectura contra SQL Server.
"""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from diccionario_bd import catalogo, config, mapa  # noqa: E402


def cmd_probar(_a) -> int:
    from diccionario_bd.db import probar_conexiones

    ok = True
    for nombre, estado in probar_conexiones().items():
        print(f"  {nombre:<5} {estado}")
        ok &= estado.startswith("OK")
    return 0 if ok else 1


def cmd_extraer(a) -> int:
    from diccionario_bd.extraccion import extraer

    sps = catalogo.filtrar(catalogo.cargar(), a.base, a.sp, a.reporte)
    if not sps:
        print("Ningún SP del catálogo coincide con el filtro.")
        return 1
    pendientes = [p for p in sps if a.sobrescribir or not p.extraido]
    print(f"Extrayendo {len(pendientes)} de {len(sps)} SP{' (sobrescribiendo)' if a.sobrescribir else ' (solo pendientes)'}…")
    r = extraer(sps, a.sobrescribir)
    for titulo, lista in (("Escritos", r.escritos), ("Sin cambios", r.sin_cambios), ("No existen en la base", r.no_existen),
                          ("Sin definición (cifrados o sin VIEW DEFINITION)", r.sin_definicion), ("Errores", r.errores)):
        if lista:
            print(f"{titulo}: {len(lista)}")
            for x in lista[:30]:
                print(f"   · {x}")
            if len(lista) > 30:
                print(f"   … y {len(lista) - 30} más")
    return 1 if r.errores else 0


def cmd_dependencias(a) -> int:
    from diccionario_bd.dependencias import bases_disponibles, obtener

    codigo = 0
    for base in [a.base] if a.base else bases_disponibles():
        try:
            filas, con_error = obtener(base)
            print(f"  {base:<10} {filas} fila(s) → extraccion/fuente/dependencias/{base}.csv" + (f" · {con_error} SP con error del motor" if con_error else ""))
        except Exception as exc:  # noqa: BLE001
            print(f"  {base:<10} ERROR: {type(exc).__name__}: {str(exc)[:160]}")
            codigo = 1
    return codigo


def cmd_estructura(a) -> int:
    from diccionario_bd.estructura import obtener, tablas_por_base

    codigo = 0
    for base, tablas in tablas_por_base().items():
        if a.base and base != a.base.lower():
            continue
        try:
            existen = obtener(base, tablas)
            print(f"  {base:<10} {existen}/{len(tablas)} tabla(s) encontradas → extraccion/fuente/estructura/{base}.csv")
        except Exception as exc:  # noqa: BLE001
            print(f"  {base:<10} ERROR: {type(exc).__name__}: {str(exc)[:160]}")
            codigo = 1
    return codigo


def cmd_generar(_a) -> int:
    npm = shutil.which("npm")
    if not npm:
        print("No se encontró npm/Node 20+: instalarlo para generar el diccionario.")
        return 1
    return subprocess.call([npm, "run", "-s", "generar"], cwd=config.RAIZ)


def cmd_todo(a) -> int:
    pasos = [("Extraer cuerpos", cmd_extraer), ("Generar", cmd_generar), ("Dependencias del motor", cmd_dependencias),
             ("Generar", cmd_generar), ("Estructura de tablas", cmd_estructura), ("Generar", cmd_generar)]
    codigo = 0
    for titulo, paso in pasos:
        print(f"\n== {titulo}")
        codigo |= paso(a)
    return codigo


def cmd_estado(_a) -> int:
    sps = catalogo.cargar()
    por_base: dict[str, list] = {}
    for p in sps.values():
        por_base.setdefault(p.base or "-", []).append(p)
    print(f"{'base':<10} {'servidor':<9} {'SP':>4} {'extraídos':>10}")
    for base, lista in sorted(por_base.items()):
        try:
            srv = config.servidor_de_base(base)
        except config.ConfiguracionError:
            srv = "?"
        print(f"{base:<10} {srv:<9} {len(lista):>4} {sum(p.extraido for p in lista):>10}")
    return 0


def cmd_mapa(a) -> int:
    d = mapa.cargar()
    if a.reporte:
        lineas = mapa.de_reporte(d, a.reporte)
    elif a.sp:
        lineas = mapa.de_procedimiento(d, a.sp)
    elif a.tabla:
        lineas = mapa.de_tabla(d, a.tabla)
    elif a.columna:
        lineas = mapa.de_columna(d, a.columna)
    else:
        print("Indicar --reporte, --sp, --tabla o --columna")
        return 1
    print("\n".join(lineas))
    return 0


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--env", help="ruta al .env con MISH_*, SLC_*, RCC_* (por defecto .env en la raíz o DICCIONARIO_ENV)")
    sub = ap.add_subparsers(dest="comando", required=True)
    filtros = argparse.ArgumentParser(add_help=False)
    filtros.add_argument("--base")
    filtros.add_argument("--sp")
    filtros.add_argument("--reporte")
    filtros.add_argument("--sobrescribir", action="store_true")
    sub.add_parser("probar").set_defaults(f=cmd_probar)
    sub.add_parser("extraer", parents=[filtros]).set_defaults(f=cmd_extraer)
    sub.add_parser("dependencias", parents=[filtros]).set_defaults(f=cmd_dependencias)
    sub.add_parser("estructura", parents=[filtros]).set_defaults(f=cmd_estructura)
    sub.add_parser("todo", parents=[filtros]).set_defaults(f=cmd_todo)
    sub.add_parser("generar").set_defaults(f=cmd_generar)
    sub.add_parser("estado").set_defaults(f=cmd_estado)
    m = sub.add_parser("mapa")
    for opcion in ("--reporte", "--sp", "--tabla", "--columna"):
        m.add_argument(opcion)
    m.set_defaults(f=cmd_mapa)

    a = ap.parse_args(argv)
    if a.comando not in ("estado", "mapa", "generar"):
        try:
            usado = config.cargar_entorno(a.env)
            print(f"Entorno: {usado if usado else '(variables del sistema)'}")
        except config.ConfiguracionError as exc:
            print(f"✗ {exc}")
            return 2
    try:
        return a.f(a)
    except config.ConfiguracionError as exc:
        print(f"✗ {exc}")
        return 2


if __name__ == "__main__":
    sys.exit(main())
