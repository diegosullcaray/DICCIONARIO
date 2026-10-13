# mod_rep.com.GLIMOVRO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GLIMOVRO01.sql](../../../../procedimientos/mod_rep/com/GLIMOVRO01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GLIMOVRO01.sql](../../../../sql/01-extraccion/mod_rep/com/GLIMOVRO01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GLIMOVRO01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GLIMOVRO01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PLANMOVR_01` | Planilla Movilidad Recuperador | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [mod_sys_admin.dbo.SUSEPROF01](../../../tablas/mod_sys_admin/dbo/SUSEPROF01.md) | lee | `SCODPROFN`, `SCODUSE` | estatico + motor |
| [STORAGE.com_act.HBMOV001](../../../tablas/STORAGE/com_act/HBMOV001.md) | lee | `GRUPo`, `HCODGEOR`, `HCODSEC`, `HCTACLI`, `HDESCLI`, `HDESPER`, `HDISTR`, `HDISTR_LLEGADA`, `HDISTREC`, `HDPT`, `HFECEMI`, `hfecpro`, `HFECREG`, `HMONTDIS`, `HMOTIV`, `HNUMDOC`, `HNUMDOCCLI`, `HNUMREG`, `HPROV`, `mm`≈, `yyyy`≈ | estatico + motor |
| [storage.com_act.VCAH001](../../../tablas/storage/com_act/VCAH001.md) | lee | `hctacli`, `hdescli` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HMAILPER`, `HNUMDOC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `nivel`, `HFECREG`, `HCODSEC`, `HNUMREG`, `HMOTIV`, `HDESCLI`, `HDISTR`, `HDISTR_LLEGADA`, `HCODGEOR`, `HDISTREC`, `HMONTDIS`, `HPROV`, `HDPT`, `HCTACLI`
2. `HFECEMI`, `style_HFECEMI`, `Fecha`
3. `nivel`, `HFECREG`, `HCODSEC`, `HNUMREG`, `HMOTIV`, `HDESCLI`, `HDISTR`, `HDISTR_LLEGADA`, `HCODGEOR`, `HDISTREC`, `HMONTDIS`, `HPROV`, `HDPT`, `HCTACLI`
4. `HFECEMI`, `style_HFECEMI`, `Fecha`

### Observaciones del análisis

- Temporales: `#HBMOV001`
- ⚠️ Columna sin resolver `HMOTIV` (¿STORAGE.com_act.HBMOV001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
