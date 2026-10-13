# mod_rep.com.RMESA01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RMESA01.sql](../../../../extraccion/procedimientos/mod_rep/com/RMESA01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RMESA01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RMESA01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RMESA01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RMESA01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RMESA_01` | Efectividades Sin Asignar | `tip_cod`, `cod_rel`, `pagen` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@pagen` | int | 1 |  | `pagen` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WDMESA001](../../../tablas/storage/com_act/WDMESA001.md) | lee | `HCODOPE`, `HCODSEC`, `HCODSEC2`, `HDCODSEC`, `HFCRES`, `HFNUM`, `HSALCAPMN`, `HSALCAPMN2`, `HTRAM01`, `HTRAM02`, `RCODCOR`, `RCODGRU`, `RCODTER`, `RCODUNI`, `RDESCOR`, `RDESSEC`, `RDESTER`, `RDESUNI`, `SITUACION` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `Total`

### Observaciones del análisis

- CTE: `datos`

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
