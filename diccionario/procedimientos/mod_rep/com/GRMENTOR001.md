# mod_rep.com.GRMENTOR001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRMENTOR001.sql](../../../../procedimientos/mod_rep/com/GRMENTOR001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRMENTOR001.sql](../../../../sql/01-extraccion/mod_rep/com/GRMENTOR001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRMENTOR001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRMENTOR001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RMENTORIN_01` | Reporte Mentoring 01 | `tip_cod`, `cod_rel`, `fec`, `resp` | reportes / actividad-diaria / Campañas |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@resp` | varchar(250) | — |  | `resp` |

### Tablas y columnas (18)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.SDAE002](../../../tablas/storage/com_act/SDAE002.md) | lee | `scodagr`, `SCODSEC`, `sfecpro`, `SSALINIMN`, `SSALMAN01MN`, `SSALRECMN` | estatico + motor |
| [storage.com_act.SDAE003](../../../tablas/storage/com_act/SDAE003.md) | lee | `scodagr`, `SCODSEC`, `sfecpro`, `SSALINIMN`, `SSALMAN01MN`, `SSALRECMN` | estatico + motor |
| [storage.com_act.SDAF002](../../../tablas/storage/com_act/SDAF002.md) | lee | `SCODAGR`, `scodsec`, `sfecpro`, `SNUMOPE` | estatico + motor |
| [storage.com_act.SDAS001](../../../tablas/storage/com_act/SDAS001.md) | lee | `SCODAGR`, `scodsec`, `sfecpro`, `SSALCAPMN` | estatico + motor |
| [storage.com_act.wacli001](../../../tablas/storage/com_act/WACLI001.md) | lee | `hclinue`, `HCODSEC`, `hconcli`, `hfecpro`, `hinddes` | estatico + motor |
| [storage.com_act.WAPPCLI001](../../../tablas/storage/com_act/WAPPCLI001.md) | lee | `HAGUSER`, `HFECPRO`, `htipnumdoc` | estatico + motor |
| [storage.com_act.WCDCE001](../../../tablas/storage/com_act/WCDCE001.md) | lee | `HCODOPE`, `HCODSEC`, `hfecpro` | estatico + motor |
| [storage.com_act.WCLIRETE001](../../../tablas/storage/com_act/WCLIRETE001.md) | lee | `HFECPRO`, `HNUMCLISTOCK`, `HNUMRETENCION`, `SCODSEC` | estatico + motor |
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `hcodrel`, `hfecpro`, `HNUMCLI`, `htipcod` | estatico + motor |
| [storage.com_seg.SDSF001](../../../tablas/storage/com_seg/SDSF001.md) | lee | `scodagr`, `SCODSEC`, `scodseg`, `SFECPRO`, `SNUMPLZ` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HVALVAR` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUNI`, `RFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, '"fec"', @columns, =, '"vars"', @config, =, @tconf | no |

### Columnas que devuelve

1. `descrip`, `hfecpro`, `100`, `165`, `5006`, `126`, `122`, `0002`, `0003`, `0001`, `5001`, `5003`
2. `descrip`, `hfecpro`, `100`, `165`, `5006`, `126`, `122`, `0002`, `0003`, `0001`, `5001`, `5003`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_cartera`, `cte_ce`, `cte_clientes`, `cte_clientesnuevos`, `cte_desembolsos`, `cte_enrolamiento`, `cte_into`, `cte_m`, `cte_metas`, `cte_mm`, `cte_mora_1a30`, `cte_mora_30a0`, `cte_retencion`, `cte_seguros`, `cte_union`
- Temporales: `#DES`, `#Diario`, `#FECS`, `#MAnterior`, `#Metas`, `#Metas2`, `#fecs`
- ⚠️ Columna sin resolver `SNUMPLZ` (¿storage.com_seg.SDSF001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HNUMRETENCION` (¿storage.com_act.WCLIRETE001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HNUMCLISTOCK` (¿storage.com_act.WCLIRETE001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HCODVAR` (¿storage.com.VDMCOM01?)
- ⚠️ Columna sin resolver `HTIPCOD` (¿storage.com.VDMCOM01?)
- ⚠️ Columna sin resolver `HCODREL` (¿storage.com.VDMCOM01?)
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
