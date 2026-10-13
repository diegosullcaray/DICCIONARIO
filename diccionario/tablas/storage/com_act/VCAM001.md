# storage.com_act.VCAM001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 104 columna(s) usadas · 4 procedimiento(s) · vista con 104 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/VCAM001.sql](../../../../sql/03-tablas/storage/com_act/VCAM001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HASEOPER` | varchar(10) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HASEORI` | varchar(30) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCAPPEN` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCARCOB` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCARNCOB` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCLFSBS` | varchar(15) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCODCIIU` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCODCNV` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCODEMP` | smallint not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCODMOD` | smallint not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCODMON` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCODOPE` | int | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HCODSEC` | varchar(10) | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HCRESBS` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCTACLI` | int | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HCTAFIA` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCUOPEN` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HCUOVEN` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDCODCNV` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDCODSEC` | varchar(80) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDESCIIU` | varchar(60) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDESCLI` | varchar(40) | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HDESCRE` | varchar(60) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDESMOD` | varchar(80) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDESRUB` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDESTOPE` | varchar(80) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDIAATR` | smallint | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HDINDCAM` | varchar(80) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDIREC` | varchar(255) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDNIVAPR` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDOCCON` | varchar(34) not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDOCFIA` | varchar(20) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDPAIS` | varchar(30) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDSUBTIP` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDSUCCLI` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HDSUCSEC` | varchar(40) | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HDTIPOPE` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HESTOPE` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECCLF` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECDES` | date | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HFECMOR` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECPER` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECPRC` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HFECUCC` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFRCPAG` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HGENPER` | varchar(1) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HHORREG` | varchar(8) not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HINDCAM` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HINDCAR` | varchar(20) | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HINDTIPCB` | varchar(80) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HINGDIF` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HINTCMP` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HINTMOR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HINTVEN` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HMONDES` | numeric(17,2) | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HMONGAR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HMONPRV` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNASEORI` | varchar(120) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNIVAPR` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNOMFIA` | varchar(120) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNOMREG` | varchar(40) | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HNUMCOR` | bigint not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNUMCRCLI` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNUMDOC` | varchar(20) | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HNUMLET` | bigint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNUMREN` | bigint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNUMRUB` | char(14) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNUMTAS` | numeric(17,6) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNUMTHR` | smallint not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HOCUP` | varchar(150) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HPAIS` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HPAPEL` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HPRIVEN` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HRANDIA` | varchar(40) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HRESID` | varchar(1) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HRIECBCLI` | varchar(1) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HRIECBOPE` | varchar(60) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HROWID` | int not null | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSALCAP` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSALCAPMN` | numeric(17,2) | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HSALCAR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSALRIE` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSALVEN` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSALVENMN` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSHKCMB` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSITCRE` | varchar(20) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSUBOPE` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSUBTIP` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSUCCLI` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSUCOPER` | int | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HSUCSEC` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HTIPCAR` | varchar(20) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HTIPCMB` | numeric(17,4) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HTIPDOC` | smallint | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HTIPOPE` | smallint | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HTIPPER` | varchar(1) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HTOTCUO` | smallint | ✅ confirmada | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md), [RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | — |
| `HTOTDEU` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HTOTGAR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HUBIGEO` | varchar(6) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HULTVEN` | date | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HUSUPRO` | varchar(10) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HVENATR` | numeric(17,2) | 🗄️ motor | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | lee | `RESINCGRUP_01` |
| [mod_rep.com.RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | lee | `RS_MON_EFEC_02`, `RS_MON_EFECM_02` |
| [mod_rep.com.RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | lee | `RS_MON_EFECREASIG_02` |
| [mod_rep.com.RSRDMA023](../../../procedimientos/mod_rep/com/RSRDMA023.md) | lee | `R_APADRINA_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODSEC`: _por documentar_
- `HFECPRO`: _por documentar_
