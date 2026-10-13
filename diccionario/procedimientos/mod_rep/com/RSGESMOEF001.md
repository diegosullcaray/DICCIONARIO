# mod_rep.com.RSGESMOEF001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSGESMOEF001.sql](../../../../procedimientos/mod_rep/com/RSGESMOEF001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSGESMOEF001.sql](../../../../sql/01-extraccion/mod_rep/com/RSGESMOEF001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSGESMOEF001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSGESMOEF001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `rma/administracion/Mora/monitor_efectividad_rma_03` | Gestión de Monitor Efectividades | `tip_cod`, `cod_rel`, `tram` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | nvarchar(10) | — |  | `tip_cod` |
| 2 | `@cod_rel` | nvarchar(10) | — |  | `cod_rel` |
| 3 | `@tram` | nvarchar(20) | — |  | `tram` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.VLCH001](../../../tablas/storage/com_act/VLCH001.md) | lee | `RCODCOR`, `RCODPAR` | estatico + motor |
| [storage.com_act.WCED001](../../../tablas/storage/com_act/WCED001.md) | lee | `HCODSEC`, `HESTACT`, `HFCRES`, `HFGPR`, `HSALCAPMN`, `HTRAM`, `RCODMAT`, `RCODREG`, `RCODTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `rep.FTHEACOLS01` | 'rda/administracion/mora/monitor_efectividades_03' | no |

### Columnas que devuelve

`style`, `desc`, `count`, `sum`, `percent`

### Observaciones del análisis

- CTE: `cte_base`, `cte_cp`, `cte_otr`, `cte_report`, `cte_t`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
