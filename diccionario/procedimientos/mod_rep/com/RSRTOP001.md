# mod_rep.com.RSRTOP001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSRTOP001.sql](../../../../extraccion/procedimientos/mod_rep/com/RSRTOP001.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSRTOP001.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSRTOP001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RSRTOP01` | Monitor de Efectividades TOP | `tip_cod`, `level` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | nvarchar(10) | — |  | `tip_cod` |
| 2 | `@level` | nvarchar(10) | — |  | `level` |

### Tablas y columnas (0)

No se detectaron tablas.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.com.RSRTOPT001` | @tip_cod, @level | no |
| `mod_rep.com.RSRTOPT002` | @tip_cod, @level | no |
| `mod_rep.com.RSRTOPT003` | @tip_cod, @level | no |

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
