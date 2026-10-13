# mod_rep.com.RSCMGFCA002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSCMGFCA002.sql](../../../../procedimientos/mod_rep/com/RSCMGFCA002.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSCMGFCA002.sql](../../../../sql/01-extraccion/mod_rep/com/RSCMGFCA002.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSCMGFCA002.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSCMGFCA002.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CMG_CARTERA_01` | CMG CARTERA | `codrel`, `Fecha`, `tipcod`, `met`, `prod` | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@codrel` | varchar(25) | — |  | `codrel` |
| 2 | `@Fecha` | date | — |  | `Fecha` |
| 3 | `@tipcod` | varchar(5) | — |  | `tipcod` |
| 4 | `@met` | int | — |  | `met` |
| 5 | `@prod` | varchar(250) | — |  | `prod` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `HCANAMN`, `HCODREL`, `HFECPRO`, `HMONDESAMN`, `HNUMSECGMES`, `HNUMSECIMES`, `HOPEDESA`, `HSALMEDMN`, `HSALMEDMNVIGE`, `HTIPCOD`, `HVSALMN`, `HVSALVIGMN` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tipcod, @codrel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = '"fec"', @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVLEV01` | @tipcod, @codrel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvarsPRD, @filters = @tfil, @rows = '"fec"', @columns = '"vars","prod_tipgru"', @config = @tconfPRD | no |
| `mod_rep.com.RSCMGFCA001_CFAE` | @codrel, @Fecha, @tipcod, @met | no |
| `mod_rep.com.RSCMGFCA001_SFAE` | @codrel, @Fecha, @tipcod, @met | no |

### Columnas que devuelve

`@headers`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`
- Temporales: `#AAA`, `#ACUM00`, `#CMG`, `#DES`, `#DES00`, `#FECS`, `#PROD00`, `#ProdTip1`, `#RES`, `#RESULT00`, `#RESULT01`, `#RESULT02`, `#RESULTPRE`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.util.FFMTVAR`
- `mod_rep.util.FSEMVAR`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
