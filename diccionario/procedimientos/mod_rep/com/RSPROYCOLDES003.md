# mod_rep.com.RSPROYCOLDES003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSPROYCOLDES003.sql](../../../../extraccion/procedimientos/mod_rep/com/RSPROYCOLDES003.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSPROYCOLDES003.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSPROYCOLDES003.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSPROYCOLDES003.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSPROYCOLDES003.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PROYEC_DIACOLREC_01` | proyeccion diaria colocaciones | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Proyecciones |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(8) | 'NOW' |  | — |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HBPDR002](../../../tablas/storage/com_act/HBPDR002.md) | lee | `hfecpro`, `HFECREG`, `HHORPRO` | estatico + motor |
| [storage.com_act.VCAH004](../../../tablas/storage/com_act/VCAH004.md) | lee | `hfecpro`≈, `HHORPRO`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `com.RSRDM002` | @TIP_COD, @cod_rel, @cant | no |

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
