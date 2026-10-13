# mod_rep.com.RSMONEFER02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSMONEFER02.sql](../../../../procedimientos/mod_rep/com/RSMONEFER02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSMONEFER02.sql](../../../../sql/01-extraccion/mod_rep/com/RSMONEFER02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSMONEFER02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSMONEFER02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_MON_EFECREASIG_02` | Detalle de Efectividades | `tip_cod`, `cod_rel`, `tramof`, `prod`, `comp_r`, `zcuo`, `ucuo`, `nom`, `resp`, `tdcr`, `pagen`, `fcompro` | reportes / actividad-diaria / Portafolio Reasignado |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | nvarchar(100) | — |  | `cod_rel` |
| 3 | `@tramof` | varchar(20) | — |  | `tramof` |
| 4 | `@prod` | varchar(50) | — |  | `prod` |
| 5 | `@comp_r` | varchar(20) | — |  | `comp_r` |
| 6 | `@zcuo` | varchar(20) | — |  | `zcuo` |
| 7 | `@ucuo` | varchar(20) | — |  | `ucuo` |
| 8 | `@nom` | varchar(150) | — |  | `nom` |
| 9 | `@resp` | varchar(250) | — |  | `resp` |
| 10 | `@tdcr` | varchar(50) | — |  | `tdcr` |
| 11 | `@pagen` | int | — |  | `pagen` |
| 12 | `@fcompro` | varchar(50) | — |  | `fcompro` |

### Tablas y columnas (12)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.hbac002](../../../tablas/storage/com_act/hbac002.md) | lee | `HCODOPE`, `HFECEJC`, `hfecpro`, `HNUM_CONDONADO` | estatico + motor |
| [storage.com_act.hbae001](../../../tablas/storage/com_act/hbae001.md) | lee | `hcodope`≈ | estatico + motor |
| [storage.com_act.HCDR001](../../../tablas/storage/com_act/HCDR001.md) | lee | `HCODOPE`≈, `HFECPRO`≈ | estatico + motor |
| [storage.com_act.HCDR002](../../../tablas/storage/com_act/HCDR002.md) | lee | `HCODOPE`≈, `HFECPRO`≈ | estatico + motor |
| [storage.com_act.HDGP001](../../../tablas/storage/com_act/HDGP001.md) | lee | `hfecpro`, `HNOMG`, `HNROG`, `HOPER` | estatico + motor |
| [storage.com_act.VCAM001](../../../tablas/storage/com_act/VCAM001.md) | lee | `HASEOPER`, `HASEORI`, `HCAPPEN`, `HCARCOB`, `HCARNCOB`, `HCLFSBS`, `HCODCIIU`, `HCODCNV`, `HCODEMP`, `HCODMOD`, `HCODMON`, `HCODOPE`, `HCODSEC`, `HCRESBS`, `HCTACLI`, `HCTAFIA`, `HCUOPEN`, `HCUOVEN`, `HDCODCNV`, `HDCODSEC`, `HDESCIIU`, `HDESCLI`, `HDESCRE`, `HDESMOD`, `HDESRUB`, `HDESTOPE`, `HDIAATR`, `HDINDCAM`, `HDIREC`, `HDNIVAPR`, `HDOCCON`, `HDOCFIA`, `HDPAIS`, `HDSUBTIP`, `HDSUCCLI`, `HDSUCSEC`, `HDTIPOPE`, `HESTOPE`, `HFECCLF`, `HFECDES`, `HFECMOR`, `HFECPER`, `HFECPRC`, `HFECPRO`, `HFECUCC`, `HFRCPAG`, `HGENPER`, `HHORREG`, `HINDCAM`, `HINDCAR`, `HINDTIPCB`, `HINGDIF`, `HINTCMP`, `HINTMOR`, `HINTVEN`, `HMONDES`, `HMONGAR`, `HMONPRV`, `HNASEORI`, `HNIVAPR`, `HNOMFIA`, `HNOMREG`, `HNUMCOR`, `HNUMCRCLI`, `HNUMDOC`, `HNUMLET`, `HNUMREN`, `HNUMRUB`, `HNUMTAS`, `HNUMTHR`, `HOCUP`, `HPAIS`, `HPAPEL`, `HPRIVEN`, `HRANDIA`, `HRESID`, `HRIECBCLI`, `HRIECBOPE`, `HROWID`, `HSALCAP`, `HSALCAPMN`, `HSALCAR`, `HSALRIE`, `HSALVEN`, `HSALVENMN`, `HSHKCMB`, `HSITCRE`, `HSUBOPE`, `HSUBTIP`, `HSUCCLI`, `HSUCOPER`, `HSUCSEC`, `HTIPCAR`, `HTIPCMB`, `HTIPDOC`, `HTIPOPE`, `HTIPPER`, `HTOTCUO`, `HTOTDEU`, `HTOTGAR`, `HUBIGEO`, `HULTVEN`, `HUSUPRO`, `HVENATR` | estatico + motor |
| [storage.com_act.WCED002](../../../tablas/storage/com_act/WCED002.md) | lee | `HCODMON`, `HCODOPE`, `HCODSEC`, `HCREDSBS`, `HCTACLI`, `HCUOPAG`, `HDCODSEC`, `HDESCLI`, `HDIAATR`, `HESTACT`, `HESTC`, `HFCCOM`, `HFCFGEST`, `HFCFVPP`, `HFCMPP`, `HFCRES`, `HFCRSPB`, `HFDGPR`, `HFECDES`, `HFECMOR`, `HFECUCC`, `HFGPR`, `HFTVEN`, `HINDUCUO`, `HINDZCUO`, `HMONDES`, `HNIVRIEBT`, `HNIVSOB`, `HPROBR`, `HREGG`, `HREGN`, `HSALCAPMN`, `HSALINIMN`, `HTOTCUO`, `HTRAM`, `HUBIGEO`, `RCODMAT`, `RCODREG`, `RCODTER`, `RDESAGE`, `RDESMAT`, `RDESPROD`, `RDESREG`, `RDESTER` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUNI`, `RDESCOR`, `RDESTER`, `RDESUNI`, `RFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `Total`

### Observaciones del análisis

- CTE: `a`, `cte_condonados`
- Temporales: `#HDGP001`, `#VCAM001`, `#WCED002`, `#condonados`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
