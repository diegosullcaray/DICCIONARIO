# mod_rep.com.GDCGEST_ACTIVAST03

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GDCGEST_ACTIVAST03.sql](../../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST03.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GDCGEST_ACTIVAST03.sql](../../../../sql/01-extraccion/mod_rep/com/GDCGEST_ACTIVAST03.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GDCGEST_ACTIVAST03.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GDCGEST_ACTIVAST03.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GST_ACTIVAS_08` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_07` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(10) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@var` | int | — |  | `var` |
| 4 | `@fec` | date | — |  | `fec` |
| 5 | `@diario` | int | 0 |  | `diario` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WACLI001](../../../tablas/storage/com_act/WACLI001.md) | lee | `hfecpro` | estatico + motor |
| [storage.com_act.WGATH002](../../../tablas/storage/com_act/WGATH002.md) | lee | `HFECPRO`, `HGESTTAS`, `HMDES`, `HTDES`, `HTMIN`, `HUCAP_FIN`, `ORD`, `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RANI`, `RDIAFER`, `rfec`, `RMESNOM` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV08` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars"', @config = @tconf | no |
| `tempdb.sys.sp_rename` | @objname = 'dbo.#DES.fila', @newname = 'ORD', @objtype = 'COLUMN' | no |
| `tempdb.sys.sp_rename` | @objname = 'dbo.#DES.descripcion', @newname = 'DESCR', @objtype = 'COLUMN' | no |

### Columnas que devuelve

1. `result`
2. `ORD`, `style`, `DESCR`, `A1`, `A2`, `B1`, `B2`, `B3`, `B4`, `A3`, `A10`, `PO`, `TP`, `TM`, `DT`, `FF`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_d`
- Temporales: `#C`, `#D`, `#DES`, `#FecList`, `#RESULT`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
