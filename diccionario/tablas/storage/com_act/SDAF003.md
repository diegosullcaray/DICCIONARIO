# storage.com_act.SDAF003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 11 columna(s) usadas · 6 procedimiento(s) · tabla con 17 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/SDAF003.sql](../../../../extraccion/sql/03-tablas/storage/com_act/SDAF003.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SCODAGR` | int | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md), [RSRDFCA038](../../../procedimientos/mod_rep/com/RSRDFCA038.md), [RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | — |
| `SCODMOD` | smallint | ≈ inferida | [RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | — |
| `SCODSEC` | varchar(10) | 🗄️ motor | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md), [RSRDFCA038](../../../procedimientos/mod_rep/com/RSRDFCA038.md) | — |
| `SFECDES` | date | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md), [RSRDFCA038](../../../procedimientos/mod_rep/com/RSRDFCA038.md), [RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | — |
| `SFECPRO` | date | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md), [RSRDFCA038](../../../procedimientos/mod_rep/com/RSRDFCA038.md), [RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | — |
| `SHORPRO` | tinyint | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md), [RSRDFCA038](../../../procedimientos/mod_rep/com/RSRDFCA038.md), [RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | — |
| `SMONDESMN` | numeric(32,2) | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md), [RSRDFCA038](../../../procedimientos/mod_rep/com/RSRDFCA038.md), [RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | — |
| `SNUMOPE` | int | ✅ confirmada | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md), [RSRDFCA038](../../../procedimientos/mod_rep/com/RSRDFCA038.md), [RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | — |
| `SSUBTIP` | int | ≈ inferida | [RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | — |
| `SSUCCLI` | smallint | 🗄️ motor | [RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md), [RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md), [RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md), [RSRDFCA038](../../../procedimientos/mod_rep/com/RSRDFCA038.md) | — |
| `STIPOPE` | smallint | ≈ inferida | [RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSRDFCA027](../../../procedimientos/mod_rep/com/RSRDFCA027.md) | lee | `Monitor_Dese_01` |
| [mod_rep.com.RSRDFCA028](../../../procedimientos/mod_rep/com/RSRDFCA028.md) | lee | `Monitor_Dese_03` |
| [mod_rep.com.RSRDFCA030](../../../procedimientos/mod_rep/com/RSRDFCA030.md) | lee | `Monitor_Dese_02` |
| [mod_rep.com.RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | lee | `CMG_CARTERA_02` |
| [mod_rep.com.RSRDFCA038](../../../procedimientos/mod_rep/com/RSRDFCA038.md) | lee | `CMG_CARTERA_03` |
| [mod_rep.com.RSRDFCA050](../../../procedimientos/mod_rep/com/RSRDFCA050.md) | lee | `Monitor_Dese_misi_01` |
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
