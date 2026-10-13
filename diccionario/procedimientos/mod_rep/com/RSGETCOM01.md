# mod_rep.com.RSGETCOM01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSGETCOM01.sql](../../../../procedimientos/mod_rep/com/RSGETCOM01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSGETCOM01.sql](../../../../sql/01-extraccion/mod_rep/com/RSGETCOM01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSGETCOM01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSGETCOM01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_GEST_COM_01` | Reporte Gestión Comercial | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@Fecha` | DATE | — |  | `fecha` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `HCODREL`, `HFECPRO`, `HNUMCLI`, `HNUMCLIN`, `HNUMSECGMES`, `HNUMSECIMES`, `HTIPCOD`, `HVSALVIGMN` | estatico + motor |
| [storage.com_act.WRODASAL001](../../../tablas/storage/com_act/WRODASAL001.md) | lee | `HCODREL`, `HRODAM`, `HSALNOVIG`, `HSALVIGEN`, `HTIPCOD`, `TMMHSALNOVIG`, `TMMRODAMIENTO`, `TMMSALVIGE` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`≈, `hcodvar`≈, `hfecpro`≈, `HTIPCOD`≈, `HTIPMETA`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `rdiafer`, `RDIASEM`, `rfec` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `rfecpro`, `rindfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars","fec_corr"', @config = @tconf | no |

### Columnas que devuelve

1. `JSON`
2. `*`
3. `*`, `Canc_vigente`, `Color_Cumplimiento`, `Color_Cumplimiento`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_d`
- Temporales: `#FECS`, `#Jerar`, `#MetaClientesnuevos`, `#MetaProductividad`, `#MetaProductividadAsesor`, `#Metas`, `#PreAsesor`, `#ProdT`, `#ProdT__`, `#ProdTip1`, `#TB`, `#TB_Ant`, `#Temp_1`, `#wjas001`, `#wjas001_Ant`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
