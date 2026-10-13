# mod_rep.com.GLIMOVO05

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GLIMOVO05.sql](../../../../procedimientos/mod_rep/com/GLIMOVO05.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GLIMOVO05.sql](../../../../sql/01-extraccion/mod_rep/com/GLIMOVO05.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GLIMOVO05.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GLIMOVO05.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PLANMOV_03` | Detalle | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [STORAGE.com_act.HBMOV003](../../../tablas/STORAGE/com_act/HBMOV003.md) | lee | `CODIGO_BT`, `Cta_Cliente`, `Distrito`, `FECHA`, `FILTRO2`, `FILTRO3`, `FILTRO4`, `FILTRO5`, `FILTRO6`, `FILTRO7`, `HCOMENT`, `HFECPRO`, `HLATIT`, `HLONG`, `HORA` | estatico + motor |
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `HCTACLI`, `HDESCLI`, `HFECPRO` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HNUMDOC` | estatico + motor |
| [STORAGE.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `rciebt`, `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `result`
2. `*`, `HDESCLI`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
