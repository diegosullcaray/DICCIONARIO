# mod_rep.com.RSCMGCLIPAS02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSCMGCLIPAS02.sql](../../../../procedimientos/mod_rep/com/RSCMGCLIPAS02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSCMGCLIPAS02.sql](../../../../sql/01-extraccion/mod_rep/com/RSCMGCLIPAS02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSCMGCLIPAS02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSCMGCLIPAS02.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CMG_CLI_PAS_STOCK_02` | CMG Clientes Pasivos Stock | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_pas.WJAS002](../../../tablas/storage/com_pas/WJAS002.md) | lee | `*`, `HCODREL`, `HFECPRO`, `HTIPCOD` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`style`, `ord_column`, `descripcion`, `1`, `2`, `3`, `4`, `TMM`, `TAM`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`
- Temporales: `#FECR`, `#FECS`, `#Preresult`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
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
