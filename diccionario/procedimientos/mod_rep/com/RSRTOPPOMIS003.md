# mod_rep.com.RSRTOPPOMIS003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS003.sql](../../../../extraccion/procedimientos/mod_rep/com/RSRTOPPOMIS003.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSRTOPPOMIS003.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSRTOPPOMIS003.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSRTOPPOMIS003.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSRTOPPOMIS003.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `pob_misi_03` | Productos Top Unidad | `tip_cod`, `cod_rel`, `fec`, `prod` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | nvarchar(50) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@prod` | varchar(250) | — |  | `prod` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.wacli007](../../../tablas/storage/com_act/wacli007.md) | lee | `HCODPER`≈, `HCODSEC`≈, `hfecpro`≈, `HINDBANC`≈, `HINDGEN`≈, `HINDRUR`≈, `HINDVULN`≈ | estatico + motor |
| [storage.com.metas_saldos_anual](../../../tablas/storage/com/metas_saldos_anual.md) | lee | `HCODREL`≈, `HCODVAR`≈, `hfecpro`≈, `HTIPCOD`≈, `HVALVAR`≈ | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`≈, `RCODGRU`≈, `RCODSEC`≈, `RCODTER`≈, `RCODUCO`≈, `RCODUNI`≈, `RDESCOR`≈, `RDESTER`≈, `RDESUNI`≈, `rfecpro`≈, `RINDFEC`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `@headers`
2. `*`
3. `*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_d`
- Temporales: `#Metas`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
