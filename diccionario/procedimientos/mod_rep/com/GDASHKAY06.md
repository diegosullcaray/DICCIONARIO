# mod_rep.com.GDASHKAY06

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GDASHKAY06.sql](../../../../extraccion/procedimientos/mod_rep/com/GDASHKAY06.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GDASHKAY06.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GDASHKAY06.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GDASHKAY06.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GDASHKAY06.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `rankKayrecu_01` | Ranking Kaypacha Recuperaciones | `cod_rel`, `fec`, `Ter` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 2 | `@fec` | date | — |  | `fec` |
| 3 | `@Ter` | varchar(250) | — |  | `Ter` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com.HBDK006](../../../tablas/storage/com/HBDK006.md) | lee | `HBLOACU`, `hcolbt`, `HCOLCAR`, `HCOLDOC`, `HCOLNOM`, `HCOLTIP`, `HDESTER`, `HFECPRO` | estatico + motor |
| [storage.com.HBDK007](../../../tablas/storage/com/HBDK007.md) | lee | `HBFOREXT`, `HBFRENO`, `HBPTOBAS`, `HBPTOPLUS`, `HBRIEOPE`, `hcolbt`, `HCOLCAR`, `HCOLDOC`, `HCOLNOM`, `HCOLTIP`, `HDESTER`, `HFECPRO` | estatico + motor |
| [storage.gpr.HPPC001](../../../tablas/storage/gpr/HPPC001.md) | lee | `hcodbt`, `hfecpro` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `hcodbt`, `HDESCAR` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `ORD`, `HCOLTIP`, `HCOLNOM`, `HDESTER`, `TOTAL_MES`, `style`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`
- Temporales: `#Cab`, `#Jer`, `#Result`, `#T`, `#TT`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

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
