# storage.com_act.HMMEF001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 11 columna(s) usadas · 4 procedimiento(s) · tabla con 11 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/HMMEF001.sql](../../../../sql/03-tablas/storage/com_act/HMMEF001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HFECPRO` | date | ✅ confirmada | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `HTR121TO150` | float | 🗄️ motor | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `HTR151TO180` | float | 🗄️ motor | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `HTR180TO` | float | 🗄️ motor | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `HTR1TO30` | float | 🗄️ motor | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `HTR30TO0` | float | 🗄️ motor | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `HTR31TO60` | float | 🗄️ motor | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `HTR61TO90` | float | 🗄️ motor | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `HTR91TO120` | float | 🗄️ motor | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `HTRJUDI` | float | 🗄️ motor | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |
| `RCODGRU` | smallint | ✅ confirmada | [RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md), [RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md), [RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md), [RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSMONEFE01](../../../procedimientos/mod_rep/com/RSMONEFE01.md) | lee | `RS_MON_EFEC_01`, `RS_MON_EFECM_01` |
| [mod_rep.com.RSMONEFER01](../../../procedimientos/mod_rep/com/RSMONEFER01.md) | lee | `RS_MON_EFECREASIG_01`, `RS_MON_EFECREASIGM_01` |
| [mod_rep.com.RSMONEFEREPRO01](../../../procedimientos/mod_rep/com/RSMONEFEREPRO01.md) | lee | `RS_MON_EFECREPRO_01` |
| [mod_rep.com.RSMONEFETRC01](../../../procedimientos/mod_rep/com/RSMONEFETRC01.md) | lee | `RS_MON_EFECTRAMOSC_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HFECPRO`: _por documentar_
- `RCODGRU`: _por documentar_
