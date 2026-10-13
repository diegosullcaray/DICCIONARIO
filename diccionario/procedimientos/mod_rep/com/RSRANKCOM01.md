# mod_rep.com.RSRANKCOM01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSRANKCOM01.sql](../../../../extraccion/procedimientos/mod_rep/com/RSRANKCOM01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSRANKCOM01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSRANKCOM01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSRANKCOM01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSRANKCOM01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_RANK_COM_01` | Ranking Comercial | `territorio`, `corredor`, `fecha` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@territorio` | varchar(250) | '0' |  | `territorio` |
| 2 | `@corredor` | varchar(250) | '0' |  | `corredor` |
| 3 | `@fecha` | DATE | — |  | `fecha` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.VRANKCOM01](../../../tablas/storage/com_act/VRANKCOM01.md) | lee | `cod_uuni`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `json`
2. `*`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
