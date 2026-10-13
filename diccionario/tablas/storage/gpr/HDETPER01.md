# storage.gpr.HDETPER01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `gpr` · 10 columna(s) usadas · 2 procedimiento(s) · tabla con 14 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/gpr/HDETPER01.sql](../../../../extraccion/sql/03-tablas/storage/gpr/HDETPER01.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCIIU` | varchar(6) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | — |
| `HCIUINFO` | varchar(max) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | — |
| `HEMAIL` | varchar(150) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | — |
| `HNUMDOC` | varchar(20) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HNUMTELE` | varchar(20) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HPAIS` | smallint | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HTELEINFO` | varchar(max) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | — |
| `HTIPDOC` | smallint | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HVERCIIU` | bit | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | — |
| `HVERTEL` | varchar(100) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | lee | `DET_CLI_01` |
| [mod_rep.com.GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | lee | `RES_SEC_REP_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCIIU`: _por documentar_
- `HCIUINFO`: _por documentar_
- `HEMAIL`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HNUMTELE`: _por documentar_
- `HPAIS`: _por documentar_
- `HTELEINFO`: _por documentar_
- `HTIPDOC`: _por documentar_
- `HVERCIIU`: _por documentar_
- `HVERTEL`: _por documentar_
