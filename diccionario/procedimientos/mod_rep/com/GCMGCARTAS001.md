# mod_rep.com.GCMGCARTAS001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GCMGCARTAS001.sql](../../../../extraccion/procedimientos/mod_rep/com/GCMGCARTAS001.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GCMGCARTAS001.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GCMGCARTAS001.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GCMGCARTAS001.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GCMGCARTAS001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CMG_CARTERA_ASESOR_01` | Cartera Asesor | `cod_rel`, `Fecha`, `tip_cod`, `met` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 2 | `@Fecha` | date | — |  | `Fecha` |
| 3 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 4 | `@met` | int | 1 |  | `met` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `HCODREL`, `HFECPRO`, `HSALMEDMN`, `HSALMEDMNVIGE`, `HTIPCOD`, `HVSALMN`, `HVSALVIGMN` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = '"fec"', @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

`@headers`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#AAA`, `#ACUM00`, `#CMG`, `#DES`, `#DES00`, `#FECS`, `#RES`, `#RESULT01`, `#RESULT02`, `#RESULTPRE`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.util.FFMTVAR`
- `mod_rep.util.FSEMVAR`
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
