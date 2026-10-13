# storage.com_act.WCED002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 44 columna(s) usadas · 1 procedimiento(s) · tabla con 44 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WCED002.sql](../../../../sql/03-tablas/storage/com_act/WCED002.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODMON` | smallint | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCODOPE` | int | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCODSEC` | varchar(255) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCREDSBS` | varchar(40) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCTACLI` | int | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCUOPAG` | smallint | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDCODSEC` | varchar(255) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDESCLI` | varchar(40) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDIAATR` | smallint | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HESTACT` | varchar(19) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HESTC` | varchar(255) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFCCOM` | varchar(120) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFCFGEST` | date | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFCFVPP` | date | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFCMPP` | numeric(15,2) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFCRES` | varchar(50) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFCRSPB` | varchar(8) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFDGPR` | int | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECDES` | date | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECMOR` | date | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECUCC` | date | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFGPR` | varchar(2) not null | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFTVEN` | varchar(17) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HINDUCUO` | varchar(2) not null | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HINDZCUO` | varchar(2) not null | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HMONDES` | numeric(38,2) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNIVRIEBT` | varchar(255) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNIVSOB` | varchar(255) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HPROBR` | float | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HREGG` | varchar(2) not null | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HREGN` | int not null | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSALCAPMN` | numeric(38,2) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSALINIMN` | numeric(38,2) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HTOTCUO` | smallint | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HTRAM` | varchar(11) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HUBIGEO` | varchar(6) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `RCODMAT` | int | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `RCODREG` | int | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `RCODTER` | int | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `RDESAGE` | varchar(50) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `RDESMAT` | varchar(50) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `RDESPROD` | varchar(255) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `RDESREG` | varchar(15) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `RDESTER` | varchar(15) | 🗄️ motor | [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | lee | `RS_MON_EFECREASIG_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

