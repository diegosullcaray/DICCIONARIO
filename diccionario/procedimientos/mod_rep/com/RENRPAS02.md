# mod_rep.com.RENRPAS02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RENRPAS02.sql](../../../../procedimientos/mod_rep/com/RENRPAS02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RENRPAS02.sql](../../../../sql/01-extraccion/mod_rep/com/RENRPAS02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RENRPAS02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RENRPAS02.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `enrolamiento_pasivo_pas_02` | Enrolamiento Pasivo | `tip_cod`, `cod_rel`, `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.VLCAPP001](../../../tablas/storage/com_act/VLCAPP001.md) | lee | `HTIPNUMDOC` | estatico + motor |
| [storage.com_pas.VCPH001](../../../tablas/storage/com_pas/VCPH001.md) | lee | `HCODSEC`, `HESTADO`, `HPENDOC`, `HPETDOC`, `HSBFECH`, `HSBMOD`, `HSBSDO1`, `HSBSUC`, `HSBTOPE` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |
| [storage.ref.VJERCOR03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODAGE`, `RCODCOR`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESCOR`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`cod`, `descripcion`, `num_cli_pas_enro`, `cli_inst_pas_enro`, `(expresión 5)`, `cli_aper_pas_enro`, `cli_aper_insta_pas_enro`, `(expresión 8)`

### Observaciones del análisis

- Temporales: `#T1`
- ⚠️ Columna sin resolver `HSBSUC` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `HSBFECH` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `HSBTOPE` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `HCODSEC` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `HESTADO` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `HSBSDO1` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)

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
