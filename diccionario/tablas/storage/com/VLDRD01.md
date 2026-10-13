# storage.com.VLDRD01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com` · 17 columna(s) usadas · 1 procedimiento(s) · vista con 39 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com/VLDRD01.sql](../../../../sql/03-tablas/storage/com/VLDRD01.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODOPE` | int not null | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HCODSEC` | varchar(10) | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HCTACLI` | int not null | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HDCLI` | varchar(255) | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HDIAATR` | int | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HDREACC` | varchar(max) | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HDSITCRED` | varchar(255) | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HFFINVIG` | date not null | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HFINIVIG` | date not null | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HHORPRO` | time not null | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HNUMDOC` | varchar(15) | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HPAIS` | smallint | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HSALCAPMN` | float | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HTIPDOC` | tinyint | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HTIPOPE` | smallint not null | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |
| `HTIPSBS` | varchar(255) | ✅ confirmada | [GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLISCAPRET01](../../../procedimientos/mod_rep/com/GLISCAPRET01.md) | lee | `LIS_CAPRET_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODOPE`: _por documentar_
- `HCODSEC`: _por documentar_
- `HCTACLI`: _por documentar_
- `HDCLI`: _por documentar_
- `HDIAATR`: _por documentar_
- `HDREACC`: _por documentar_
- `HDSITCRED`: _por documentar_
- `HFECPRO`: _por documentar_
- `HFFINVIG`: _por documentar_
- `HFINIVIG`: _por documentar_
- `HHORPRO`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HPAIS`: _por documentar_
- `HSALCAPMN`: _por documentar_
- `HTIPDOC`: _por documentar_
- `HTIPOPE`: _por documentar_
- `HTIPSBS`: _por documentar_
