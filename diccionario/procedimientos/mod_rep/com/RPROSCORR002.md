# mod_rep.com.RPROSCORR002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RPROSCORR002.sql](../../../../procedimientos/mod_rep/com/RPROSCORR002.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RPROSCORR002.sql](../../../../sql/01-extraccion/mod_rep/com/RPROSCORR002.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RPROSCORR002.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RPROSCORR002.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GREPROSPCORRE_01` | TAB_MENU_PROSPECTO_Corresponsales | `tip_cod`, `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCMC002](../../../tablas/storage/com_act/HCMC002.md) | lee | `HAPERTCTA`, `HDESAGE`, `HFECPRO`, `HINSTALAD`, `HMESINST`, `HPROSPEC`, `HZONA` | estatico + motor |
| [storage.ref.VJERCOR03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODAGE`, `RCODCOR`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESCOR`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `descripcion`, `NumProspecto`
2. `NumProspecto`, `NumNOCalifica`, `NumEva`, `NumProceso`, `NumInstalado`, `PercentInsta`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`
- Temporales: `#Res`, `#Result`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
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
