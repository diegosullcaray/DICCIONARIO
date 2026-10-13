# mod_rep.com.RS_AGROMIX_CHART4

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RS_AGROMIX_CHART4.sql](../../../../extraccion/procedimientos/mod_rep/com/RS_AGROMIX_CHART4.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RS_AGROMIX_CHART4.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RS_AGROMIX_CHART4.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RS_AGROMIX_CHART4.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RS_AGROMIX_CHART4.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_AGROMIX_05` | Graf Resumen AGROMIX | `tip_cod`, `cod_rel`, `fec` | reportes |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | INT | — |  | `tip_cod` |
| 2 | `@cod_rel` | VARCHAR(250) | — |  | `cod_rel` |
| 3 | `@fec` | DATE | — |  | `fec` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WCMAG001](../../../tablas/storage/com_act/WCMAG001.md) | lee | `hfecpro`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.ref.fjercor02` (función) | — | no |

### Columnas que devuelve

`categories`, `series`

### Observaciones del análisis

- CTE: `consultaresumen`, `cte_a`
- Temporales: `#Asesor`, `#HBase`, `#f_`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
