# mod_rep.com.RSPROYCOLDES009

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSPROYCOLDES009.sql](../../../../procedimientos/mod_rep/com/RSPROYCOLDES009.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSPROYCOLDES009.sql](../../../../sql/01-extraccion/mod_rep/com/RSPROYCOLDES009.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSPROYCOLDES009.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSPROYCOLDES009.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PROYEC_COLREC_03` | proyeccion diaria colocacion detalle | `tip_cod`, `cod_rel`, `pagen` | reportes / actividad-diaria / Proyecciones |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@pagen` | int | — |  | `pagen` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.com.Datos_PD](../../../tablas/mod_rep/com/Datos_PD.md) ⚠️ esquema implícito | elimina-objeto, lee | — | estatico |
| [mod_rep.dbo.Datos_PD](../../../tablas/mod_rep/dbo/Datos_PD.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [STORAGE.com_act.HBPDR001](../../../tablas/STORAGE/com_act/HBPDR001.md) | lee | `HFECPRO`, `hfecreg` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `Total`

### Observaciones del análisis

- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
