# mod_rep.com.GRESREPSEG01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESREPSEG01.sql](../../../../procedimientos/mod_rep/com/GRESREPSEG01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESREPSEG01.sql](../../../../sql/01-extraccion/mod_rep/com/GRESREPSEG01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESREPSEG01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESREPSEG01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRSCMIS_01` | Modulo de Detalle Seguro | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Seguros |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SDAF002](../../../tablas/storage/com_act/SDAF002.md) | lee | `SCLINUE`, `SCODAGR`, `SCODMOD`, `SCODSEC`, `SFECPRO`, `SINTMESMN`, `SMDNUEMN`, `SMONDESMN`, `SNUMCLI`, `SNUMOPE`, `SNUMSEC`, `SOPENUE`, `SSUBTIP`, `SSUCCLI`, `STIPOPE` | estatico + motor |
| [storage.com_seg.SDSF001](../../../tablas/storage/com_seg/SDSF001.md) | lee | `scodagr`, `SCODMOD`, `SCODSEC`, `scodseg`, `SFECEMI`, `SFECPRO`, `SINDPGO`, `SNUMPLZ`, `SSUBTIP`, `SSUCCLI`, `STIPOPE` | estatico + motor |
| [storage.com_seg.VCSH006](../../../tablas/storage/com_seg/VCSH006.md) | lee | `HCODSEC`, `HFECPRO` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `hfecpro`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `rep.FTHEACOLS01` | 'RSCMIS_01' | no |

### Columnas que devuelve

`SCODDESCRIP`, `RNOMSUB`, `VentaT`, `MetaT`, `(expresión 5)`, `VentaMR`, `MetaMR`, `(expresión 8)`, `VentaMC`, `MetaMC`, `(expresión 11)`, `VentaPRO`, `MetaPRO`, `(expresión 14)`, `VentaAgro`, `MetaAgro`, `(expresión 17)`, `AsesSegu`, `TotalAsesor`, `PorcCob`, `Prod`, `VentaOnco`

### Observaciones del análisis

- CTE: `cte_a`, `cte_a1`, `cte_ase`, `cte_b`, `cte_c`, `cte_d`, `cte_e`
- Temporales: `#Meta_Vr2`, `#PRESULT2`, `#PreResult`
- ⚠️ Columna sin resolver `SEG` (¿storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RINDFEC` (¿storage.com_seg.VCSH006 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `SCODSEC` (¿storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HCODSEC` (¿storage.com_seg.VCSH006 o storage.ref.WJERCOR03?)
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
