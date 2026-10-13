# mod_rep.com.GDASHCLI01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | 🔎 extraído |
| Cuerpo | [procedimientos/mod_rep/com/GDASHCLI01.sql](../../../../procedimientos/mod_rep/com/GDASHCLI01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GDASHCLI01.sql](../../../../sql/01-extraccion/mod_rep/com/GDASHCLI01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `DASHBOARD_CLIENTES_01` | Dashboard Clientes | `uni_cfg`, `sel_cfg` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@uni_cfg` | varchar(max) | — |  | `uni_cfg` |
| 2 | `@sel_cfg` | varchar(max) | — |  | `sel_cfg` |

### Tablas y columnas (0)

No se detectaron tablas.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.com.openjson` (función) | — | no |
| `mod_rep.com.openjson` (función) | — | no |

### Columnas que devuelve

1. `hdefs`
2. `var_ord`, `var_niv`, `var_des`, `col_1`, `col_2`, `col_3`, `col_4`, `col_5`, `col_6`

### Observaciones del análisis

- CTE: `a`, `b`, `c`
- Temporales: `#A`, `#BASE`, `#VARS`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
