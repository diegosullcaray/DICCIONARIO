# storage.com_act.SDAS021

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 10 columna(s) usadas · 3 procedimiento(s) · tabla con 13 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/SDAS021.sql](../../../../extraccion/sql/03-tablas/storage/com_act/SDAS021.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SAGENCI` | varchar(250) | 🧩 por estructura | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |
| `SCORRED` | varchar(250) | 🧩 por estructura | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |
| `SCORRES` | varchar(250) | ✅ confirmada | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md), [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md) | — |
| `sfecpro` | date | 🎯 exacta | [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |
| `SMONTO` | numeric(17,2) | 🧩 por estructura | [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |
| `SNUMCORRE` | int | 🧩 por estructura | [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |
| `SNUMTRANS` | int | 🧩 por estructura | [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |
| `STERRIT` | varchar(250) | 🧩 por estructura | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |
| `STICKPROM` | numeric(17,2) | 🧩 por estructura | [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |
| `STIPTRA` | varchar(250) | 🧩 por estructura | [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md) | lee | `TABDIG_02` |
| [mod_rep.com.RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | lee | `GREPORCORRE_01` |
| [mod_rep.com.RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md) | lee | `GREPORCORRE_05` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `SCORRES`: _por documentar_
- `sfecpro`: _por documentar_
