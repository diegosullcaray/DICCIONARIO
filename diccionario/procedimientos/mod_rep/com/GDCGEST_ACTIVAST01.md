# mod_rep.com.GDCGEST_ACTIVAST01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.sql](../../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GDCGEST_ACTIVAST01.sql](../../../../sql/01-extraccion/mod_rep/com/GDCGEST_ACTIVAST01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GDCGEST_ACTIVAST01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GDCGEST_ACTIVAST01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (12)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GST_ACTIVAS_01` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_02` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_03` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_04` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_05` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_06` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_M_01` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_M_02` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_M_03` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_M_04` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_M_05` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |
| `GST_ACTIVAS_M_06` | GESTION TASAS ACTIVAS | `tip_cod`, `cod_rel`, `var`, `fec`, `diario` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(10) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@var` | int | — |  | `var` |
| 4 | `@fec` | date | — |  | `fec` |
| 5 | `@diario` | int | 0 |  | `diario` |

### Tablas y columnas (9)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [storage.com_act.RETP001](../../../tablas/storage/com_act/RETP001.md) | lee | `RCODMOD`, `RCODPROD`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP002](../../../tablas/storage/com_act/RETP002.md) | lee | `RCODMOD`, `RCODPROD`, `RSUBTIP`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP003](../../../tablas/storage/com_act/RETP003.md) | lee | `RCODPROD`, `RDESGRU01`, `RDESPROD` | estatico + motor |
| [storage.com_act.WACLI001](../../../tablas/storage/com_act/WACLI001.md) | lee | `hfecpro` | estatico + motor |
| [storage.com_act.WGATH002](../../../tablas/storage/com_act/WGATH002.md) | lee | `*`, `HAUTO`, `HCAPP1`, `HCAPP2`, `HCAPP3`, `HCAPP4`, `HCAPP5`, `HCASE`, `HCCLI`, `HCOFI`, `HCRT10`, `HCRT11`, `HCRT12`, `HCRT2`, `HCRT3`, `HCRT4`, `HCRT5`, `HCRT6`, `HCRT7`, `HCRT8`, `HCRT9`, `HDASE`, `HDOFI`, `HDTDOC`, `HFAPP1`, `HFAPP2`, `HFAPP3`, `HFAPP4`, `HFAPP5`, `HFDES`, `HFECPRO`, `HGESTTAS`, `HHAPP1`, `HHAPP2`, `HHAPP3`, `HHAPP4`, `HHAPP5`, `HMDES`, `HMOD`, `HNAPP1`, `HNAPP2`, `HNAPP3`, `HNAPP4`, `HNAPP5`, `HNCLI`, `HNCUO`, `HNDOC`, `HOPER`, `HPBS`, `HPLZO`, `HPROD`, `HREGI`, `HSOLI`, `HSUBTIP`, `HTBAS`, `HTDES`, `HTERR`, `HTMER`, `HTMIN`, `HTOPE`, `HTSEG`, `HTSOL`, `HTTAR`, `HUAPP1`, `HUAPP2`, `HUAPP3`, `HUAPP4`, `HUAPP5`, `HUCAP`, `HUCAP_FIN`, `HUFAP`, `HUHAP`, `HUNAP`, `HUUAP`, `HVARI1`, `HVARI2`, `HVARI3`, `HVARI4`, `HVARI5`, `ID`, `ORD`, `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFEC` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RANI`, `RDIAFER`, `rfec`, `RMESNOM` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar, output | no |

### Columnas que devuelve

1. `result`
2. `*`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`, `cte_c`, `cte_d`
- Temporales: `#C`, `#D`, `#FECS`, `#FIN`, `#FecList`, `#RESULT`, `#res`
- ⚠️ Columna sin resolver `RDESGRU01` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.WGATH002?)
- ⚠️ Columna sin resolver `RDESPROD` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.WGATH002?)
- ⚠️ Columna sin resolver `ORD` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.WGATH002?)
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
