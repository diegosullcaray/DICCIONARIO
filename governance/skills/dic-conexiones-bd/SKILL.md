---
name: dic-conexiones-bd
description: Cómo se conecta el DICCIONARIO a SQL Server desde Python — los 3 servidores (mish, slc, rcc) del .env compartido con REPORTES-AUTOMATIZADOS, qué base vive en cada uno y los comandos de herramientas/bd.py para extraer cuerpos, dependencias y estructura. Usar al configurar el entorno, al bajar SP de la base o al diagnosticar un error de conexión.
---

# Conexiones a la base

Mismo contrato que la skill `reportes-conexiones-bd` de REPORTES-AUTOMATIZADOS.

## 1. Servidores

| Conexión | Auth | Bases relevantes para el diccionario |
|---|---|---|
| `mish` | Windows | **todas las de los SP**: `mod_rep`, `strategos`, `mod_gpa`, `mod_sec`, `storage` |
| `slc` | Windows | `dwh`, `dma`, `csd`, `intcom`, `slc` (si un SP las cita, por linked server) |
| `rcc` | SQL | `DBRCC`, `dbriesgos`, `DW_Raw_v2`, `DB<AAAAMM>` |

El `.env` trae solo servidor y credenciales (`MISH_SERVER`, `MISH_USER`, …); la base la elige cada
consulta. `config.servidor_de_base()` decide a qué servidor ir. Una base nueva → agregarla a `BASES_DE`.

## 2. Uso

```bash
pip install -r herramientas/requirements.txt
python herramientas/bd.py --env ../REPORTES-AUTOMATIZADOS/backend/.env probar
python herramientas/bd.py todo --base mod_rep
python herramientas/bd.py mapa --reporte SEL_JEFE_01
```

## 3. Diagnóstico

| Error | Causa |
|---|---|
| `Define MISH_SERVER en el .env` | falta el `.env` o `--env` |
| `Falta pyodbc` / `driver ODBC` | `pip install -r herramientas/requirements.txt` + «ODBC Driver 17 for SQL Server» |
| `Login failed` en `mish`/`slc` | la cuenta de Windows no tiene acceso a esa base |
| SP en "sin definición" | cifrado o falta `VIEW DEFINITION`: pedir el permiso, no copiarlo de otro lado |
| `No sé en qué servidor vive la base` | agregarla a `BASES_DE` en `herramientas/diccionario_bd/config.py` |

## 4. Prohibido

- `pyodbc.connect` fuera de `db.py` (lo controla `npm run test:py`).
- Hosts, usuarios o claves en el código o en archivos versionados: solo en `.env`.
- DML, `EXEC` de un SP de reporte o cualquier escritura en la base.
