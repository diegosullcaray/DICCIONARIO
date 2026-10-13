# mod_rep.com.GDCGEST_ACTIVAST04

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GDCGEST_ACTIVAST04.sql](../../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST04.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GDCGEST_ACTIVAST04.sql](../../../../sql/01-extraccion/mod_rep/com/GDCGEST_ACTIVAST04.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GDCGEST_ACTIVAST04.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GDCGEST_ACTIVAST04.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GST_ACTIVAS_09` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_10` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(10) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@var` | int | — |  | `var` |
| 4 | `@fec` | date | — |  | `fec` |
| 5 | `@diario` | int | 0 |  | `diario` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [storage.com_act.WACLI001](../../../tablas/storage/com_act/WACLI001.md) | lee | `hfecpro` | estatico + motor |
| [storage.com_act.WGATH002](../../../tablas/storage/com_act/WGATH002.md) | lee | `HFECPRO`, `HGESTTAS`, `HMDES`, `HTDES`, `HTMIN`, `HUCAP_FIN`, `ORD`, `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFEC` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RANI`, `RDIAFER`, `rfec`, `RMESNOM` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar, output | no |

### Columnas que devuelve

1. `result`
2. `*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_d`
- Temporales: `#C`, `#D`, `#FIN`, `#FecList`, `#RES`, `#RESULT`, `#res`
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
