# mod_rep.com.RMORAGP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RMORAGP01.sql](../../../../procedimientos/mod_rep/com/RMORAGP01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RMORAGP01.sql](../../../../sql/01-extraccion/mod_rep/com/RMORAGP01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RMORAGP01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RMORAGP01.sql) |
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

### Tablas y columnas (9)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.HDGP001](../../../tablas/storage/com_act/HDGP001.md) | lee | `HFECPRO` | estatico + motor |
| [storage.com_act.WCED001](../../../tablas/storage/com_act/WCED001.md) | lee | `*`, `hcodsec` | estatico + motor |
| [storage.com_act.WCEM001](../../../tablas/storage/com_act/WCEM001.md) | lee | `*`, `hcodsec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |

### Columnas que devuelve

`HTRAM`, `saldoMoraA`, `num_grupA`, `num_clieA`, `saldoMora`, `num_grup`, `Num_Clie`, `(expresión 8)`, `(expresión 9)`, `(expresión 10)`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_base`, `cte_c`, `cte_d`, `cte_grupos`, `cte_u`
- Temporales: `#FECS`, `#FJERCOR02`, `#Resultado`, `#report`
- ⚠️ Columna sin resolver `HESTG` (¿storage.com_act.HDGP001?)
- ⚠️ Columna sin resolver `HESTI` (¿storage.com_act.HDGP001?)
- ⚠️ Columna sin resolver `hfecpro` (¿storage.com_act.HDGP001?)
- ⚠️ Columna sin resolver `HNROG` (¿storage.com_act.HDGP001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
