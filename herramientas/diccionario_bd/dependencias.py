"""Ejecuta sql/02-dependencias/<base>.sql (generado por npm run generar) y guarda fuente/dependencias/<base>.csv.

Es lo mismo que correrlo en SSMS y "Guardar resultados como…", pero sin pasos manuales.
"""

from __future__ import annotations

import csv
import io

from .config import DIR_FUENTE, DIR_SQL, ConfiguracionError, servidor_de_base
from .db import conexion, ejecutar_script

COLUMNAS = ["sp_base", "sp_esquema", "sp_nombre", "ref_servidor", "ref_base", "ref_esquema", "ref_entidad",
            "ref_columna", "ref_tipo", "ref_objeto_tipo", "es_lectura", "es_escritura", "es_select_todo", "origen", "error"]


def a_csv(filas: list[dict]) -> str:
    salida = io.StringIO()
    w = csv.DictWriter(salida, fieldnames=COLUMNAS, extrasaction="ignore", lineterminator="\n")
    w.writeheader()
    for f in filas:
        w.writerow({k: ("" if f.get(k) is None else int(f[k]) if isinstance(f.get(k), bool) else f[k]) for k in COLUMNAS})
    return salida.getvalue()


def bases_disponibles() -> list[str]:
    return sorted(p.stem for p in (DIR_SQL / "02-dependencias").glob("*.sql"))


def obtener(base: str, conectar=conexion) -> tuple[int, int]:
    """Devuelve (filas, SP con error)."""
    script = DIR_SQL / "02-dependencias" / f"{base}.sql"
    if not script.exists():
        raise ConfiguracionError(f"No existe {script.relative_to(DIR_SQL.parent)}: correr npm run generar")
    with conectar(servidor_de_base(base), base) as conn:
        filas = ejecutar_script(conn, script.read_text(encoding="utf-8"))
    destino = DIR_FUENTE / "dependencias" / f"{base}.csv"
    destino.parent.mkdir(parents=True, exist_ok=True)
    destino.write_text(a_csv(filas), encoding="utf-8", newline="")
    return len(filas), len({(f["sp_esquema"], f["sp_nombre"]) for f in filas if f.get("error")})
