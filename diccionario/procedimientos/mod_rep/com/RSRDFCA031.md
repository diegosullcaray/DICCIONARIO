# mod_rep.com.RSRDFCA031

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSRDFCA031.sql](../../../../procedimientos/mod_rep/com/RSRDFCA031.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSRDFCA031.sql](../../../../sql/01-extraccion/mod_rep/com/RSRDFCA031.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSRDFCA031.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSRDFCA031.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `DesemDiario_05` | Operaciones Diario CE 05 | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tipcod` | int | — |  | `tip_cod` |
| 2 | `@codrel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SDAF001](../../../tablas/storage/com_act/SDAF001.md) | lee | `SFECPRO` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `strategos.mod_rep_com_act.CABDESEDIAR02` | @tipcod, @codrel | no |
| `piv.GPIVLEV01` | @tipcod, @codrel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVLEV01` | @tipcod, @codrel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Observaciones del análisis

- Temporales: `#FecMensual`, `#T1`, `#T2`, `#T3`, `#Tabla`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

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
