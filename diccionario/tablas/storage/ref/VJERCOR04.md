# storage.ref.VJERCOR04

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `ref` · 12 columna(s) usadas · 10 procedimiento(s) · vista con 12 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/ref/VJERCOR04.sql](../../../../extraccion/sql/03-tablas/storage/ref/VJERCOR04.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `RCODAGE` | int | ✅ confirmada | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |
| `RCODAGEH` | int | ✅ confirmada | [GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md), [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | — |
| `RCODFC` | int not null | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |
| `RCODMAC` | int | ✅ confirmada | [GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md), [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |
| `RCODMAT` | int | ✅ confirmada | [GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md), [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |
| `RCODTER` | int | ✅ confirmada | [GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md), [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |
| `RDESAGE` | varchar(50) | ✅ confirmada | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |
| `RDESAGEH` | varchar(50) | ✅ confirmada | [GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | — |
| `RDESFC` | varchar(20) not null | ✅ confirmada | [GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |
| `RDESMAC` | varchar(150) | ✅ confirmada | [GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |
| `RDESMAT` | varchar(50) | ✅ confirmada | [GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |
| `RDESTER` | varchar(150) | ✅ confirmada | [GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md), [RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md), [RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md), [RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md), [RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md), [RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md), [RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRGCTABDIGO02](../../../procedimientos/mod_rep/com/GRGCTABDIGO02.md) | lee | `GCTABDIG_VR2_OPE_02` |
| [mod_rep.com.GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md) | lee | `TABDIG_VR2_01` |
| [mod_rep.com.GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | lee | `CAP_SEGUI_BP_01` |
| [mod_rep.com.RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | lee | `CARACT_pas_M_01`, `CARACT_pas_01` |
| [mod_rep.com.RSROPERA001](../../../procedimientos/mod_rep/com/RSROPERA001.md) | lee | `TB_PANEL_OPE_01` |
| [mod_rep.com.RSROPERA002](../../../procedimientos/mod_rep/com/RSROPERA002.md) | lee | `TB_PANEL_OPE_02` |
| [mod_rep.com.RSSEGPAS01](../../../procedimientos/mod_rep/com/RSSEGPAS01.md) | lee | `RS_SEG_PAS_01` |
| [mod_rep.com.RSSEGPAS02](../../../procedimientos/mod_rep/com/RSSEGPAS02.md) | lee | `RS_SEG_PAS_02` |
| [mod_rep.com.RSSEGPAS03](../../../procedimientos/mod_rep/com/RSSEGPAS03.md) | lee | `RS_SEG_PAS_03` |
| [mod_rep.com.RSSEGPAS04](../../../procedimientos/mod_rep/com/RSSEGPAS04.md) | lee | `RS_SEG_PAS_04` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `RCODAGE`: _por documentar_
- `RCODAGEH`: _por documentar_
- `RCODFC`: _por documentar_
- `RCODMAC`: _por documentar_
- `RCODMAT`: _por documentar_
- `RCODTER`: _por documentar_
- `RDESAGE`: _por documentar_
- `RDESAGEH`: _por documentar_
- `RDESFC`: _por documentar_
- `RDESMAC`: _por documentar_
- `RDESMAT`: _por documentar_
- `RDESTER`: _por documentar_
