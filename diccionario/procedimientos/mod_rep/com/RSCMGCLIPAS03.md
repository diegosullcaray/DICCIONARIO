# mod_rep.com.RSCMGCLIPAS03

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSCMGCLIPAS03.sql](../../../../extraccion/procedimientos/mod_rep/com/RSCMGCLIPAS03.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSCMGCLIPAS03.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSCMGCLIPAS03.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSCMGCLIPAS03.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSCMGCLIPAS03.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CMG_CLI_PAS_DETA_01` | CMG Clientes Pasivos Detalle | `tip_cod`, `cod_rel`, `fec`, `agru`, `grupo` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@agru` | varchar(250) | — |  | `agru` |
| 5 | `@grupo` | varchar(250) | — |  | `grupo` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`≈, `RFEC`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV03` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = '"vars","prod_capt_mig"', @columns = '"fec_corr"', @config = @tconf | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV03` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = '"prod_capt_mig","fec"', @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

1. `*`, `TMM`, `TAM`
2. `*`, `TMM`, `TAM`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_d`, `cte_e`, `cte_f`
- Temporales: `#FECS`, `#F_P`, `#RTD`, `#TA`, `#TD`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

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
