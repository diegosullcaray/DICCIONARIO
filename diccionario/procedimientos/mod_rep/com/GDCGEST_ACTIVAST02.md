# mod_rep.com.GDCGEST_ACTIVAST02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql](../../../../extraccion/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GDCGEST_ACTIVAST02.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GDCGEST_ACTIVAST02.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GDCGEST_ACTIVAST02.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GDCGEST_ACTIVAST02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `reporte_autonomia_newdiaria_01` | Lista... | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Cartera |
| `reporte_autonomia_new_01` | Lista... | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(10) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@diario` | int | 0 |  | — |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WGATH001](../../../tablas/storage/com_act/WGATH001.md) | lee | `HFECPRO`, `HGESTTAS`, `HMDES`, `HUCAP_FIN`, `ORD`, `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESUCO`, `RDESUNI`, `RFEC` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RANI`, `RCIEMES`, `rfec`, `RMESNOM` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODSEC`, `RDESCOR`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `result`
2. `*`
3. `*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`
- Temporales: `#C`, `#C_G`, `#FECS`, `#FIN`, `#FIN_G`, `#FecList`, `#RESULT`, `#RESULT_G`, `#Result1`, `#Result1_G`, `#res`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `RINDFEC` (¿storage.com_act.WGATH001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `ORD` (¿storage.com_act.WGATH001 o storage.ref.WJERCOR03?)
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
- `mod_rep.rep.FFTHCOLDEF`
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
