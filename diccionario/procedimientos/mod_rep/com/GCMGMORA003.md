# mod_rep.com.GCMGMORA003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GCMGMORA003.sql](../../../../extraccion/procedimientos/mod_rep/com/GCMGMORA003.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GCMGMORA003.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GCMGMORA003.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GCMGMORA003.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GCMGMORA003.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `cuadro_Variable_Riesgo_F_01` | Cuadro Variable Riesgo Finanzas | `cod_rel`, `fec`, `tip_cod` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 2 | `@fec` | date | — |  | `fec` |
| 3 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 4 | `@tipmeta` | int | 2 |  | — |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SBTVRIE001](../../../tablas/storage/com_act/SBTVRIE001.md) | lee | `SCODREL`, `SFECPRO`, `SGASPROVBRUTO12M`, `SGASPROVCART`, `SGASPROVCONTA`, `SGASPROVOM3155`, `SGASPROVVOLU`, `SMONREC`, `SRECCAST12M`, `SSTKPROV`, `STASREC`, `STIPCOD` | estatico + motor |
| [storage.com_act.wjas002](../../../tablas/storage/com_act/wjas002.md) | lee | `HFECPRO` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.com.FCMGCAB` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = '"fec"', @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

1. `(expresión 1)`
2. `RDESVAR`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, `12`, `13`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#AAA`, `#ACUM00`, `#ACUM01`, `#CMG`, `#FECS`, `#PROD00`, `#RES`, `#RESULT00`, `#RESULT01`, `#RESULT02`, `#RESULT03`, `#RESULT03_C`, `#RESULT03_C_MENSUAL`, `#RESULT03_D`, `#RESULT03_D_MENSUAL`, `#RESULT03_D_P1`, `#RESULT03_D_P1_MENSUAL`, `#RESULTPIV`, `#RESULTPRE`, `#VALOR_PRIRMGO_DENOM1`, `#VALOR_PRIRMGO_META`, `#VALOR_PRIRMGO_NOM1`, `#VALOR_PRIRMGO_NOM2`, `#VAR01A_COBERCAR`, `#VAR01A_COBERCATRAS`, `#VAR01A_GTOPROVI12M`, `#VAR01A_MORAREALNETA`, `#VAR01A_PROVCARTEF`, `#VAR01A_RECUCASTI12M`, `#VAR01B_COBERCAR`, `#VAR01B_COBERCATRAS`, `#VAR01B_GTOPROVI12M`, `#VAR01B_MORAREALNETA`, `#VAR01B_PROVB_MENSUAL`, `#VAR01B_PROVCARTEF`, `#VAR01B_RECUCASTI12M`, `#VAR01C_COBERCAR`, `#VAR01C_MORAREALNETA`, `#VAR01N_PROVB`, `#VAR01_MORARB`, `#VAR02N_PROVB`, `#VAR02_MORARB`, `#VAR02_PROVB_MENSUAL`, `#VAR03N_PROVB`, `#VAR03_PROVB_MENSUAL`, `#WJAS002`, `#tabla`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.util.FFMTVAR`
- `mod_rep.util.FSEMVAR`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
