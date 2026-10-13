# mod_rep.com.GCMGCAP01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GCMGCAP01.sql](../../../../extraccion/procedimientos/mod_rep/com/GCMGCAP01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GCMGCAP01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GCMGCAP01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GCMGCAP01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GCMGCAP01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GCMGCAP_01` | CMG Pasivas | `fec`, `tip_cod`, `cod_rel` | reportes / actividad-diaria / Captaciones<br>reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@fec` | date | — |  | `fec` |
| 2 | `@tip_cod` | int | — |  | `tip_cod` |
| 3 | `@cod_rel` | varchar(250) | '231' |  | `cod_rel` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `HFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.com.FCMGCAB` (función) | — | no |
| `mod_rep.rep.FCABTABDEF` (función) | — | no |
| `mod_rep.com.RSCMGP002` | @tip_cod, @cod_rel, @fecha | no |

### Columnas que devuelve

`(expresión 1)`

### Observaciones del análisis

- CTE: `ctecab`, `cterec`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.rep.TCADS` (tipo de tabla)
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
