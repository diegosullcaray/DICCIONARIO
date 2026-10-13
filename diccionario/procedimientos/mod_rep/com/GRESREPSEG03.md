# mod_rep.com.GRESREPSEG03

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GRESREPSEG03.sql](../../../../procedimientos/mod_rep/com/GRESREPSEG03.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GRESREPSEG03.sql](../../../../sql/01-extraccion/mod_rep/com/GRESREPSEG03.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GRESREPSEG03.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GRESREPSEG03.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRSCMIS_03` | Modulo de Resumen Pasivos | `tip_cod`, `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_seg.SDSF001](../../../tablas/storage/com_seg/SDSF001.md) | lee | `SFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.RCALC` | @json3, null, 2 | no |
| `rep.FTHEACOLS01` | 'RSCMIS_03' | no |

### Columnas que devuelve

1. `result`
2. `*`

### Observaciones del análisis

- Temporales: `#MaxCodVar`, `#ResumenSeguro3`, `#cab3`, `#tmpDATOSSOPC3S`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
