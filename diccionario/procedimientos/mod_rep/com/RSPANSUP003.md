# mod_rep.com.RSPANSUP003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSPANSUP003.sql](../../../../procedimientos/mod_rep/com/RSPANSUP003.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSPANSUP003.sql](../../../../sql/01-extraccion/mod_rep/com/RSPANSUP003.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSPANSUP003.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSPANSUP003.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PANEL_SUP_03` | Panel de Supervisión 2 | `tip_cod`, `cod_rel`, `carg` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | nvarchar(10) | — |  | `cod_rel` |
| 3 | `@carg` | nvarchar(100) | — |  | `carg` |

### Tablas y columnas (8)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.api.FUSECDIV01](../../../tablas/storage/api/FUSECDIV01.md) | — | — | motor |
| [storage.com_act.HDSC001](../../../tablas/storage/com_act/HDSC001.md) | lee | `HCARGO`, `HFECPRO`, `HPERSUP`, `HREG` | estatico + motor |
| [storage.com_act.HMSUP001](../../../tablas/storage/com_act/HMSUP001.md) | lee | `HDESREL`≈, `HFECPRO`≈, `HPOSTCOORPDM`≈, `HPOSTGREG`≈, `HPOSTJAGRO`≈, `HPOSTJINCL`≈, `HPRECOORPDM`≈, `HPREGREG`≈, `HPREJAGRO`≈, `HPREJINCL`≈ | estatico + motor |
| [storage.com_act.SDAS006](../../../tablas/storage/com_act/SDAS006.md) | lee | `SCARGO`, `SCODAGR`, `SFECPRO`, `SOPECONF`, `SOPEPRE`, `SSUCCLI` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `day`≈, `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |
| [storage.ref.REAM001](../../../tablas/storage/ref/REAM001.md) | lee | `RCODAGE`, `RCODMAT` | estatico + motor |
| [storage.ref.REMR001](../../../tablas/storage/ref/REMR001.md) | lee | `RCODMAT`, `RCODREG`, `RDESMAT` | estatico + motor |
| [storage.ref.RERT001](../../../tablas/storage/ref/RERT001.md) | lee | `RCODREG`, `RCODTER`, `RDESREG` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.FTHEACOLS01` | 'PANEL_SUP_01' | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `a`, `b`, `m`
- Temporales: `#def`, `#limitate`
- ⚠️ Columna sin resolver `SOPEPOST` (¿storage.com_act.SDAS006 o storage.ref.REAM001 o storage.ref.REMR001 o storage.ref.RERT001?)
- ⚠️ Columna sin resolver `SOPESEAL` (¿storage.com_act.SDAS006 o storage.ref.REAM001 o storage.ref.REMR001 o storage.ref.RERT001?)
- ⚠️ Columna sin resolver `SOPEREGR` (¿storage.com_act.SDAS006 o storage.ref.REAM001 o storage.ref.REMR001 o storage.ref.RERT001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
