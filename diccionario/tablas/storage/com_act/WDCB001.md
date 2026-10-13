# storage.com_act.WDCB001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 25 columna(s) usadas · 1 procedimiento(s) · tabla con 26 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WDCB001.sql](../../../../sql/03-tablas/storage/com_act/WDCB001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HAVG_ASIST` | float not null | 🧩 por estructura | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HAVG_DURA` | int not null | 🧩 por estructura | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HAVG_OPE` | int not null | 🧩 por estructura | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `hcodrel` | varchar(50) | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HCOM_10_20K` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HCOM_10K` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HCOM_DESEMB` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HCOM_FIRMA` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HCOM_FISICO` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HCOM_M20K` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HCOM_SDESEMB` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HCOM_SFIRMA` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HCOM_VIRTUAL` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HDESEMB_COM` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HDESEMB_SCOM` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HFECPRO` | date | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HMAX_ASIST` | float not null | 🧩 por estructura | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HMAX_DURA` | smallint not null | 🧩 por estructura | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HMAX_OPE` | int not null | 🧩 por estructura | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HNUM_COMITE` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HSCOM_10_20K` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HSCOM_10K` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HSCOM_M20K` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `htipcod` | int | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |
| `HTOT_OPEDESEMB` | int not null | 🎯 exacta | [GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GCOMCRE01](../../../procedimientos/mod_rep/com/GCOMCRE01.md) | lee | `SEGUI_COMITE_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hcodrel`: _por documentar_
- `HCOM_10_20K`: _por documentar_
- `HCOM_10K`: _por documentar_
- `HCOM_DESEMB`: _por documentar_
- `HCOM_FIRMA`: _por documentar_
- `HCOM_FISICO`: _por documentar_
- `HCOM_M20K`: _por documentar_
- `HCOM_SDESEMB`: _por documentar_
- `HCOM_SFIRMA`: _por documentar_
- `HCOM_VIRTUAL`: _por documentar_
- `HDESEMB_COM`: _por documentar_
- `HDESEMB_SCOM`: _por documentar_
- `HFECPRO`: _por documentar_
- `HNUM_COMITE`: _por documentar_
- `HSCOM_10_20K`: _por documentar_
- `HSCOM_10K`: _por documentar_
- `HSCOM_M20K`: _por documentar_
- `htipcod`: _por documentar_
- `HTOT_OPEDESEMB`: _por documentar_
