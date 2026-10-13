# strategos.etl.ABPEVLOG01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `strategos` · esquema `etl` · 6 columna(s) usadas · 1 procedimiento(s) · tabla con 5 columna(s) en la base

Consultas listas: [sql/03-tablas/strategos/etl/ABPEVLOG01.sql](../../../../sql/03-tablas/strategos/etl/ABPEVLOG01.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `dd` | ⚠️ no existe | ≈ inferida | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |
| `HCODPRO` | varchar(10) | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |
| `HDESPRO` | varchar(100) | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |
| `HDESTAD` | varchar(10) | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |
| `HFECLOG` | datetime not null | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSRPD001](../../../procedimientos/mod_rep/com/RSRPD001.md) | lee | `RS_MON_CAR_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `dd`: _por documentar_
- `HCODPRO`: _por documentar_
- `HDESPRO`: _por documentar_
- `HDESTAD`: _por documentar_
- `HFECLOG`: _por documentar_
- `HFECPRO`: _por documentar_
