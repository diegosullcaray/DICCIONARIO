"""Lee extraccion/fuente/reportes.json y agrupa los reportes por SP. Mismas reglas que governance/scripts/lib/catalogo.mjs:
corchetes y espacios fuera, clave en minúsculas (SQL Server no distingue mayúsculas en nombres)."""

from __future__ import annotations

import json
from dataclasses import dataclass, field
from pathlib import Path

from .config import DIR_FUENTE, DIR_PROCEDIMIENTOS


def partes_nombre(nombre: str) -> list[str]:
    partes, actual, en_corchete = [], "", False
    for c in (nombre or "").strip():
        if c == "[":
            en_corchete = True
        elif c == "]":
            en_corchete = False
        elif c == "." and not en_corchete:
            partes.append(actual.strip())
            actual = ""
        else:
            actual += c
    partes.append(actual.strip())
    return partes


@dataclass
class Procedimiento:
    base: str | None
    esquema: str
    nombre: str
    reportes: list[str] = field(default_factory=list)

    @property
    def completo(self) -> str:
        return ".".join(p for p in (self.base, self.esquema, self.nombre) if p)

    @property
    def clave(self) -> str:
        return self.completo.lower()

    @property
    def archivo(self) -> Path:
        return DIR_PROCEDIMIENTOS / (self.base or "_sin_base") / self.esquema / f"{self.nombre}.sql"

    @property
    def extraido(self) -> bool:
        return self.archivo.exists() and es_cuerpo_real(self.archivo.read_text(encoding="utf-8", errors="replace"))


def es_cuerpo_real(texto: str) -> bool:
    import re

    return re.search(r"\b(create|alter)\s+(or\s+alter\s+)?proc(edure)?\b", texto, re.I) is not None


def cargar(ruta: Path = DIR_FUENTE / "reportes.json") -> dict[str, Procedimiento]:
    """clave → Procedimiento, ordenado por clave."""
    sps: dict[str, Procedimiento] = {}
    for r in json.loads(ruta.read_text(encoding="utf-8")):
        partes = partes_nombre((r.get("RTPREP") or {}).get("name", ""))
        base, esquema, nombre = partes if len(partes) == 3 else ([None, *partes] if len(partes) == 2 else [None, "dbo", partes[0]])
        sp = Procedimiento(base, esquema or "dbo", nombre)
        sps.setdefault(sp.clave, sp).reportes.append(r["RCODREP"])
    return dict(sorted(sps.items()))


def filtrar(sps: dict[str, Procedimiento], base: str | None = None, nombre: str | None = None,
            reporte: str | None = None) -> list[Procedimiento]:
    salida = list(sps.values())
    if base:
        salida = [s for s in salida if (s.base or "").lower() == base.lower()]
    if nombre:
        salida = [s for s in salida if s.nombre.lower() == nombre.lower() or s.completo.lower() == nombre.lower()]
    if reporte:
        salida = [s for s in salida if reporte.upper() in (c.upper() for c in s.reportes)]
    return salida
