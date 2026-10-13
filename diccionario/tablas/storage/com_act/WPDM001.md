# storage.com_act.WPDM001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 17 columna(s) usadas · 1 procedimiento(s) · tabla con 17 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WPDM001.sql](../../../../sql/03-tablas/storage/com_act/WPDM001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODREL` | varchar(255) | ✅ confirmada | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HFECPRO` | varchar(255) | ✅ confirmada | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HNROG` | int | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HNROG_ANT` | int | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HNROG_DESEM` | int | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HNUMCLI` | int | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HNUMCLI_ANT` | int | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HSALCAPMN` | float | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HSALCAPMN_1_30` | float | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HSALCAPMN_1_30_ANT` | float | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HSALCAPMN_ANT` | float | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HSALCAPMN_ma_30` | float | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HSALCAPMN_ma_30_ANT` | float | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HTIPCOD` | int | ✅ confirmada | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `HULTVEN_RECUR_DESEM` | int | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `NUEVO_DESEM` | int | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |
| `RECURRENTE_DESEM` | int | 🗄️ motor | [RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSSEGPDM01](../../../procedimientos/mod_rep/com/RSSEGPDM01.md) | lee | `SEG_PDM_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODREL`: _por documentar_
- `HFECPRO`: _por documentar_
- `HTIPCOD`: _por documentar_
