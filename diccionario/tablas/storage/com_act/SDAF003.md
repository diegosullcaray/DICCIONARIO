# storage.com_act.SDAF003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 8 columna(s) usadas · 4 procedimiento(s) · tabla con 17 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/SDAF003.sql](../../../../sql/03-tablas/storage/com_act/SDAF003.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SCODAGR` | int | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `SCODSEC` | varchar(10) | 🗄️ motor | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `SFECDES` | date | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `SFECPRO` | date | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `SHORPRO` | tinyint | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `SMONDESMN` | numeric(32,2) | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `SNUMOPE` | int | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `SSUCCLI` | smallint | 🗄️ motor | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md) | lee | `Monitor_Dese_01` |
| [mod_rep.com.RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md) | lee | `Monitor_Dese_03` |
| [mod_rep.com.RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md) | lee | `Monitor_Dese_02` |
| [mod_rep.com.RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | lee | `CMG_CARTERA_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `SCODAGR`: _por documentar_
- `SFECDES`: _por documentar_
- `SFECPRO`: _por documentar_
- `SHORPRO`: _por documentar_
- `SMONDESMN`: _por documentar_
- `SNUMOPE`: _por documentar_
