# mod_rep.com.RSPANSUP002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSPANSUP002.sql](../../../../procedimientos/mod_rep/com/RSPANSUP002.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSPANSUP002.sql](../../../../sql/01-extraccion/mod_rep/com/RSPANSUP002.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSPANSUP002.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSPANSUP002.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PANEL_SUP_02` | Panel de Supervisión Detalle | `tip_cod`, `cod_rel`, `carg`, `state` | — |
| `PANEL_SUP_02` | Panel de Supervisión Detalle | `tip_cod`, `cod_rel`, `carg`, `state` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | nvarchar(10) | — |  | `cod_rel` |
| 3 | `@carg` | int | — |  | `carg` |
| 4 | `@state` | nvarchar(100) | — |  | `state` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.VDSC001](../../../tablas/storage/com_act/VDSC001.md) | lee | `HAGDEP`, `HASESUP`, `HCARGO`, `HCDEFIN`, `HCODASE`, `HDESCLI`, `HFECPRO`, `HFECVIS`, `HJUSTIF`, `HMDESOL`, `HNTOPE`, `HPERSUP`, `HTCANAL` | estatico + motor |
| [storage.ref.RCAR001](../../../tablas/storage/ref/RCAR001.md) | lee | `RCODCAR`, `RDESCAR` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUNI` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `rep.FTHEACOLS01` | 'PANEL_SUP_02' | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `cte_base`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
