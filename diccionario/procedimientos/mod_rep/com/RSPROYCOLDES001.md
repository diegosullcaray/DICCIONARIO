# mod_rep.com.RSPROYCOLDES001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSPROYCOLDES001.sql](../../../../procedimientos/mod_rep/com/RSPROYCOLDES001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSPROYCOLDES001.sql](../../../../sql/01-extraccion/mod_rep/com/RSPROYCOLDES001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSPROYCOLDES001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSPROYCOLDES001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PROYEC_COLREC_01` | proyeccion de colocaciones | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Proyecciones |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(8) | 'NOW' |  | — |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.com_act.HBPDR002](../../../tablas/storage/com_act/HBPDR002.md) | lee | `hfecpro`, `HFECREG`, `HHORPRO` | estatico + motor |
| [storage.com_act.VCAH004](../../../tablas/storage/com_act/VCAH004.md) | lee | `hfecpro`≈, `HHORPRO`≈ | estatico + motor |
| [storage.com_act.WPROYDES001](../../../tablas/storage/com_act/WPROYDES001.md) | lee | `hfecreg` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

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
