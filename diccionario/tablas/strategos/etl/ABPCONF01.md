# strategos.etl.ABPCONF01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `strategos` · esquema `etl` · 5 columna(s) usadas · 1 procedimiento(s) · tabla con 9 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/strategos/etl/ABPCONF01.sql](../../../../extraccion/sql/03-tablas/strategos/etl/ABPCONF01.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODPRO` | varchar(10) | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |
| `HDESLOG` | varchar(255) | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |
| `HDESPRO` | varchar(255) | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |
| `HSTATUS` | bit | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |
| `HTIPPRO` | varchar(10) | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | lee | `RS_MON_CAR_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODPRO`: _por documentar_
- `HDESLOG`: _por documentar_
- `HDESPRO`: _por documentar_
- `HSTATUS`: _por documentar_
- `HTIPPRO`: _por documentar_
