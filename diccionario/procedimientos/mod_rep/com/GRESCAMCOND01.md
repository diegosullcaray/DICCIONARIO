# mod_rep.com.GRESCAMCOND01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESCAMCOND01.sql](../../../../procedimientos/mod_rep/com/GRESCAMCOND01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESCAMCOND01.sql](../../../../sql/01-extraccion/mod_rep/com/GRESCAMCOND01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESCAMCOND01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESCAMCOND01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRESCONDO_02` | Modulo de Condonaciones Mes Día  | `tip_cod`, `cod_rel`, `tdcrMonto`, `tdcrMoti`, `diariomes`, `niveles` | — |
| `GRESCONDO_01` | Modulo de Condonaciones | `tip_cod`, `cod_rel`, `tdcrMonto`, `tdcrMoti` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@tdcrMonto` | varchar(20) | — |  | `tdcrMonto` |
| 4 | `@tdcrMoti` | varchar(20) | — |  | `tdcrMoti` |
| 5 | `@diariomes` | varchar(20) | '' |  | `diariomes` |
| 6 | `@vista` | int | 2 |  | `niveles` |
| 7 | `@tipmeta` | int | 1 |  | — |
| 8 | `@fec` | date | null |  | — |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SCCO001](../../../tablas/storage/com_act/SCCO001.md) | lee | `SFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.RCALC` | @json, null, 2 | no |
| `mod_rep.rep.FCABTABDEF` (función) | — | no |
| `mod_rep.rep.RCALC` | @jsonS, 0, 2 | no |
| `mod_rep.rep.FCABTABDEF` (función) | — | no |

### Columnas que devuelve

1. `(expresión 1)`
2. `(expresión 1)`

### Observaciones del análisis

- Temporales: `#tmpDATOS`, `#tmpDATOS1`, `#tmpDATOS2S`, `#tmpDATOSS1S`, `#tmpDATOSSFech`, `#tmpDatosF`, `#tmpVariabless`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.rep.TCADS` (tipo de tabla)
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
