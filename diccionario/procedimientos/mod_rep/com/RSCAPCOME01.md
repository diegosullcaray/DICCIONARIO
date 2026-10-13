# mod_rep.com.RSCAPCOME01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSCAPCOME01.sql](../../../../extraccion/procedimientos/mod_rep/com/RSCAPCOME01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSCAPCOME01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSCAPCOME01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSCAPCOME01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSCAPCOME01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_MON_SALCAP_COM_01` | Reporte Saldo Captacion Cartera | `codrel`, `fecha`, `tipcod` | reportes<br>reportes / actividad-diaria / Captaciones |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@codrel` | varchar(25) | — |  | `codrel` |
| 2 | `@Fecha` | date | — |  | `fecha` |
| 3 | `@tipcod` | varchar(5) | — |  | `tipcod` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WSALCAPCOMER01](../../../tablas/storage/com_act/WSALCAPCOMER01.md) | lee | `HFECPRO`≈, `PRODUCTO`≈ | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `rfecpro`, `rindfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tipcod, @codrel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars","fec_corr"', @config = @tconf | no |

### Columnas que devuelve

1. `@headers`
2. `HTIPCOD`, `hcodrel`, `style`, `descripcion`, `6-ahorros`, `5-ahorros`, `var-ahorros`, `6-DPF`, `5-DPF`, `var-DPF`, `6-CTS`, `5-CTS`, `var-CTS`
3. `HTIPCOD`, `HCODREL`, `descripcion`, `HSBSDO1`, `PRODUCTO`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#FECS`, `#Fec`, `#HHH`, `#Jerar`, `#PP`, `#PP1`, `#ProdT`, `#ProdT_`, `#ProdT__`, `#ProdT__1`

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
