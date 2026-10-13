# mod_rep.com.GSELCIUT001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GSELCIUT001.sql](../../../../extraccion/procedimientos/mod_rep/com/GSELCIUT001.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GSELCIUT001.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GSELCIUT001.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GSELCIUT001.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GSELCIUT001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `SEL_CIU_01` | Filtro CIIU | — | — |

### Firma

Sin parámetros.

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.ref.REGCIIU003](../../../tablas/storage/ref/REGCIIU003.md) | lee | `RCODCIIU`, `RDESCIIU` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `rep.FTHEACOLS01` | 'SEL_EFEC_01' | no |

### Columnas que devuelve

`id`, `desc`

### Observaciones del análisis

- CTE: `cte_f`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
