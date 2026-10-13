# storage.com_pas.WJAS008

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 6 columna(s) usadas · 2 procedimiento(s) · tabla con 6 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_pas/WJAS008.sql](../../../../extraccion/sql/03-tablas/storage/com_pas/WJAS008.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODREL` | varchar(250) | ✅ confirmada | [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md) | — |
| `hfecpro` | date | ✅ confirmada | [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | — |
| `HSALFENO` | float | ✅ confirmada | [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md) | — |
| `HSALFESI` | float | ✅ confirmada | [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md) | — |
| `HTIPCOD` | int | ✅ confirmada | [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md) | — |
| `RDESCPROD` | varchar(250) | ✅ confirmada | [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md) | lee | `TB_PANEL_OPE_01` |
| [mod_rep.com.RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | lee | `TB_PANEL_OPE_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODREL`: _por documentar_
- `hfecpro`: _por documentar_
- `HSALFENO`: _por documentar_
- `HSALFESI`: _por documentar_
- `HTIPCOD`: _por documentar_
- `RDESCPROD`: _por documentar_
