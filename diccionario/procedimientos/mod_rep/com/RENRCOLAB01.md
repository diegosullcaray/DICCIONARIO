# mod_rep.com.RENRCOLAB01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RENRCOLAB01.sql](../../../../procedimientos/mod_rep/com/RENRCOLAB01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RENRCOLAB01.sql](../../../../sql/01-extraccion/mod_rep/com/RENRCOLAB01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RENRCOLAB01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RENRCOLAB01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `enrolamiento_colaboradores_01` | Enrolamiento Colaboradores | `tip_cod`, `cod_rel`, `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.VLCAPP001](../../../tablas/storage/com_act/VLCAPP001.md) | lee | `HTIPNUMDOC` | estatico + motor |
| [storage.gpr.HPPC001](../../../tablas/storage/gpr/HPPC001.md) | lee | `HCODSUC`, `HDESTER`, `hfecpro`, `HNUMDOC` | estatico + motor |
| [storage.ref.VJERCOR02](../../../tablas/storage/ref/VJERCOR02.md) | lee | `rcodage`, `RCODAGEH`, `RCODCOR`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESCOR`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `a`, `b`, `c`, `d`
- ⚠️ Columna sin resolver `HNUMDOC` (¿storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02?)
- ⚠️ Columna sin resolver `hfecpro` (¿storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02?)
- ⚠️ Columna sin resolver `rcodter` (¿storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02?)
- ⚠️ Columna sin resolver `rcodcor` (¿storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02?)
- ⚠️ Columna sin resolver `rcodmat` (¿storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02?)
- ⚠️ Columna sin resolver `RCODAGEH` (¿storage.com_act.VLCAPP001 o storage.gpr.HPPC001 o storage.ref.VJERCOR02?)

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
