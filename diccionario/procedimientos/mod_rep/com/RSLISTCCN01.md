# mod_rep.com.RSLISTCCN01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSLISTCCN01.sql](../../../../extraccion/procedimientos/mod_rep/com/RSLISTCCN01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSLISTCCN01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSLISTCCN01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSLISTCCN01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSLISTCCN01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `LCCUOTANUEVA_01` | BASE DE GESTION CERO CUOTAS NUEVAS | `tip_cod`, `cod_rel`, `pagen`, `tipcuota` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | nvarchar(100) | — |  | `cod_rel` |
| 3 | `@pagen` | int | — |  | `pagen` |
| 4 | `@tipcuota` | varchar(250) | — |  | `tipcuota` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WCCLISTADO01](../../../tablas/storage/com_act/WCCLISTADO01.md) | lee | `HCODOPE`, `HCODSEC`, `HCTACLI`, `HDESCIIU`, `HDESCLI`, `HDIAATR`, `HDSUCCLI`, `HFCCOM`, `HFCFGEST`, `HFECDES`, `HFECPRO`, `HMONDES`, `HSALCAPMN`, `HSALVENMN`, `HSITCRE`, `IndCartera`, `IndIngreso` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUNI`, `RDESCOR`, `RDESSEC`, `RDESTER`, `RDESUNI`, `RFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `Total`

### Observaciones del análisis

- CTE: `a`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
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
