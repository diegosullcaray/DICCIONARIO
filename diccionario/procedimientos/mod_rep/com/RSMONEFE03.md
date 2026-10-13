# mod_rep.com.RSMONEFE03

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSMONEFE03.sql](../../../../extraccion/procedimientos/mod_rep/com/RSMONEFE03.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSMONEFE03.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSMONEFE03.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSMONEFE03.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSMONEFE03.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_MON_EFEC_03` | Gestión de Monitor Efectividades | `tip_cod`, `cod_rel`, `tram` | reportes / actividad-diaria / Cartera en Mora |
| `RS_MON_EFECM_03` | Gestión de Monitor Efectividades Mensual | `tip_cod`, `cod_rel`, `tram` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | nvarchar(10) | — |  | `tip_cod` |
| 2 | `@cod_rel` | nvarchar(10) | — |  | `cod_rel` |
| 3 | `@tram` | nvarchar(20) | — |  | `tram` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WCED001](../../../tablas/storage/com_act/WCED001.md) | lee | `HCODSEC`, `HESTACT`, `HFCRES`, `HFGPR`, `HSALCAPMN`, `HTRAM` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `rep.FTHEACOLS01` | 'RS_MON_EFEC_03' | no |

### Columnas que devuelve

`style`, `desc`, `count`, `sum`, `percent`

### Observaciones del análisis

- CTE: `cte_base`, `cte_count`, `cte_cp`, `cte_otr`, `cte_report`, `cte_t`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
