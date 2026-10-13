# mod_rep.com.GRESREPSEG06

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GRESREPSEG06.sql](../../../../extraccion/procedimientos/mod_rep/com/GRESREPSEG06.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GRESREPSEG06.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GRESREPSEG06.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GRESREPSEG06.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GRESREPSEG06.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRSCMIS_05` | Reporte Detalle | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Seguros |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SDAF002](../../../tablas/storage/com_act/SDAF002.md) | lee | `*`, `SCODMOD`, `sfecpro`, `SSUBTIP`, `STIPOPE` | estatico + motor |
| [storage.com_seg.SDSF001](../../../tablas/storage/com_seg/SDSF001.md) | lee | `*`, `scodseg`, `sfecpro` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `hfecpro`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`≈, `rfec`≈ | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `rfecpro`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.ref.FJERCOR02` (función) | — | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_d`, `cte_result`, `cte_seg_pc`, `cte_seg_pc_jer`
- Temporales: `#FJERCOR`, `#Fec`, `#Meta_Vr2`, `#PreResult`, `#PreResult2`, `#REPSEGUROS`, `#ResultSeg`, `#TABRESULT`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `SCODMOD` (¿storage.com_act.SDAF002?)
- ⚠️ Columna sin resolver `STIPOPE` (¿storage.com_act.SDAF002?)
- ⚠️ Columna sin resolver `SSUBTIP` (¿storage.com_act.SDAF002?)
- ⚠️ Columna sin resolver `SCODAGR` (¿storage.com_act.SDAF002 o storage.com_seg.SDSF001?)
- ⚠️ Columna sin resolver `scodseg` (¿storage.com_seg.SDSF001?)
- ⚠️ Columna sin resolver `pvt.SCODDESCRIP`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
- `mod_rep.rep.FFTHCOLDEF`
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
