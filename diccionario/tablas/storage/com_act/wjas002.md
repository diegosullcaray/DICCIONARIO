# storage.com_act.wjas002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 7 columna(s) usadas · 3 procedimiento(s) · tabla con 15 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/wjas002.sql](../../../../sql/03-tablas/storage/com_act/wjas002.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCAST12M` | float | 🧩 por estructura | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `hcodrel` | varchar(255) | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HFECPRO` | varchar(255) | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md), [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HRECCAST12M` | float | 🧩 por estructura | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `htipcod` | int | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HVENTA_CARTMN` | float | ≈ inferida | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md) | — |
| `HVENTA_CARTMN12M` | float | 🧩 por estructura | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md) | lee | `cuadro_Variable_Riesgo_01`, `cuadro_Variable_M_01` |
| [mod_rep.com.GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | lee | `cuadro_Variable_Riesgo_F_01` |
| [mod_rep.com.GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | lee | `SEGUI_COMITE_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hcodrel`: _por documentar_
- `HFECPRO`: _por documentar_
- `htipcod`: _por documentar_
- `HVENTA_CARTMN`: _por documentar_
- `HVENTA_CARTMN12M`: _por documentar_
