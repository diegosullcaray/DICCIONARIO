# mod_rep.com.RSDESEMP02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSDESEMP02.sql](../../../../extraccion/procedimientos/mod_rep/com/RSDESEMP02.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSDESEMP02.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSDESEMP02.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSDESEMP02.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSDESEMP02.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `DESE_SOC_AS_01` | Desempeno Social | `tip_cod`, `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.wacli007](../../../tablas/storage/com_act/wacli007.md) | lee | `HCODPER`, `hcodsec`, `hfecpro`, `HINDBANC`, `HINDGEN`, `HINDMIGR`, `HINDRUR` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HNUMDOC` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`*`, `col_14`

### Observaciones del análisis

- Temporales: `#AAA`, `#CMG`, `#RES`, `#RESULTPRE`, `#base_2`, `#base_3`, `#fechas`, `#resultado`
- ⚠️ Columna sin resolver `F` (¿storage.com_act.wacli007?)
- ⚠️ Columna sin resolver `HINDBANC` (¿storage.com_act.wacli007?)
- ⚠️ Columna sin resolver `HCODPER` (¿storage.com_act.wacli007?)
- ⚠️ Columna sin resolver `HINDGEN` (¿storage.com_act.wacli007?)
- ⚠️ Columna sin resolver `HINDRUR` (¿storage.com_act.wacli007?)
- ⚠️ Columna sin resolver `HINDMIGR` (¿storage.com_act.wacli007?)
- ⚠️ Columna sin resolver `hcodsec` (¿storage.com_act.wacli007?)
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.util.FFMTVAR`
- `mod_rep.util.FSEMVAR`
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
