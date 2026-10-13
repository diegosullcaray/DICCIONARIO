# mod_rep.com.RSDESEMP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSDESEMP01.sql](../../../../procedimientos/mod_rep/com/RSDESEMP01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSDESEMP01.sql](../../../../sql/01-extraccion/mod_rep/com/RSDESEMP01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSDESEMP01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSDESEMP01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `DESEMP_SOC_01` | Desempeño Social | `tip_cod`, `cod_rel`, `fec` | reportes / desarrollo-sostenible |
| `DESE_SOC_01` | Desempeno Social | `uni_cfg` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(8) | — |  | `fec` |

### Tablas y columnas (7)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [mod_rep.util.FFMTVAR](../../../tablas/mod_rep/util/FFMTVAR.md) | — | — | motor |
| [mod_rep.util.FSEMVAR](../../../tablas/mod_rep/util/FSEMVAR.md) | — | — | motor |
| [storage.com_act.WACLI007](../../../tablas/storage/com_act/WACLI007.md) | lee | `HCODSEC`≈, `HFECPRO`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.ref.wjercor03](../../../tablas/storage/ref/wjercor03.md) | lee | `*`, `Rfecpro` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- Temporales: `#CMG`, `#RES`, `#RESULTADO`, `#RESULTPRE`, `#RESULTPRE2`, `#RESULTPRE_M`, `#base`, `#base_3`, `#fechas`, `#wacli007_mes`, `#wjercor03`
- ⚠️ Columna sin resolver `rindfec` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODFC` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODGRU` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODTER` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODCOR` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODUNI` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `RCODUCO` (¿storage.ref.wjercor03?)
- ⚠️ Columna sin resolver `variables` (¿storage.com.VDMCOM01?)
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
