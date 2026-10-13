# mod_rep.com.RCORRES01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RCORRES01.sql](../../../../extraccion/procedimientos/mod_rep/com/RCORRES01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RCORRES01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RCORRES01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RCORRES01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RCORRES01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GREPORCORRE_01` | Corresponsales | `tip_cod`, `cod_rel`, `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCMC001](../../../tablas/storage/com_act/HCMC001.md) | lee | `hfecpro` | estatico + motor |
| [storage.com_act.SDAS021](../../../tablas/storage/com_act/SDAS021.md) | lee | `SAGENCI`, `SCORRED`, `SCORRES`, `sfecpro`, `SMONTO`, `SNUMCORRE`, `SNUMTRANS`, `STERRIT`, `STICKPROM`, `STIPTRA` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `RDIAFER`, `RFEC` | estatico + motor |
| [storage.ref.VJERCOR03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODCOR`≈, `RCODMAT`≈, `RCODTER`≈, `RDESCOR`≈, `RDESMAT`≈, `RDESTER`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `result`
2. `corresstock`, `transstock`, `montstock`, `tickstock`, `corresmes`, `transmes`, `montmes`, `tickmes`

### Observaciones del análisis

- Temporales: `#Cab`, `#FecConsultar`, `#subCab`, `#temp1`, `#temp1_1`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `STERRIT` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SCORRED` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SAGENCI` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SFECPRO` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SCORRES` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `STIPTRA` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SNUMTRANS` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SMONTO` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `STICKPROM` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SNUMCORRE` (¿storage.com_act.SDAS021?)

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
