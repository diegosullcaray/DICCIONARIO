# mod_rep.com.GMOVCLI01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GMOVCLI01.sql](../../../../procedimientos/mod_rep/com/GMOVCLI01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GMOVCLI01.sql](../../../../sql/01-extraccion/mod_rep/com/GMOVCLI01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GMOVCLI01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GMOVCLI01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `MOVIMIENTO_CLIENTES_01` | Movimiento Clientes | — | reportes / actividad-diaria / Clientes |

### Firma

Sin parámetros.

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.RETP003](../../../tablas/storage/com_act/RETP003.md) | lee | `RCODPROD`, `RDESPROD` | estatico + motor |
| [storage.com.WBCLI02](../../../tablas/storage/com/WBCLI02.md) | lee | `HFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `hdefs`
2. `gru`, `cod`, `des`, `bold`, `col_1`, `col_2`, `col_3`, `col_4`, `col_5`, `col_6`

### Observaciones del análisis

- CTE: `a`, `b`, `c`, `d`
- Temporales: `#descs`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
