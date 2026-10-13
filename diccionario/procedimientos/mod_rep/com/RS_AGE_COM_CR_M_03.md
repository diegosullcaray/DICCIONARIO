# mod_rep.com.RS_AGE_COM_CR_M_03

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RS_AGE_COM_CR_M_03.sql](../../../../procedimientos/mod_rep/com/RS_AGE_COM_CR_M_03.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RS_AGE_COM_CR_M_03.sql](../../../../sql/01-extraccion/mod_rep/com/RS_AGE_COM_CR_M_03.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RS_AGE_COM_CR_M_03.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RS_AGE_COM_CR_M_03.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_AGE_COM_CRM_S_01` | Agendamiento Comercial Reasignado Stock | `tip_cod`, `cod_rel`, `ver`, `fecha`, `tipo_ase` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@ver` | smallint | 0 |  | `ver` |
| 4 | `@fecha` | date | null |  | `fecha` |
| 5 | `@tipo_ase` | smallint | 0 |  | `tipo_ase` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | estatico + motor |

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
