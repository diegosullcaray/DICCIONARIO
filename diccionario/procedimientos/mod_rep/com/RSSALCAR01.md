# mod_rep.com.RSSALCAR01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSSALCAR01.sql](../../../../extraccion/procedimientos/mod_rep/com/RSSALCAR01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSSALCAR01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSSALCAR01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSSALCAR01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSSALCAR01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_SAL_CAR_01` | Saldo Puntual de Cartera | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | — | `HCANAMN`, `HCANAPGMN`, `HCANASPGMN`, `HCODREL`, `HFECPRO`, `HMDESAPGMN`, `HMDESASPGMN`, `HMONDESAMN`, `HMONDESMN`, `HNUMBANCOMP`, `HNUMBANEXC`, `HNUMCLI`, `HNUMCLIEDAD1`, `HNUMCLIEDAD2`, `HNUMCLIEDAD3`, `HNUMCLIEDAD4`, `HNUMCLIEDAD5`, `HNUMCLIFEME`, `HNUMCLIG`, `HNUMCLII`, `HNUMCLIINMI`, `HNUMCLIJURI`, `HNUMCLIMASC`, `HNUMCLIMES`, `HNUMCLIMESPG`, `HNUMCLIMESSPG`, `HNUMCLIN`, `HNUMCLIPERU`, `HNUMCLIPG`, `HNUMCLIRUR`, `HNUMCLISPG`, `HNUMCLIURB`, `HNUMOPE`, `HNUMSECGMES`, `HNUMSECGMESPG`, `HNUMSECGMESSPG`, `HNUMSECIMES`, `HNUMSECIMESPG`, `HNUMSECIMESSPG`, `HNUMSECMES`, `HNUMSECMESPG`, `HNUMSECMESSPG`, `HODESAPGMN`, `HODESASPGMN`, `HOPEDESA`, `HSALMEDMN`, `HSALMEDMNVIGE`, `HSALMPGMN`, `HSALMPGMNVIGE`, `HSALMSPGMN`, `HSALMSPGMNVIGE`, `HTIPCOD`, `HVSALMN`, `HVSALPGMN`, `HVSALSPGMN`, `HVSALVIGMN`, `HVSALVIGPG`, `HVSALVIGSPG`, `HVULEXPOBREZA`, `HVULNERABLE`, `HVULOTROS`, `HVULPOBREZA`, `HVULSINCALIF` | motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`≈, `HFECPRO`≈, `HTIPCOD`≈, `HVALVAR`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer output, 9, @lvl_cfg | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

1. `result`
2. `*`, `sal_cap_ant`, `meta_cart`, `dist_met_cart`, `meta_var_cart`, `var_cart`, `dist_met_var_cart`, `sem_met_cart`, `sem_met_var_cart`, `descripcion`, `descripcion`, `(expresión 12)`, `HTIPCOD`, `(expresión 14)`, `HCODREL`, `cod_n1`, `cod_n2`, `cod_n3`

### Observaciones del análisis

- CTE: `cte_act`, `cte_ant`, `cte_m`
- Temporales: `#ract`, `#ract0`, `#ract1`, `#rant`, `#rant0`, `#rant1`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)
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
