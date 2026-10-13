# mod_rep.com.GDMREP001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GDMREP001.sql](../../../../extraccion/procedimientos/mod_rep/com/GDMREP001.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GDMREP001.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GDMREP001.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GDMREP001.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GDMREP001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_MON_REP_01` | Monitor de reprogramados | `cod_rel`, `fec`, `tip_cod`, `car` | reportes / avance-comercial |
| `RS_MON_REP_SEC_01` | Monitor de reprogramados | `cod_rel`, `fec`, `tip_cod`, `car` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 2 | `@fec` | date | — |  | `fec` |
| 3 | `@tip_cod` | varchar(10) | — |  | `tip_cod` |
| 4 | `@car` | int | 1 |  | `car` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WCRH001](../../../tablas/storage/com_act/WCRH001.md) | lee | `HFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `com.RSMREP002` | @cod_rel, @fec, @tip_cod, @car | no |
| `com.RSMREP001` | @cod_rel, @fec, @tip_cod, @car | no |

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
