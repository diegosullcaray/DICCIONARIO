# SQL

Todo lo que se ejecuta en SQL Server. **Solo lectura**: metadatos, `sp_helptext`, `OBJECT_DEFINITION` y
muestras con `NOLOCK`. Ningún archivo modifica la base ni ejecuta un SP de reporte.

| Carpeta | Contenido | Origen |
|---|---|---|
| [`01-extraccion/`](./01-extraccion/) | un `sp_helptext` por SP (`<base>/<esquema>/<SP>.sql`), lotes por base (`_lotes/`) y `manifiesto.json` | generado |
| [`02-dependencias/`](./02-dependencias/) | tablas y columnas que el motor registra, una consulta por base | generado |
| [`03-tablas/`](./03-tablas/) | por cada tabla descubierta: estructura, tamaño, muestra y perfil de las columnas usadas | generado |
| [`04-consultas/`](./04-consultas/) | consultas utilitarias de exploración | a mano |
| [`05-por-procedimiento/`](./05-por-procedimiento/) | por cada SP analizado: columnas que devuelve y una muestra de cada tabla que usa, solo con sus columnas | generado |

Lo generado se regenera con `npm run generar` desde `fuente/reportes.json` y los cuerpos de
`procedimientos/`. No se edita: el cambio se pierde en la próxima generación.
