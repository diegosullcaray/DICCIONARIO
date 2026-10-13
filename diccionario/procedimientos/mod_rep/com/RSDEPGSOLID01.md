# mod_rep.com.RSDEPGSOLID01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSDEPGSOLID01.sql](../../../../extraccion/procedimientos/mod_rep/com/RSDEPGSOLID01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSDEPGSOLID01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSDEPGSOLID01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSDEPGSOLID01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSDEPGSOLID01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRBSOLI_01` | Reporte Grupo Solidario | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Reportes PDM |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`≈, `RCODFC`≈, `RCODGRU`≈, `RCODSEC`≈, `RCODTER`≈, `RCODUCO`≈, `RCODUNI`≈, `RDESCOR`≈, `RDESFC`≈, `RDESGRU`≈, `RDESSEC`≈, `RDESTER`≈, `RDESUCO`≈, `RDESUNI`≈, `rfecpro`≈, `rindfec`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars","prod_tipo","prod_com"', @config = @tconf | no |

### Columnas que devuelve

1. `@headers`
2. `htipcod`, `hcodrel`, `*`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#DES`, `#DESS`, `#DES_`, `#FECS`, `#Jerar`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
