# mod_rep.com.RGRAFZCUO02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RGRAFZCUO02.sql](../../../../extraccion/procedimientos/mod_rep/com/RGRAFZCUO02.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RGRAFZCUO02.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RGRAFZCUO02.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RGRAFZCUO02.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RGRAFZCUO02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRAF_ZCUO_02` | Graf Zero Cuotas | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@fecha` | DATE | — |  | `fecha` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WZCUO001](../../../tablas/storage/com_act/WZCUO001.md) | lee | `haseoper`, `HFECPRO`, `hsalcapmn`, `nuevo_ingreso`, `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESTER`, `RDESUCO`, `RDESUNI` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`categories`, `PATH`, `WITHOUT_ARRAY_WRAPPER`

### Observaciones del análisis

- Temporales: `#datos`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
