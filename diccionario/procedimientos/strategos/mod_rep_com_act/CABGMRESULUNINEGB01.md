# strategos.mod_rep_com_act.CABGMRESULUNINEGB01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `strategos` · `mod_rep_com_act` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/strategos/mod_rep_com_act/CABGMRESULUNINEGB01.sql](../../../../extraccion/procedimientos/strategos/mod_rep_com_act/CABGMRESULUNINEGB01.sql) |
| Extracción | [extraccion/sql/01-extraccion/strategos/mod_rep_com_act/CABGMRESULUNINEGB01.sql](../../../../extraccion/sql/01-extraccion/strategos/mod_rep_com_act/CABGMRESULUNINEGB01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `resultado_unidad_negocio_rma_01` | RESULTADO GUN | `tip_cod`, `cod_rel`, `fec`, `canal` | reportes / actividad-mensual |
| `resultado_unidad_negocio_rma_ope_01` | RESULTADO GUN | `tip_cod`, `cod_rel`, `fec`, `canal` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tipcod` | int | — |  | `tip_cod` |
| 2 | `@codrel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@canal` | varchar(250) | — |  | `canal` |

### Tablas y columnas (0)

No se detectaron tablas.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.com.CABRSRMFCN001` | @codrel, @fec, @tipcod | no |
| `strategos.mod_rep_com_act.GMRESULUNINEGB01` | @tipcod, @codrel, @fec, @canal | no |
| `storage.com.CABRSRMFCN001` | 231, @fec, @tipcod | no |
| `strategos.mod_rep_com_act.GMRESULUNINEGB01` | @tipcod, @codrel, @fec, @canal | no |

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/strategos.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
