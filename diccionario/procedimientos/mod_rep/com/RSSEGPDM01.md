# mod_rep.com.RSSEGPDM01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSSEGPDM01.sql](../../../../procedimientos/mod_rep/com/RSSEGPDM01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSSEGPDM01.sql](../../../../sql/01-extraccion/mod_rep/com/RSSEGPDM01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSSEGPDM01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSSEGPDM01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `SEG_PDM_01` | Seguimiento PDM | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Reportes PDM |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.WPDM001](../../../tablas/storage/com_act/WPDM001.md) | lee | `HCODREL`, `HFECPRO`, `HNROG`, `HNROG_ANT`, `HNROG_DESEM`, `HNUMCLI`, `HNUMCLI_ANT`, `HSALCAPMN`, `HSALCAPMN_1_30`, `HSALCAPMN_1_30_ANT`, `HSALCAPMN_ANT`, `HSALCAPMN_ma_30`, `HSALCAPMN_ma_30_ANT`, `HTIPCOD`, `HULTVEN_RECUR_DESEM`, `NUEVO_DESEM`, `RECURRENTE_DESEM` | estatico + motor |
| [storage.com.metas_saldos](../../../tablas/storage/com/metas_saldos.md) | lee | `10044`≈, `10062`≈, `8000`≈, `HCODREL`≈, `HCODVAR`≈, `HFECPRO`≈, `HTIPCOD`≈, `HTIPMETA`≈, `HVALVAR`≈, `PVT`≈ | estatico + motor |
| [storage.ref.wjercor03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESTER`, `RDESUCO`, `RDESUNI` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `jerar`, `metas`
- Temporales: `#PRIM`, `#SEC`
- ⚠️ Columna sin resolver `HDESREL` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HNUMCLI_ANT` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `10062` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HNUMCLI` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HNROG_ANT` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `10044` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HNROG` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `NUEVO_DESEM` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HNROG_DESEM` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HULTVEN_RECUR_DESEM` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `RECURRENTE_DESEM` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HSALCAPMN_ANT` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `8000` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HSALCAPMN` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HSALCAPMN_1_30_ANT` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HSALCAPMN_1_30` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HSALCAPMN_ma_30_ANT` (¿storage.com_act.WPDM001?)
- ⚠️ Columna sin resolver `HSALCAPMN_ma_30` (¿storage.com_act.WPDM001?)
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
