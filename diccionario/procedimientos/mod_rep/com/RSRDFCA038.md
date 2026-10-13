# mod_rep.com.RSRDFCA038

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSRDFCA038.sql](../../../../extraccion/procedimientos/mod_rep/com/RSRDFCA038.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSRDFCA038.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSRDFCA038.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSRDFCA038.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSRDFCA038.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CMG_CARTERA_03` | CMG CARTERA | `tipcod`, `cod_rel`, `tipmet`, `prod` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tipcod` | int | — |  | `tipcod` |
| 2 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |
| 3 | `@tipmet` | int | — |  | `tipmet` |
| 4 | `@prod` | int | — |  | `prod` |

### Tablas y columnas (8)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `HFECPRO` | estatico + motor |
| [storage.com_act.SDAF001](../../../tablas/storage/com_act/SDAF001.md) | lee | `SFECPRO` | estatico + motor |
| [storage.com_act.SDAF003](../../../tablas/storage/com_act/SDAF003.md) | lee | `SCODAGR`, `SCODSEC`, `SFECDES`, `SFECPRO`, `SHORPRO`, `SMONDESMN`, `SNUMOPE`, `SSUCCLI` | estatico + motor |
| [storage.com_act.SDAS004](../../../tablas/storage/com_act/SDAS004.md) | lee | `SCODAGR`, `SCODSEC`, `SFECPRO`, `SMDESMN`, `SSCAPFMN`, `SSCAPIMN`, `SSCASMN`, `SSUCCLI` | estatico + motor |
| [storage.com_act.SDAS010](../../../tablas/storage/com_act/SDAS010.md) | lee | `SFECPRO`, `SHORPRO` | estatico + motor |
| [storage.com_act.WGATH002](../../../tablas/storage/com_act/WGATH002.md) | lee | `hfecpro` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `htipcod`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tipcod, @cod_rel, @jera output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jera, @columns = '"vars"', @config = @tconf | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `mod_rep.com.FDILMETA` (función) | — | no |
| `mod_rep.com.FDILMETA` (función) | — | no |

### Columnas que devuelve

1. `json`
2. `ope_acum_`, `meta_ope_acum_`, `cumpl_ope_acum`, `des_acum`, `meta_des_acum`, `cumpl_des_acum`
3. `*`

### Observaciones del análisis

- CTE: `cte_a`, `cteacum`, `cteacumetas`, `ctecalc`, `ctecan`, `ctecanacumetas`, `ctecanmetas`, `ctedatmetas`, `ctemetas`
- Temporales: `#DESEMBOLSOS`, `#DatosDia`, `#FecHabil`, `#SDAF`, `#SDAF001`, `#SDAF003`, `#T1`, `#WJERCOR3`, `#tmpAcuMetas`, `#tmpCancelaciones`, `#tmpDILMDes`, `#tmpDILMOpe`, `#tmpParT`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.com.FLIMNEG`
- `mod_rep.dbo.a`
- `mod_rep.com.TDILMETA` (tipo de tabla)
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
