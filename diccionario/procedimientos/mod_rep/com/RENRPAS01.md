# mod_rep.com.RENRPAS01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RENRPAS01.sql](../../../../extraccion/procedimientos/mod_rep/com/RENRPAS01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RENRPAS01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RENRPAS01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RENRPAS01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RENRPAS01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `enrolamiento_pasivo_01` | Enrolamiento Pasivo | `tip_cod`, `cod_rel`, `fecha` | — |

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
| [storage.com_pas.VCPH001](../../../tablas/storage/com_pas/VCPH001.md) | lee | `HCODSEC`, `HESTADO`, `HPENDOC`, `HPETDOC`, `HSBFECH`, `HSBMOD`, `HSBSDO1`, `HSBTOPE`, `HUSERBP` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HDESPER` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`descripcion`, `HUSERBP`, `num_cli_pas_enro`, `cli_inst_pas_enro`, `ratio_t1`, `cli_aper_pas_enro`, `cli_aper_insta_pas_enro`, `ratio_t2`

### Observaciones del análisis

- Temporales: `#T1`
- ⚠️ Columna sin resolver `HUSERBP` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001 o storage.gpr.VPPH001?)
- ⚠️ Columna sin resolver `HSBFECH` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `HSBTOPE` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `HCODSEC` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `HESTADO` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `HSBSDO1` (¿storage.com_act.VLCAPP001 o storage.com_pas.VCPH001?)
- ⚠️ Columna sin resolver `nro_Clientes` (¿storage.gpr.VPPH001?)
- ⚠️ Columna sin resolver `nro_clientes_instalados` (¿storage.gpr.VPPH001?)
- ⚠️ Columna sin resolver `nro_clientes_apertura` (¿storage.gpr.VPPH001?)
- ⚠️ Columna sin resolver `nro_clientes_apertura_instalados` (¿storage.gpr.VPPH001?)

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
