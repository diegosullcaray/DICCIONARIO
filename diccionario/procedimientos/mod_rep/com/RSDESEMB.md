# mod_rep.com.RSDESEMB

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSDESEMB.sql](../../../../extraccion/procedimientos/mod_rep/com/RSDESEMB.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSDESEMB.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSDESEMB.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSDESEMB.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSDESEMB.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_DESEMB_01` | Estructura de Desembolsos | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual<br>reportes / actividad-mensual / Cartera<br>shared / ui |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.VCAH005](../../../tablas/storage/com_act/VCAH005.md) | lee | `haseoper`, `HCODOPE`, `hfecpro`, `HMONDESMN`, `HNUMTAS`, `idrango`, `idrango2`, `RangoDesembolso`, `RangoDesembolso2` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `RDIAFER`, `rfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.ref.FJERCOR02` (función) | — | no |

### Columnas que devuelve

1. `@headers`
2. `style`, `IDRango`, `RangoDesembolso`, `1_Ope`, `2_Ope`, `3_Ope`, `Ope_Var`, `1_MON`, `2_MON`, `3_MON`, `Mon_Var`, `1_mes`, `2_mes`, `3_mes`, `mes_var`

### Observaciones del análisis

- CTE: `cte__`, `cte_a`, `cte_a_`
- Temporales: `#Base_`, `#Base__`, `#PreResult`, `#fec`, `#jerar`, `#r`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
