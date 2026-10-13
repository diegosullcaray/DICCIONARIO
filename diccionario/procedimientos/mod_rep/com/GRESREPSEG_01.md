# mod_rep.com.GRESREPSEG_01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GRESREPSEG_01.sql](../../../../extraccion/procedimientos/mod_rep/com/GRESREPSEG_01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GRESREPSEG_01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GRESREPSEG_01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GRESREPSEG_01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GRESREPSEG_01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRSCMISREP_01` | Seguro Optativo | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Seguros |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SDAF002](../../../tablas/storage/com_act/SDAF002.md) | lee | `SCODAGR`≈, `SFECPRO`≈ | estatico + motor |
| [storage.com_seg.retp003](../../../tablas/storage/com_seg/retp003.md) | lee | `hcodmod`, `HCODSEG`, `HDESSEG`, `HSUBTIP`, `HTIPOPE` | estatico + motor |
| [storage.com_seg.SDSF001](../../../tablas/storage/com_seg/SDSF001.md) | lee | `scodagr`≈, `scodseg`≈, `sfecpro`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `hcodvar`≈, `hfecpro`≈, `HTIPCOD`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `rfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.ref.fjercor02` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

1. `@headers`
2. `style`, `htipcod`, `cod_fc`, `hcodrel`, `RNOMSUB`, `TOpeOS`, `TOpePC`, `SegPC`, `PorcPenPC`, `TOpeMC`, `SegMC`, `PorcPenMC`, `TOpeAgro`, `SegAgro`, `PorcPenAgro`, `TOpeMR`, `SegMR`, `PorcPenMR`, `TOpeOnco`, `SegOnco`, `PorcPenOnco`, `TOpePT`, `segPT`, `PorcPenPT`, `TSegOS`, `PorcPenOS`, `SMROS`, `SMCOS`, `SPCCOS`, `MetaT`, `(expresión 31)`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_d`, `cte_result`, `cte_seg_pc`, `cte_seg_pc_jer`
- Temporales: `#Meta_Vr2`, `#R1`, `#TABRESULT`, `#TP`, `#fjercor02`
- ⚠️ Columna sin resolver `pvt.SCODDESCRIP`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

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
