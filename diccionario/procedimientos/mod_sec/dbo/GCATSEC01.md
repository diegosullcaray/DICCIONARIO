# mod_sec.dbo.GCATSEC01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_sec` · `dbo` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_sec/dbo/GCATSEC01.sql](../../../../procedimientos/mod_sec/dbo/GCATSEC01.sql) |
| Extracción | [sql/01-extraccion/mod_sec/dbo/GCATSEC01.sql](../../../../sql/01-extraccion/mod_sec/dbo/GCATSEC01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_sec/dbo/GCATSEC01.sql](../../../../sql/05-por-procedimiento/mod_sec/dbo/GCATSEC01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `REP_CATEGO_ASE_01` | Reporte Categorización Asesor | `cod_bt` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_bt` | varchar(20) | — |  | `cod_bt` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.gpr.HBASCAT001](../../../tablas/storage/gpr/HBASCAT001.md) | lee | `c1_1`, `c1_2`, `c1_3`, `c1_4`, `c1_5`, `c1_6`, `c2_1`, `c2_2`, `c2_3`, `c2_4`, `c2_5`, `c2_6`, `c3_1`, `c3_2`, `c3_3`, `c3_4`, `c3_5`, `c3_6`, `c4_1`, `c4_2`, `c4_3`, `c4_4`, `c4_5`, `c4_6`, `c5_1`, `c5_2`, `c5_3`, `c5_4`, `c5_5`, `c5_6`, `c6_1`, `c6_2`, `c6_3`, `c6_4`, `c6_5`, `c6_6`, `HCARSEC`, `HCATSEC`, `HCODSEC`, `HCOM001`, `HCOM002`, `HCOM003`, `HCOM004`, `HCOM005`, `HCOM006`, `HCOMFIN`, `HDESSEC`, `HFECPRO`, `HGENSEC`, `HNUMDOC`, `HREQ001`, `HREQ002`, `HREQ003`, `HREQ004` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RANI`, `RCIEBT`, `RFEC`, `RMESNOM` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.ref.FJERCOR02` (función) | — | no |

### Columnas que devuelve

1. `num_doc`, `nom`, `car`, `cat`, `gen`, `uni`, `corr`, `terr`, `codgru`, `r3`, `r1`, `r2`, `r4`, `ri3`, `ri1`, `ri2`, `ri4`, `c1`, `c2`, `c3`, `c4`, `c5`, `c6`, `ci1`, `ci2`, `ci3`, `ci4`, `ci5`, `ci6`, `cf`, `c1_1`, `c1_2`, `c1_3`, `c1_4`, `c1_5`, `c1_6`, `c2_1`, `c2_2`, `c2_3`, `c2_4`, `c2_5`, `c2_6`, `c3_1`, `c3_2`, `c3_3`, `c3_4`, `c3_5`, `c3_6`, `c4_1`, `c4_2`, `c4_3`, `c4_4`, `c4_5`, `c4_6`, `c5_1`, `c5_2`, `c5_3`, `c5_4`, `c5_5`, `c5_6`, `c6_1`, `c6_2`, `c6_3`, `c6_4`, `c6_5`, `c6_6`
2. `nom`

### Observaciones del análisis

- CTE: `a`
- ⚠️ Columna sin resolver `HNUMDOC` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HDESSEC` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCARSEC` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCATSEC` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HGENSEC` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HREQ001` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HREQ002` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HREQ003` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HREQ004` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCOM001` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCOM002` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCOM003` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCOM004` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCOM005` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCOM006` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCOMFIN` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HCODSEC` (¿storage.gpr.HBASCAT001?)
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.gpr.HBASCAT001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_sec.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
