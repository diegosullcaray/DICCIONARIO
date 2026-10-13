# mod_rep.com.RSRDFCA029

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSRDFCA029.sql](../../../../extraccion/procedimientos/mod_rep/com/RSRDFCA029.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSRDFCA029.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSRDFCA029.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSRDFCA029.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSRDFCA029.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `Monitor_Dese_04` | Monitor desembolsos Promedio | `tip_cod`, `cod_rel` | reportes / avance-comercial |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `HFECPRO` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jera output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jera, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

`variable`, `des_diario`, `des_mensual`, `ope_diario`, `ope_mensual`

### Observaciones del análisis

- CTE: `cte_desem_diario`, `cte_desem_diario_final`, `cte_desem_ini_diario`, `cte_desem_ini_mes`, `cte_desem_mensual`, `cte_desem_mensual_final`, `cte_orden_monto`, `cte_orden_ope`
- Temporales: `#FECHASDES`, `#SDAF001`
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
