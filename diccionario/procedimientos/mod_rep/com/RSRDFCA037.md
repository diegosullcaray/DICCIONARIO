# mod_rep.com.RSRDFCA037

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSRDFCA037.sql](../../../../procedimientos/mod_rep/com/RSRDFCA037.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSRDFCA037.sql](../../../../sql/01-extraccion/mod_rep/com/RSRDFCA037.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSRDFCA037.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSRDFCA037.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CMG_CARTERA_02` | CMG CARTERA | `tipcod`, `cod_rel`, `tipmet`, `prod`, `fec` | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tipcod` | int | — |  | `tipcod` |
| 2 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |
| 3 | `@tipmet` | int | — |  | `tipmet` |
| 4 | `@prod` | int | — |  | `prod` |
| 5 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (15)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.com.FLIMNEG](../../../tablas/mod_rep/com/FLIMNEG.md) | — | — | motor |
| [mod_rep.com.TDILMETA](../../../tablas/mod_rep/com/TDILMETA.md) | — | — | motor |
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [storage.com_act.SDAF001](../../../tablas/storage/com_act/SDAF001.md) | lee | `SFECPRO` | estatico + motor |
| [storage.com_act.SDAF003](../../../tablas/storage/com_act/SDAF003.md) | lee | `SCODAGR`, `SCODSEC`, `SFECDES`, `SFECPRO`, `SHORPRO`, `SMONDESMN`, `SNUMOPE`, `SSUCCLI` | estatico + motor |
| [storage.com_act.SDAS004](../../../tablas/storage/com_act/SDAS004.md) | lee | `SCODAGR`, `SCODSEC`, `SFECPRO`, `SMDESMN`, `SSCAPFMN`, `SSCAPIMN`, `SSCASMN`, `SSUCCLI` | estatico + motor |
| [storage.com_act.SDAS010](../../../tablas/storage/com_act/SDAS010.md) | lee | `SFECPRO`, `SHORPRO` | estatico + motor |
| [storage.com_act.VCAH005](../../../tablas/storage/com_act/VCAH005.md) | lee | `haseoper`, `hcodope`, `hfecpro`, `HMONDESMN`, `HNUMTAS` | estatico + motor |
| [storage.com_act.WGATH002](../../../tablas/storage/com_act/WGATH002.md) | lee | `HAUTO`, `HCAPP1`, `HCAPP2`, `HCAPP3`, `HCAPP4`, `HCAPP5`, `HCASE`, `HCCLI`, `HCOFI`, `HCRT10`, `HCRT11`, `HCRT12`, `HCRT2`, `HCRT3`, `HCRT4`, `HCRT5`, `HCRT6`, `HCRT7`, `HCRT8`, `HCRT9`, `HDASE`, `HDOFI`, `HDTDOC`, `HFAPP1`, `HFAPP2`, `HFAPP3`, `HFAPP4`, `HFAPP5`, `HFDES`, `hfecpro`, `HGESTTAS`, `HHAPP1`, `HHAPP2`, `HHAPP3`, `HHAPP4`, `HHAPP5`, `HMDES`, `HMOD`, `HNAPP1`, `HNAPP2`, `HNAPP3`, `HNAPP4`, `HNAPP5`, `HNCLI`, `HNCUO`, `HNDOC`, `HOPER`, `HPBS`, `HPLZO`, `HPROD`, `HREGI`, `HSOLI`, `HSUBTIP`, `HTBAS`, `HTDES`, `HTERR`, `HTMER`, `HTMIN`, `HTOPE`, `HTSEG`, `HTSOL`, `HTTAR`, `HUAPP1`, `HUAPP2`, `HUAPP3`, `HUAPP4`, `HUAPP5`, `HUCAP`, `HUCAP_FIN`, `HUFAP`, `HUHAP`, `HUNAP`, `HUUAP`, `HVARI1`, `HVARI2`, `HVARI3`, `HVARI4`, `HVARI5`, `ID`, `ord`, `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFEC` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `htipcod`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.ref.rcalen001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `rfec` | estatico + motor |
| [storage.ref.wjercor03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `rcodsec`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `rfecpro`, `rindfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tipcod, @cod_rel, @jera, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jera, @columns, =, '"vars"', @config, =, @tconf | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `mod_rep.com.FDILMETA` (función) | — | no |
| `mod_rep.com.FDILMETA` (función) | — | no |

### Columnas que devuelve

1. `json`
2. `ope_acum_`, `meta_ope_acum_`, `cumpl_ope_acum`, `des_acum`, `meta_des_acum`, `cumpl_des_acum`, `tasaminima`
3. `*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cteacum`, `cteacumetas`, `ctecalc`, `ctecan`, `ctecanacumetas`, `ctecanmetas`, `ctedatmetas`, `ctemetas`
- Temporales: `#DESEMBOLSOS`, `#DatosDia`, `#FecHabil`, `#SDAF`, `#SDAF001`, `#SDAF003`, `#T1`, `#WJERCOR3`, `#tmpAcuMetas`, `#tmpCancelaciones`, `#tmpDILMDes`, `#tmpDILMOpe`, `#tmpParT`
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
