# mod_rep.com.RS_AGE_COM_CR_01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RS_AGE_COM_CR_01.sql](../../../../extraccion/procedimientos/mod_rep/com/RS_AGE_COM_CR_01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RS_AGE_COM_CR_01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RS_AGE_COM_CR_01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RS_AGE_COM_CR_01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RS_AGE_COM_CR_01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_AGE_COM_CR_01` | Agendamiento Comercial Reasignado | `tip_cod`, `cod_rel`, `ver`, `fecha` | reportes / actividad-diaria / Portafolio Reasignado |
| `RS_AGE_COM_CRM_01` | Agendamiento Comercial Reasignado Mensual | `tip_cod`, `cod_rel`, `ver`, `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@ver` | smallint | 0 |  | `ver` |
| 4 | `@fecha` | date | null |  | `fecha` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Observaciones del análisis

- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver

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
