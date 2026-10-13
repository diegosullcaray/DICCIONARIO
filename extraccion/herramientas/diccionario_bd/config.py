"""Configuración: rutas del repositorio, los 3 servidores y en qué servidor vive cada base.

Copia del contrato de REPORTES-AUTOMATIZADOS (backend/src/reportes/config.py) con una diferencia:
acá NO hay servidores por defecto en el código. Host, usuario y clave salen solo del `.env`
(regla del DICCIONARIO: nada de servidores ni credenciales versionados).
"""

from __future__ import annotations

import os
import re
from dataclasses import dataclass
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[3]          # raíz del repositorio (aquí va el .env)
DIR_EXTRACCION = RAIZ / "extraccion"                 # todo el proceso de extracción
DIR_PROCEDIMIENTOS = DIR_EXTRACCION / "procedimientos"
DIR_FUENTE = DIR_EXTRACCION / "fuente"
DIR_SQL = DIR_EXTRACCION / "sql"
DIR_DICCIONARIO = RAIZ / "diccionario"

DRIVER_ODBC = os.getenv("DB_ODBC_DRIVER", "ODBC Driver 17 for SQL Server")
_DRIVERS_PREFERIDOS = ("ODBC Driver 18 for SQL Server", "ODBC Driver 17 for SQL Server", "ODBC Driver 13 for SQL Server",
                       "SQL Server Native Client 11.0", "SQL Server")


class ConfiguracionError(RuntimeError):
    """Falta configuración necesaria (servidor, credenciales, driver)."""


def cargar_entorno(ruta: str | Path | None = None) -> Path | None:
    """Carga el `.env`: el indicado, `DICCIONARIO_ENV`, o el de la raíz del repo. Devuelve cuál se usó.

    Se puede apuntar al mismo `.env` de REPORTES-AUTOMATIZADOS: las variables son las mismas (MISH_*, SLC_*, RCC_*).
    """
    from dotenv import load_dotenv

    candidato = Path(ruta or os.getenv("DICCIONARIO_ENV") or RAIZ / ".env")
    if candidato.exists():
        load_dotenv(candidato, override=True)
        return candidato
    if ruta:
        raise ConfiguracionError(f"No existe el archivo de entorno {candidato}")
    return None


def driver_en_uso() -> str:
    try:
        import pyodbc
    except ImportError:
        return DRIVER_ODBC
    instalados = pyodbc.drivers()
    if DRIVER_ODBC in instalados:
        return DRIVER_ODBC
    for candidato in _DRIVERS_PREFERIDOS:
        if candidato in instalados:
            return candidato
    raise ConfiguracionError(
        f"El driver ODBC «{DRIVER_ODBC}» no está instalado. Instala «ODBC Driver 17 for SQL Server» "
        f"o define DB_ODBC_DRIVER con uno de: {', '.join(instalados) or 'ninguno'}"
    )


@dataclass(frozen=True)
class Servidor:
    """Una conexión: un servidor SQL Server. La base la elige cada consulta (`base=`)."""

    nombre: str
    prefijo: str
    descripcion: str
    windows_auth_defecto: bool

    @property
    def servidor(self) -> str:
        valor = os.getenv(f"{self.prefijo}_SERVER")
        if not valor:
            raise ConfiguracionError(f"Define {self.prefijo}_SERVER en el .env (ver .env.example)")
        return valor

    @property
    def usuario(self) -> str | None:
        return os.getenv(f"{self.prefijo}_USER") or None

    @property
    def clave(self) -> str | None:
        return os.getenv(f"{self.prefijo}_PASSWORD") or None

    def cadena_odbc(self, base: str | None = None) -> str:
        partes = [f"DRIVER={{{driver_en_uso()}}}", f"SERVER={self.servidor}"]
        if base:
            partes.append(f"DATABASE={base}")
        if self.usuario or self.clave:
            if not (self.usuario and self.clave):
                raise ConfiguracionError(f"Define {self.prefijo}_USER y {self.prefijo}_PASSWORD (o ninguno para Windows)")
            partes += [f"UID={self.usuario}", "PWD={" + self.clave.replace("}", "}}") + "}"]
        elif self.windows_auth_defecto:
            partes.append("Trusted_Connection=yes")
        else:
            raise ConfiguracionError(f"La conexión {self.nombre} requiere {self.prefijo}_USER y {self.prefijo}_PASSWORD")
        partes.append("ApplicationIntent=ReadOnly")
        return ";".join(partes)


SERVIDORES: dict[str, Servidor] = {
    "mish": Servidor("mish", "MISH", "MIS (Windows): mod_rep, strategos, mod_gpa, mod_sec, storage…", True),
    "slc": Servidor("slc", "SLC", "SLC (Windows): dwh, dma, csd, intcom, slc…", True),
    "rcc": Servidor("rcc", "RCC", "RCC (SQL): DBRCC, dbriesgos, DW_Raw_v2, DB<AAAAMM>…", False),
}

# Qué base vive en qué servidor. Fuente: REPORTES-AUTOMATIZADOS config.BASES_DE (capturas SSMS 2026-10).
BASES_DE: dict[str, tuple[str, ...]] = {
    "mish": ("app", "gitea", "government", "inme", "junk", "metadata", "mide", "mod_app", "mod_gpa", "mod_rep",
             "mod_sec", "mod_sys_admin", "mod_sys_login", "staging", "storage", "strategos", "appj"),
    "slc": ("abp", "aud", "crs", "csd", "dbs70", "dga", "dma", "dsa", "dwh", "etl", "intcom", "mds", "mla", "sla",
            "slb", "slc", "sld", "sle", "slf", "slg", "tdj", "test_temp", "tmp", "wks", "rcc_cd"),
    "rcc": ("dbfinanzas", "dbfsh", "dbrcc", "dbriesgos", "dw_application", "dw_metadata", "dw_raw", "dw_raw_v2",
            "dw_recycle", "dw_staging", "dw_staging_v2", "dw_summary", "dw_summary_v2", "gerencia_riesgos_bd",
            "reportserver", "reportservertempdb"),
}
_SERVIDOR_DE_BASE = {b: srv for srv, bases in BASES_DE.items() for b in bases}


def servidor_de_base(base: str) -> str:
    """mish | slc | rcc según la base. ConfiguracionError si no se conoce."""
    b = base.lower().strip("[]")
    if re.fullmatch(r"db\d{6}", b):
        return "rcc"
    try:
        return _SERVIDOR_DE_BASE[b]
    except KeyError:
        raise ConfiguracionError(f"No sé en qué servidor vive la base '{base}': añadirla a config.BASES_DE") from None


def obtener_servidor(nombre: str) -> Servidor:
    try:
        return SERVIDORES[nombre.lower()]
    except KeyError:
        raise ConfiguracionError(f"Servidor desconocido '{nombre}'. Opciones: {', '.join(SERVIDORES)}") from None
