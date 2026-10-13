# storage.com_act.WBCR001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 17 columna(s) usadas · 1 procedimiento(s) · tabla con 17 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/WBCR001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/WBCR001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HBGCTACLI` | varchar(6) | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HBGNOMCLI` | varchar(6) | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HCODOPE` | int | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HCODSEC` | varchar(10) | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HCTACLI` | int | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HCUOPEN` | smallint | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HDESCLI` | varchar(40) | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HFECDES` | date | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HFECMOR` | date | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HFLAGREAC` | varchar(2) not null | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HGRUPROD` | varchar(10) not null | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HNOMG` | varchar(80) | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HNUMDOC` | varchar(20) | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HPAIS` | smallint | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HSALCAPMN` | numeric(17,2) | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `HTIPDOC` | smallint | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |
| `RDESPROD` | varchar(150) | ✅ confirmada | [GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRESCLIREP01](../../../procedimientos/mod_rep/com/GRESCLIREP01.md) | lee | `RES_SEC_REP_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HBGCTACLI`: _por documentar_
- `HBGNOMCLI`: _por documentar_
- `HCODOPE`: _por documentar_
- `HCODSEC`: _por documentar_
- `HCTACLI`: _por documentar_
- `HCUOPEN`: _por documentar_
- `HDESCLI`: _por documentar_
- `HFECDES`: _por documentar_
- `HFECMOR`: _por documentar_
- `HFLAGREAC`: _por documentar_
- `HGRUPROD`: _por documentar_
- `HNOMG`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HPAIS`: _por documentar_
- `HSALCAPMN`: _por documentar_
- `HTIPDOC`: _por documentar_
- `RDESPROD`: _por documentar_
