# mod_rep.com.RPROSCORR006

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RPROSCORR006.sql](../../../../extraccion/procedimientos/mod_rep/com/RPROSCORR006.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RPROSCORR006.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RPROSCORR006.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RPROSCORR006.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RPROSCORR006.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GREPROSPCORRE_03` | Graf_Pie_PROSTO_Inst_Corresponsales | `tip_cod`, `cod_rel`, `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCMC002](../../../tablas/storage/com_act/HCMC002.md) | lee | `HAPERTCTA`, `HDESAGE`, `HFECPRO`, `HINSTALAD`, `HMESINST`, `HPROSPEC`, `HZONA` | estatico + motor |
| [storage.ref.VJERCOR03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODAGE`, `RCODCOR`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESCOR`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `TCAD`
2. `TCAD`
3. `TCAD`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`
- Temporales: `#Res`, `#Res2`, `#Result`, `#Total`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
