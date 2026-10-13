# mod_rep.com.GCMGMORA001_SIMP

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GCMGMORA001_SIMP.sql](../../../../procedimientos/mod_rep/com/GCMGMORA001_SIMP.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GCMGMORA001_SIMP.sql](../../../../sql/01-extraccion/mod_rep/com/GCMGMORA001_SIMP.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GCMGMORA001_SIMP.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GCMGMORA001_SIMP.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `cmg_mora_simp_01` | Cmg Mora Sin Impulso | `cod_rel`, `fec`, `tip_cod` | reportes / actividad-diaria / Cartera en Mora |
| `cmg_mora_simp_m_01` | Cmg Mora Sin Impulso Mensual | `cod_rel`, `fec`, `tip_cod` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 2 | `@fec` | date | — |  | `fec` |
| 3 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 4 | `@tipmeta` | int | 1 |  | — |

### Tablas y columnas (8)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.util.FFMTVAR](../../../tablas/mod_rep/util/FFMTVAR.md) | — | — | motor |
| [mod_rep.util.FSEMVAR](../../../tablas/mod_rep/util/FSEMVAR.md) | — | — | motor |
| [storage.com_act.WJAS002_SIMP](../../../tablas/storage/com_act/WJAS002_SIMP.md) | lee | `HFECPRO` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.com.FCMGCAB` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, '"fec"', @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVLEV04` | @tip_cod, @cod_rel, @jerar, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, '"fec"', @columns, =, '"vars"', @config, =, @tconf | no |

### Columnas que devuelve

1. `(expresión 1)`
2. `RDESVAR`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, `12`, `13`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#AAA`, `#ACUM01`, `#CMG`, `#FECS`, `#PARTE01`, `#PARTE02_NUMEROS`, `#PARTE03_RATIOS`, `#PROD00`, `#RES`, `#RESULT00`, `#RESULT01`, `#RESULTPIV`, `#RESULTPIV1`, `#RESULTPRE`, `#VAR01A_MORAREALNETA`, `#VAR02_MORARB`, `#WJAS002`, `#tabla`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
