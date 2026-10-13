# mod_rep.com.RAGROMIX

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RAGROMIX.sql](../../../../extraccion/procedimientos/mod_rep/com/RAGROMIX.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RAGROMIX.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RAGROMIX.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RAGROMIX.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RAGROMIX.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_AGROMIX_01` | REPORTE AGROMIX | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Cartera<br>reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WCMAG001](../../../tablas/storage/com_act/WCMAG001.md) | lee | `haseoper`, `HCAPMON`, `HCTACLI`, `HEXTENS`, `hfecpro`, `HVENMON` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `RFEC` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `rcodcor`≈, `RCODFC`≈, `rcodgru`≈, `rcodsec`≈, `rcodter`≈, `RcodUCO`≈, `rcoduni`≈, `rdescor`≈, `RDESFC`≈, `RDESGRU`≈, `rdessec`≈, `rdester`≈, `RdesUCO`≈, `rdesuni`≈, `rfecpro`≈, `rindfec`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `@headers`
2. `*`
3. `*`

### Observaciones del análisis

- CTE: `cte_b`, `cte_detalles_calculados`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
