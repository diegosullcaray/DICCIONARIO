# mod_rep.com.RGRAFSEGPAS01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RGRAFSEGPAS01.sql](../../../../procedimientos/mod_rep/com/RGRAFSEGPAS01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RGRAFSEGPAS01.sql](../../../../sql/01-extraccion/mod_rep/com/RGRAFSEGPAS01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RGRAFSEGPAS01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RGRAFSEGPAS01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRAFSEGPAS_01` | GRAFICO SEGURO PASIVOS ONCOLOGICO | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `RDIAFER`, `RFEC`, `RFECTXT`, `RMES` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV09` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"Prod_Seg","vars"', @config, =, @tconf | no |

### Columnas que devuelve

1. `JsonGraf`
2. `categories`, `series`, `vucle`, `result615`, `result616`

### Observaciones del análisis

- CTE: `b`, `cta`, `cte_a`, `cte_b`, `x`
- Temporales: `#Res`, `#ST`, `#T_`, `#fec`, `#fec_Cat`, `#sss`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
