# mod_rep.com.GRESCAMCOND03

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESCAMCOND03.sql](../../../../procedimientos/mod_rep/com/GRESCAMCOND03.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESCAMCOND03.sql](../../../../sql/01-extraccion/mod_rep/com/GRESCAMCOND03.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESCAMCOND03.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESCAMCOND03.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRESCONDO_03` | Modulo de Condonaciones Mes Día  | `tip_cod`, `cod_rel`, `fec`, `tdcrMonto`, `tdcrMoti`, `niveles` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@tdcrMonto` | varchar(250) | — |  | `tdcrMonto` |
| 5 | `@tdcrMoti` | varchar(250) | — |  | `tdcrMoti` |
| 6 | `@niveles` | int | — |  | `niveles` |

### Tablas y columnas (7)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.com.#temp3](../../../tablas/mod_rep/com/#temp3.md) ⚠️ esquema implícito | trunca | — | estatico |
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `MONTH`≈, `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, '"fec_dese_v"', @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, '"fec"', @columns, =, '"vars"', @config, =, @tconf | no |

### Columnas que devuelve

1. `result`
2. `result`

### Observaciones del análisis

- Temporales: `#Cab`, `#FECS`, `#T`, `#Tabla`, `#Tabla2`, `#TablaS`, `#TablaTip15`, `#Unpivot`, `#subCab`, `#temp3`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
