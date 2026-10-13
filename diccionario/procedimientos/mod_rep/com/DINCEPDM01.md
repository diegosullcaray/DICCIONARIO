# mod_rep.com.DINCEPDM01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/DINCEPDM01.sql](../../../../procedimientos/mod_rep/com/DINCEPDM01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/DINCEPDM01.sql](../../../../sql/01-extraccion/mod_rep/com/DINCEPDM01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/DINCEPDM01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/DINCEPDM01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `DET_INCEN_PDM_01` | DETALLE INCENTIVO PDM | `tip_cod`, `cod_rel`, `fecha`, `pagen` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |
| 4 | `@pagen` | int | 1 |  | `pagen` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HDGP001](../../../tablas/storage/com_act/HDGP001.md) | lee | `HASES`, `HCODA`, `HCODS`, `HDNIP`, `HDOCC`, `HEJEC`, `HESTG`, `HESTI`, `HFALG`, `HFECPRO`, `HINST`, `HMODU`, `HNCTA`, `HNOMC`, `HNOMG`, `HNROG`, `HOPER`, `HROWID`, `HSTOP`, `HTOPE` | estatico + motor |
| [storage.com_act.RFGP001](../../../tablas/storage/com_act/RFGP001.md) | lee | `RFECG`≈ | estatico + motor |
| [storage.com_act.VCAH002](../../../tablas/storage/com_act/VCAH002.md) | lee | `HASEOPER`, `HASEORI`, `HCAPPEN`, `HCARCOB`, `HCARNCOB`, `HCLFSBS`, `HCODCIIU`, `HCODCNV`, `HCODEMP`, `HCODMOD`, `HCODMON`, `HCODOPE`, `HCODSEC`, `HCODSECANT`, `HCRESBS`, `HCTACLI`, `HCTAFIA`, `HCUOPEN`, `HCUOVEN`, `HDCODCNV`, `HDCODSEC`, `HDESCIIU`, `HDESCLI`, `HDESCRE`, `HDESMOD`, `HDESRUB`, `HDESTOPE`, `HDIAATR`, `HDINDCAM`, `HDIREC`, `HDNIVAPR`, `HDOCCON`, `HDOCFIA`, `HDPAIS`, `HDSUBTIP`, `HDSUCCLI`, `HDSUCSEC`, `HDTIPOPE`, `HESTOPE`, `HFECCLF`, `HFECDES`, `HFECDESA`, `HFECMOR`, `HFECPER`, `HFECPRC`, `HFECPRO`, `HFECUCC`, `HFRCPAG`, `HGENPER`, `HHORREG`, `HINDCAM`, `HINDCAR`, `HINDIM`, `HINDMETA`, `HINDTIPCB`, `HINGDIF`, `HINTCMP`, `HINTMOR`, `HINTVEN`, `HMONDES`, `HMONDESMN`, `HMONGAR`, `HMONPRV`, `HNASEORI`, `HNDOCSEC`, `HNIVAPR`, `HNOMFIA`, `HNOMREG`, `HNUMCOR`, `HNUMCRCLI`, `HNUMDOC`, `HNUMLET`, `HNUMREN`, `HNUMRUB`, `HNUMTAS`, `HNUMTHR`, `HOCUP`, `HPAIS`, `HPAPEL`, `HPRIVEN`, `HRANDIA`, `HRESID`, `HRIECBCLI`, `HRIECBOPE`, `HROWID`, `HSALCAP`, `HSALCAPMN`, `HSALCAR`, `HSALRIE`, `HSALVEN`, `HSALVENMN`, `HSHKCMB`, `HSITCRE`, `HSUBOPE`, `HSUBTIP`, `HSUCCLI`, `HSUCOPER`, `HSUCSEC`, `HTIPCAR`, `HTIPCMB`, `HTIPDOC`, `HTIPOPE`, `HTIPPER`, `HTOTCUO`, `HTOTDEU`, `HTOTGAR`, `HUBIGEO`, `HULTVEN`, `HUSUPRO`, `HVENATR` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODGRU`, `rcodsec`, `RCODTER`, `RCODUCO`, `RCODUNI`, `rdescor`, `rdessec`, `rdester`, `RDESUCO`, `rdesuni`, `rfecpro`, `rindfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `Total`

### Observaciones del análisis

- CTE: `a`, `b`, `c`, `d`, `e`, `f`
- Temporales: `#GRU_PDM_INI`, `#HINI_PDM`, `#VCAH002`
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `HCODOPE` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `HNROG` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `HMONDESMN` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `HDOCC` (¿storage.ref.wjercor03?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
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
