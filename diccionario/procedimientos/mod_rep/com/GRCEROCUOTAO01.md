# mod_rep.com.GRCEROCUOTAO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRCEROCUOTAO01.sql](../../../../procedimientos/mod_rep/com/GRCEROCUOTAO01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRCEROCUOTAO01.sql](../../../../sql/01-extraccion/mod_rep/com/GRCEROCUOTAO01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRCEROCUOTAO01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRCEROCUOTAO01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CEROYCUOTA_01` | CERO Y UNA CUOTA | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(50) | — |  | `cod_rel` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SDAS001](../../../tablas/storage/com_act/SDAS001.md) | lee | `sfecpro` | estatico + motor |
| [storage.com.metas_saldos](../../../tablas/storage/com/metas_saldos.md) | lee | `hcodvar`≈, `hfecpro`≈, `htipmeta`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESFC`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars","fec"', @config = @tconf | no |

### Columnas que devuelve

`*`, `var_meta_ope_zc`, `var_meta_saldo_zc`, `meta_ope_zc`, `meta_saldo_zc`

### Observaciones del análisis

- CTE: `cte_meta`
- Temporales: `#Fec`, `#R1`, `#R3`, `#T`, `#WJERCOR3`, `#r2`, `#r3`

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
