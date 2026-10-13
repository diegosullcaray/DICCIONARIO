# mod_rep.com.GLISAUTO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GLISAUTO01.sql](../../../../procedimientos/mod_rep/com/GLISAUTO01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GLISAUTO01.sql](../../../../sql/01-extraccion/mod_rep/com/GLISAUTO01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GLISAUTO01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GLISAUTO01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `LST_AUT_01` | Lista Autonomias | `tip_cod`, `cod_rel`, `c_aut`, `aut` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@c_aut` | int | — |  | `c_aut` |
| 4 | `@aut` | int | — |  | `aut` |

### Tablas y columnas (7)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.BTPCRA001](../../../tablas/storage/com_act/BTPCRA001.md) | lee | `*`, `CARGO_ADM`, `FECHA_INGRESO`, `HFECPRO`, `SAGENCIA`, `SAUTSUG`, `SAUTWF`, `SAVGMRAPROB`, `SC12M1`, `SC12M2`, `SC12M3`, `SC12MACUM`, `SC3M1`, `SC3M2`, `SC3M3`, `SC3MACUM`, `SCODSEC`, `SCOMENT`, `Segmentacion`, `SFILMR`, `SMRAPROB1`, `SMRAPROB2`, `SMRAPROB3`, `SNOMADM`, `SREGION`, `STERRITORIO`, `usuario` | estatico + motor |
| [storage.com_act.BTPCRC001](../../../tablas/storage/com_act/BTPCRC001.md) | lee | `*`, `AGENCIA`, `Col0`, `Comentarios`, `HFECPRO`, `REGION`, `SAUTSUG`, `SAUTSUGF`, `SAUTWF`, `SAVGMRAPRO`, `SC12M1`, `SC12M2`, `SC12M3`, `SC12MACUM`, `SC3M1`, `SC3M2`, `SC3M3`, `SC3MACUM`, `SCARCOOR`, `SCODSEC`, `Segmentacion`, `SFILMR`, `SMR1`, `SMR2`, `SMR3`, `SMRPROP`, `SNOMCOOR`, `TERRITORIO` | estatico + motor |
| [storage.com_act.BTPCRS001](../../../tablas/storage/com_act/BTPCRS001.md) | lee | `*`, `AGENCIA`, `Col0`, `Fecha de ingreso`, `HFECPRO`, `REGION`, `Resultado`, `SANTIGFC`, `SC12M1`, `SC12M2`, `SC12M3`, `SC3M1`, `SC3M2`, `SC3M3`, `SCARSEC`, `SCODSEC`, `SCUMPANTIGFC`, `SDCODSEC`, `SMR1`, `SMR2`, `SMR3`, `SMR4`, `SMRTEND3M`, `SNIVAUT`, `TERRITORIO` | estatico + motor |
| [storage.com_act.BTPCRT001](../../../tablas/storage/com_act/BTPCRT001.md) | lee | `*`, `Col0`, `HFECPRO`, `SAGSUP`, `SAGTOT`, `SAVGC12M`, `SAVGC3M`, `SAVGMRAPROB`, `SC12M1`, `SC12M2`, `SC12M3`, `SC3M1`, `SC3M2`, `SC3M3`, `SCARGO`, `SCODSEC`, `SDCODSEC`, `SDREG`, `SDTER`, `SMAPROB2`, `SMRAPROB3`, `SPAGSUP`, `SRESUL`, `SRMAPROB1` | estatico + motor |
| [storage.gpr.HPPC001](../../../tablas/storage/gpr/HPPC001.md) | lee | `HCODBT`, `HCODSUC`, `HFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.com.FTRAGEASE` (función) | — | no |
| `mod_rep.com.FTRAGEASE` (función) | — | no |
| `mod_rep.com.FTRAGEASE` (función) | — | no |
| `mod_rep.com.FTRAGEASE` (función) | — | no |

### Columnas que devuelve

1. `result`
2. `nom_ter`, `nom_reg`, `usu_bt`, `nom_per`, `carg_per`, `mes_1`, `mes_2`, `mes_3`, `prom_mr`, `mes_4`, `mes_5`, `mes_6`, `c3m_prom`, `mes_7`, `mes_8`, `mes_9`, `c12m_prom`, `ag_sup`, `ag_tot`, `pag_sup`, `result`
3. `nom_ter`, `nom_reg`, `nom_age`, `usu_bt`, `nom_per`, `carg_per`, `fec_ini`, `mes_1`, `mes_2`, `mes_3`, `prom_mr`, `mes_4`, `mes_5`, `mes_6`, `c3m_prom`, `mes_7`, `mes_8`, `mes_9`, `c12m_prom`, `filtro_mr`, `seg`, `aut_sug`, `aut`, `coment`
4. `nom_ter`, `nom_reg`, `nom_age`, `usu_bt`, `nom_per`, `carg_per`, `mr_prop`, `mes_1`, `mes_2`, `mes_3`, `prom_mr`, `mes_4`, `mes_5`, `mes_6`, `c3m_prom`, `mes_7`, `mes_8`, `mes_9`, `c12m_prom`, `filtro_mr`, `seg`, `aut_sug`, `aut`, `coment`
5. `nom_ter`, `nom_reg`, `nom_age`, `usu_bt`, `nom_per`, `carg_per`, `fec_ini`, `ant_fc`, `cum_ant`, `mes_1`, `mes_2`, `mes_3`, `mes_4`, `tend_3m`, `mes_5`, `mes_6`, `mes_7`, `mes_8`, `mes_9`, `mes_10`, `result`, `desc`, `res`, `niv_aut`

### Observaciones del análisis

- CTE: `a`, `b`, `c`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
