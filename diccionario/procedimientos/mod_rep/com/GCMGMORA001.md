# mod_rep.com.GCMGMORA001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GCMGMORA001.sql](../../../../extraccion/procedimientos/mod_rep/com/GCMGMORA001.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GCMGMORA001.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GCMGMORA001.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GCMGMORA001.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GCMGMORA001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `cuadro_Variable_Riesgo_01` | Cuadro Variable Riesgo | `cod_rel`, `fec`, `tip_cod` | reportes / actividad-diaria / Cartera en Mora |
| `cuadro_Variable_M_01` | Cuadro Variable Riesgo Mensual | `cod_rel`, `fec`, `tip_cod` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 2 | `@fec` | date | — |  | `fec` |
| 3 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 4 | `@tipmeta` | int | 1 |  | — |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SBTVRIE001](../../../tablas/storage/com_act/SBTVRIE001.md) | lee | `SCODREL`, `SFECPRO`, `SGASPROVBRUTO12M`, `SGASPROVCART`, `SGASPROVCONTA`, `SGASPROVOM3155`, `SGASPROVVOLU`, `SMONREC`, `SRECCAST12M`, `SSTKPROV`, `STASREC`, `STIPCOD` | estatico + motor |
| [storage.com_act.SDAS005](../../../tablas/storage/com_act/SDAS005.md) | lee | `SCODAGR`≈, `SFECPRO`≈, `SSRECUMN`≈ | estatico + motor |
| [storage.com_act.wjas002](../../../tablas/storage/com_act/wjas002.md) | lee | `hcodrel`≈, `HFECPRO`, `htipcod`≈, `HVENTA_CARTMN`≈, `HVENTA_CARTMN12M`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.com.FCMGCAB` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = '"fec"', @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVLEV04` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = '"fec"', @columns = '"vars"', @config = @tconf | no |
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`(expresión 1)`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#AAA`, `#ACUM00`, `#ACUM01`, `#CMG`, `#DENOM01`, `#DENOM02`, `#DENOM03`, `#DENOMINADOR_RAT_MOR_REAL`, `#FECS`, `#FECS12`, `#FILTRO01_FECHA`, `#META_RAT_MOR_REAL`, `#NUMER01`, `#NUMER02`, `#NUMER03`, `#NUMERADOR_RAT_MOR_REAL`, `#PARTE01`, `#PARTE02_NUMEROS`, `#PARTE03_RATIOS`, `#PROD00`, `#RES`, `#RESULT00`, `#RESULT01`, `#RESULT02`, `#RESULT03`, `#RESULT03_C`, `#RESULT03_C_MENSUAL`, `#RESULT03_D`, `#RESULT03_D_FIN`, `#RESULT03_D_MENSUAL`, `#RESULT03_D_P1`, `#RESULT03_D_P1_FIN`, `#RESULT03_D_P1_MENSUAL`, `#RESULT04`, `#RESULTPIV`, `#RESULTPIV1`, `#RESULTPRE`, `#VALOR_PRIRMGO_DENOM1`, `#VALOR_PRIRMGO_META`, `#VALOR_PRIRMGO_NOM1`, `#VALOR_PRIRMGO_NOM2`, `#VAR01A_COBERCAR`, `#VAR01A_COBERCATRAS`, `#VAR01A_GTOPROVI12M`, `#VAR01A_METAPROVGENE`, `#VAR01A_MORAREALNETA`, `#VAR01A_PROVCARTEF`, `#VAR01A_PROVGENEFIN`, `#VAR01A_RECUCASTI12M`, `#VAR01B_COBERCAR`, `#VAR01B_COBERCATRAS`, `#VAR01B_GTOPROVI12M`, `#VAR01B_MORAREALNETA`, `#VAR01B_PROVB_MENSUAL`, `#VAR01B_PROVCARTEF`, `#VAR01B_RECUCASTI12M`, `#VAR01C_COBERCAR`, `#VAR01C_MORAREALNETA`, `#VAR01N_PROVB`, `#VAR01_MORARB`, `#VAR02N_PROVB`, `#VAR02_MORARB`, `#VAR02_PROVB_MENSUAL`, `#VAR03N_PROVB`, `#VAR03_PROVB_MENSUAL`, `#VAR_9018`, `#VENTCART`, `#VENTCART_MES`, `#WJAS002`, `#tabla`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
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
