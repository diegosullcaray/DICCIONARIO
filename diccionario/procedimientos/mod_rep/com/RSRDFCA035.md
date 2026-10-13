# mod_rep.com.RSRDFCA035

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSRDFCA035.sql](../../../../procedimientos/mod_rep/com/RSRDFCA035.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSRDFCA035.sql](../../../../sql/01-extraccion/mod_rep/com/RSRDFCA035.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSRDFCA035.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSRDFCA035.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CARACT_CARTERA_01` | CARACT.CARTERA | `tip_cod`, `cod_rel`, `fec`, `prod` | reportes / actividad-diaria / Captaciones |
| `CARACT_CARTERA_M_01` | CARACT.CARTERA.Mensual | `tip_cod`, `cod_rel`, `fec`, `prod` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(10) | — |  | `fec` |
| 4 | `@prod` | varchar(250) | — |  | `prod` |

### Tablas y columnas (9)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [mod_rep.util.FSEMVAR](../../../tablas/mod_rep/util/FSEMVAR.md) | — | — | motor |
| [storage.com_act.WJAS004](../../../tablas/storage/com_act/WJAS004.md) | lee | `HCODREL`, `hfecpro`≈, `htipcod`≈, `RDESCPROD02`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`, `hfecpro` | estatico + motor |
| [storage.ref.wjercor03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUNI`, `rfecpro` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars","fec_corr"', @config, =, @tconf, @show_query, =, 1 | no |

### Columnas que devuelve

`style`, `descripcion`, `monto_cartera_caract_1`, `monto_cartera_caract_2`, `monto_cartera_caract_3`, `TMMSALDO`, `TFMSALDO`, `8`, `10`, `A1`, `A2`, `A3`, `TMMSM`, `TFMSM`, `9`, `11`, `numcli_cartera_caract_3`, `dif_clientes`, `15`, `metasaldo`, `metasaldoM`, `VARMETS`, `VARMETSM`

### Observaciones del análisis

- CTE: `cte_a`, `cte_a_`, `cte_b`
- Temporales: `#FECS`, `#JERAR`, `#M`, `#Met`, `#RESULTPIV`, `#SalMedio`, `#SemSaldo`, `#SemSaldoMedio`, `#TD`, `#T_`, `#fecs`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `hfecpro` (¿storage.com_act.WJAS004?)
- ⚠️ Columna sin resolver `htipcod` (¿storage.com_act.WJAS004?)
- ⚠️ Columna sin resolver `hcodrel` (¿storage.com_act.WJAS004?)
- ⚠️ Columna sin resolver `RDESCPROD02` (¿storage.com_act.WJAS004?)
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
