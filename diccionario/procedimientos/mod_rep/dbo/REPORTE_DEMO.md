# mod_rep.dbo.REPORTE_DEMO

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `dbo` |
| Estado | 🔎 extraído |
| Cuerpo | [extraccion/procedimientos/mod_rep/dbo/REPORTE_DEMO.sql](../../../../extraccion/procedimientos/mod_rep/dbo/REPORTE_DEMO.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/dbo/REPORTE_DEMO.sql](../../../../extraccion/sql/01-extraccion/mod_rep/dbo/REPORTE_DEMO.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `reporte-demo` | Reporte Demo | `fecha`, `cod_user_bt` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@fec` | varchar(10) | — |  | `fecha` |
| 2 | `@cod_bt` | varchar(10) | — |  | `cod_user_bt` |

### Tablas y columnas (0)

No se detectaron tablas.

### Columnas que devuelve

1. `HDRS`
2. `msg`
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
