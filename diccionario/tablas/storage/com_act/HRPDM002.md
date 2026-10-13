# storage.com_act.HRPDM002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 8 columna(s) usadas · 1 procedimiento(s) · tabla con 13 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/HRPDM002.sql](../../../../sql/03-tablas/storage/com_act/HRPDM002.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HFFINVIG` | date not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HFINIVIG` | date not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HHORPRO` | time not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HMOREACC` | varchar(255) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HNUMDOC` | varchar(25) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HPAIS` | smallint | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HREACC` | varchar(255) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HTIPDOC` | smallint | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | lee | `REACT_PDM_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HFFINVIG`: _por documentar_
- `HFINIVIG`: _por documentar_
- `HHORPRO`: _por documentar_
- `HMOREACC`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HPAIS`: _por documentar_
- `HREACC`: _por documentar_
- `HTIPDOC`: _por documentar_
