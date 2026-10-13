# storage.com_act.HDGP001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 20 columna(s) usadas · 5 procedimiento(s) · tabla con 20 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/HDGP001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/HDGP001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HASES` | varchar(80) not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HCODA` | varchar(10) not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HCODS` | varchar(10) not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HDNIP` | varchar(20) not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HDOCC` | varchar(20) not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HEJEC` | int not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HESTG` | varchar(20) not null | ✅ confirmada | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RMORAGP01](../../../procedimientos/mod_rep/com/RMORAGP01.md) | — |
| `HESTI` | varchar(20) not null | ✅ confirmada | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RMORAGP01](../../../procedimientos/mod_rep/com/RMORAGP01.md) | — |
| `HFALG` | date | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RMORAGP01](../../../procedimientos/mod_rep/com/RMORAGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HINST` | int not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HMODU` | smallint not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HNCTA` | int not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HNOMC` | varchar(80) not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HNOMG` | varchar(80) not null | ✅ confirmada | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNROG` | int not null | ✅ confirmada | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RMORAGP01](../../../procedimientos/mod_rep/com/RMORAGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HOPER` | int not null | ✅ confirmada | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HROWID` | int not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HSTOP` | smallint not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |
| `HTOPE` | smallint not null | 🗄️ motor | [DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.DINCEPDM01](../../../procedimientos/mod_rep/com/DINCEPDM01.md) | lee | `DET_INCEN_PDM_01` |
| [mod_rep.com.RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | lee | `RESINCGRUP_01` |
| [mod_rep.com.RMORAGP01](../../../procedimientos/mod_rep/com/RMORAGP01.md) | lee | `RESMORAGP_01` |
| [mod_rep.com.RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | lee | `RS_MON_EFEC_02`, `RS_MON_EFECM_02` |
| [mod_rep.com.RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | lee | `RS_MON_EFECREASIG_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HESTG`: _por documentar_
- `HESTI`: _por documentar_
- `HFECPRO`: _por documentar_
- `HNOMG`: _por documentar_
- `HNROG`: _por documentar_
- `HOPER`: _por documentar_
