# mod_rep.com.GRESPROGOB02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESPROGOB02.sql](../../../../procedimientos/mod_rep/com/GRESPROGOB02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESPROGOB02.sql](../../../../sql/01-extraccion/mod_rep/com/GRESPROGOB02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESPROGOB02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESPROGOB02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (4)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RPROGOB_03` | Reporte de cartera de progamas del gobierno | `cod_rel`, `tip_cod`, `fec`, `var` | — |
| `RPROGOB_M_03` | Reporte de cartera de progamas del gobierno | `cod_rel`, `tip_cod`, `fec`, `var` | reportes / actividad-mensual |
| `RPROGOB_04` | Reporte de cartera de progamas del gobierno | `cod_rel`, `tip_cod`, `fec`, `var` | — |
| `RPROGOB_M_04` | Reporte de cartera de progamas del gobierno | `cod_rel`, `tip_cod`, `fec`, `var` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 2 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@var` | int | 1 |  | `var` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `*`, `HASEOPER`, `HCODMOD`, `HFECPRO`, `HSUBTIP`, `HTIPOPE` | estatico + motor |
| [storage.com_act.RETP001](../../../tablas/storage/com_act/RETP001.md) | lee | `RCODMOD`, `RCODPROD`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP002](../../../tablas/storage/com_act/RETP002.md) | lee | `RCODMOD`, `RCODPROD`, `RSUBTIP`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP003](../../../tablas/storage/com_act/RETP003.md) | lee | `RCODPROD`, `RDESGRU01`, `RDESPROD` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `style`, `HDESPROD`, `*`
2. `style`, `HDESPROD`, `*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`
- Temporales: `#JERCOR`, `#PROD`, `#RES`
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.com_act.HCDA001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003?)

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
