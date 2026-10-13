# storage.gpr.HPVP001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `gpr` · 3 columna(s) usadas · 1 procedimiento(s) · tabla con 3 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/gpr/HPVP001.sql](../../../../extraccion/sql/03-tablas/storage/gpr/HPVP001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODBT` | varchar(8) | ✅ confirmada | [RSPANSUP001](../../../procedimientos/mod_rep/com/RSPANSUP001.md) | — |
| `HDIAS` | smallint | 🗄️ motor | [RSPANSUP001](../../../procedimientos/mod_rep/com/RSPANSUP001.md) | — |
| `HFECPRO` | date | ✅ confirmada | [RSPANSUP001](../../../procedimientos/mod_rep/com/RSPANSUP001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSPANSUP001](../../../procedimientos/mod_rep/com/RSPANSUP001.md) | lee | `PANEL_SUP_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODBT`: _por documentar_
- `HFECPRO`: _por documentar_
