# storage.com_act.VCAH005

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 9 columna(s) usadas · 3 procedimiento(s) · tabla con 10 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/VCAH005.sql](../../../../extraccion/sql/03-tablas/storage/com_act/VCAH005.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `haseoper` | varchar(10) | ✅ confirmada | [RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md), [RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `HCODOPE` | int | ✅ confirmada | [RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md), [RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `hfecpro` | date not null | ✅ confirmada | [RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md), [RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `HMONDESMN` | numeric(37,8) | ✅ confirmada | [RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md), [RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `HNUMTAS` | numeric(17,6) | ✅ confirmada | [RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md), [RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md), [RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | — |
| `idrango` | int | 🎯 exacta | [RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md), [RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md) | — |
| `idrango2` | int | 🎯 exacta | [RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md), [RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md) | — |
| `RangoDesembolso` | varchar(23) not null | 🎯 exacta | [RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md), [RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md) | — |
| `RangoDesembolso2` | varchar(21) not null | 🎯 exacta | [RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md), [RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSDESEMB](../../../procedimientos/mod_rep/com/RSDESEMB.md) | lee | `RS_DESEMB_01` |
| [mod_rep.com.RSDESEMB02](../../../procedimientos/mod_rep/com/RSDESEMB02.md) | lee | `RS_DESEMB_02` |
| [mod_rep.com.RSRDFCA037](../../../procedimientos/mod_rep/com/RSRDFCA037.md) | lee | `CMG_CARTERA_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `haseoper`: _por documentar_
- `HCODOPE`: _por documentar_
- `hfecpro`: _por documentar_
- `HMONDESMN`: _por documentar_
- `HNUMTAS`: _por documentar_
- `idrango`: _por documentar_
- `idrango2`: _por documentar_
- `RangoDesembolso`: _por documentar_
- `RangoDesembolso2`: _por documentar_
