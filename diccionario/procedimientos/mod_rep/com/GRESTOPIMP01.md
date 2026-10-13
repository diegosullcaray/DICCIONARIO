# mod_rep.com.GRESTOPIMP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESTOPIMP01.sql](../../../../procedimientos/mod_rep/com/GRESTOPIMP01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESTOPIMP01.sql](../../../../sql/01-extraccion/mod_rep/com/GRESTOPIMP01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESTOPIMP01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESTOPIMP01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRESCAMIMP_02` | Top Imparables | `cod_rel`, `tip_cod` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 2 | `@tip_cod` | int | — |  | `tip_cod` |
| 3 | `@tipmeta` | int | 1 |  | — |
| 4 | `@fec` | date | null |  | — |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TCADS](../../../tablas/mod_rep/rep/TCADS.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.RCALC` | @json | no |
| `mod_rep.rep.RCALC` | @json1 | no |
| `mod_rep.rep.FCABTABDEF` (función) | — | no |

### Columnas que devuelve

`(expresión 1)`

### Observaciones del análisis

- CTE: `a`, `b`
- Temporales: `#tmpDATOS`, `#tmpDATOS1`, `#tmpDATOS2`
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
