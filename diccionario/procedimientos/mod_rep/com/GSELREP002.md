# mod_rep.com.GSELREP002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GSELREP002.sql](../../../../procedimientos/mod_rep/com/GSELREP002.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GSELREP002.sql](../../../../sql/01-extraccion/mod_rep/com/GSELREP002.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GSELREP002.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GSELREP002.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `SEL_JEFE_01` | Filtro de Jefes | `codmod` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@codmod` | smallint | 11 |  | `codmod` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.SDECCOM01](../../../tablas/mod_rep/rep/SDECCOM01.md) | lee | `SCODSUB`, `SNOMSUB`, `STIPCOD` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.FTHEACOLS01` | 'SEL_JEFE_01' | no |

### Columnas que devuelve

`id`, `desc`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
