# mod_rep.com.GLISPROSP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GLISPROSP01.sql](../../../../extraccion/procedimientos/mod_rep/com/GLISPROSP01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GLISPROSP01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GLISPROSP01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GLISPROSP01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GLISPROSP01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `LIS_PROSPE_01` | Lista de Prospectos | `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCMC002](../../../tablas/storage/com_act/HCMC002.md) | lee | `HAPENOMB`, `HAPERTCTA`, `HASEASIG`, `HCANACAP`, `HCELULAR`, `HCODSEC`, `HCODSECASIG`, `HCONSLNE`, `HCONSRCC`, `HCONSRUC`, `HCTALICEF`, `HDCIIU`, `HDEPA`, `HDESAGE`, `HDESASE`, `HDESCOR`, `HDESTER`, `HDIREC`, `HDISTR`, `HESTDCORE`, `HFECINSTAL`, `HFECPRO`, `HFIRMADN`, `HFOTNEGO`, `HGEOLATI`, `HGEOLON`, `HIDCORRES`, `HINSTALAD`, `HLICFUNCI`, `HMESINST`, `HNOMCOM`, `HNUMDOC`, `HNUMRUC`, `HPROSPEC`, `HPROV`, `HTAPERCC`, `HTIPAGENT`, `HTIPVINC`, `HVINFAMI`, `HZONA` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HNUMDOC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`HFECPRO`, `HAPENOMB`, `HNUMDOC`, `HNUMRUC`, `HCELULAR`, `HDIREC`, `HDISTR`, `HPROV`, `HDEPA`, `HDCIIU`, `HDESASE`, `HDESCOR`, `HDESAGE`, `HGEOLATI`, `HGEOLON`, `HNOMCOM`, `HDESTER`, `HAPERTCTA`, `HESTDCORE`, `HINSTALAD`, `HFECINSTAL`, `HZONA`, `HPROSPEC`, `HFIRMADN`, `HTAPERCC`, `HCONSRUC`, `HCONSRCC`, `HCONSLNE`, `HFOTNEGO`, `HCTALICEF`, `HLICFUNCI`, `HCANACAP`, `HMESINST`, `HTIPAGENT`, `HCODSECASIG`, `HASEASIG`, `HVINFAMI`, `HTIPVINC`, `HIDCORRES`

### Observaciones del análisis

- CTE: `a`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
