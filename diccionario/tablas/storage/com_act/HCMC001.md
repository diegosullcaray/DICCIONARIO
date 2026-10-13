# storage.com_act.HCMC001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 10 columna(s) usadas · 5 procedimiento(s) · tabla con 35 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/HCMC001.sql](../../../../sql/03-tablas/storage/com_act/HCMC001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCAUSAL` | varchar(255) | ✅ confirmada | [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HCODIGOCB` | int | ✅ confirmada | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HESTADOTX` | varchar(255) | ≈ inferida | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md) | — |
| `HFECHAMOV` | varchar(255) | 🗄️ motor | [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `hfecpro` | varchar(255) | ✅ confirmada | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HMUNICB` | varchar(255) | ✅ confirmada | [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md) | — |
| `HNOMBREPTO` | varchar(255) | ✅ confirmada | [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md), [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HNOMTITCB` | varchar(255) | ≈ inferida | [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md) | — |
| `HTIPOTRN` | varchar(255) | 🗄️ motor | [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HVALORTX` | float | 🗄️ motor | [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md) | lee | `TABDIG_02` |
| [mod_rep.com.GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md) | lee | `SEL_JER_01` |
| [mod_rep.com.RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | lee | `GREPORCORRE_01` |
| [mod_rep.com.RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md) | lee | `GREPORCORRE_05` |
| [mod_rep.com.RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | lee | `RDETCORR_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCAUSAL`: _por documentar_
- `HCODIGOCB`: _por documentar_
- `HESTADOTX`: _por documentar_
- `hfecpro`: _por documentar_
- `HMUNICB`: _por documentar_
- `HNOMBREPTO`: _por documentar_
- `HNOMTITCB`: _por documentar_
