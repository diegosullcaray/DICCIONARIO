# mod_rep.com.GCMCNUE001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GCMCNUE001.sql](../../../../procedimientos/mod_rep/com/GCMCNUE001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GCMCNUE001.sql](../../../../sql/01-extraccion/mod_rep/com/GCMCNUE001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GCMCNUE001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GCMCNUE001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CMCUONUEV_01` | Cuadro de Mando Cero Cuotas Nuevas | `tip_cod`, `cod_rel`, `fec`, `prod`, `tipcuota` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@prod` | varchar(50) | — |  | `prod` |
| 5 | `@tipcuota` | int | — |  | `tipcuota` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`≈, `hfecpro`≈, `HTIPMETA`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars","fec"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jerar, @columns = '"vars","fec_corr"', @config = @tconf | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `a`, `cte_a`, `cte_b`, `cte_c`, `cte_idx1`
- Temporales: `#FECS`, `#RESULTPIV`, `#RESULTPIVM`, `#Te`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
