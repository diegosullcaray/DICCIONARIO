# mod_rep.com.GRMENTOR002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRMENTOR002.sql](../../../../procedimientos/mod_rep/com/GRMENTOR002.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRMENTOR002.sql](../../../../sql/01-extraccion/mod_rep/com/GRMENTOR002.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRMENTOR002.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRMENTOR002.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RMENTORIN_02` | Reporte Mentoring 02 | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@Fecha` | date | — |  | `fec` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`≈, `RFEC`≈ | estatico + motor |
| [storage.ref.wjercor01](../../../tablas/storage/ref/wjercor01.md) | lee | `RDESGRU`≈, `RFECPRO`≈, `RINDFEC`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

`RDESGRU`, `descrip`, `100`, `165`, `5006`, `126`, `122`, `5001`, `0001`, `0002`, `202`

### Observaciones del análisis

- CTE: `cte_jerar`, `cte_meta`
- Temporales: `#DES`, `#Pas`, `#TabMetas`
- ⚠️ Columna sin resolver `HCODVAR` (¿storage.com.VDMCOM01?)
- ⚠️ Columna sin resolver `hcodrel` (¿storage.com.VDMCOM01?)
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.com.VDMCOM01?)
- ⚠️ Columna sin resolver `HTIPMETA` (¿storage.com.VDMCOM01?)
- ⚠️ Columna sin resolver `HTIPCOD` (¿storage.com.VDMCOM01?)
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)
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
