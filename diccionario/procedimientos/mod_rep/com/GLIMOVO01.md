# mod_rep.com.GLIMOVO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GLIMOVO01.sql](../../../../procedimientos/mod_rep/com/GLIMOVO01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GLIMOVO01.sql](../../../../sql/01-extraccion/mod_rep/com/GLIMOVO01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GLIMOVO01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GLIMOVO01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PLANMOV_01` | Planilla Movilidad | `tip_cod`, `cod_rel`, `fec` | — |
| `PLANMOVPERFIL_01` | Planilla Movilidad Perfil | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HBMOV001](../../../tablas/storage/com_act/HBMOV001.md) | lee | `HCODGEOR`, `HCODSEC`, `HCTACLI`, `HDISTR`, `HDISTR_LLEGADA`, `HDISTREC`, `HDPT`, `hfecpro`, `HFECREG`, `HMONTDIS`, `HMOTIV`, `HNUMDOC`, `HNUMREG`, `HPROV` | estatico + motor |
| [storage.com_act.VCAH001](../../../tablas/storage/com_act/VCAH001.md) | lee | `hctacli`, `hdescli` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `result`
2. `nivel`, `HFECREG`, `HCODSEC`, `HNUMREG`, `HMOTIV`, `HDESCLI`, `HDISTR`, `HDISTR_LLEGADA`, `HCODGEOR`, `HDISTREC`, `HMONTDIS`, `HPROV`, `HDPT`, `HCTACLI`
3. `HFECEMI`, `style_HFECEMI`, `Fecha`
4. `nivel`, `HFECREG`, `HCODSEC`, `HNUMREG`, `HMOTIV`, `HDESCLI`, `HDISTR`, `HDISTR_LLEGADA`, `HCODGEOR`, `HDISTREC`, `HMONTDIS`, `HPROV`, `HDPT`, `HCTACLI`
5. `HFECEMI`, `style_HFECEMI`, `Fecha`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#HBMOV001`, `#WJERCOR3`
- ⚠️ Columna sin resolver `HMOTIV` (¿STORAGE.com_act.HBMOV001?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
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
