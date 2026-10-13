# storage.com_act.WAPPCLI001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 3 columna(s) usadas · 2 procedimiento(s) · tabla con 11 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/WAPPCLI001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/WAPPCLI001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HAGUSER` | varchar(250) | ✅ confirmada | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `HFECPRO` | date | ✅ confirmada | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | — |
| `htipnumdoc` | varchar(250) | 🎯 exacta | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md), [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | lee | `RMENTORIN_01` |
| [mod_rep.com.GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | lee | `CAP_SEGUI_BP_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HAGUSER`: _por documentar_
- `HFECPRO`: _por documentar_
- `htipnumdoc`: _por documentar_
