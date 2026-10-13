# storage.ref.VJERCOR03

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `ref` · 10 columna(s) usadas · 13 procedimiento(s) · vista con 10 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/ref/VJERCOR03.sql](../../../../extraccion/sql/03-tablas/storage/ref/VJERCOR03.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `RCODAGE` | int | ✅ confirmada | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md), [RPROSCORR002](../../../procedimientos/mod_rep/com/RPROSCORR002.md), [RPROSCORR004](../../../procedimientos/mod_rep/com/RPROSCORR004.md), [RPROSCORR005](../../../procedimientos/mod_rep/com/RPROSCORR005.md), [RPROSCORR006](../../../procedimientos/mod_rep/com/RPROSCORR006.md) | — |
| `RCODCOR` | int | ✅ confirmada | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md), [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md), [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md), [RPROSCORR002](../../../procedimientos/mod_rep/com/RPROSCORR002.md), [RPROSCORR004](../../../procedimientos/mod_rep/com/RPROSCORR004.md), [RPROSCORR005](../../../procedimientos/mod_rep/com/RPROSCORR005.md), [RPROSCORR006](../../../procedimientos/mod_rep/com/RPROSCORR006.md) | — |
| `RCODFC` | varchar(3) not null | 🗄️ motor | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md) | — |
| `RCODMAT` | int | ✅ confirmada | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md), [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md), [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md), [RPROSCORR002](../../../procedimientos/mod_rep/com/RPROSCORR002.md), [RPROSCORR004](../../../procedimientos/mod_rep/com/RPROSCORR004.md), [RPROSCORR005](../../../procedimientos/mod_rep/com/RPROSCORR005.md), [RPROSCORR006](../../../procedimientos/mod_rep/com/RPROSCORR006.md) | — |
| `RCODTER` | smallint | ✅ confirmada | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md), [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md), [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md), [RPROSCORR002](../../../procedimientos/mod_rep/com/RPROSCORR002.md), [RPROSCORR004](../../../procedimientos/mod_rep/com/RPROSCORR004.md), [RPROSCORR005](../../../procedimientos/mod_rep/com/RPROSCORR005.md), [RPROSCORR006](../../../procedimientos/mod_rep/com/RPROSCORR006.md) | — |
| `RDESAGE` | varchar(50) | ✅ confirmada | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md), [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md), [RPROSCORR002](../../../procedimientos/mod_rep/com/RPROSCORR002.md), [RPROSCORR004](../../../procedimientos/mod_rep/com/RPROSCORR004.md), [RPROSCORR005](../../../procedimientos/mod_rep/com/RPROSCORR005.md), [RPROSCORR006](../../../procedimientos/mod_rep/com/RPROSCORR006.md) | — |
| `RDESCOR` | varchar(255) | ✅ confirmada | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md), [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md), [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md), [RPROSCORR002](../../../procedimientos/mod_rep/com/RPROSCORR002.md), [RPROSCORR004](../../../procedimientos/mod_rep/com/RPROSCORR004.md), [RPROSCORR005](../../../procedimientos/mod_rep/com/RPROSCORR005.md), [RPROSCORR006](../../../procedimientos/mod_rep/com/RPROSCORR006.md) | — |
| `RDESFC` | varchar(20) not null | 🗄️ motor | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md) | — |
| `RDESMAT` | varchar(50) | ✅ confirmada | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md), [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md), [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md), [RPROSCORR002](../../../procedimientos/mod_rep/com/RPROSCORR002.md), [RPROSCORR004](../../../procedimientos/mod_rep/com/RPROSCORR004.md), [RPROSCORR005](../../../procedimientos/mod_rep/com/RPROSCORR005.md), [RPROSCORR006](../../../procedimientos/mod_rep/com/RPROSCORR006.md) | — |
| `RDESTER` | varchar(150) | ✅ confirmada | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md), [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md), [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md), [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md), [RPROSCORR002](../../../procedimientos/mod_rep/com/RPROSCORR002.md), [RPROSCORR004](../../../procedimientos/mod_rep/com/RPROSCORR004.md), [RPROSCORR005](../../../procedimientos/mod_rep/com/RPROSCORR005.md), [RPROSCORR006](../../../procedimientos/mod_rep/com/RPROSCORR006.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | lee | `GST_PASIVA_01`, `GST_PASIVA_02`, `GST_PASIVA_03`, `GST_PASIVA_M_01`, `GST_PASIVA_M_02`, `GST_PASIVA_M_03` |
| [mod_rep.com.GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md) | lee | `TABDIG_01` |
| [mod_rep.com.GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md) | lee | `TABDIG_02` |
| [mod_rep.com.GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md) | lee | `SEL_JER_01` |
| [mod_rep.com.RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | lee | `GREPORCORRE_01` |
| [mod_rep.com.RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md) | lee | `GREPORCORRE_05` |
| [mod_rep.com.RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md) | lee | `GREPORCORRE_06` |
| [mod_rep.com.RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | lee | `RDETCORR_01` |
| [mod_rep.com.RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | lee | `enrolamiento_pasivo_pas_02` |
| [mod_rep.com.RPROSCORR002](../../../procedimientos/mod_rep/com/RPROSCORR002.md) | lee | `GREPROSPCORRE_01` |
| [mod_rep.com.RPROSCORR004](../../../procedimientos/mod_rep/com/RPROSCORR004.md) | lee | `GREPROSPCORRE_02` |
| [mod_rep.com.RPROSCORR005](../../../procedimientos/mod_rep/com/RPROSCORR005.md) | lee | `GREPROSPCORRE_06` |
| [mod_rep.com.RPROSCORR006](../../../procedimientos/mod_rep/com/RPROSCORR006.md) | lee | `GREPROSPCORRE_03` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `RCODAGE`: _por documentar_
- `RCODCOR`: _por documentar_
- `RCODMAT`: _por documentar_
- `RCODTER`: _por documentar_
- `RDESAGE`: _por documentar_
- `RDESCOR`: _por documentar_
- `RDESMAT`: _por documentar_
- `RDESTER`: _por documentar_
