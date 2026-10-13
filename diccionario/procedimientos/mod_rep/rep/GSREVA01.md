# mod_rep.rep.GSREVA01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `rep` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/rep/GSREVA01.sql](../../../../extraccion/procedimientos/mod_rep/rep/GSREVA01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/rep/GSREVA01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/rep/GSREVA01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/rep/GSREVA01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/rep/GSREVA01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (3)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GSREVA01` | Reporte Reva | `Fecha`, `tipcod`, `codrel`, `codmod` | — |
| `GSREVA101` | Reporte Reva | `Fecha`, `tipcod`, `codrel`, `codmod` | — |
| `GSREVA201` | Reporte Reva | `Fecha`, `tipcod`, `codrel`, `codmod` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@Fecha` | date | — |  | `Fecha` |
| 2 | `@tipcod` | int | - 1 |  | `tipcod` |
| 3 | `@codrel` | varchar(50) | — |  | `codrel` |
| 4 | `@codmod` | smallint | - 1 |  | `codmod` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.RREGVAR01](../../../tablas/mod_rep/rep/RREGVAR01.md) | lee | `RALIVAR`, `RAMBGRU`, `RCODVAR`, `RDESVAR`, `RFORV01`, `RFORV02` | estatico + motor |
| [mod_rep.rep.SDECCOM01](../../../tablas/mod_rep/rep/SDECCOM01.md) | lee | `SCODSUB`, `STIPCOD` | estatico + motor |
| [mod_rep.reva.SVARREVA01](../../../tablas/mod_rep/reva/SVARREVA01.md) | lee | `SAMBFIL`, `SAMBGRU`, `SCODMOD`, `SCODVAR`, `SDESVAR`, `SORDREV` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `rep.RCALC` | @json | no |
| `rep.FTHEACOLS01` | 'GSREVA01' | no |

### Columnas que devuelve

`RNUM`, `RNOMSUB`, `DESVAL`, `2`, `1`, `-12`, `0`, `100`, `-10`

### Observaciones del análisis

- CTE: `cteadic`, `cteadic2`, `ctedatos`, `cteformat`, `ctefupvt`
- Temporales: `#tmpDATOS`
- ⚠️ Columna sin resolver `SAMBFIL` (¿mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01?)
- ⚠️ Columna sin resolver `SDESVAR` (¿mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01?)
- ⚠️ Columna sin resolver `RDESVAR` (¿mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01?)
- ⚠️ Columna sin resolver `json` (¿mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01?)
- ⚠️ Columna sin resolver `path` (¿mod_rep.rep.RREGVAR01 o mod_rep.reva.SVARREVA01?)
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFORMAT`
- `mod_rep.rep.FUMB`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
