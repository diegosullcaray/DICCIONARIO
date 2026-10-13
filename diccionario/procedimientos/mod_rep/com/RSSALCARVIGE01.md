# mod_rep.com.RSSALCARVIGE01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSSALCARVIGE01.sql](../../../../procedimientos/mod_rep/com/RSSALCARVIGE01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSSALCARVIGE01.sql](../../../../sql/01-extraccion/mod_rep/com/RSSALCARVIGE01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSSALCARVIGE01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSSALCARVIGE01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_SAL_CAR_04` | Saldo Puntual de Cartera Vigente | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera<br>shared / ui |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (8)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `HCANAMN`, `HCANAPGMN`, `HCANASPGMN`, `HCODREL`, `hfecpro`, `HMDESAPGMN`, `HMDESASPGMN`, `HMONDESAMN`, `HMONDESMN`, `HNUMBANCOMP`, `HNUMBANEXC`, `HNUMCLI`, `HNUMCLIEDAD1`, `HNUMCLIEDAD2`, `HNUMCLIEDAD3`, `HNUMCLIEDAD4`, `HNUMCLIEDAD5`, `HNUMCLIFEME`, `HNUMCLIG`, `HNUMCLII`, `HNUMCLIINMI`, `HNUMCLIJURI`, `HNUMCLIMASC`, `HNUMCLIMES`, `HNUMCLIMESPG`, `HNUMCLIMESSPG`, `HNUMCLIN`, `HNUMCLIPERU`, `HNUMCLIPG`, `HNUMCLIRUR`, `HNUMCLISPG`, `HNUMCLIURB`, `HNUMOPE`, `HNUMSECGMES`, `HNUMSECGMESPG`, `HNUMSECGMESSPG`, `HNUMSECIMES`, `HNUMSECIMESPG`, `HNUMSECIMESSPG`, `HNUMSECMES`, `HNUMSECMESPG`, `HNUMSECMESSPG`, `HODESAPGMN`, `HODESASPGMN`, `HOPEDESA`, `HSALMEDMN`, `HSALMEDMNVIGE`, `HSALMPGMN`, `HSALMPGMNVIGE`, `HSALMSPGMN`, `HSALMSPGMNVIGE`, `HTIPCOD`, `HVSALMN`, `HVSALPGMN`, `HVSALSPGMN`, `HVSALVIGMN`, `HVSALVIGPG`, `HVSALVIGSPG`, `HVULEXPOBREZA`, `HVULNERABLE`, `HVULOTROS`, `HVULPOBREZA`, `HVULSINCALIF` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`≈, `HFECPRO`≈, `HTIPCOD`≈, `HVALVAR`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer, output, 9, @lvl_cfg | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |

### Columnas que devuelve

1. `result`
2. `*`
3. `*`, `HSALMEDMNVIGE`, `meta_sal_cart_v2`, `dist_met_cart_v2`
4. `*`, `HSALMEDMNVIGE`, `meta_sal_cart_v2`, `dist_met_cart_v2`

### Observaciones del análisis

- CTE: `cte_act`, `cte_ant`, `cte_m`
- Temporales: `#PreResult`, `#SaldoMedio`, `#ract`, `#ract0`, `#ract1`, `#rant`, `#rant0`, `#rant1`
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
