# mod_rep.com.GCOMCRE02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GCOMCRE02.sql](../../../../extraccion/procedimientos/mod_rep/com/GCOMCRE02.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GCOMCRE02.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GCOMCRE02.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GCOMCRE02.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GCOMCRE02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GCOMCRE_02` | Comite de Créditos Diario | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.wdcb003](../../../tablas/storage/com_act/wdcb003.md) | lee | `HCODREL`, `HCOM_10_20K`, `HCOM_3_5K`, `HCOM_3K`, `HCOM_5_10K`, `HCOM_M20K`, `HDESEMB_COM`, `HFECPRO`, `HMAX_DURA_H`, `HMIN_DURA_H`, `HNUM_COMITE`, `HOPE_APROB`, `HOPE_OBS`, `HOPE_RECH`, `HTIPCOD` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`≈, `RFEC`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`style`, `RDESVAR`, `col_1`, `col_2`, `col_3`, `col_4`, `col_5`, `col_6`, `col_7`, `col_8`, `col_9`, `col_10`, `col_11`, `col_12`, `col_13`, `col_14`, `col_15`, `col_16`, `col_17`, `col_18`, `col_19`, `col_20`, `col_21`, `col_22`, `col_23`, `col_24`, `col_25`, `col_26`, `col_27`, `col_28`, `col_29`, `col_30`, `col_31`

### Observaciones del análisis

- Temporales: `#AAA`, `#ACUM000`, `#ACUM001`, `#CMG`, `#RES`, `#fechas`
- ⚠️ Columna sin resolver `HMIN_DURA_H` (¿storage.com_act.WDCB003?)
- ⚠️ Columna sin resolver `HMAX_DURA_H` (¿storage.com_act.WDCB003?)
- ⚠️ Columna sin resolver `HOPE_APROB` (¿storage.com_act.WDCB003?)
- ⚠️ Columna sin resolver `HOPE_OBS` (¿storage.com_act.WDCB003?)
- ⚠️ Columna sin resolver `HOPE_RECH` (¿storage.com_act.WDCB003?)
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.util.FFMTVAR`
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
