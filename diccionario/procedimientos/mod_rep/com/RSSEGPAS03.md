# mod_rep.com.RSSEGPAS03

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSSEGPAS03.sql](../../../../procedimientos/mod_rep/com/RSSEGPAS03.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSSEGPAS03.sql](../../../../sql/01-extraccion/mod_rep/com/RSSEGPAS03.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSSEGPAS03.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSSEGPAS03.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_SEG_PAS_03` | Seguros Pasivos Resumen | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Seguros |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | '20240610' |  | `fec` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [storage.com_seg.RETC001](../../../tablas/storage/com_seg/RETC001.md) | lee | `HCODSEG` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `hfecpro`, `HTIPCOD`, `HVALVAR` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RDIASEM`, `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV09` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars","fec_corr"', @config, =, @tconf | no |

### Columnas que devuelve

1. `@head`
2. `*`, `TMM`, `var_meta`, `Avance_Esperado`, `vari_ava_espe`, `Total_Ing`, `meta`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#FECS`, `#T`
- ⚠️ Columna sin resolver `num_pol_pasiv_3` (¿storage.com_seg.RETC001?)
- ⚠️ Columna sin resolver `num_pol_pasiv_2` (¿storage.com_seg.RETC001?)
- ⚠️ Columna sin resolver `cod_Prod_Seg` (¿storage.com_seg.RETC001?)
- ⚠️ Columna sin resolver `HCOMIFC` (¿storage.com_seg.RETC001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
