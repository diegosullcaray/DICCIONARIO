# mod_rep.com.RSSEGPAS02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSSEGPAS02.sql](../../../../extraccion/procedimientos/mod_rep/com/RSSEGPAS02.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSSEGPAS02.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSSEGPAS02.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSSEGPAS02.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSSEGPAS02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_SEG_PAS_02` | Seguros Pasivos Multiple Ahorro | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Seguros |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | '20240610' |  | `fec` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `hfecpro`, `HTIPCOD`, `HVALVAR`, `Tip_cod`≈, `tip_cod2`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RDIASEM`, `RFEC` | estatico + motor |
| [storage.ref.VJERCOR04](../../../tablas/storage/ref/VJERCOR04.md) | lee | `RCODAGE`, `RCODFC`, `RCODMAC`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESFC`, `RDESMAC`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV09` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"Prod_Seg","vars","fec_corr"', @config = @tconf | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

1. `@head`
2. `fila`, `cod_fc`, `cod_cter_seg_m`, `style`, `descripcion`, `617_num_pol_pasiv_1`, `617_num_pol_pasiv_2`, `617_num_pol_pasiv_3`, `TMM_617`, `meta_617`, `AV_ESP_617`, `var_meta_617`, `vari_ava_espe_617`, `618_num_pol_pasiv_1`, `618_num_pol_pasiv_2`, `618_num_pol_pasiv_3`, `TMM_618`, `meta_618`, `AV_ESP_618`, `var_meta_618`, `vari_ava_espe_618`, `619_num_pol_pasiv_1`, `619_num_pol_pasiv_2`, `619_num_pol_pasiv_3`, `TMM_619`, `meta_619`, `AV_ESP_619`, `var_meta_619`, `vari_ava_espe_619`

### Observaciones del análisis

- CTE: `cte_niv1`, `cte_niv1_`, `cte_niv2`, `cte_niv2_`, `cte_u`
- Temporales: `#FECS`, `#M`, `#T_`

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
