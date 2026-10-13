# mod_rep.com.GRESDESCRE02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESDESCRE02.sql](../../../../procedimientos/mod_rep/com/GRESDESCRE02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESDESCRE02.sql](../../../../sql/01-extraccion/mod_rep/com/GRESDESCRE02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESDESCRE02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESDESCRE02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `DESCRED_01` | Reporte de Destino de Crédito | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HDESCRE001](../../../tablas/storage/com_act/HDESCRE001.md) | lee | `HCODADM`, `HCODMOD`, `HCODMON`, `HCODOPE`, `HCODSEC`, `HCUMPLDC`, `HDESCLI`, `HDESCRE`, `HFECDES`, `HFECPRO`, `HFECVIS`, `HINDCAR`, `HMONDES`, `HSUBTIP`, `HTIPOPE` | estatico + motor |
| [storage.com_act.RETP001](../../../tablas/storage/com_act/RETP001.md) | lee | `RCODMOD`, `RCODPROD`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP002](../../../tablas/storage/com_act/RETP002.md) | lee | `RCODMOD`, `RCODPROD`, `RSUBTIP`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP003](../../../tablas/storage/com_act/RETP003.md) | lee | `RCODPROD`, `RDESPROD` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `RDIAFER`, `RFEC` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`*`, `HPCUMP`, `HPCUMP_VIS`, `style`, `HDESCRIP`

### Observaciones del análisis

- CTE: `cte_0`, `cte_a`
- Temporales: `#RES`
- ⚠️ Columna sin resolver `RCODTER` (¿storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003?)
- ⚠️ Columna sin resolver `RCODCOR` (¿storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003?)
- ⚠️ Columna sin resolver `RCODUNI` (¿storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003?)
- ⚠️ Columna sin resolver `RCODUCO` (¿storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003?)
- ⚠️ Columna sin resolver `RINDFEC` (¿storage.com_act.HDESCRE001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003?)

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
