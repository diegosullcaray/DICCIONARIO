# mod_rep.com.RSAGECOM01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSAGECOM01.sql](../../../../procedimientos/mod_rep/com/RSAGECOM01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSAGECOM01.sql](../../../../sql/01-extraccion/mod_rep/com/RSAGECOM01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSAGECOM01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSAGECOM01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_AGE_COM_01` | Agendamiento Comercial | `tip_cod`, `cod_rel`, `fecha`, `mode`, `fuga`, `prop` | reportes / actividad-diaria / Campañas |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |
| 4 | `@mode` | int | — |  | `mode` |
| 5 | `@fuga` | int | — |  | `fuga` |
| 6 | `@prop` | int | — |  | `prop` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.VABRE001](../../../tablas/storage/com_act/VABRE001.md) | lee | `HDSC`, `HEVTO` | estatico + motor |
| [storage.com_act.WABDC001](../../../tablas/storage/com_act/WABDC001.md) | lee | `HCODSEC`, `HEVTO`, `HFECPRO`, `HINDBASE`, `HINDDESB`, `HNUMCON` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = @columns, @config = @tconf | no |

### Columnas que devuelve

`@head`

### Observaciones del análisis

- CTE: `a`
- Temporales: `#Def`, `#sort`, `#sort2`, `#sort3`
- ⚠️ Columna sin resolver `HEVTO` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `HINDBASE` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `HNUMCON` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `HINDDESB` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODTER` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODCOR` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODGRU` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODUNI` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODUCO` (¿storage.com_act.WABDC001 o storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `Rowsort` (¿storage.com_act.VABRE001?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

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
