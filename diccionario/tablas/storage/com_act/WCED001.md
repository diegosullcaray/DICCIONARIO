# storage.com_act.WCED001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 46 columna(s) usadas · 6 procedimiento(s) · tabla con 45 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WCED001.sql](../../../../sql/03-tablas/storage/com_act/WCED001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `*` | ⚠️ no existe | 🎯 exacta | [RMORAGP01](../../../procedimientos/mod_rep/com/RMORAGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `HCODMON` | smallint | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HCODOPE` | int | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `hcodsec` | varchar(255) | ✅ confirmada | [RMORAGP01](../../../procedimientos/mod_rep/com/RMORAGP01.md), [RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE03](../../../procedimientos/mod_rep/com/RSMONEFE03.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HCREDSBS` | varchar(40) | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `HCTACLI` | int | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HCUOPAG` | smallint | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `HDCODSEC` | varchar(255) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HDESCLI` | varchar(40) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HDIAATR` | smallint | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HESTACT` | varchar(19) | ✅ confirmada | [RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE03](../../../procedimientos/mod_rep/com/RSMONEFE03.md) | — |
| `HESTC` | varchar(255) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFCCOM` | varchar(120) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFCFGEST` | date | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFCFVPP` | date | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFCMPP` | numeric(15,2) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFCRES` | varchar(50) | ✅ confirmada | [GSELREP001](../../../procedimientos/mod_rep/com/GSELREP001.md), [RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE03](../../../procedimientos/mod_rep/com/RSMONEFE03.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFCRSPB` | varchar(8) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFDGPR` | int | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFECDES` | date | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFECMOR` | date | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `HFECUCC` | date | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `HFGPR` | varchar(2) not null | ✅ confirmada | [RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE03](../../../procedimientos/mod_rep/com/RSMONEFE03.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HFTVEN` | varchar(17) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HINDUCUO` | varchar(2) not null | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HINDZCUO` | varchar(2) not null | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HMONDES` | numeric(38,2) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HNIVRIEBT` | varchar(255) | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `HNIVSOB` | varchar(255) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HPRECOS` | int | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `HPROBR` | float | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HREGG` | varchar(2) not null | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HREGN` | int not null | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HSALCAPMN` | numeric(38,2) | ✅ confirmada | [RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE03](../../../procedimientos/mod_rep/com/RSMONEFE03.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HSALINIMN` | numeric(38,2) | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `HTOTCUO` | smallint | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `HTRAM` | varchar(11) | ✅ confirmada | [RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE03](../../../procedimientos/mod_rep/com/RSMONEFE03.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `HUBIGEO` | varchar(6) | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `RCODMAT` | int | ✅ confirmada | [RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `RCODREG` | int | ✅ confirmada | [RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `RCODTER` | int | ✅ confirmada | [RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `RDESAGE` | varchar(50) | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `RDESMAT` | varchar(50) | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `RDESPROD` | varchar(255) | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | — |
| `RDESREG` | varchar(15) | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |
| `RDESTER` | varchar(15) | 🗄️ motor | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GSELREP001](../../../procedimientos/mod_rep/com/GSELREP001.md) | lee | `SEL_EFEC_01` |
| [mod_rep.com.RMORAGP01](../../../procedimientos/mod_rep/com/RMORAGP01.md) | lee | `RESMORAGP_01` |
| [mod_rep.com.RSGESMOEF001](../../../procedimientos/mod_rep/com/RSGESMOEF001.md) | lee | `rma/administracion/Mora/monitor_efectividad_rma_03` |
| [mod_rep.com.RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | lee | `RS_MON_EFEC_02`, `RS_MON_EFECM_02` |
| [mod_rep.com.RSMONEFE03](../../../procedimientos/mod_rep/com/RSMONEFE03.md) | lee | `RS_MON_EFEC_03`, `RS_MON_EFECM_03` |
| [mod_rep.com.RSMONEFE05](../../../procedimientos/mod_rep/com/RSMONEFE05.md) | lee | `RS_MON_EFEC_SEC_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HFCRES`: _por documentar_
