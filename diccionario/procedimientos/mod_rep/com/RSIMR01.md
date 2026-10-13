# mod_rep.com.RSIMR01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSIMR01.sql](../../../../extraccion/procedimientos/mod_rep/com/RSIMR01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSIMR01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSIMR01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSIMR01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSIMR01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RSIMR_01` | IMR | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@f_ase` | varchar(20) | null |  | — |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WIMR001](../../../tablas/storage/com_act/WIMR001.md) | lee | `haseoper`, `HDESPROD`, `hfecpro`, `HTIPO_IS` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `rciebt`, `RFEC` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`≈, `RCODFC`≈, `RCODGRU`≈, `RCODTER`≈, `RCODUCO`≈, `RCODUNI`≈, `RFECPRO`≈, `RINDFEC`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

1. `(expresión 1)`
2. `*`

### Observaciones del análisis

- CTE: `cte_a`, `fechas`, `fecs1`, `fecs2`, `resultado`
- Temporales: `#Base`, `#INCRE`, `#ING`, `#SAL`, `#fechas`, `#wjercor03`
- ⚠️ Columna sin resolver `HDESPROD` (¿storage.com_act.WIMR001?)
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.com_act.WIMR001?)
- ⚠️ Columna sin resolver `HTIPO_IS` (¿storage.com_act.WIMR001?)
- ⚠️ Columna sin resolver `HMONTIPOMN` (¿storage.com_act.WIMR001?)
- ⚠️ Columna sin resolver `HFLAG_ASESOR` (¿storage.com_act.WIMR001?)
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
