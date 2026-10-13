# mod_rep.com.RSMONEFE05

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSMONEFE05.sql](../../../../extraccion/procedimientos/mod_rep/com/RSMONEFE05.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSMONEFE05.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSMONEFE05.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSMONEFE05.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSMONEFE05.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_MON_EFEC_SEC_01` | Detalle de Efectividades Asesor | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `tdcr`, `pagen` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | nvarchar(100) | — |  | `cod_rel` |
| 3 | `@tramof` | varchar(20) | — |  | `tramof` |
| 4 | `@prod` | varchar(50) | — |  | `prod` |
| 5 | `@comp_r` | varchar(20) | — |  | `comp_r` |
| 6 | `@zcuo` | varchar(20) | — |  | `zcuo` |
| 7 | `@ucuo` | varchar(20) | — |  | `ucuo` |
| 8 | `@tdcr` | varchar(50) | — |  | `tdcr` |
| 9 | `@pagen` | int | — |  | `pagen` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WCED001](../../../tablas/storage/com_act/WCED001.md) | lee | `HCODMON`, `HCODOPE`, `HCODSEC`, `HCTACLI`, `HDCODSEC`, `HDESCLI`, `HDIAATR`, `HESTC`, `HFCCOM`, `HFCFGEST`, `HFCFVPP`, `HFCMPP`, `HFCRES`, `HFCRSPB`, `HFDGPR`, `HFECDES`, `HFGPR`, `HFTVEN`, `HINDUCUO`, `HINDZCUO`, `HMONDES`, `HNIVSOB`, `HPROBR`, `HREGG`, `HREGN`, `HSALCAPMN`, `HTRAM`, `RDESPROD` | estatico + motor |
| [storage.gpr.HPPC001](../../../tablas/storage/gpr/HPPC001.md) | lee | `HCODBT`, `HFECPRO`, `HNUMDOC` | motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`≈, `HNUMDOC`≈ | estatico |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `Total`

### Observaciones del análisis

- CTE: `a`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
