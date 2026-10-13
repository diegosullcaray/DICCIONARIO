# storage.com_pas.WTRXMONE001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 7 columna(s) usadas · 2 procedimiento(s) · tabla con 9 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_pas/WTRXMONE001.sql](../../../../extraccion/sql/03-tablas/storage/com_pas/WTRXMONE001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `*` | ⚠️ no existe | 🎯 exacta | [GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | — |
| `HDESPROC` | varchar(255) | 🧩 por estructura | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md) | — |
| `HNUMDOC` | varchar(255) | 🎯 exacta | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | — |
| `HTIPDOC` | int | 🎯 exacta | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | — |
| `HTIPTRAX` | varchar(255) | 🧩 por estructura | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md) | — |
| `HTOTINTE` | float | 🧩 por estructura | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md) | — |
| `RCODSUC` | int | 🎯 exacta | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md) | lee | `TABDIG_VR2_01` |
| [mod_rep.com.GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | lee | `TABDIG_VR2_COM_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `*`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HTIPDOC`: _por documentar_
- `RCODSUC`: _por documentar_
