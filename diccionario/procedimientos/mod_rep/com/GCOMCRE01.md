# mod_rep.com.GCOMCRE01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GCOMCRE01.sql](../../../../procedimientos/mod_rep/com/GCOMCRE01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GCOMCRE01.sql](../../../../sql/01-extraccion/mod_rep/com/GCOMCRE01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GCOMCRE01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GCOMCRE01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `SEGUI_COMITE_01` | SEGUIMIENTO COMITE | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (8)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [mod_rep.util.FFMTVAR](../../../tablas/mod_rep/util/FFMTVAR.md) | — | — | motor |
| [mod_rep.util.FSEMVAR](../../../tablas/mod_rep/util/FSEMVAR.md) | — | — | motor |
| [storage.com_act.WDCB001](../../../tablas/storage/com_act/WDCB001.md) | lee | `hcodrel`, `HCOM_10_20K`, `HCOM_10K`, `HCOM_DESEMB`, `HCOM_FIRMA`, `HCOM_FISICO`, `HCOM_M20K`, `HCOM_SDESEMB`, `HCOM_SFIRMA`, `HCOM_VIRTUAL`, `HDESEMB_COM`, `HDESEMB_SCOM`, `HFECPRO`, `HNUM_COMITE`, `HSCOM_10_20K`, `HSCOM_10K`, `HSCOM_M20K`, `htipcod`, `HTOT_OPEDESEMB` | estatico + motor |
| [storage.com_act.WDCB002](../../../tablas/storage/com_act/WDCB002.md) | lee | `hcodrel`, `HFECPRO`, `htipcod` | estatico + motor |
| [storage.com_act.wjas002](../../../tablas/storage/com_act/WJAS002.md) | lee | `hcodrel`, `HFECPRO`, `htipcod` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `rciebt`≈, `RFEC`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Observaciones del análisis

- Temporales: `#AAA`, `#ACUM000`, `#ACUM001`, `#ACUM001T`, `#ACUM002`, `#ACUM00A`, `#CMG`, `#COL_ANIO`, `#FEC_anio`, `#RES`, `#fechas`
- ⚠️ Columna sin resolver `HAVG_OPE` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HMAX_OPE` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HAVG_DURA` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HMAX_DURA` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HAVG_ASIST` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HMAX_ASIST` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HSALVENMN_CC` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HCAST12M` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HVENTA_CARTMN12M` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HRECCAST12M` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HSALCAPMN_CC` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HSALVENMN_SC` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
- ⚠️ Columna sin resolver `HSALCAPMN_SC` (¿storage.com_act.WDCB001 o storage.com_act.WDCB002 o storage.com_act.wjas002?)
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
