# mod_rep.com.GRTABDIGO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GRTABDIGO01.sql](../../../../extraccion/procedimientos/mod_rep/com/GRTABDIGO01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GRTABDIGO01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GRTABDIGO01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GRTABDIGO01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GRTABDIGO01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `TABDIG_VR2_01` | TABLERO DIGITAL | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Tablero Digital |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (7)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_pas.WCAP002](../../../tablas/storage/com_pas/WCAP002.md) | lee | `HPENDOC`, `HPEPAIS`, `HPETDOC`, `HSBSUC` | estatico + motor |
| [storage.com_pas.WCLIENRO001](../../../tablas/storage/com_pas/WCLIENRO001.md) | lee | `hcodcan`, `HSBSUC` | estatico + motor |
| [storage.com_pas.WMTCORRE001](../../../tablas/storage/com_pas/WMTCORRE001.md) | lee | `HCODCAN`≈ | estatico + motor |
| [storage.com_pas.WTRXMONE001](../../../tablas/storage/com_pas/WTRXMONE001.md) | lee | `HDESPROC`, `HNUMDOC`, `HTIPDOC`, `HTIPTRAX`, `HTOTINTE`, `RCODSUC` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `hcodrel`≈, `HCODVAR`, `hfecpro`, `htipcod`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`≈, `RFEC`≈ | estatico + motor |
| [storage.ref.VJERCOR04](../../../tablas/storage/ref/VJERCOR04.md) | lee | `RCODAGE`, `RCODAGEH`, `RCODMAC`, `RCODMAT`, `RCODTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_base_activos`, `cte_base_cancelados`, `cte_base_stock`, `cte_h_base_carec`, `cte_h_enrolado`, `cte_h_maestro_corre`, `cte_resul_num_usab`, `cte_result`, `cte_result_cli_net`, `cte_result_enrolado`, `cte_result_otros_tx_s_monetarias`, `cte_result_pagocredito_s_monetaria`, `cte_result_perce_enrolado`, `cte_result_perce_usab`, `cte_result_stock_ac_can`, `cte_result_transferencia_s_monetaria`, `cte_result_trx_n_monetaria`, `cte_result_trx_s_monetaria`
- Temporales: `#FECS`, `#M`, `#PreRESULT`, `#Result`, `#TFORMAT`, `#vjercor04`
- ⚠️ Columna sin resolver `HORD` (¿STORAGE.com_pas.WCLIENRO001 o STORAGE.com_pas.WTRXMONE001 o storage.com_pas.WCAP002?)
- ⚠️ Columna sin resolver `HFECPRO` (¿STORAGE.com_pas.WCLIENRO001 o STORAGE.com_pas.WTRXMONE001 o storage.com_pas.WCAP002?)
- ⚠️ Columna sin resolver `HTIPNUMDOC` (¿STORAGE.com_pas.WCLIENRO001?)
- ⚠️ Columna sin resolver `HPETDOC` (¿storage.com_pas.WCAP002?)
- ⚠️ Columna sin resolver `HPENDOC` (¿storage.com_pas.WCAP002?)
- ⚠️ Columna sin resolver `HPEPAIS` (¿storage.com_pas.WCAP002?)
- ⚠️ Columna sin resolver `HCODCAN` (¿STORAGE.com_pas.WTRXMONE001 o storage.com_pas.WCAP002?)
- ⚠️ Columna sin resolver `HTIPDOC` (¿STORAGE.com_pas.WTRXMONE001?)
- ⚠️ Columna sin resolver `HNUMDOC` (¿STORAGE.com_pas.WTRXMONE001?)
- ⚠️ Columna sin resolver `HTOTINTE` (¿STORAGE.com_pas.WTRXMONE001?)
- ⚠️ Columna sin resolver `HTIPTRAX` (¿STORAGE.com_pas.WTRXMONE001?)
- ⚠️ Columna sin resolver `HDESPROC` (¿STORAGE.com_pas.WTRXMONE001?)
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
