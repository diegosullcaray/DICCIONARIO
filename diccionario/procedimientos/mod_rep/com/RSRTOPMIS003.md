# mod_rep.com.RSRTOPMIS003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSRTOPMIS003.sql](../../../../procedimientos/mod_rep/com/RSRTOPMIS003.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSRTOPMIS003.sql](../../../../sql/01-extraccion/mod_rep/com/RSRTOPMIS003.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSRTOPMIS003.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSRTOPMIS003.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `prod_misi_03` | Productos Top Asesores | `tip_cod`, `cod_rel`, `fec`, `prod` | reportes / desarrollo-sostenible |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | nvarchar(50) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@prod` | varchar(250) | — |  | `prod` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.RETP006](../../../tablas/storage/com_act/RETP006.md) | lee | `RCODMOD`, `RDESSUBP`, `RSUBTIP`, `RTIPOPE` | estatico + motor |
| [storage.com_act.SDAF002](../../../tablas/storage/com_act/SDAF002.md) | lee | `scodagr`≈, `sfecpro`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`≈, `HCODVAR`≈, `hfecpro`≈, `HTIPCOD`≈, `HVALVAR`≈ | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODCOR`≈, `RCODGRU`≈, `RCODSEC`≈, `RCODTER`≈, `RCODUCO`≈, `RCODUNI`≈, `RDESCOR`≈, `RDESSEC`≈, `RDESTER`≈, `RDESUNI`≈, `rfecpro`≈, `RINDFEC`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `@headers`
2. `*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_bb`, `cte_c`, `cte_cc`, `cte_d`
- Temporales: `#Metas`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
