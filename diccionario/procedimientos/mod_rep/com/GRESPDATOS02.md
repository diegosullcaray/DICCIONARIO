# mod_rep.com.GRESPDATOS02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESPDATOS02.sql](../../../../procedimientos/mod_rep/com/GRESPDATOS02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESPDATOS02.sql](../../../../sql/01-extraccion/mod_rep/com/GRESPDATOS02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESPDATOS02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESPDATOS02.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `P_Datos_02` | Plan de Datos | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.HBPDATOS001](../../../tablas/storage/com_act/HBPDATOS001.md) | lee | `HCINDI`, `HCODSEC`, `hfecpro`, `HRATIO`, `HTIPO` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HDESPER`, `HNUMDOC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`hfecpro`, `htipo`, `HDESPER`, `hratio`, `hcindi`

### Observaciones del análisis

- CTE: `cte_a`, `cte_c`
- ⚠️ Columna sin resolver `htipo` (¿storage.gpr.VPPH001?)
- ⚠️ Columna sin resolver `hratio` (¿storage.gpr.VPPH001?)
- ⚠️ Columna sin resolver `hcindi` (¿storage.gpr.VPPH001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
