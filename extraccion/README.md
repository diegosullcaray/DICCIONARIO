# Extracción

Todo el proceso que trae los datos de SQL Server y los deja listos para generar el diccionario.
Lo único que se edita a mano acá son las consultas de `sql/04-consultas/`; el resto lo producen las
herramientas o `npm run generar`.

```text
extraccion/
├── herramientas/      Python (bd.py) y extraer-definiciones.ps1: hablan con SQL Server, solo lectura
├── sql/               consultas para SQL Server
├── procedimientos/    cuerpo de cada SP, tal cual sale de la base: <base>/<esquema>/<SP>.sql
└── fuente/            catálogo de reportes y resultados del motor, entrada del generador
```

```text
fuente/reportes.json ──► npm run generar ──► sql/01, sql/02
                                                 │
                               herramientas/bd.py (o SSMS)
                                                 │
                    procedimientos/ + fuente/dependencias + fuente/estructura
                                                 │
                              npm run generar ──► ../diccionario/
```

Paso a paso: [flujo de trabajo](../governance/docs/development/workflow.md) · Comandos de Python:
[herramientas/README.md](./herramientas/README.md)

## `fuente/` — entradas

| Archivo | Qué es | Cómo se actualiza |
|---|---|---|
| `reportes.json` | catálogo `RCODREP` → SP (`RTPREP.name`) → parámetros (`RTPREP.params`) | reemplazar por un export nuevo de la tabla de reportes del backend |
| `dependencias/<base>.csv` | lo que SQL Server registra de cada SP (tablas, columnas, tipo de objeto) | `bd.py dependencias` |
| `estructura/<base>.csv` | columnas, tipos y nulabilidad reales de las tablas usadas | `bd.py estructura` |
| `consumo-front.json` | qué RCODREP usa MIS-angular-front, con el commit leído | `npm run trazar:front` |

Los CSV solo tienen **metadatos** (nombres de objetos y columnas), nunca datos. Si se generan desde SSMS
deben incluir la fila de encabezados.

## `procedimientos/` — cuerpos de SP

Se guardan **tal cual** salen de la base: sin formatear ni corregir. La única edición permitida es
reemplazar una credencial embebida por `<redactado>`.

## `sql/` — consultas (solo lectura)

| Carpeta | Contenido | Origen |
|---|---|---|
| `01-extraccion/` | `sp_helptext` por SP, lotes por base (`_lotes/`) y `manifiesto.json` | generado |
| `02-dependencias/` | tablas, columnas y tipo de objeto que el motor registra, por base | generado |
| `03-tablas/` | por tabla descubierta: estructura, tamaño, muestra y perfil de las columnas usadas | generado |
| `04-consultas/` | consultas utilitarias de exploración | a mano |
| `05-por-procedimiento/` | por SP: columnas que devuelve y muestra de cada tabla que usa, con solo sus columnas | generado |
