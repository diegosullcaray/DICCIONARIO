# storage.com_seg.retp003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_seg` · 5 columna(s) usadas · 2 procedimiento(s) · tabla con 5 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_seg/retp003.sql](../../../../extraccion/sql/03-tablas/storage/com_seg/retp003.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `hcodmod` | int | ✅ confirmada | [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md) | — |
| `HCODSEG` | int | ✅ confirmada | [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md) | — |
| `HDESSEG` | varchar(255) | ✅ confirmada | [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md) | — |
| `HSUBTIP` | int | ✅ confirmada | [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md) | — |
| `HTIPOPE` | int | ✅ confirmada | [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md) | lee | `GRSCMISREP_01` |
| [mod_rep.com.GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md) | lee | `GRSCMIS_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hcodmod`: _por documentar_
- `HCODSEG`: _por documentar_
- `HDESSEG`: _por documentar_
- `HSUBTIP`: _por documentar_
- `HTIPOPE`: _por documentar_
