# mod_rep.com.RCORRES05

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RCORRES05.sql](../../../../procedimientos/mod_rep/com/RCORRES05.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RCORRES05.sql](../../../../sql/01-extraccion/mod_rep/com/RCORRES05.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RCORRES05.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RCORRES05.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GREPORCORRE_05` | Grafico Mapa Corresponsales | `tip_cod`, `cod_rel`, `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [STORAGE.com_act.HCGEO002](../../../tablas/STORAGE/com_act/HCGEO002.md) | lee | `HNOMCOR` | estatico + motor |
| [storage.com_act.HCMC001](../../../tablas/storage/com_act/HCMC001.md) | lee | `HMUNICB`, `HNOMBREPTO` | estatico + motor |
| [storage.com_act.SDAS021](../../../tablas/storage/com_act/SDAS021.md) | lee | `SCORRES` | estatico + motor |
| [storage.ref.vjercor03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODCOR`≈, `RCODMAT`≈, `RCODTER`≈, `RDESCOR`≈, `RDESMAT`≈, `RDESTER`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `TCAD`
2. `TCAD`
3. `TCAD`

### Observaciones del análisis

- CTE: `a`, `cte_a`
- Temporales: `#CorresponsaleGeoCount`, `#Geo`, `#a`, `#cte_corres`
- ⚠️ Columna sin resolver `HFECPRO` (¿STORAGE.com_act.HCGEO002?)
- ⚠️ Columna sin resolver `HNOMCOR` (¿STORAGE.com_act.HCGEO002?)
- ⚠️ Columna sin resolver `HCOORDE` (¿STORAGE.com_act.HCGEO002?)
- ⚠️ Columna sin resolver `HTERRIT` (¿STORAGE.com_act.HCGEO002?)
- ⚠️ Columna sin resolver `HCORRED` (¿STORAGE.com_act.HCGEO002?)
- ⚠️ Columna sin resolver `HAGENCI` (¿STORAGE.com_act.HCGEO002?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
