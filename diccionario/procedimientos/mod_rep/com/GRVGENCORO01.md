# mod_rep.com.GRVGENCORO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRVGENCORO01.sql](../../../../procedimientos/mod_rep/com/GRVGENCORO01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRVGENCORO01.sql](../../../../sql/01-extraccion/mod_rep/com/GRVGENCORO01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRVGENCORO01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRVGENCORO01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RVIUWGCOR_01` | Reporte Vista General Corresponsal | `tip_cod`, `cod_rel`, `fec`, `tip_age` | reportes / actividad-diaria / Tablero Digital |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@tip_age` | VARCHAR(250) | — |  | `tip_age` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `MM`≈, `RDIAFER`, `rfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV03` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, '"vars","agr_trx"', @columns, =, '"fec_corr"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, '"vars","esta_corr"', @columns, =, '"fec_corr"', @config, =, @tconf | no |

### Columnas que devuelve

`cod_desc`, `COD`, `DESCR`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `TFM`, `TMM`, `style`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`
- Temporales: `#F`, `#F2`, `#FECS`, `#R`, `#R2`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
