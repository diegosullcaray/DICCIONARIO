# mod_rep.com.RMORAGP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RMORAGP01.sql](../../../../extraccion/procedimientos/mod_rep/com/RMORAGP01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RMORAGP01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RMORAGP01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RMORAGP01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RMORAGP01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RESMORAGP_01` | Mora Grupos PDM | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | DATE | — |  | `fec` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HDGP001](../../../tablas/storage/com_act/HDGP001.md) | lee | `HESTG`, `HESTI`, `HFECPRO`, `HNROG` | estatico + motor |
| [storage.com_act.WCED001](../../../tablas/storage/com_act/WCED001.md) | lee | `*`, `hcodsec` | estatico + motor |
| [storage.com_act.WCEM001](../../../tablas/storage/com_act/WCEM001.md) | lee | `*`, `hcodsec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

`HTRAM`, `saldoMoraA`, `num_grupA`, `num_clieA`, `saldoMora`, `num_grup`, `Num_Clie`, `(expresión 8)`, `(expresión 9)`, `(expresión 10)`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_base`, `cte_c`, `cte_d`, `cte_grupos`, `cte_u`
- Temporales: `#FECS`, `#FJERCOR02`, `#Resultado`, `#report`
- ⚠️ Columna sin resolver `HESTG` (¿storage.com_act.HDGP001?)
- ⚠️ Columna sin resolver `HESTI` (¿storage.com_act.HDGP001?)
- ⚠️ Columna sin resolver `hfecpro` (¿storage.com_act.HDGP001?)
- ⚠️ Columna sin resolver `HNROG` (¿storage.com_act.HDGP001?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)
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
