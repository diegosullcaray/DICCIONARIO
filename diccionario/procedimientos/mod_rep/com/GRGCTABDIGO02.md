# mod_rep.com.GRGCTABDIGO02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRGCTABDIGO02.sql](../../../../procedimientos/mod_rep/com/GRGCTABDIGO02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRGCTABDIGO02.sql](../../../../sql/01-extraccion/mod_rep/com/GRGCTABDIGO02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRGCTABDIGO02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRGCTABDIGO02.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GCTABDIG_VR2_OPE_02` | GC TABLERO DIGITAL - Operacional | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (8)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.WUSABCLIENR001](../../../tablas/storage/com_act/WUSABCLIENR001.md) | lee | `HCODREL`, `hfecpro`≈, `htipcod`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | estatico + motor |
| [storage.ref.VJERCOR04](../../../tablas/storage/ref/VJERCOR04.md) | lee | `RCODAGEH`, `RCODMAC`, `RCODMAT`, `RCODTER`, `RDESAGEH`, `RDESFC`, `RDESMAC`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV06` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars","fec_corr"', @config, =, @tconf | no |

### Columnas que devuelve

`style`, `descripcion`, `CLI_NET_1`, `CLI_ENBO_1`, `PERCENT_ENRO`, `MHNUMENROLADO`, `AVENROLA`, `CLI_USAB_1`, `PERCENT_USA`, `MHNUMUSA`, `AVUSA`

### Observaciones del análisis

- Temporales: `#CliNetUsab`, `#JERAR`, `#RESULTPIV`, `#TR`
- ⚠️ Columna sin resolver `hfecpro` (¿storage.com_act.WUSABCLIENR001?)
- ⚠️ Columna sin resolver `htipcod` (¿storage.com_act.WUSABCLIENR001?)
- ⚠️ Columna sin resolver `hcodrel` (¿storage.com_act.WUSABCLIENR001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
