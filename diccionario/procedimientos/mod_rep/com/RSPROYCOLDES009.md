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

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.com.Datos_PD](../../../tablas/mod_rep/com/Datos_PD.md) ⚠️ esquema implícito | elimina-objeto, lee | — | estatico + motor |
| [storage.com_act.HBPDR001](../../../tablas/storage/com_act/HBPDR001.md) | lee | `HFECPRO`, `hfecreg` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `*`
2. `Total`

### Observaciones del análisis

- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
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
