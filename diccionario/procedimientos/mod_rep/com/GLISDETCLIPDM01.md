# mod_rep.com.GLISDETCLIPDM01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GLISDETCLIPDM01.sql](../../../../extraccion/procedimientos/mod_rep/com/GLISDETCLIPDM01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GLISDETCLIPDM01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GLISDETCLIPDM01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GLISDETCLIPDM01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GLISDETCLIPDM01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `REACT_PDM_01` | Lista Clientes PDM Reprogramados | `cod_rel`, `base` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 2 | `@base` | varchar(20) | — |  | `base` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HRPDM002](../../../tablas/storage/com_act/HRPDM002.md) | lee | `HFFINVIG`, `HFINIVIG`, `HHORPRO`, `HMOREACC`, `HNUMDOC`, `HPAIS`, `HREACC`, `HTIPDOC` | estatico + motor |
| [storage.com_act.VRPDM001](../../../tablas/storage/com_act/VRPDM001.md) | lee | `HCODSEC`, `HCTACLI`, `HDCLI`, `HDGRP`, `HDIAATR`, `HDPROP`, `HENTID`, `HFECPRO`, `HFFINVIG`, `HFINIVIG`, `HFUVEN`, `HHORPRO`, `HMONDESMN`, `HNUMDOC`, `HPAIS`, `HSEMF`, `HTELF01`, `HTIPBASE`, `HTIPDOC`, `HTIPIN`, `HTIPOF` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HNUMDOC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.FTHEACOLS01` | 'REACT_PDM_01' | no |

### Columnas que devuelve

`nom_grup`, `cta_cli`, `nom_cli`, `num_tele`, `sem`, `mon_desem`, `fec_ult_ven`, `max_atr`, `tipo`, `num_ent`, `fec_ven`, `background`, `num_doc`, `tip_doc`, `cod_pais`, `fec_pro`, `hor_pro`, `fini_vig`, `ffin_vig`, `reaccion`, `motivo`

### Observaciones del análisis

- CTE: `a`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
