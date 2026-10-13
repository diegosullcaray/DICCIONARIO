# mod_rep.com.RACTGP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RACTGP01.sql](../../../../procedimientos/mod_rep/com/RACTGP01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RACTGP01.sql](../../../../sql/01-extraccion/mod_rep/com/RACTGP01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RACTGP01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RACTGP01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RACTGP_01` | Activas PDM | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | DATE | — |  | `fec` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.WACTGRP001](../../../tablas/storage/com_act/WACTGRP001.md) | lee | `*`, `HCODA`, `hfecpro` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.ref.FJERCOR02` (función) | — | no |

### Columnas que devuelve

`rord`, `descripcion`, `dat1`, `dat2`, `dat3`, `dat4`, `dat5`, `VARDIA`, `PerceDia`, `VARMES`, `PerceMes`, `VARINTANU`, `PerceINTAN`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`
- Temporales: `#Dat`, `#FECS`, `#FJERCOR02`, `#Grupos`, `#R`, `#UvpDat`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `RCODTER` (¿storage.com_act.WACTGRP001?)
- ⚠️ Columna sin resolver `RCODCOR` (¿storage.com_act.WACTGRP001?)
- ⚠️ Columna sin resolver `RCODGRU` (¿storage.com_act.WACTGRP001?)
- ⚠️ Columna sin resolver `RCODUNI` (¿storage.com_act.WACTGRP001?)
- ⚠️ Columna sin resolver `RCODUCO` (¿storage.com_act.WACTGRP001?)
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
