# mod_rep.com.RSPANSUP001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSPANSUP001.sql](../../../../procedimientos/mod_rep/com/RSPANSUP001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSPANSUP001.sql](../../../../sql/01-extraccion/mod_rep/com/RSPANSUP001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSPANSUP001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSPANSUP001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PANEL_SUP_01` | Panel de Supervisión | `tip_cod`, `cod_rel`, `carg` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | nvarchar(10) | — |  | `cod_rel` |
| 3 | `@carg` | nvarchar(100) | — |  | `carg` |

### Tablas y columnas (13)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [mod_sys_login.dbo.SUSEALT01](../../../tablas/mod_sys_login/dbo/SUSEALT01.md) | lee | `SFECCRE`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HFECPRO`, `HTIPCOD` | estatico + motor |
| [storage.gpr.HPAD001](../../../tablas/storage/gpr/HPAD001.md) | lee | `HCODPER`, `HMAILPER` | estatico + motor |
| [storage.gpr.HPVP001](../../../tablas/storage/gpr/HPVP001.md) | lee | `HCODBT`, `HDIAS`, `HFECPRO` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |
| [storage.ref.RECCA001](../../../tablas/storage/ref/RECCA001.md) | lee | `RCODTER`, `RUSUADM` | estatico + motor |
| [storage.ref.RECCT001](../../../tablas/storage/ref/RECCT001.md) | lee | `rcodcor`, `RUSUADM` | estatico + motor |
| [storage.ref.RECUC001](../../../tablas/storage/ref/RECUC001.md) | lee | `RCODADM`, `RCODUNI` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODSEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `rep.FTHEACOLS01` | 'PANEL_SUP_01' | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Observaciones del análisis

- CTE: `a`
- Temporales: `#HPVP001`, `#Super`, `#VDMCOM01`, `#WJERCOR03`, `#base_in`, `#basesup`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `RFECPRO` (¿storage.gpr.HPAD001 o storage.ref.RECCA001 o storage.ref.RECCT001 o storage.ref.RECUC001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RDESGRU` (¿storage.gpr.HPAD001 o storage.ref.RECCA001 o storage.ref.RECCT001 o storage.ref.RECUC001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RINDFEC` (¿storage.gpr.HPAD001 o storage.ref.RECCA001 o storage.ref.RECCT001 o storage.ref.RECUC001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RCODADM` (¿storage.gpr.HPAD001 o storage.ref.RECCT001 o storage.ref.RECUC001?)
- ⚠️ Columna sin resolver `rcodsec` (¿storage.gpr.HPAD001 o storage.ref.RECUC001?)
- ⚠️ Columna sin resolver `RCODTER` (¿storage.gpr.HPAD001 o storage.ref.RECUC001?)
- ⚠️ Columna sin resolver `SCODUSE` (¿storage.gpr.HPAD001 o storage.ref.RECUC001?)
- ⚠️ Columna sin resolver `RCODCOR` (¿storage.ref.RECCA001?)
- ⚠️ Columna sin resolver `RCODGRU` (¿storage.ref.RECCA001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
