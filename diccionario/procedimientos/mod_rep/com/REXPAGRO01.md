# mod_rep.com.REXPAGRO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | 🔎 extraído |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/REXPAGRO01.sql](../../../../extraccion/procedimientos/mod_rep/com/REXPAGRO01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/REXPAGRO01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/REXPAGRO01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CON_AGRO_FEN` | Consulta FEN CENEPRED | `col`, `val` | consulta-fen |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@col` | int | — |  | `col` |
| 2 | `@val` | varchar(100) | — |  | `val` |

### Tablas y columnas (0)

No se detectaron tablas.

### Columnas que devuelve

`dummy`

### Observaciones del análisis

- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
