---
name: dic-conexiones-bd
description: Cómo se conecta el DICCIONARIO a SQL Server desde Python — los 3 servidores (mish, slc, rcc) del .env compartido con REPORTES-AUTOMATIZADOS, qué base vive en cada uno y cómo diagnosticar un error de conexión. Usar al configurar el entorno, al bajar SP o dependencias de la base o cuando herramientas/bd.py falla al conectar.
---
<!-- Copia de governance/skills/dic-conexiones-bd/SKILL.md. Editar el original y correr npm run generar. -->

# Conexiones a la base

Mismo contrato que la skill `reportes-conexiones-bd` de REPORTES-AUTOMATIZADOS. Instalación y todos los
comandos: [herramientas/README.md](../../../herramientas/README.md).

## Servidores

| Conexión | Auth | Bases que importan al diccionario |
|---|---|---|
| `mish` | Windows | **todas las de los SP**: `mod_rep`, `strategos`, `mod_gpa`, `mod_sec`, `storage` |
| `slc` | Windows | `dwh`, `dma`, `csd`, `intcom`, `slc` |
| `rcc` | SQL | `DBRCC`, `dbriesgos`, `DW_Raw_v2`, `DB<AAAAMM>` |

El `.env` trae solo servidor y credenciales (`MISH_SERVER`, `MISH_USER`, …). La base la elige cada
consulta y `config.servidor_de_base()` decide a qué servidor ir. Se puede usar el `.env` de
REPORTES-AUTOMATIZADOS con `--env`.

## Diagnóstico

| Error | Causa |
|---|---|
| `Define MISH_SERVER en el .env` | falta el `.env` o el `--env` |
| `Falta pyodbc` / `driver ODBC` | `pip install -r herramientas/requirements.txt` + «ODBC Driver 17 for SQL Server» |
| `Login failed` | la cuenta no tiene acceso a esa base |
| `No sé en qué servidor vive la base` | agregarla a `BASES_DE` en `herramientas/diccionario_bd/config.py` (y en REPORTES-AUTOMATIZADOS) |

## Prohibido

- `pyodbc.connect` fuera de `db.py` (lo controla `npm run test:py`).
- Hosts, usuarios o claves en archivos versionados.
- Escribir en la base: DML, `EXEC` de un SP de reporte.
