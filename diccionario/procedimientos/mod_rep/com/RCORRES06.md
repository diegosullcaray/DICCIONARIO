# mod_rep.com.RCORRES06

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RCORRES06.sql](../../../../procedimientos/mod_rep/com/RCORRES06.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RCORRES06.sql](../../../../sql/01-extraccion/mod_rep/com/RCORRES06.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RCORRES06.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RCORRES06.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GREPORCORRE_06` | Corresponsales Metas | `tip_cod`, `cod_rel`, `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com.metas_corresponsales](../../../tablas/storage/com/metas_corresponsales.md) | lee | `HCODOFI`, `HDESCOR`, `hfeccar`, `HFECPRO`, `HTERDES`, `HTIPMETA`, `HVAL` | estatico + motor |
| [storage.ref.vjercor03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODCOR`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESCOR`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`result`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`
- Temporales: `#Fec`, `#MC`
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
