# mod_rep.com.GPRECOSELIS001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GPRECOSELIS001.sql](../../../../procedimientos/mod_rep/com/GPRECOSELIS001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GPRECOSELIS001.sql](../../../../sql/01-extraccion/mod_rep/com/GPRECOSELIS001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GPRECOSELIS001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GPRECOSELIS001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PRECOSELISTADO_02` | Listado Pre Cosechas | `tip_cod`, `cod_rel`, `fec`, `prod`, `subpro`, `pagen`, `nom` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(50) | — |  | `fec` |
| 4 | `@prod` | varchar(20) | — |  | `prod` |
| 5 | `@subpro` | varchar(20) | — |  | `subpro` |
| 6 | `@pagen` | int | 1 |  | `pagen` |
| 7 | `@nom` | VARCHAR(500) | — |  | `nom` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WBCH002](../../../tablas/storage/com_act/WBCH002.md) | lee | `HCODMOD`, `HCODOPE`, `hCODSEC`, `HCTACLI`, `HDESCLI`, `HDTIPOPE`, `HFECPRO`, `HMONDESMN`, `HSUCCLI`, `RDESPROD` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.ref.FJERCOR01_` (función) | — | no |

### Columnas que devuelve

1. `result`
2. `*`

### Observaciones del análisis

- CTE: `datos`, `fechas`
- ⚠️ Columna sin resolver `HCTACLI` (¿storage.com_act.WBCH002?)
- ⚠️ Columna sin resolver `HDESCLI` (¿storage.com_act.WBCH002?)
- ⚠️ Columna sin resolver `HCODOPE` (¿storage.com_act.WBCH002?)
- ⚠️ Columna sin resolver `HMONDESMN` (¿storage.com_act.WBCH002?)
- ⚠️ Columna sin resolver `HSUCCLI` (¿storage.com_act.WBCH002?)
- ⚠️ Columna sin resolver `HCODMOD` (¿storage.com_act.WBCH002?)
- ⚠️ Columna sin resolver `HDTIPOPE` (¿storage.com_act.WBCH002?)

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
