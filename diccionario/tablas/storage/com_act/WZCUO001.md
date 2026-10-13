# storage.com_act.WZCUO001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 24 columna(s) usadas · 6 procedimiento(s) · tabla con 34 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/WZCUO001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/WZCUO001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `anio_des` | smallint | ✅ confirmada | [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md), [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md) | — |
| `haseoper` | varchar(20) | ✅ confirmada | [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `HCODDES` | varchar(20) | ✅ confirmada | [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `HCODOPE` | int | ✅ confirmada | [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `HCODORI` | varchar(20) | ✅ confirmada | [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `HDIAATR` | smallint | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md) | — |
| `HFECPRO` | date | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md), [RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md), [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md), [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `HINDCAR` | varchar(50) | ✅ confirmada | [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md) | — |
| `HSALCAPMN` | numeric(17,2) | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md), [RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md), [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md), [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `nuevo_ingreso` | varchar(5) | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md), [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md) | — |
| `RCODCOR` | smallint | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md), [RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md), [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md), [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `RCODFC` | smallint | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md), [RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md), [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md), [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `RCODGRU` | smallint | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md), [RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md), [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md), [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `RCODTER` | varchar(5) | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md), [RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md), [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md), [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `RCODUCO` | int | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md), [RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md), [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md), [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `RCODUNI` | smallint | ✅ confirmada | [RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md), [RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md), [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md), [RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `RDESCOR` | varchar(50) | ✅ confirmada | [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `RDESGRU` | varchar(50) | ✅ confirmada | [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md) | — |
| `RDESPROD` | varchar(50) | ✅ confirmada | [RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md) | — |
| `RDESSEC` | varchar(250) | ✅ confirmada | [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `RDESTER` | varchar(50) | ✅ confirmada | [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `RDESUCO` | varchar(50) | ✅ confirmada | [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md) | — |
| `RDESUNI` | varchar(50) | ✅ confirmada | [RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md), [RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | — |
| `TRAMO` | varchar(50) | ✅ confirmada | [RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RCARDZCUO01](../../../procedimientos/mod_rep/com/RCARDZCUO01.md) | lee | `RS_CARD_ZCUO_01` |
| [mod_rep.com.RGRAFZCUO01](../../../procedimientos/mod_rep/com/RGRAFZCUO01.md) | lee | `GRAF_ZCUO_01` |
| [mod_rep.com.RGRAFZCUO02](../../../procedimientos/mod_rep/com/RGRAFZCUO02.md) | lee | `GRAF_ZCUO_02` |
| [mod_rep.com.RGRAFZCUO03](../../../procedimientos/mod_rep/com/RGRAFZCUO03.md) | lee | `GRAF_ZCUO_03` |
| [mod_rep.com.RGRAFZCUO04](../../../procedimientos/mod_rep/com/RGRAFZCUO04.md) | lee | `GRAF_ZCUO_04` |
| [mod_rep.com.RTOPZCUO01](../../../procedimientos/mod_rep/com/RTOPZCUO01.md) | lee | `RS_TOP_ZCUO_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `anio_des`: _por documentar_
- `haseoper`: _por documentar_
- `HCODDES`: _por documentar_
- `HCODOPE`: _por documentar_
- `HCODORI`: _por documentar_
- `HDIAATR`: _por documentar_
- `HFECPRO`: _por documentar_
- `HINDCAR`: _por documentar_
- `HSALCAPMN`: _por documentar_
- `nuevo_ingreso`: _por documentar_
- `RCODCOR`: _por documentar_
- `RCODFC`: _por documentar_
- `RCODGRU`: _por documentar_
- `RCODTER`: _por documentar_
- `RCODUCO`: _por documentar_
- `RCODUNI`: _por documentar_
- `RDESCOR`: _por documentar_
- `RDESGRU`: _por documentar_
- `RDESPROD`: _por documentar_
- `RDESSEC`: _por documentar_
- `RDESTER`: _por documentar_
- `RDESUCO`: _por documentar_
- `RDESUNI`: _por documentar_
- `TRAMO`: _por documentar_
