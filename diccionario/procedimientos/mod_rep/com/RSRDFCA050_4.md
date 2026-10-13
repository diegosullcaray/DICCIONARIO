# mod_rep.com.RSRDFCA050_4

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSRDFCA050_4.sql](../../../../extraccion/procedimientos/mod_rep/com/RSRDFCA050_4.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSRDFCA050_4.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSRDFCA050_4.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSRDFCA050_4.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSRDFCA050_4.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `prod_misi_05` | Monitor desembolsos Operación  | `tip_cod`, `cod_rel`, `fec`, `prod` | reportes / desarrollo-sostenible |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | nvarchar(50) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@prod` | varchar(250) | — |  | `prod` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `HFECPRO` | estatico + motor |
| [storage.com_act.SDAF001](../../../tablas/storage/com_act/SDAF001.md) | lee | `SFECPRO` | estatico + motor |
| [storage.com_act.SDAS010](../../../tablas/storage/com_act/SDAS010.md) | lee | `SFECPRO`, `SHORPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jera output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jera, @columns = '"prod_mis_com","vars"', @config = @tconf | no |

### Columnas que devuelve

1. `@headers`
2. `cod`, `descripcion`, `meta_Anual`, `num_ope`, `cumpl`, `met_requerido`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `##cteDatMetas`, `##cteDatMetasRequerido`, `#SDAF001`, `#SDAF001_`, `#SDAF001_Prev`, `#cteDatMetas`, `#cteDatMetasRequerido`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver

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
