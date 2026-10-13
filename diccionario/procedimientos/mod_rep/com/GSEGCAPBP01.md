# mod_rep.com.GSEGCAPBP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GSEGCAPBP01.sql](../../../../procedimientos/mod_rep/com/GSEGCAPBP01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GSEGCAPBP01.sql](../../../../sql/01-extraccion/mod_rep/com/GSEGCAPBP01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GSEGCAPBP01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GSEGCAPBP01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CAP_SEGUI_BP_01` | Captaciones Seguimiento BP | `tip_cod`, `cod_rel`, `fec`, `prod` | reportes / actividad-diaria / Captaciones |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(10) | — |  | `fec` |
| 4 | `@prod` | varchar(250) | — |  | `prod` |

### Tablas y columnas (17)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [mod_rep.util.FFMTVAR](../../../tablas/mod_rep/util/FFMTVAR.md) | — | — | motor |
| [mod_rep.util.FSEMVAR](../../../tablas/mod_rep/util/FSEMVAR.md) | — | — | motor |
| [storage.com_act.HTDA001](../../../tablas/storage/com_act/HTDA001.md) | lee | `HCANAL`, `hfecpro` | estatico + motor |
| [storage.com_act.WAPPCLI001](../../../tablas/storage/com_act/WAPPCLI001.md) | lee | `hfecpro` | estatico + motor |
| [storage.com_pas.HCDP001](../../../tablas/storage/com_pas/HCDP001.md) | lee | `*`, `hfecpro` | estatico + motor |
| [storage.com_pas.RETP001](../../../tablas/storage/com_pas/RETP001.md) | lee | `RDESCPROD02`≈ | estatico + motor |
| [STORAGE.com_pas.WJAS009](../../../tablas/STORAGE/com_pas/WJAS009.md) | lee | `HCODREL`, `HFECPRO`≈, `HTIPCOD`, `RDESCPROD`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `rfec` | estatico + motor |
| [storage.ref.REABP001](../../../tablas/storage/ref/REABP001.md) | lee | `RESTACT`≈, `RESTSEC`≈ | estatico + motor |
| [storage.ref.REABP002](../../../tablas/storage/ref/REABP002.md) | lee | `RCODZBP`, `RDESZBP` | estatico + motor |
| [storage.ref.VJERCOR04](../../../tablas/storage/ref/VJERCOR04.md) | lee | `RCODAGEH`, `RCODMAC`, `RCODMAT`, `RCODTER`, `RDESAGEH`, `RDESFC`, `RDESMAC`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV02` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, '"fec"', @columns, =, '"vars"', @config, =, @tconf | no |
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`style`, `ord`, `descripcion`, `saldo4`, `var_sal_anual`, `var_sal_diario`, `var_sal_mes`, `sem_sal_anual`, `sem_sal_diario`, `sem_sal_mes`, `cli4`, `var_cli_anual`, `var_cli_mes`, `sem_cli_anual`, `sem_cli_mes`, `ts4`, `var_ts_mes`, `tm4`, `var_tm_mes`, `semTS`, `semTMES`, `CLI_FE`, `VARANUCLI_FE`, `VARMESCLI_FE`, `VARDIA_FE`, `percent_FE`, `semafvarmesfondeobase`, `enroladoT2`, `varmesenro`, `enrolado2`, `usabilidad2`, `varmesusa`, `tasausa`

### Observaciones del análisis

- CTE: `abph`, `abph_`, `cte_a`, `cte_b`
- Temporales: `#BCLIPIVOT2`, `#BP`, `#BP_FINAL`, `#BP__`, `#BP__FC`, `#Back`, `#CliPivot2`, `#FECS`, `#Fec`, `#JERAR`, `#PRFC`, `#PRFC_`, `#PreResult`, `#PreResult_`, `#RBP`, `#RBPFC`, `#RBPP`, `#Rs_`, `#TB`, `#TPRECLI2`, `#USOAPP`, `#VCPH007`, `#WAPP`, `#fec`, `#fecs`, `#fecsS`, `#rst2`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.com_act.HTDA001 o storage.com_act.WAPPCLI001?)
- ⚠️ Columna sin resolver `HTIPNUMDOC` (¿storage.com_act.WAPPCLI001?)
- ⚠️ Columna sin resolver `HTIPDOC` (¿storage.com_act.HTDA001?)
- ⚠️ Columna sin resolver `HNUMDOC` (¿storage.com_act.HTDA001?)
- ⚠️ Columna sin resolver `HPENDOC` (¿storage.com_pas.HCDP001?)
- ⚠️ Columna sin resolver `HPETDOC` (¿storage.com_pas.HCDP001?)
- ⚠️ Columna sin resolver `HPEPAIS` (¿storage.com_pas.HCDP001?)
- ⚠️ Columna sin resolver `HSBCTA` (¿storage.com_pas.HCDP001?)
- ⚠️ Columna sin resolver `HSBOPER` (¿storage.com_pas.HCDP001?)
- ⚠️ Columna sin resolver `HSBSBOP` (¿storage.com_pas.HCDP001?)
- ⚠️ Columna sin resolver `HCODSEC` (¿storage.com_pas.HCDP001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
