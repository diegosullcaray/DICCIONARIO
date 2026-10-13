# mod_rep.com.GRVGENCORO02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GRVGENCORO02.sql](../../../../extraccion/procedimientos/mod_rep/com/GRVGENCORO02.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GRVGENCORO02.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GRVGENCORO02.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GRVGENCORO02.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GRVGENCORO02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RVIUWGCORE_02` | Reporte Vista Gestión Corresponsal | `tip_cod`, `cod_rel`, `fec`, `tip_age` | reportes / actividad-diaria / Tablero Digital |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@tip_age` | VARCHAR(250) | — |  | `tip_age` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV06` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars","agr_trx"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars","esta_corr"', @config = @tconf | no |

### Columnas que devuelve

`*`, `num_ag_esta_0`, `num_ag_esta_1`, `num_age_trx_0`, `num_age_trx_1`, `Agent_insta`, `agent_c_trx`, `agent_s_trx`

### Observaciones del análisis

- Temporales: `#R1`, `#R1_1`, `#R2`, `#R2_2`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
