# mod_rep.com.RSROPERA002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSROPERA002.sql](../../../../extraccion/procedimientos/mod_rep/com/RSROPERA002.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSROPERA002.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSROPERA002.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSROPERA002.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSROPERA002.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `TB_PANEL_OPE_02` | PANEL OPERACIONES PASIVO REGULA | `tip_cod`, `cod_rel`, `fec`, `prod` | reportes / actividad-diaria / Captaciones |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(10) | — |  | `fec` |
| 4 | `@prod` | varchar(250) | — |  | `prod` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_pas.wjas007](../../../tablas/storage/com_pas/wjas007.md) | lee | `HCODREL`, `HFECPRO`, `HNUMCLI`, `HTIPCOD`, `RDESCPROD` | estatico + motor |
| [storage.com_pas.WJAS008](../../../tablas/storage/com_pas/WJAS008.md) | lee | `hfecpro` | estatico + motor |
| [storage.com_pas.WJAS011](../../../tablas/storage/com_pas/WJAS011.md) | lee | `HCODREL`, `HFECPRO`≈, `HTIPCOD`≈, `RDESCPROD`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`, `hfecpro` | estatico + motor |
| [storage.ref.VJERCOR04](../../../tablas/storage/ref/VJERCOR04.md) | lee | `RCODAGEH`, `RCODMAC`, `RCODMAT`, `RCODTER`, `RDESAGEH`, `RDESFC`, `RDESMAC`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV10` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars","fec_corr"', @config = @tconf | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#BCLIPIVOT`, `#BCLIPIVOT2`, `#CliPivot`, `#CliPivot2`, `#CliPivot_`, `#FECS`, `#JERAR`, `#M`, `#Met`, `#Presult`, `#TPRECLI`, `#TPRECLI2`, `#TR`, `#fecs`, `#rst`, `#rst2`, `#trf`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `HFECPRO` (¿STORAGE.com_pas.WJAS007 o STORAGE.com_pas.WJAS011?)
- ⚠️ Columna sin resolver `HTIPCOD` (¿STORAGE.com_pas.WJAS007 o STORAGE.com_pas.WJAS011?)
- ⚠️ Columna sin resolver `HCODREL` (¿STORAGE.com_pas.WJAS007 o STORAGE.com_pas.WJAS011?)
- ⚠️ Columna sin resolver `HNUMCLI` (¿STORAGE.com_pas.WJAS007?)
- ⚠️ Columna sin resolver `RDESCPROD` (¿STORAGE.com_pas.WJAS007 o STORAGE.com_pas.WJAS011?)

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
