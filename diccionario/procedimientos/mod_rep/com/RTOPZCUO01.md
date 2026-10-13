# mod_rep.com.RTOPZCUO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RTOPZCUO01.sql](../../../../extraccion/procedimientos/mod_rep/com/RTOPZCUO01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RTOPZCUO01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RTOPZCUO01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RTOPZCUO01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RTOPZCUO01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_TOP_ZCUO_01` | top 10 asesores Zcuo | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@Fecha` | varchar(10) | — |  | `fecha` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WZCUO001](../../../tablas/storage/com_act/WZCUO001.md) | lee | `HASEOPER`, `HCODDES`, `HCODOPE`, `HCODORI`, `hfecpro`, `hsalcapmn`, `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESSEC`, `RDESTER`, `RDESUNI` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `@headers`
2. `RDESTER`, `RDESCOR`, `RDESUNI`, `RDESSEC`, `hsalcapmn`, `HTOTOPE`, `TRASLADO`, `HEREDADO`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
