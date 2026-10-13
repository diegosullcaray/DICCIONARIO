# Herramientas de extracción — conexión a SQL Server

Leen los SP y sus dependencias **directo de la base**, con el mismo patrón de conexión que
REPORTES-AUTOMATIZADOS: 3 servidores (`mish`, `slc`, `rcc`) en el `.env`, `config.py` sabe qué base
vive en qué servidor y `db.py` es el único lugar que abre conexiones. Todo es de **solo lectura**.

## Instalación (una vez)

```bash
python -m venv .venv && .venv\Scripts\activate          # Windows  (Linux/macOS: source .venv/bin/activate)
pip install -r extraccion/herramientas/requirements.txt              # pyodbc + python-dotenv
copy .env.example .env                                    # y completar MISH_SERVER, …
```

Requiere «ODBC Driver 17 for SQL Server» (el mismo que REPORTES-AUTOMATIZADOS) y Node 20+ para `generar`.
La herramienta usa por defecto el `.env` ubicado en la raíz de este repositorio (DICCIONARIO), fuera de
`extraccion/herramientas/`. No es necesario pasar `--env`:

```powershell
python extraccion/herramientas/bd.py probar
```

Usa `--env "<ruta>"` solo si necesitas seleccionar otro archivo de entorno.

## Actualizar cuerpos desde una base

`npm run generar` **no se conecta a SQL Server**: solo regenera el diccionario y los SQL derivados
a partir de `reportes.json`, los cuerpos ya guardados en `extraccion/procedimientos/` y los CSV de
fuente. Para traer una versión nueva del SP primero hay que extraerla desde la base y después generar.

Antes de extraer, verifica que el `.env` elegido apunte al ambiente deseado. La herramienta lee la
base; no ejecuta ni modifica los SP en SQL Server.

Para refrescar un SP que ya está en `extraccion/fuente/reportes.json`:

```powershell
python extraccion/herramientas/bd.py extraer --base mod_rep --sp GDCGEST_ACTIVAST01 --sobrescribir
npm run generar
```

`--sobrescribir` vuelve a leer ese procedimiento y reemplaza el cuerpo local solo si cambió. Afecta
`extraccion/procedimientos/` y, al regenerar, los archivos derivados relacionados. Revisa el diff
antes de conservar los cambios, especialmente si el `.env` apunta a desarrollo: el diccionario no
separa automáticamente los cuerpos por ambiente.

El filtro `--sp` solo puede seleccionar procedimientos presentes en `reportes.json`; no es un
buscador de cualquier objeto de SQL Server. Si el SP todavía no está en ese catálogo (por ejemplo,
`GDCGEST_ACTIVAST01_NEW` mientras ningún reporte lo referencia), el extractor informará que no
coincide. No agregues una entrada inventada a `reportes.json`: ese archivo representa el catálogo
real de reportes y parámetros. Para documentar un SP nuevo, primero debe existir la asociación
aprobada en el catálogo y luego se regenera. Si solo necesitas guardar el cuerpo para revisión,
usa SSMS con una consulta de solo lectura:

```sql
USE mod_rep;
SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.GDCGEST_ACTIVAST01_NEW')) AS definicion;
```

Guarda la definición completa, sin reformatearla ni corregirla, en
`extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST01_NEW.sql`. Si el resultado es `NULL`,
confirma con el DBA que el objeto existe en esa base y que tu usuario puede ver su definición. Un
cuerpo sin asociación en `reportes.json` queda guardado para revisión, pero el generador no lo incluye
en el diccionario. Ejecuta `npm run generar` cuando el catálogo tenga la asociación aprobada y revisa
los archivos modificados.

## Comandos

| Comando | Qué hace | Escribe |
|---|---|---|
| `probar` | prueba los 3 servidores | — |
| `extraer [--base] [--sp] [--reporte] [--sobrescribir]` | `OBJECT_DEFINITION` de cada SP (una conexión y una consulta por base) | `extraccion/procedimientos/<base>/<esquema>/<SP>.sql` |
| `dependencias [--base]` | ejecuta `extraccion/sql/02-dependencias/<base>.sql` | `extraccion/fuente/dependencias/<base>.csv` |
| `estructura [--base]` | `INFORMATION_SCHEMA` de las tablas descubiertas | `extraccion/fuente/estructura/<base>.csv` |
| `generar` | `npm run generar` | `diccionario/`, `extraccion/sql/` |
| `todo [--base]` | extraer → generar → dependencias → generar → estructura → generar | todo lo anterior |
| `estado` | avance por base, sin conectarse | — |
| `mapa --reporte X \| --sp X \| --tabla X \| --columna X` | consulta el diccionario generado, sin conectarse | — |

El comando `todo` no equivale a `generar`: además de extraer los cuerpos, consulta dependencias y
estructura en SQL Server, escribe sus CSV de fuente y ejecuta la generación varias veces. Úsalo solo
cuando quieras actualizar todo ese conjunto para la base indicada.

```bash
python extraccion/herramientas/bd.py todo                       # todo el catálogo
python extraccion/herramientas/bd.py todo --base strategos      # una base
python extraccion/herramientas/bd.py extraer --reporte SEL_JEFE_01
python extraccion/herramientas/bd.py mapa --reporte SEL_EFEC_01
python extraccion/herramientas/bd.py mapa --columna HFCRES      # qué SP y reportes usan una columna
```

`extraer` sin `--sobrescribir` solo baja los pendientes; con `--sobrescribir` vuelve a bajar y solo
reescribe los que cambiaron en la base. Informa aparte los SP que **no existen** en la base y los que
no devuelven definición (cifrados `WITH ENCRYPTION` o sin permiso `VIEW DEFINITION`).

## Módulos (`diccionario_bd/`)

| Módulo | Responsabilidad |
|---|---|
| `config.py` | servidores desde `.env` (sin hosts por defecto en el código) y `BASES_DE` |
| `db.py` | única conexión (`pyodbc`, `ApplicationIntent=ReadOnly`), consultas y scripts con `GO` |
| `catalogo.py` | `extraccion/fuente/reportes.json` → SP, con las mismas reglas de nombre que el generador Node |
| `extraccion.py` | cuerpos de SP |
| `dependencias.py` | dependencias del motor a CSV |
| `estructura.py` | columnas y tipos reales a CSV |
| `mapa.py` | consultas sobre `diccionario/diccionario.json` |

## Pruebas

```bash
npm run test:py      # sin servidor: una conexión simulada responde como pyodbc
```

Reglas: `pyodbc.connect` solo en `db.py`; ningún módulo ejecuta DML; nada de hosts ni credenciales en el código.

## Sin Python: `extraer-definiciones.ps1`

Para quien tiene `sqlcmd` pero no Python. Lee `extraccion/sql/01-extraccion/manifiesto.json` y baja con
`OBJECT_DEFINITION` los cuerpos pendientes; usa autenticación de Windows, o pide la contraseña si se pasa `-Usuario`.

```powershell
./extraccion/herramientas/extraer-definiciones.ps1 -Servidor <servidor>                 # todos los pendientes
./extraccion/herramientas/extraer-definiciones.ps1 -Servidor <servidor> -Base mod_rep
./extraccion/herramientas/extraer-definiciones.ps1 -Servidor <servidor> -Nombre GSREVA01 -Sobrescribir
```
