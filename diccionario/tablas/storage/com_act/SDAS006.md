# storage.com_act.SDAS006

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 9 columna(s) usadas · 1 procedimiento(s) · tabla con 17 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/SDAS006.sql](../../../../extraccion/sql/03-tablas/storage/com_act/SDAS006.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SCARGO` | ⚠️ no existe | 🎯 exacta | [RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | — |
| `SCODAGR` | int | 🎯 exacta | [RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | — |
| `SFECPRO` | date | 🎯 exacta | [RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | — |
| `SOPECONF` | int | 🎯 exacta | [RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | — |
| `SOPEPOST` | int | 🧩 por estructura | [RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | — |
| `SOPEPRE` | int | 🎯 exacta | [RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | — |
| `SOPEREGR` | int | 🧩 por estructura | [RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | — |
| `SOPESEAL` | int | 🧩 por estructura | [RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | — |
| `SSUCCLI` | numeric(3,0) | 🎯 exacta | [RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSPANSUP003](../../../procedimientos/mod_rep/com/RSPANSUP003.md) | lee | `PANEL_SUP_03` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `SCARGO`: _por documentar_
- `SCODAGR`: _por documentar_
- `SFECPRO`: _por documentar_
- `SOPECONF`: _por documentar_
- `SOPEPRE`: _por documentar_
- `SSUCCLI`: _por documentar_
