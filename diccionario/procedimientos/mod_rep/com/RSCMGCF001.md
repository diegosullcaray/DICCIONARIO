# mod_rep.com.RSCMGCF001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSCMGCF001.sql](../../../../extraccion/procedimientos/mod_rep/com/RSCMGCF001.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSCMGCF001.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSCMGCF001.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSCMGCF001.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSCMGCF001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CMG_CLIF_01` | CMG Clientes Flujo | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Clientes<br>reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODREL`, `HCODVAR`, `HFECPRO`, `HTIPCOD`, `HTIPMETA`, `HVALVAR` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `rciebt`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars2, @filters = @tfil2, @rows = @jer, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- Temporales: `#AAA`, `#AAA_1`, `#AAA_3`, `#AAA_4`, `#CMG`, `#F`, `#F2`, `#F3`, `#RES`, `#RESULTADO`, `#RESULTPRE`, `#RESULTPRE_1`, `#RESULTPRE_3`, `#RESULTPRE_4`, `#RES_1`, `#RES_3`, `#RES_4`, `#base`, `#base_2`, `#base_22`, `#base_2_1`, `#base_2_1A`, `#base_2_3`, `#base_2_31`, `#base_2_4`, `#base_2_4A`, `#base_3`, `#base_3_1`, `#base_3_3`, `#base_3_4`, `#castigo`, `#f`, `#f2`, `#fechas`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.util.FFMTVAR`
- `mod_rep.util.FSEMVAR`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
