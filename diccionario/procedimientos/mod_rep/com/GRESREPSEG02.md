# mod_rep.com.GRESREPSEG02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESREPSEG02.sql](../../../../procedimientos/mod_rep/com/GRESREPSEG02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESREPSEG02.sql](../../../../sql/01-extraccion/mod_rep/com/GRESREPSEG02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESREPSEG02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESREPSEG02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRSCMIS_02` | Modulo de Detalle Asesor | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Seguros |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SDAF002](../../../tablas/storage/com_act/SDAF002.md) | lee | `SCLINUE`, `SCODAGR`, `SCODMOD`, `SCODSEC`, `SFECPRO`, `SINTMESMN`, `SMDNUEMN`, `SMONDESMN`, `SNUMCLI`, `SNUMOPE`, `SNUMSEC`, `SOPENUE`, `SSUBTIP`, `SSUCCLI`, `STIPOPE` | estatico + motor |
| [storage.com_seg.SDSF001](../../../tablas/storage/com_seg/SDSF001.md) | lee | `scodagr`, `SCODMOD`, `SCODSEC`, `scodseg`, `SFECEMI`, `SFECPRO`, `SINDPGO`, `SNUMPLZ`, `SSUBTIP`, `SSUCCLI`, `STIPOPE` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.FTHEACOLS01` | 'RSCMIS_02' | no |

### Columnas que devuelve

`SCODDESCRIP`, `RNOMSUB`, `(expresión 3)`, `EMPCPC`, `CCPC`, `CONSUMPC`, `CREPC`, `TO_AG`, `SegPC`, `(expresión 10)`, `(expresión 11)`, `SegMC`, `(expresión 13)`, `(expresión 14)`, `SegAgro`, `(expresión 16)`, `(expresión 17)`, `SegMR`, `SECMR`, `SECCMR`, `TO_IC`, `TO_IN`, `PorcPenMR`, `(expresión 24)`, `SegOnco`, `(expresión 26)`, `(expresión 27)`, `(expresión 28)`, `(expresión 29)`, `(expresión 30)`, `(expresión 31)`, `(expresión 32)`, `(expresión 33)`, `(expresión 34)`, `(expresión 35)`, `(expresión 36)`, `(expresión 37)`, `(expresión 38)`, `(expresión 39)`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_result`, `cte_seg_pc`, `cte_seg_pc_jer`
- Temporales: `#TABRESULT`
- ⚠️ Columna sin resolver `SEG` (¿storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RINDFEC` (¿storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `pvt.SCODDESCRIP`
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
