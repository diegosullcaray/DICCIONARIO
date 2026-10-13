# storage.com_act.VCAH001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 108 columna(s) usadas · 5 procedimiento(s) · vista con 108 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/VCAH001.sql](../../../../sql/03-tablas/storage/com_act/VCAH001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HASEOPER` | varchar(10) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HASEORI` | varchar(30) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCAPPEN` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCARCOB` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCARNCOB` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCLFSBS` | varchar(15) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCODCIIU` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCODCNV` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCODEMP` | smallint not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCODMOD` | smallint not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCODMON` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCODOPE` | int | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HCODSEC` | varchar(10) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCODSECANT` | varchar(10) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCRESBS` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `hctacli` | int | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCTAFIA` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCUOPEN` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HCUOVEN` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDCODCNV` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDCODSEC` | varchar(255) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDESCIIU` | varchar(60) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `hdescli` | varchar(40) | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md), [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDESCRE` | varchar(60) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDESMOD` | varchar(80) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDESRUB` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDESTOPE` | varchar(80) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDIAATR` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDINDCAM` | varchar(80) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDIREC` | varchar(255) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDNIVAPR` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDOCCON` | varchar(34) not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDOCFIA` | varchar(20) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDPAIS` | varchar(30) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDSUBTIP` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDSUCCLI` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDSUCSEC` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HDTIPOPE` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HESTOPE` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HFECCLF` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HFECDES` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HFECMOR` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HFECPER` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HFECPRC` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HFECUCC` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HFRCPAG` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HGENPER` | varchar(1) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HHORREG` | varchar(8) not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HINDCAM` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HINDCAR` | varchar(20) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HINDIM` | int not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HINDMETA` | int not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HINDTIPCB` | varchar(80) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HINGDIF` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HINTCMP` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HINTMOR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HINTVEN` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HMONDES` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HMONGAR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HMONPRV` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNASEORI` | varchar(120) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNDOCSEC` | varchar(255) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNIVAPR` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNOMFIA` | varchar(120) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNOMREG` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNUMCOR` | bigint not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNUMCRCLI` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNUMDOC` | varchar(20) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNUMLET` | bigint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNUMREN` | bigint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNUMRUB` | char(14) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNUMTAS` | numeric(17,6) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HNUMTHR` | smallint not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HOCUP` | varchar(150) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HPAIS` | smallint | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HPAPEL` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HPRIVEN` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HRANDIA` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HRESID` | varchar(1) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HRIECBCLI` | varchar(1) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HRIECBOPE` | varchar(60) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HROWID` | int not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSALCAP` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSALCAPMN` | numeric(17,2) | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HSALCAR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSALRIE` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSALVEN` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSALVENMN` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSHKCMB` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSITCRE` | varchar(20) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSUBOPE` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSUBTIP` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSUCCLI` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSUCOPER` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HSUCSEC` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HTIPCAR` | varchar(20) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HTIPCMB` | numeric(17,4) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HTIPDOC` | smallint | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HTIPOPE` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HTIPPER` | varchar(1) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HTOTCUO` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HTOTDEU` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HTOTGAR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HUBIGEO` | varchar(6) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HULTVEN` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HUSUPRO` | varchar(10) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |
| `HVENATR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md) | lee | `PLANMOV_01`, `PLANMOVPERFIL_01` |
| [mod_rep.com.GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | lee | `PLANMOVR_01` |
| [mod_rep.com.GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | lee | `DET_CLI_01` |
| [mod_rep.com.RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | lee | `RESINCGRUP_01` |
| [mod_rep.com.RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | lee | `R_APADRINA_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODOPE`: _por documentar_
- `HCODSEC`: _por documentar_
- `hctacli`: _por documentar_
- `hdescli`: _por documentar_
- `HFECPRO`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HPAIS`: _por documentar_
- `HSALCAPMN`: _por documentar_
- `HTIPDOC`: _por documentar_
