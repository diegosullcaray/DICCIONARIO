# mod_rep.com.RDETCORR01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RDETCORR01.sql](../../../../procedimientos/mod_rep/com/RDETCORR01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RDETCORR01.sql](../../../../sql/01-extraccion/mod_rep/com/RDETCORR01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RDETCORR01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RDETCORR01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RDETCORR_01` | Detalle Corresponsales | `tip_cod`, `cod_rel`, `fec`, `pagen`, `tipo` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@pagen` | int | 1 |  | `pagen` |
| 5 | `@tipo` | varchar(250) | — |  | `tipo` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCMC001](../../../tablas/storage/com_act/HCMC001.md) | lee | `HCAUSAL`, `HCODIGOCB`, `HFECHAMOV`, `HFECPRO`, `HNOMBREPTO`, `HTIPOTRN`, `HVALORTX` | estatico + motor |
| [storage.com_act.HCMC004](../../../tablas/storage/com_act/HCMC004.md) | lee | `HCODREDEXT`, `HCODSUC`, `HESTCORR`, `HFECINSTALA`, `HFECPRO` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `rfec` | estatico + motor |
| [storage.ref.VJERCOR03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `rcodage`, `RCODCOR`, `RCODMAT`, `RCODTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `Total`

### Observaciones del análisis

- CTE: `cte_a`, `cte_corres`, `cte_maestrocorres`, `cte_res`
- Temporales: `#PRE`
- ⚠️ Columna sin resolver `HFECHAMOV` (¿storage.com_act.HCMC001?)
- ⚠️ Columna sin resolver `HCAUSAL` (¿storage.com_act.HCMC001?)
- ⚠️ Columna sin resolver `hfecpro` (¿storage.com_act.HCMC001?)
- ⚠️ Columna sin resolver `HTIPOTRN` (¿storage.com_act.HCMC001 o storage.ref.vjercor03?)
- ⚠️ Columna sin resolver `HVALORTX` (¿storage.com_act.HCMC001?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
