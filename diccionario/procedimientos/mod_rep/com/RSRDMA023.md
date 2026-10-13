# mod_rep.com.RSRDMA023

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSRDMA023.sql](../../../../procedimientos/mod_rep/com/RSRDMA023.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSRDMA023.sql](../../../../sql/01-extraccion/mod_rep/com/RSRDMA023.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSRDMA023.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSRDMA023.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `R_APADRINA_01` | Apadrinamiento | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Campañas |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tipcod` | int | — |  | `tip_cod` |
| 2 | `@codrel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fecha` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HBDE001](../../../tablas/storage/com_act/HBDE001.md) | lee | `HCODOPE`, `HDIAATR`, `HFECPRO`, `HREGG` | estatico + motor |
| [storage.com_act.VCAH001](../../../tablas/storage/com_act/VCAH001.md) | lee | `HCODOPE`, `HFECPRO`, `HSALCAPMN` | estatico + motor |
| [storage.com_act.VCAM001](../../../tablas/storage/com_act/VCAM001.md) | lee | `HCODOPE`, `HCODSEC`, `HCTACLI`, `HDESCLI`, `HDIAATR`, `HDSUCSEC`, `HFECDES`, `HFECPRO`, `HINDCAR`, `HMONDES`, `HNOMREG`, `HNUMDOC`, `HSALCAPMN`, `HTIPDOC`, `HTOTCUO` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUNI`, `RDESCOR`, `RDESSEC`≈, `RDESUNI`≈, `RFECPRO`, `RINDFEC`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.com.FCMGFECMES` (función) | — | no |

### Columnas que devuelve

`result`

### Observaciones del análisis

- CTE: `ctedatos`, `ctepredatos`, `cteunpivot`, `cteval`
- Temporales: `#tmpCCD`, `#tmpDatos`, `#tmpDatosF`, `#tmpDatosF2`, `#tmpFechas`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `HCODOPE` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HSALCAPMN` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HDIAATR` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HNOMREG` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HCODSEC` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HNUMDOC` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HTIPDOC` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HCTACLI` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HDESCLI` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HDSUCSEC` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HFECDES` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HTOTCUO` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HMONDES` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HINDCAR` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RCODTER` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RCODCOR` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RCODGRU` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `RCODUNI` (¿storage.com_act.VCAM001 o storage.ref.WJERCOR03?)
- ⚠️ Columna sin resolver `GESTION` (¿storage.com_act.VCAH001?)
- ⚠️ Columna sin resolver `PAGO` (¿storage.com_act.VCAH001?)
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.com.TFECMES` (tipo de tabla)
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
