# mod_rep.com.RSRDFCA030

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSRDFCA030.sql](../../../../procedimientos/mod_rep/com/RSRDFCA030.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSRDFCA030.sql](../../../../sql/01-extraccion/mod_rep/com/RSRDFCA030.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSRDFCA030.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSRDFCA030.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `Monitor_Dese_02` | Monitor desembolsos Monto | `tipmet`, `tip_cod`, `cod_rel` | reportes / avance-comercial |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tipmet` | INT | — |  | `tipmet` |
| 2 | `@tip_cod` | int | — |  | `tip_cod` |
| 3 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |

### Tablas y columnas (15)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.com.FLIMNEG](../../../tablas/mod_rep/com/FLIMNEG.md) | — | — | motor |
| [mod_rep.com.TDILMETA](../../../tablas/mod_rep/com/TDILMETA.md) | — | — | motor |
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `HFECPRO` | estatico + motor |
| [storage.com_act.SDAF001](../../../tablas/storage/com_act/SDAF001.md) | lee | `SFECPRO` | estatico + motor |
| [storage.com_act.SDAF003](../../../tablas/storage/com_act/SDAF003.md) | lee | `SCODAGR`, `SCODSEC`, `SFECDES`, `SFECPRO`, `SHORPRO`, `SMONDESMN`, `SNUMOPE`, `SSUCCLI` | estatico + motor |
| [storage.com_act.SDAS004](../../../tablas/storage/com_act/SDAS004.md) | lee | `SCODAGR`, `SCODSEC`, `SFECPRO`, `SMDESMN`, `SSCAPFMN`, `SSCAPIMN`, `SSCASMN`, `SSUCCLI` | estatico + motor |
| [storage.com_act.SDAS010](../../../tablas/storage/com_act/SDAS010.md) | lee | `SFECPRO`, `SHORPRO` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `htipcod`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jera, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jera, @columns, =, '"vars"', @config, =, @tconf | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `mod_rep.com.FDILMETA` (función) | — | no |
| `mod_rep.com.FDILMETA` (función) | — | no |
| `mod_rep.com.RSRDFCA027_3` | @cod_rel, @p_fecha, @tip_cod, @tipmet, @flag, @hor, 0, 2 | no |

### Columnas que devuelve

`*`, `porc_dias`, `TMDIARIO1`, `TMDIARIO`, `cumpl_des_diario`, `sem_cumpl_des_diario`, `cumpl_ope_diario`, `sem_cumpl_ope_diario`, `cumpl_ope_acum`, `sem_cumpl_ope_acum`, `cumpl_des_acum`, `sem_cumpl_des_acum`

### Observaciones del análisis

- CTE: `cteacum`, `cteacumetas`, `ctecalc`, `ctecan`, `ctecanacumetas`, `ctecanmetas`, `ctedatmetas`, `ctemetas`
- Temporales: `#FecHabil`, `#SDAF`, `#SDAF001`, `#SDAF003`, `#T1`, `#WJERCOR3`, `#tmpAcuMetas`, `#tmpCancelaciones`, `#tmpDILMDes`, `#tmpDILMOpe`, `#tmpParT`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
