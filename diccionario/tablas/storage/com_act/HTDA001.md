# storage.com_act.HTDA001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 9 columna(s) usadas · 2 procedimiento(s) · tabla con 19 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/HTDA001.sql](../../../../sql/03-tablas/storage/com_act/HTDA001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCANAL` | varchar(250) | 🎯 exacta | [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | — |
| `HDESPROC` | varchar(250) | ≈ inferida | [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md) | — |
| `HFECPRO` | date not null | 🎯 exacta | [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | — |
| `HMONTO` | numeric(17,2) | ≈ inferida | [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md) | — |
| `HNUMDOC` | varchar(20) | 🧩 por estructura | [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | — |
| `HTIPDOC` | smallint | 🧩 por estructura | [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | — |
| `htiptrax` | varchar(1) | ≈ inferida | [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md) | — |
| `HTOTINTE` | smallint | ≈ inferida | [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md) | — |
| `RCODSUC` | smallint | ≈ inferida | [GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRTABAPPO01](../../../procedimientos/mod_rep/com/GRTABAPPO01.md) | lee | `TABDIG_01` |
| [mod_rep.com.GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | lee | `CAP_SEGUI_BP_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCANAL`: _por documentar_
- `HDESPROC`: _por documentar_
- `HFECPRO`: _por documentar_
- `HMONTO`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HTIPDOC`: _por documentar_
- `htiptrax`: _por documentar_
- `HTOTINTE`: _por documentar_
- `RCODSUC`: _por documentar_
