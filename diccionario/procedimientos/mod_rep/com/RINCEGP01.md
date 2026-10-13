# mod_rep.com.RINCEGP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RINCEGP01.sql](../../../../procedimientos/mod_rep/com/RINCEGP01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RINCEGP01.sql](../../../../sql/01-extraccion/mod_rep/com/RINCEGP01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RINCEGP01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RINCEGP01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RESINCGRUP_01` | Incentivos Meta Grupos PDM | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(8) | 'NOW' |  | — |
| 4 | `@pagen` | int | 1 |  | — |

### Tablas y columnas (12)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.HCDR001](../../../tablas/storage/com_act/HCDR001.md) | lee | `HCODOPE`≈, `HFECPRO`≈, `HFECREP`≈ | estatico + motor |
| [storage.com_act.HCDR002](../../../tablas/storage/com_act/HCDR002.md) | lee | `HCODOPE`≈, `HFECPRO`≈, `HFECREP`≈ | estatico + motor |
| [storage.com_act.HDGP001](../../../tablas/storage/com_act/HDGP001.md) | lee | `HESTG`, `HESTI`, `HFECPRO`, `HNROG` | estatico + motor |
| [storage.com_act.RFOC001](../../../tablas/storage/com_act/RFOC001.md) | lee | `RCODOPE`, `ROPEFEC` | estatico + motor |
| [storage.com_act.VCAH001](../../../tablas/storage/com_act/VCAH001.md) | lee | `HASEOPER`, `HASEORI`, `HCAPPEN`, `HCARCOB`, `HCARNCOB`, `HCLFSBS`, `HCODCIIU`, `HCODCNV`, `HCODEMP`, `HCODMOD`, `HCODMON`, `HCODOPE`, `HCODSEC`, `HCODSECANT`, `HCRESBS`, `HCTACLI`, `HCTAFIA`, `HCUOPEN`, `HCUOVEN`, `HDCODCNV`, `HDCODSEC`, `HDESCIIU`, `HDESCLI`, `HDESCRE`, `HDESMOD`, `HDESRUB`, `HDESTOPE`, `HDIAATR`, `HDINDCAM`, `HDIREC`, `HDNIVAPR`, `HDOCCON`, `HDOCFIA`, `HDPAIS`, `HDSUBTIP`, `HDSUCCLI`, `HDSUCSEC`, `HDTIPOPE`, `HESTOPE`, `HFECCLF`, `HFECDES`, `HFECMOR`, `HFECPER`, `HFECPRC`, `HFECPRO`, `HFECUCC`, `HFRCPAG`, `HGENPER`, `HHORREG`, `HINDCAM`, `HINDCAR`, `HINDIM`, `HINDMETA`, `HINDTIPCB`, `HINGDIF`, `HINTCMP`, `HINTMOR`, `HINTVEN`, `HMONDES`, `HMONGAR`, `HMONPRV`, `HNASEORI`, `HNDOCSEC`, `HNIVAPR`, `HNOMFIA`, `HNOMREG`, `HNUMCOR`, `HNUMCRCLI`, `HNUMDOC`, `HNUMLET`, `HNUMREN`, `HNUMRUB`, `HNUMTAS`, `HNUMTHR`, `HOCUP`, `HPAIS`, `HPAPEL`, `HPRIVEN`, `HRANDIA`, `HRESID`, `HRIECBCLI`, `HRIECBOPE`, `HROWID`, `HSALCAP`, `HSALCAPMN`, `HSALCAR`, `HSALRIE`, `HSALVEN`, `HSALVENMN`, `HSHKCMB`, `HSITCRE`, `HSUBOPE`, `HSUBTIP`, `HSUCCLI`, `HSUCOPER`, `HSUCSEC`, `HTIPCAR`, `HTIPCMB`, `HTIPDOC`, `HTIPOPE`, `HTIPPER`, `HTOTCUO`, `HTOTDEU`, `HTOTGAR`, `HUBIGEO`, `HULTVEN`, `HUSUPRO`, `HVENATR` | estatico + motor |
| [storage.com_act.VCAM001](../../../tablas/storage/com_act/VCAM001.md) | lee | `HASEOPER`, `HASEORI`, `HCAPPEN`, `HCARCOB`, `HCARNCOB`, `HCLFSBS`, `HCODCIIU`, `HCODCNV`, `HCODEMP`, `HCODMOD`, `HCODMON`, `HCODOPE`, `HCODSEC`, `HCRESBS`, `HCTACLI`, `HCTAFIA`, `HCUOPEN`, `HCUOVEN`, `HDCODCNV`, `HDCODSEC`, `HDESCIIU`, `HDESCLI`, `HDESCRE`, `HDESMOD`, `HDESRUB`, `HDESTOPE`, `HDIAATR`, `HDINDCAM`, `HDIREC`, `HDNIVAPR`, `HDOCCON`, `HDOCFIA`, `HDPAIS`, `HDSUBTIP`, `HDSUCCLI`, `HDSUCSEC`, `HDTIPOPE`, `HESTOPE`, `HFECCLF`, `HFECDES`, `HFECMOR`, `HFECPER`, `HFECPRC`, `HFECPRO`, `HFECUCC`, `HFRCPAG`, `HGENPER`, `HHORREG`, `HINDCAM`, `HINDCAR`, `HINDTIPCB`, `HINGDIF`, `HINTCMP`, `HINTMOR`, `HINTVEN`, `HMONDES`, `HMONGAR`, `HMONPRV`, `HNASEORI`, `HNIVAPR`, `HNOMFIA`, `HNOMREG`, `HNUMCOR`, `HNUMCRCLI`, `HNUMDOC`, `HNUMLET`, `HNUMREN`, `HNUMRUB`, `HNUMTAS`, `HNUMTHR`, `HOCUP`, `HPAIS`, `HPAPEL`, `HPRIVEN`, `HRANDIA`, `HRESID`, `HRIECBCLI`, `HRIECBOPE`, `HROWID`, `HSALCAP`, `HSALCAPMN`, `HSALCAR`, `HSALRIE`, `HSALVEN`, `HSALVENMN`, `HSHKCMB`, `HSITCRE`, `HSUBOPE`, `HSUBTIP`, `HSUCCLI`, `HSUCOPER`, `HSUCSEC`, `HTIPCAR`, `HTIPCMB`, `HTIPDOC`, `HTIPOPE`, `HTIPPER`, `HTOTCUO`, `HTOTDEU`, `HTOTGAR`, `HUBIGEO`, `HULTVEN`, `HUSUPRO`, `HVENATR` | estatico + motor |
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `HCODREL`, `HFECPRO`, `HNUMCLI`, `HNUMCLIN`, `HTIPCOD` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`≈, `HFECPRO`≈, `HTIPCOD`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `rcodsec`, `RCODTER`, `RCODUCO`, `RCODUNI`, `rdescor`, `RDESFC`, `RDESGRU`, `RDESSEC`, `rdester`, `RDESUCO`, `rdesuni`, `rfecpro`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `Total`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_dif`, `cte_grup`, `vgph001`, `vgph001_d`, `vgpm001`, `vgpm001_d`
- Temporales: `#GrupAnte`, `#GrupCli`, `#Grupos`, `#VCAH001`, `#VCAM001`
- ⚠️ Columna sin resolver `HINDCAR` (¿storage.com_act.RFOC001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
