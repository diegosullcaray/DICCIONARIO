# mod_rep.com.GLISCAPRET01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GLISCAPRET01.sql](../../../../procedimientos/mod_rep/com/GLISCAPRET01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GLISCAPRET01.sql](../../../../sql/01-extraccion/mod_rep/com/GLISCAPRET01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GLISCAPRET01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GLISCAPRET01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `LIS_CAPRET_01` | List Capacity Retailer | `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com.VLDRD01](../../../tablas/storage/com/VLDRD01.md) | lee | `HCODOPE`, `HCODSEC`, `HCTACLI`, `HDCLI`, `HDIAATR`, `HDREACC`, `HDSITCRED`, `HFECPRO`, `HFFINVIG`, `HFINIVIG`, `HHORPRO`, `HNUMDOC`, `HPAIS`, `HSALCAPMN`, `HTIPDOC`, `HTIPOPE`, `HTIPSBS` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HNUMDOC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`cod_ope`, `sal_cart`, `nom_cli`, `max_atr`, `fec_pro`, `tip_sbs`, `sit_cred`, `fec_pro`, `fini_vig`, `ffin_vig`, `hor_pro`, `cta_cli`, `cod_ope`, `tip_ope`, `num_doc`, `tip_doc`, `cod_pais`, `reaccion`, `afec_neg`, `fun_neg`, `sit_neg`, `red_neg`, `sec_eco`, `gir_neg`

### Observaciones del análisis

- CTE: `a`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
