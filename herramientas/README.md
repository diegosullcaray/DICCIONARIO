# Herramientas Python — conexión a SQL Server

Leen los SP y sus dependencias **directo de la base**, con el mismo patrón de conexión que
REPORTES-AUTOMATIZADOS: 3 servidores (`mish`, `slc`, `rcc`) en el `.env`, `config.py` sabe qué base
vive en qué servidor y `db.py` es el único lugar que abre conexiones. Todo es de **solo lectura**.

## Instalación (una vez)

```bash
python -m venv .venv && .venv\Scripts\activate          # Windows  (Linux/macOS: source .venv/bin/activate)
pip install -r herramientas/requirements.txt              # pyodbc + python-dotenv
copy .env.example .env                                    # y completar MISH_SERVER, …
```

Requiere «ODBC Driver 17 for SQL Server» (el mismo que REPORTES-AUTOMATIZADOS) y Node 20+ para `generar`.
Para no duplicar el `.env`, apuntar al de REPORTES-AUTOMATIZADOS:

```bash
python herramientas/bd.py --env ../REPORTES-AUTOMATIZADOS/backend/.env probar
```

## Comandos

| Comando | Qué hace | Escribe |
|---|---|---|
| `probar` | prueba los 3 servidores | — |
| `extraer [--base] [--sp] [--reporte] [--sobrescribir]` | `OBJECT_DEFINITION` de cada SP (una conexión y una consulta por base) | `procedimientos/<base>/<esquema>/<SP>.sql` |
| `dependencias [--base]` | ejecuta `sql/02-dependencias/<base>.sql` | `fuente/dependencias/<base>.csv` |
| `estructura [--base]` | `INFORMATION_SCHEMA` de las tablas descubiertas | `fuente/estructura/<base>.csv` |
| `generar` | `npm run generar` | `diccionario/`, `sql/` |
| `todo [--base]` | extraer → generar → dependencias → generar → estructura → generar | todo lo anterior |
| `estado` | avance por base, sin conectarse | — |
| `mapa --reporte X \| --sp X \| --tabla X \| --columna X` | consulta el diccionario generado, sin conectarse | — |

```bash
python herramientas/bd.py todo                       # todo el catálogo
python herramientas/bd.py todo --base strategos      # una base
python herramientas/bd.py extraer --reporte SEL_JEFE_01
python herramientas/bd.py mapa --reporte SEL_EFEC_01
python herramientas/bd.py mapa --columna HFCRES      # qué SP y reportes usan una columna
```

`extraer` sin `--sobrescribir` solo baja los pendientes; con `--sobrescribir` vuelve a bajar y solo
reescribe los que cambiaron en la base. Informa aparte los SP que **no existen** en la base y los que
no devuelven definición (cifrados `WITH ENCRYPTION` o sin permiso `VIEW DEFINITION`).

## Módulos (`diccionario_bd/`)

| Módulo | Responsabilidad |
|---|---|
| `config.py` | servidores desde `.env` (sin hosts por defecto en el código) y `BASES_DE` |
| `db.py` | única conexión (`pyodbc`, `ApplicationIntent=ReadOnly`), consultas y scripts con `GO` |
| `catalogo.py` | `fuente/reportes.json` → SP, con las mismas reglas de nombre que el generador Node |
| `extraccion.py` | cuerpos de SP |
| `dependencias.py` | dependencias del motor a CSV |
| `estructura.py` | columnas y tipos reales a CSV |
| `mapa.py` | consultas sobre `diccionario/diccionario.json` |

## Pruebas

```bash
npm run test:py      # sin servidor: una conexión simulada responde como pyodbc
```

Reglas: `pyodbc.connect` solo en `db.py`; ningún módulo ejecuta DML; nada de hosts ni credenciales en el código.
