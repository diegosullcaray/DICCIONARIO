# mod_rep.com.GDCEROCN004

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GDCEROCN004.sql](../../../../procedimientos/mod_rep/com/GDCEROCN004.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GDCEROCN004.sql](../../../../sql/01-extraccion/mod_rep/com/GDCEROCN004.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GDCEROCN004.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GDCEROCN004.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `REP_CERCUOT_02` | Reporte cero cuota | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera en Mora |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WCUONUEV001](../../../tablas/storage/com_act/WCUONUEV001.md) | lee | `HCODMOD`, `HDIAATR`, `HINDCAR`, `HSUBTIP`, `HTIPOPE`, `SCODSEC`, `SFECPRO`, `SNUMOPEZCNUE`, `SSALZCMNNUE`, `SSUCCLI` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `storage.ref.FJERCOR02` (función) | — | no |

### Columnas que devuelve

`json`

### Observaciones del análisis

- CTE: `cte_a`, `cte_datos`
- Temporales: `#Fec`, `#cte_a`
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
