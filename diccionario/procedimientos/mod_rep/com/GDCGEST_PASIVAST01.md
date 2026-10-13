# mod_rep.com.GDCGEST_PASIVAST01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GDCGEST_PASIVAST01.sql](../../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GDCGEST_PASIVAST01.sql](../../../../sql/01-extraccion/mod_rep/com/GDCGEST_PASIVAST01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GDCGEST_PASIVAST01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GDCGEST_PASIVAST01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (6)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GST_PASIVA_01` | GESTION TASAS PASIVAS | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | reportes / actividad-diaria / Captaciones |
| `GST_PASIVA_02` | GESTION TASAS PASIVAS | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | reportes / actividad-diaria / Captaciones |
| `GST_PASIVA_03` | GESTION TASAS PASIVAS | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | — |
| `GST_PASIVA_M_01` | GESTION TASAS PASIVAS | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | — |
| `GST_PASIVA_M_02` | GESTION TASAS PASIVAS | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | — |
| `GST_PASIVA_M_03` | GESTION TASAS PASIVAS | `tip_cod`, `cod_rel`, `var`, `agr`, `calc`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tipcod` | int | — |  | `tip_cod` |
| 2 | `@codrel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@var` | varchar(5) | — |  | `var` |
| 4 | `@agr` | int | 1 |  | `agr` |
| 5 | `@calc` | int | 1 |  | `calc` |
| 6 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_pas.WBAUT001](../../../tablas/storage/com_pas/WBAUT001.md) | lee | `HCOFIC`, `HFECPRO` | estatico + motor |
| [storage.ref.VJERCOR03](../../../tablas/storage/ref/VJERCOR03.md) | lee | `RCODAGE`, `RCODCOR`, `RCODFC`, `RCODMAT`, `RCODTER`, `RDESAGE`, `RDESCOR`, `RDESFC`, `RDESMAT`, `RDESTER` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `strategos.mod_rep_com_act.CABGDCGEST_PASIVASTAPI01` | @tipcod, @codrel, @var, @agr, @calc, @fec | no |

### Columnas que devuelve

`style`, `HDESC`, `3`, `2`, `Admin`, `GerenteCorredor`, `GerenteTerritorial`, `EjBancaPref.`, `Tesoreria`, `1`, `10`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#A`, `#B`, `#C`, `#D`, `#E`, `#F`, `#JER`, `#RES`
- ⚠️ Columna sin resolver `HMAPER` (¿storage.com_pas.WBAUT001?)
- ⚠️ Columna sin resolver `HAOTASA` (¿storage.com_pas.WBAUT001?)
- ⚠️ Columna sin resolver `HTMAXI` (¿storage.com_pas.WBAUT001?)
- ⚠️ Columna sin resolver `HFECPRO` (¿storage.com_pas.WBAUT001?)
- ⚠️ Columna sin resolver `HRENOV` (¿storage.com_pas.WBAUT001?)
- ⚠️ Columna sin resolver `HDMODU` (¿storage.com_pas.WBAUT001?)
- ⚠️ Columna sin resolver `CANAL` (¿storage.com_pas.WBAUT001?)
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
