# mod_rep.com.RSHHCARB001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSHHCARB001.sql](../../../../procedimientos/mod_rep/com/RSHHCARB001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSHHCARB001.sql](../../../../sql/01-extraccion/mod_rep/com/RSHHCARB001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSHHCARB001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSHHCARB001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `HCARBONO_01` | Huella de carbono | `tip_cod`, `cod_rel`, `fec`, `cargambiental` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(250) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@cargambiental` | varchar(250) | — |  | `cargambiental` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com.HHDC001](../../../tablas/storage/com/HHDC001.md) | lee | `HCODSUCU`, `HCTACONT`, `HFECPRO`, `HHCARBCA`, `HHCARBMO`, `HHUCARUN`, `HNOMBCTA` | estatico + motor |
| [storage.com.HHDC002](../../../tablas/storage/com/HHDC002.md) | lee | `HCODSUCU`, `HCTACONT`, `HDESCCTA`, `HFECPRO`, `HHUECARCA`, `HHUECARMO`, `HHUECARUN` | estatico + motor |
| [storage.ref.VJERCOR02](../../../tablas/storage/ref/VJERCOR02.md) | lee | `RCODAGE`, `RCODAGEH`, `rcodcor`, `rcodmat`, `rcodter`, `rdesage`, `rdescor`, `rdesmat`, `rdester` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `cte_b`, `cte_c`, `cte_cajachica`, `cte_ctacontable`, `cte_obligaciones`
- Temporales: `#T`, `#VJERCOR02`
- ⚠️ Columna sin resolver `HHUCARUN` (¿storage.COM.HHDC001?)
- ⚠️ Columna sin resolver `HHCARBCA` (¿storage.COM.HHDC001?)
- ⚠️ Columna sin resolver `HHCARBMO` (¿storage.COM.HHDC001?)
- ⚠️ Columna sin resolver `HHUECARUN` (¿storage.COM.HHDC002?)
- ⚠️ Columna sin resolver `HHUECARCA` (¿storage.COM.HHDC002?)
- ⚠️ Columna sin resolver `HHUECARMO` (¿storage.COM.HHDC002?)

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
