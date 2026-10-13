# storage.com_act.VRPDM001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 20 columna(s) usadas · 1 procedimiento(s) · vista con 28 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/VRPDM001.sql](../../../../sql/03-tablas/storage/com_act/VRPDM001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODSEC` | varchar(255) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HCTACLI` | int not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HDCLI` | varchar(255) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HDGRP` | varchar(255) not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HDIAATR` | int | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HENTID` | int | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HFFINVIG` | date not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HFINIVIG` | date not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HFUVEN` | date | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HHORPRO` | time | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HMONDESMN` | numeric(17,2) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HNUMDOC` | varchar(255) not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HPAIS` | int not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HSEMF` | varchar(8) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HTELF01` | varchar(20) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HTIPBASE` | varchar(20) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HTIPDOC` | tinyint not null | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HTIPIN` | varchar(50) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |
| `HTIPOF` | varchar(50) | ✅ confirmada | [GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLISDETCLIPDM01](../../../procedimientos/mod_rep/com/GLISDETCLIPDM01.md) | lee | `REACT_PDM_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODSEC`: _por documentar_
- `HCTACLI`: _por documentar_
- `HDCLI`: _por documentar_
- `HDGRP`: _por documentar_
- `HDIAATR`: _por documentar_
- `HENTID`: _por documentar_
- `HFECPRO`: _por documentar_
- `HFFINVIG`: _por documentar_
- `HFINIVIG`: _por documentar_
- `HFUVEN`: _por documentar_
- `HHORPRO`: _por documentar_
- `HMONDESMN`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HPAIS`: _por documentar_
- `HSEMF`: _por documentar_
- `HTELF01`: _por documentar_
- `HTIPBASE`: _por documentar_
- `HTIPDOC`: _por documentar_
- `HTIPIN`: _por documentar_
- `HTIPOF`: _por documentar_
