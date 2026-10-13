# mod_rep.com.RSCALCAR02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSCALCAR02.sql](../../../../procedimientos/mod_rep/com/RSCALCAR02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSCALCAR02.sql](../../../../sql/01-extraccion/mod_rep/com/RSCALCAR02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSCALCAR02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSCALCAR02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_CAL_CAR_02` | Calidad de Cartera 2 | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars_aux, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars_aux, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

`fila`, `parent`, `child`, `style`, `descripcion`, `sal_cap`, `sal_cap_sm1`, `ratio_t1`, `sal_cap_sm2`, `ratio_t2`, `sal_cap_sm3`, `ratio_t3`, `sal_cap_sm4`, `ratio_t4`, `sal_cap_sm5`, `ratio_t5`, `num_cli_cm1`, `num_cli_cm2`, `num_cli_cm3`, `num_cli_cm4`, `num_cli_cm5`

### Observaciones del análisis

- Temporales: `#report_p1`, `#report_p2`

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
