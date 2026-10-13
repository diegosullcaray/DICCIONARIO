# mod_rep.com.RTABDIGCOM01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RTABDIGCOM01.sql](../../../../extraccion/procedimientos/mod_rep/com/RTABDIGCOM01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RTABDIGCOM01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RTABDIGCOM01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RTABDIGCOM01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RTABDIGCOM01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `TABDIGITAL_COMERCIAL_01` | TABLERO DIGITAL COMERCIAL | `tip_cod`, `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WACLI001](../../../tablas/storage/com_act/WACLI001.md) | lee | `hfecpro` | estatico + motor |
| [storage.com.WJAS005](../../../tablas/storage/com/WJAS005.md) | lee | `hcodrel`≈, `hfecpro`≈, `hnumcli`≈, `hnumcliclinet`≈, `hnumclipagocre`≈, `hnumclipagoplin`≈, `htipcod`≈, `htipcred`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

1. `@head`
2. `*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_aa`, `cte_b`
- Temporales: `#DES`, `#Des`, `#Result`, `#fec`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
