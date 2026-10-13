# mod_rep.com.GRESREPSEG05

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GRESREPSEG05.sql](../../../../extraccion/procedimientos/mod_rep/com/GRESREPSEG05.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GRESREPSEG05.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GRESREPSEG05.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GRESREPSEG05.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GRESREPSEG05.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRSCMIS_04` | Meta por Producto | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Seguros |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |

### Tablas y columnas (8)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.RETP001](../../../tablas/storage/com_act/RETP001.md) | lee | `RCODMOD`, `RCODPROD`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP002](../../../tablas/storage/com_act/RETP002.md) | lee | `RCODMOD`, `RCODPROD`, `RSUBTIP`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP003](../../../tablas/storage/com_act/RETP003.md) | lee | `RCODPROD` | estatico + motor |
| [storage.com_act.SDAF002](../../../tablas/storage/com_act/SDAF002.md) | lee | `*`, `SCLINUE`, `SCODAGR`, `SCODMOD`, `SCODSEC`, `SFECPRO`, `SINTMESMN`, `SMDNUEMN`, `SMONDESMN`, `SNUMCLI`, `SNUMOPE`, `SNUMSEC`, `SOPENUE`, `SSUBTIP`, `SSUCCLI`, `STIPOPE` | estatico + motor |
| [storage.com_seg.SDSF001](../../../tablas/storage/com_seg/SDSF001.md) | lee | `*`, `SCODAGR`, `SCODMOD`, `SCODSEC`, `SCODSEG`, `SFECEMI`, `sfecpro`, `SINDPGO`, `SNUMPLZ`, `SSUBTIP`, `SSUCCLI`, `STIPOPE` | estatico + motor |
| [storage.com.metas_saldos](../../../tablas/storage/com/metas_saldos.md) | lee | `hcodvar`≈, `hfecpro`≈, `HTIPCOD`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `hfecpro`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`SCODDESCRIP`, `descripcion`, `T_OPE_IO`, `T_S_IO`, `PERCENT_S_IO`, `S_MR_IO`, `S_MC_IO`, `S_PC_IO`, `MET_IO`, `AVANCE_IO`, `T_OPE_CE`, `T_S_EC`, `PERCENT_S_CE`, `MET_EC`, `AVANCE_EC`, `T_OPE_CONSUMO`, `T_S_CONSUMO`, `PERCENT_S_CONSUMO`, `S_MC_CONSUMO`, `S_PC_CONSUMO`, `MET_CONSUMO`, `AVANCE_CONSUMO`, `T_OPE_AGRO`, `T_S_AGRO`, `PERCENT_S_AGRO`, `S_MR_AGRO`, `S_MC_AGRO`, `S_PC_AGRO`, `S_AGRO_AGRO`, `MET_AGRO`, `AVANCE_AGRO`, `T_OPE_ONCO`, `S_ONCO`, `PERCENT_S_ONCO`, `T_OPE_PYME_CC`, `T_S_PYME_CC`, `PERCENT_S_PYME_CC`, `S_MR_PYME_CC`, `S_MC_PYME_CC`, `S_PC_PYME_CC`, `MET_PYME_CC`, `AVANCE_PYME_CC`, `T_OPE_TOTAL`, `T_S_TOTAL`, `T_S_T_MR`, `T_S_T_MC`, `T_S_T_PC`, `T_S_T_AGRO`, `T_Ope_EC`, `T_Ope_CC`, `T_Ope_CC`, `T_Ope_CONSU`, `T_Ope_CE`, `T_Ope_IO`, `T_Ope_IN`, `PERCENT_S_TOTAL`, `META`, `Avance`, `Cumplimiento`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_d`, `cte_result`, `cte_seg`, `cte_seg_pc_jer`
- Temporales: `#Data`, `#MetSeg`, `#Meta_Vr2`, `#TABRESULTCartera`, `#TABRESULTSeguros`
- ⚠️ Columna sin resolver `SFECPRO` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAF002?)
- ⚠️ Columna sin resolver `SCODAGR` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAF002 o storage.com_seg.SDSF001?)
- ⚠️ Columna sin resolver `RCODPROD` (¿storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RINDFEC` (¿storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `SCODSEG` (¿storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `pvt.SCODDESCRIP`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

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
