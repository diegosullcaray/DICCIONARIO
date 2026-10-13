# mod_rep.com.GSCAMP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GSCAMP01.sql](../../../../procedimientos/mod_rep/com/GSCAMP01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GSCAMP01.sql](../../../../sql/01-extraccion/mod_rep/com/GSCAMP01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GSCAMP01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GSCAMP01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GSCAMP_01` | Campaña Agil | `cod_rel`, `tip_cod`, `ind`, `sem` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 2 | `@tip_cod` | int | — |  | `tip_cod` |
| 3 | `@ind` | int | — |  | `ind` |
| 4 | `@sem` | int | 0 |  | `sem` |
| 5 | `@tipmeta` | int | 1 |  | — |
| 6 | `@fec` | date | null |  | — |
| 7 | `@CONFIG` | varchar(100) | 'RDA' |  | — |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HACA001](../../../tablas/storage/com_act/HACA001.md) | lee | `HCODASE`, `HDCARGO`, `HFECPRO`, `HPART` | estatico + motor |
| [storage.com_act.SABT001](../../../tablas/storage/com_act/SABT001.md) | lee | `SCODREL`, `SDESVAL`, `SFECPRO`, `SINDPDM`, `STIPCOD`, `SVAL` | estatico + motor |
| [storage.gpr.HPPC001](../../../tablas/storage/gpr/HPPC001.md) | lee | `hcodbt`, `HNUMDOC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.FFECMES` (función) | — | no |
| `storage.com.FTRAGEASE` (función) | — | no |
| `storage.com.FCAMPFEC` (función) | — | no |
| `storage.com.FCAMPFEC` (función) | — | no |
| `storage.com.FTRAGEASE` (función) | — | no |
| `storage.com.FCMGFEC` (función) | — | no |
| `storage.com.FVARCAMP` (función) | — | no |
| `storage.com.FINDPDM` (función) | — | no |
| `storage.com.FVARCAMP` (función) | — | no |
| `mod_rep.rep.FSPLITG` (función) | — | no |
| `storage.com.FCABCAMP` (función) | — | no |
| `mod_rep.rep.FCABTABDEF` (función) | — | no |
| `storage.com.FTRAGEASE` (función) | — | no |

### Columnas que devuelve

1. `(expresión 1)`
2. `Orden`, `RNOMSUB`, `VAL`, `NOMAGE`, `NOMREG`

### Observaciones del análisis

- CTE: `cteage`, `ctenom`
- Temporales: `#tmpAse`, `#tmpDATOSPAR`, `#tmpDatos`, `#tmpFec`, `#tmpNoPiv`, `#tmpdesc`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `storage.com.FCAMPFEC2`
- `mod_rep.rep.TCADS` (tipo de tabla)
- `mod_rep.rep.TFECMES` (tipo de tabla)
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
