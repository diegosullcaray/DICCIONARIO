# mod_rep.com.RFECREPMEN02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RFECREPMEN02.sql](../../../../procedimientos/mod_rep/com/RFECREPMEN02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RFECREPMEN02.sql](../../../../sql/01-extraccion/mod_rep/com/RFECREPMEN02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RFECREPMEN02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RFECREPMEN02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_FECH02` | Fecha Reporte Hoy Mensual | `fec` | reportes<br>reportes / actividad-diaria / Cartera<br>reportes / actividad-diaria / Seguros |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@fec` | date | null |  | `fec` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `RDIAFER`, `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `json`
2. `(expresión 1)`
3. `(expresión 1)`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
