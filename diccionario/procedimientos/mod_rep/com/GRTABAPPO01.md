# mod_rep.com.GRTABAPPO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRTABAPPO01.sql](../../../../procedimientos/mod_rep/com/GRTABAPPO01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRTABAPPO01.sql](../../../../sql/01-extraccion/mod_rep/com/GRTABAPPO01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRTABAPPO01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRTABAPPO01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `TABDIG_01` | APP CLIENTES | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Tablero Digital |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (8)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HTDA001](../../../tablas/storage/com_act/HTDA001.md) | lee | `HCANAL`≈, `HDESPROC`≈, `HFECPRO`≈, `HMONTO`≈, `HNUMDOC`≈, `HTIPDOC`≈, `htiptrax`≈, `HTOTINTE`≈, `RCODSUC`≈ | estatico + motor |
| [storage.com_act.WHDV001](../../../tablas/storage/com_act/WHDV001.md) | lee | `hcodrel`≈, `htipcod`≈ | estatico + motor |
| [storage.com_act.WHDV002](../../../tablas/storage/com_act/WHDV002.md) | lee | `hcodrel`≈, `htipcod`≈ | estatico + motor |
| [storage.com_act.WHOP001](../../../tablas/storage/com_act/WHOP001.md) | lee | `hcodrel`≈, `htipcod`≈ | estatico + motor |
| [storage.com_act.WTRXMON001](../../../tablas/storage/com_act/WTRXMON001.md) | lee | `RCODSUC` | estatico + motor |
| [storage.com.wjas004](../../../tablas/storage/com/wjas004.md) | lee | `hcodrel`, `HDATINPUTRXUSA`, `hfecpro`, `HPERCENTCART`, `HPERCENTENROCLINET`, `HPERCENTPASI`, `HPERCENTUSABILIDAD`, `HTIPAMBO`, `htipcod`, `HTIPCRED`, `HTIPFALT`, `HTIPPASI`, `HTOTALCLIENROL` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `rfec` | estatico + motor |
| [storage.ref.VJERCOR03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODAGE`, `RCODCOR`, `RCODFC`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESCOR`, `RDESFC`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV03` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = '"vars"', @columns = '"fec_corr"', @config = @tconf | no |

### Columnas que devuelve

1. `result`
2. `descripcion`, `vars`, `v1`, `v2`, `v3`, `v4`, `v5`, `v6`, `v7`, `v8`, `v9`, `variacion`, `style`

### Observaciones del análisis

- CTE: `cte_aa`, `cte_b`, `whdv001`, `whdv002`, `whop001`
- Temporales: `#A`, `#AB`, `#CLITRANSMES`, `#FECS`, `#HDV`, `#HDV2`, `#HOP`, `#P`, `#RPRETRANSX`, `#TD`, `#TFORMAT`, `#TM`, `#TNM`, `#res`, `#tnm`, `#vjercor03`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `HTIPCRED` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `HTIPPASI` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `HTIPAMBO` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `HTIPFALT` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `HPERCENTCART` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `HPERCENTPASI` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `HTOTALCLIENROL` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `HPERCENTUSABILIDAD` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `HPERCENTENROCLINET` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `HDATINPUTRXUSA` (¿storage.com.WJAS004?)
- ⚠️ Columna sin resolver `hcodrel` (¿storage.com.WJAS004?)
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
