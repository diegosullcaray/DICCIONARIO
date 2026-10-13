# mod_rep.com.GRESPDATOS01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESPDATOS01.sql](../../../../procedimientos/mod_rep/com/GRESPDATOS01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESPDATOS01.sql](../../../../sql/01-extraccion/mod_rep/com/GRESPDATOS01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESPDATOS01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESPDATOS01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `P_Datos_01` | Plan de Datos | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HBPDATOS001](../../../tablas/storage/com_act/HBPDATOS001.md) | lee | `hfecpro`≈ | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HDESPER` | estatico + motor |
| [storage.ref.wjercor01](../../../tablas/storage/ref/wjercor01.md) | lee | `RCODADM`, `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`hfecpro`, `htipo`, `HDESPER`, `hratio`, `hcindi`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`
- ⚠️ Columna sin resolver `htipo` (¿storage.gpr.VPPH001 o storage.ref.WJERCOR01?)
- ⚠️ Columna sin resolver `hratio` (¿storage.gpr.VPPH001 o storage.ref.WJERCOR01?)
- ⚠️ Columna sin resolver `hcindi` (¿storage.gpr.VPPH001 o storage.ref.WJERCOR01?)
- ⚠️ Columna sin resolver `RINDFEC` (¿storage.ref.WJERCOR01?)

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
