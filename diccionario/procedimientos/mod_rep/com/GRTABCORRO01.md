# mod_rep.com.GRTABCORRO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRTABCORRO01.sql](../../../../procedimientos/mod_rep/com/GRTABCORRO01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRTABCORRO01.sql](../../../../sql/01-extraccion/mod_rep/com/GRTABCORRO01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRTABCORRO01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRTABCORRO01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `TABDIG_02` | Tablero digital Corresponsal | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Tablero Digital |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCMC001](../../../tablas/storage/com_act/HCMC001.md) | lee | `HCODIGOCB`≈, `HESTADOTX`≈, `hfecpro`≈ | estatico + motor |
| [storage.com_act.HCMC004](../../../tablas/storage/com_act/HCMC004.md) | lee | `HCODREDEXT`≈, `HCODSUC`≈, `HESTCORR`≈, `HFECINSTALA`≈, `HFECPRO`≈, `HNOMCOR`≈ | estatico + motor |
| [storage.com_act.SDAS021](../../../tablas/storage/com_act/SDAS021.md) | lee | `SAGENCI`, `SCORRED`, `SCORRES`, `STERRIT` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `rfec` | estatico + motor |
| [storage.ref.VJERCOR03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODAGE`, `RCODCOR`, `RCODMAT`≈, `RCODTER`, `RDESCOR`≈, `RDESMAT`≈, `RDESTER`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`style`, `id`, `descripcion`, `V1`, `V2`, `V3`, `Porce`

### Observaciones del análisis

- CTE: `ct_c`, `cte_a`, `cte_b`, `cte_base`, `cte_base_activos`, `cte_base_cancelados`, `cte_base_stock`, `cte_d`, `cte_e`, `cte_f`, `cte_g`, `cte_h`, `cte_i`, `cte_j`, `cte_k`, `cte_kl`, `cte_kls`, `cte_klx`, `cte_sintra`, `cte_sintraj`, `cte_stock_ac_can`, `cte_tipo`, `cte_w`, `cte_wx`, `cte_wxy`, `cte_z`, `pre_result`
- Temporales: `#FECS`, `#FormatTable`, `#Result`, `#Result1`, `#StockCorresponsales`, `#vjercor03`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `STERRIT` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SCORRED` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SAGENCI` (¿storage.com_act.SDAS021?)
- ⚠️ Columna sin resolver `SCORRES` (¿storage.com_act.SDAS021?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
