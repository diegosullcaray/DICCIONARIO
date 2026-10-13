# mod_rep.com.GPRECOSCUAD001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GPRECOSCUAD001.sql](../../../../procedimientos/mod_rep/com/GPRECOSCUAD001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GPRECOSCUAD001.sql](../../../../sql/01-extraccion/mod_rep/com/GPRECOSCUAD001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GPRECOSCUAD001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GPRECOSCUAD001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PRECOSECUADRO_03` | Cuadro Pre Cosechas | `tip_cod`, `cod_rel`, `fec`, `prod`, `subpro` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(50) | — |  | `fec` |
| 4 | `@prod` | varchar(250) | — |  | `prod` |
| 5 | `@subpro` | varchar(250) | — |  | `subpro` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.RETP001](../../../tablas/storage/com_act/RETP001.md) | lee | `RCODMOD`, `RCODPROD`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP002](../../../tablas/storage/com_act/RETP002.md) | lee | `RCODMOD`, `RCODPROD`, `RSUBTIP`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP003](../../../tablas/storage/com_act/RETP003.md) | lee | `RCODPROD`, `RDESPROD` | estatico + motor |
| [storage.com_act.RETP009](../../../tablas/storage/com_act/RETP009.md) | lee | `RCODMOD`, `RDESSUBPROD`, `RTIPOPE` | estatico + motor |
| [storage.com_act.SDAS014](../../../tablas/storage/com_act/SDAS014.md) | lee | `SCODAGR`, `SCODMOD`, `SCODSEC`, `sfecbas`, `SNUMOPEBAS`, `SSALCAPBAS`, `SSUBTIP`, `STIPOPE` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.ref.FJERCOR01_` (función) | — | no |
| `storage.ref.FJERCOR01_` (función) | — | no |
| `storage.ref.FJERCOR01_` (función) | — | no |
| `storage.ref.FJERCOR01_` (función) | — | no |
| `storage.ref.FJERCOR01_` (función) | — | no |
| `storage.ref.FJERCOR01_` (función) | — | no |
| `storage.ref.FJERCOR01_` (función) | — | no |
| `storage.ref.FJERCOR01_` (función) | — | no |

### Columnas que devuelve

1. `result`
2. `*`
3. `*`
4. `*`
5. `*`

### Observaciones del análisis

- CTE: `datos`, `fechas`
- Temporales: `#SubProducto`
- ⚠️ Columna sin resolver `RDESTER` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014?)
- ⚠️ Columna sin resolver `RDESCOR` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014?)
- ⚠️ Columna sin resolver `RDESGRU` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014?)
- ⚠️ Columna sin resolver `RDESADM` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014?)
- ⚠️ Columna sin resolver `RDESPROD` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS014?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.rep.TTHCOLDEF` (tipo de tabla)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
