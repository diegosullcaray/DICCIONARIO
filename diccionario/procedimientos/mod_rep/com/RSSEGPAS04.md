# mod_rep.com.RSSEGPAS04

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSSEGPAS04.sql](../../../../extraccion/procedimientos/mod_rep/com/RSSEGPAS04.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSSEGPAS04.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSSEGPAS04.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSSEGPAS04.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSSEGPAS04.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_SEG_PAS_04` | Seguros Pasivos Protección Total | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Seguros |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_seg.RETPP004](../../../tablas/storage/com_seg/RETPP004.md) | lee | `HCODSEG`, `hcomifc`, `HDESPLAN`, `hmonpri` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `hfecpro`, `HTIPCOD`, `HVALVAR`, `Tip_cod`≈, `tip_cod2`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RDIASEM`, `RFEC` | estatico + motor |
| [storage.ref.VJERCOR04](../../../tablas/storage/ref/VJERCOR04.md) | lee | `RCODAGE`, `RCODFC`, `RCODMAC`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESFC`, `RDESMAC`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV09` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars","fec_corr"', @config = @tconf | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

1. `@head`
2. `*`

### Observaciones del análisis

- CTE: `cte_niv1`, `cte_niv1_`, `cte_niv2`, `cte_niv2_`, `cte_u`
- Temporales: `#D`, `#D2`, `#DD3`, `#FECS`, `#M`
- ⚠️ Columna sin resolver `fila` (¿STORAGE.com_seg.RETPP004?)
- ⚠️ Columna sin resolver `cod_cter_seg_m` (¿STORAGE.com_seg.RETPP004?)
- ⚠️ Columna sin resolver `cod_ccor_seg_m` (¿STORAGE.com_seg.RETPP004?)
- ⚠️ Columna sin resolver `cod_Prod_Seg_Pas_Plan` (¿STORAGE.com_seg.RETPP004?)
- ⚠️ Columna sin resolver `style` (¿STORAGE.com_seg.RETPP004?)
- ⚠️ Columna sin resolver `descripcion` (¿STORAGE.com_seg.RETPP004?)
- ⚠️ Columna sin resolver `num_pol_pasiv_NT_1` (¿STORAGE.com_seg.RETPP004?)
- ⚠️ Columna sin resolver `num_pol_pasiv_NT_2` (¿STORAGE.com_seg.RETPP004?)
- ⚠️ Columna sin resolver `num_pol_pasiv_NT_3` (¿STORAGE.com_seg.RETPP004?)
- ⚠️ Columna sin resolver `hcomifc` (¿STORAGE.com_seg.RETPP004?)

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
