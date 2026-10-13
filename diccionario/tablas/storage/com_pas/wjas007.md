# storage.com_pas.wjas007

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 9 columna(s) usadas · 3 procedimiento(s) · tabla con 10 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_pas/wjas007.sql](../../../../extraccion/sql/03-tablas/storage/com_pas/wjas007.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODPERFEME` | int | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | — |
| `HCODPERMIG` | int | 🗄️ motor | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | — |
| `HCODPERRUR` | int | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | — |
| `HCODPERURB` | int | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | — |
| `HCODREL` | varchar(255) | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | — |
| `HFECPRO` | varchar(255) | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | — |
| `HNUMCLI` | float | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | — |
| `HTIPCOD` | int | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | — |
| `RDESCPROD` | varchar(255) | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | lee | `CARACT_pas_M_01`, `CARACT_pas_01` |
| [mod_rep.com.RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md) | lee | `TB_PANEL_OPE_01` |
| [mod_rep.com.RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | lee | `TB_PANEL_OPE_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODPERFEME`: _por documentar_
- `HCODPERRUR`: _por documentar_
- `HCODPERURB`: _por documentar_
- `HCODREL`: _por documentar_
- `HFECPRO`: _por documentar_
- `HNUMCLI`: _por documentar_
- `HTIPCOD`: _por documentar_
- `RDESCPROD`: _por documentar_
