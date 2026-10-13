# storage.com_act.SBTVRIE001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 12 columna(s) usadas · 2 procedimiento(s) · tabla con 13 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/SBTVRIE001.sql](../../../../sql/03-tablas/storage/com_act/SBTVRIE001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SCODREL` | varchar(100) not null | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `SFECPRO` | date not null | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `SGASPROVBRUTO12M` | float | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `SGASPROVCART` | float | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `SGASPROVCONTA` | float | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `SGASPROVOM3155` | float | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `SGASPROVVOLU` | float | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `SMONREC` | numeric(38,6) | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `SRECCAST12M` | float | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `SSTKPROV` | float | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `STASREC` | numeric(38,6) | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |
| `STIPCOD` | int not null | 🎯 exacta | [GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md), [GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GCMGMORA001](../../../procedimientos/mod_rep/com/GCMGMORA001.md) | lee | `cuadro_Variable_Riesgo_01`, `cuadro_Variable_M_01` |
| [mod_rep.com.GCMGMORA003](../../../procedimientos/mod_rep/com/GCMGMORA003.md) | lee | `cuadro_Variable_Riesgo_F_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `SCODREL`: _por documentar_
- `SFECPRO`: _por documentar_
- `SGASPROVBRUTO12M`: _por documentar_
- `SGASPROVCART`: _por documentar_
- `SGASPROVCONTA`: _por documentar_
- `SGASPROVOM3155`: _por documentar_
- `SGASPROVVOLU`: _por documentar_
- `SMONREC`: _por documentar_
- `SRECCAST12M`: _por documentar_
- `SSTKPROV`: _por documentar_
- `STASREC`: _por documentar_
- `STIPCOD`: _por documentar_
