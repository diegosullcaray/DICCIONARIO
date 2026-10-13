# storage.com_act.wjas005

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 7 columna(s) usadas · 1 procedimiento(s) · tabla con 12 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/wjas005.sql](../../../../extraccion/sql/03-tablas/storage/com_act/wjas005.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCLISAL1M` | int | ✅ confirmada | [RSMONRENT01](../../../procedimientos/mod_rep/com/RSMONRENT01.md) | — |
| `HCLISAL3M` | int | ✅ confirmada | [RSMONRENT01](../../../procedimientos/mod_rep/com/RSMONRENT01.md) | — |
| `HCLIVENC` | int | ✅ confirmada | [RSMONRENT01](../../../procedimientos/mod_rep/com/RSMONRENT01.md) | — |
| `HCODREL` | varchar(50) | ✅ confirmada | [RSMONRENT01](../../../procedimientos/mod_rep/com/RSMONRENT01.md) | — |
| `HFECPRO` | date | ✅ confirmada | [RSMONRENT01](../../../procedimientos/mod_rep/com/RSMONRENT01.md) | — |
| `HRATRET` | float | ✅ confirmada | [RSMONRENT01](../../../procedimientos/mod_rep/com/RSMONRENT01.md) | — |
| `HTIPCOD` | int not null | ✅ confirmada | [RSMONRENT01](../../../procedimientos/mod_rep/com/RSMONRENT01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSMONRENT01](../../../procedimientos/mod_rep/com/RSMONRENT01.md) | lee | `RS_RETE_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCLISAL1M`: _por documentar_
- `HCLISAL3M`: _por documentar_
- `HCLIVENC`: _por documentar_
- `HCODREL`: _por documentar_
- `HFECPRO`: _por documentar_
- `HRATRET`: _por documentar_
- `HTIPCOD`: _por documentar_
