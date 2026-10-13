# SQL

Todo lo que se ejecuta en SQL Server. **Solo lectura**: metadatos, definiciones y muestras con `NOLOCK`.

| Carpeta | Contenido | Origen |
|---|---|---|
| `01-extraccion/` | `sp_helptext` por SP (`<base>/<esquema>/<SP>.sql`), lotes por base (`_lotes/`) y `manifiesto.json` | generado |
| `02-dependencias/` | tablas, columnas y tipo de objeto que el motor registra, una consulta por base | generado |
| `03-tablas/` | por tabla descubierta: estructura, tamaño, muestra y perfil de las columnas usadas | generado |
| `04-consultas/` | consultas utilitarias de exploración | a mano |
| `05-por-procedimiento/` | por SP: columnas que devuelve y muestra de cada tabla que usa, solo con sus columnas | generado |

Lo generado se regenera con `npm run generar`; editarlo se pierde. Cómo se usan en el trabajo diario:
[flujo de trabajo](../governance/docs/development/workflow.md).
