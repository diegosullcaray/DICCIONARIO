# mod_rep.com.GRESCAMIMP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESCAMIMP01.sql](../../../../procedimientos/mod_rep/com/GRESCAMIMP01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESCAMIMP01.sql](../../../../sql/01-extraccion/mod_rep/com/GRESCAMIMP01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRESCAMIMP_01` | Campaña Imparables | `cod_rel`, `tip_cod` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 2 | `@tip_cod` | int | — |  | `tip_cod` |
| 3 | `@tipmeta` | int | 1 |  | — |
| 4 | `@fec` | date | null |  | — |

### Tablas y columnas (0)

No se detectaron tablas.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.RCALC` | @json | no |
| `mod_rep.rep.FCABTABDEF` (función) | — | no |

### Columnas que devuelve

`(expresión 1)`

### Observaciones del análisis

- Temporales: `#tmpDATOS`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.rep.TCADS` (tipo de tabla)
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
