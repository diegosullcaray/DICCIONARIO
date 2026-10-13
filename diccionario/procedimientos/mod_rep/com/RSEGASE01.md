# mod_rep.com.RSEGASE01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSEGASE01.sql](../../../../extraccion/procedimientos/mod_rep/com/RSEGASE01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSEGASE01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSEGASE01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSEGASE01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSEGASE01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `SEGUROS_ASESOR_01` | Tablero Seguros Asesor | `cod_rel`, `Fecha`, `tip_cod` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 2 | `@Fecha` | date | — |  | `Fecha` |
| 3 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_seg.SDSF001](../../../tablas/storage/com_seg/SDSF001.md) | lee | `scodagr`≈, `scodsec`≈, `scodseg`≈, `sfecpro`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`(expresión 1)`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `pivoteddata`
- Temporales: `#FECS`, `#R`, `#RR`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
