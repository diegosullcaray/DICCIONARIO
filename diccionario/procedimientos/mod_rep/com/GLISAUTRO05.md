# mod_rep.com.GLISAUTRO05

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GLISAUTRO05.sql](../../../../procedimientos/mod_rep/com/GLISAUTRO05.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GLISAUTRO05.sql](../../../../sql/01-extraccion/mod_rep/com/GLISAUTRO05.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GLISAUTRO05.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GLISAUTRO05.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GLISAUTRO_04` | Listado Autonomias | `tip_cod`, `cod_rel`, `cargo` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@cargo` | varchar(250) | — |  | `cargo` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.VCAUT001](../../../tablas/storage/com_act/VCAUT001.md) | lee | `HCODSEC`, `HCODUSAUT`, `HFECPRO`, `HSALCAPMN`, `HSALVENMN` | estatico + motor |
| [storage.com_act.VCAUT002](../../../tablas/storage/com_act/VCAUT002.md) | lee | `HCODSEC`≈, `HCODUSAUT`≈, `HCOSECHA`≈, `HFECBAS`≈, `SNUMOPEBAS`≈, `SNUMOPEMORH`≈ | estatico + motor |
| [storage.gpr.HPPC001](../../../tablas/storage/gpr/HPPC001.md) | lee | `HCODBT`≈, `HDESCAR`≈, `HDESPER`≈, `hfecpro` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.piv.FEXTFEC01` (función) | — | no |
| `mod_rep.piv.FEXTFEC01` (función) | — | no |
| `mod_rep.piv.FEXTFEC01` (función) | — | no |

### Columnas que devuelve

1. `result`
2. `hdesper`, `HDESCAR`, `MRAP_3`, `MRAP_2`, `MRAP_1`, `MCOS_3`, `MCOS_2`, `MCOS_1`, `MCOS3_12`, `MCOS2_12`, `MCOS1_12`, `auto_sug`

### Observaciones del análisis

- CTE: `a`, `b`
- Temporales: `#CarteraPivot`, `#CastigoPivot`, `#ResulCap`, `#Result`, `#temp1`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
