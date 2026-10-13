# storage.com_act.BTPCRA001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 27 columna(s) usadas · 1 procedimiento(s) · tabla con 26 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/BTPCRA001.sql](../../../../sql/03-tablas/storage/com_act/BTPCRA001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `*` | ⚠️ no existe | 🎯 exacta | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `CARGO_ADM` | varchar(255) | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `FECHA_INGRESO` | datetime | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `HFECPRO` | date | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SAGENCIA` | varchar(255) | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SAUTSUG` | varchar(255) | ✅ confirmada | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SAUTWF` | int | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SAVGMRAPROB` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SC12M1` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SC12M2` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SC12M3` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SC12MACUM` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SC3M1` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SC3M2` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SC3M3` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SC3MACUM` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SCODSEC` | varchar(255) | ✅ confirmada | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SCOMENT` | varchar(255) | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `Segmentacion` | varchar(255) | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SFILMR` | varchar(255) | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SMRAPROB1` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SMRAPROB2` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SMRAPROB3` | float | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SNOMADM` | varchar(255) | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `SREGION` | varchar(255) | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `STERRITORIO` | varchar(255) | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |
| `usuario` | varchar(255) | 🗄️ motor | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | lee | `LST_AUT_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `*`: _por documentar_
- `SAUTSUG`: _por documentar_
- `SCODSEC`: _por documentar_
