# storage.com_pas.wjas005

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 14 columna(s) usadas · 1 procedimiento(s) · tabla con 18 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_pas/wjas005.sql](../../../../sql/03-tablas/storage/com_pas/wjas005.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `CANAL` | int | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `CANT_TX_ANIO_ACT` | int | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `CANT_TX_MES_ACT` | int | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `CANT_TX_MES_ANT` | int | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `CANT_TX_ULT_DIA` | int | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `EMPRESA` | varchar(250) | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `HCODREL` | varchar(50) | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `HFECPRO` | varchar(10) not null | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `HTIPCOD` | int not null | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `MON_TX_ANIO_ACT` | numeric(38,2) | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `MON_TX_MES_ACT` | numeric(38,2) | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `MON_TX_MES_ANT` | numeric(38,2) | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `MON_TX_ULT_DIA` | numeric(38,2) | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |
| `SERVICIO` | varchar(250) | ✅ confirmada | [RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSRSRV001](../../../procedimientos/mod_rep/com/RSRSRV001.md) | lee | `RECSERV_PAS_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `CANAL`: _por documentar_
- `CANT_TX_ANIO_ACT`: _por documentar_
- `CANT_TX_MES_ACT`: _por documentar_
- `CANT_TX_MES_ANT`: _por documentar_
- `CANT_TX_ULT_DIA`: _por documentar_
- `EMPRESA`: _por documentar_
- `HCODREL`: _por documentar_
- `HFECPRO`: _por documentar_
- `HTIPCOD`: _por documentar_
- `MON_TX_ANIO_ACT`: _por documentar_
- `MON_TX_MES_ACT`: _por documentar_
- `MON_TX_MES_ANT`: _por documentar_
- `MON_TX_ULT_DIA`: _por documentar_
- `SERVICIO`: _por documentar_
