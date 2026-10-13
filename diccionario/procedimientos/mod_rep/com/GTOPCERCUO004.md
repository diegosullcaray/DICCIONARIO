# mod_rep.com.GTOPCERCUO004

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GTOPCERCUO004.sql](../../../../extraccion/procedimientos/mod_rep/com/GTOPCERCUO004.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GTOPCERCUO004.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GTOPCERCUO004.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GTOPCERCUO004.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GTOPCERCUO004.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CEROCUOTA_TOPCNUEVA_04` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | reportes / actividad-diaria / Cartera en Mora |
| `CEROCUOTA_TOPCNUEVA_M_04` | Top 5 TOP 5  CORREDOR NRO CERO CUOTAS NUEVO INGRESO - TIPO PRODUCTO | `tip_cod`, `tip_cod2`, `cod_rel`, `tipcuota`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@tip_cod2` | varchar(50) | — |  | `tip_cod2` |
| 3 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 4 | `@tipcuota` | int | — |  | `tipcuota` |
| 5 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `HFECPRO` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RDESCOR`≈, `RDESGRU`≈, `RDESTER`≈, `RDESUNI`≈, `rfecpro`≈, `RINDFEC`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV07` | @tip_cod, @tip_cod2, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_result`
- Temporales: `#FECS`, `#Temp1`, `#Temp2`

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
