# mod_rep.com.RSCOMPAS01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSCOMPAS01.sql](../../../../extraccion/procedimientos/mod_rep/com/RSCOMPAS01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSCOMPAS01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSCOMPAS01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSCOMPAS01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSCOMPAS01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_CARTEPAS_01` | Reporte Carterización Pasivo | `tipcod`, `codrel`, `fecha` | reportes / actividad-diaria / Captaciones |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tipcod` | varchar(5) | — |  | `tipcod` |
| 2 | `@codrel` | varchar(25) | — |  | `codrel` |
| 3 | `@Fecha` | DATE | — |  | `fecha` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `HCODREL`, `HFECPRO`, `HNUMCLI`, `HTIPCOD` | estatico + motor |
| [storage.com_act.WRCOMPASDIG01](../../../tablas/storage/com_act/WRCOMPASDIG01.md) | lee | `HCODREL`, `HTIPCOD` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `rfecpro`, `rindfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tipcod, @codrel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars","fec_corr"', @config = @tconf | no |

### Columnas que devuelve

1. `(expresión 1)`
2. `*`, `saldo_ahorro_hoy`, `Var_Ahorro_Anual`, `Var_Ahorro_Mes`, `Var_Ahorro_Dia`, `hsaldmedio`, `Var_Saldo_Medio_Mes`, `fondeoestable`, `var_fondeoestable`, `HTIPNUMDOC`, `N_Enrolados_Activos`, `N_Pago_Creditos_App`, `N_Operaciones_QR`, `N_Operaciones_Plin_Contacto`, `num_cli`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#Fec`, `#Jerar`, `#ProdT`, `#ProdT_`, `#ProdT__`, `#wjas001`
- ⚠️ Columna sin resolver `saldo_ahorro_hoy` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `Var_Ahorro_Anual` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `Var_Ahorro_Mes` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `Var_Ahorro_Dia` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `hsaldmedio` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `Var_Saldo_Medio_Mes` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `fondeoestable` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `var_fondeoestable` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `HTIPNUMDOC` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `N_Enrolados_Activos` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `N_Pago_Creditos_App` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `N_Operaciones_QR` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `N_Operaciones_Plin_Contacto` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `STYLE` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)
- ⚠️ Columna sin resolver `cod_ugru` (¿STORAGE.COM_ACT.WRCOMPASDIG01?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

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
