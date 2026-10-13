# mod_rep.com.GCOSEMAF002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GCOSEMAF002.sql](../../../../procedimientos/mod_rep/com/GCOSEMAF002.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GCOSEMAF002.sql](../../../../sql/01-extraccion/mod_rep/com/GCOSEMAF002.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GCOSEMAF002.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GCOSEMAF002.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `COSESEMAFORO_01` | SEMAFORO DE COSECHAS | `tip_cod`, `cod_rel`, `prod`, `subpro`, `madu`, `op` | reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(250) | — |  | `cod_rel` |
| 3 | `@prod` | varchar(250) | — |  | `prod` |
| 4 | `@subpro` | varchar(250) | — |  | `subpro` |
| 5 | `@madu` | varchar(20) | — |  | `madu` |
| 6 | `@op` | varchar(250) | — |  | `op` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.RETP001](../../../tablas/storage/com_act/RETP001.md) | lee | `RCODMOD`, `RCODPROD`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP002](../../../tablas/storage/com_act/RETP002.md) | lee | `RCODMOD`, `RCODPROD`, `RSUBTIP`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP003](../../../tablas/storage/com_act/RETP003.md) | lee | `RCODPROD`, `RDESPROD` | estatico + motor |
| [storage.com_act.RETP009](../../../tablas/storage/com_act/RETP009.md) | lee | `RCODMOD`≈, `RDESSUBPROD`≈, `RTIPOPE`≈ | estatico + motor |
| [storage.com_act.SDAS013](../../../tablas/storage/com_act/SDAS013.md) | lee | `SCODAGR`, `SCODMOD`, `SCODSEC`, `SCOSECHA`, `sfecbas`, `SFECPRO`, `SNUMOPEBAS`, `SNUMOPEMORH`, `SSALCAPBAS`, `SSALCAPMORH`, `SSUBTIP`, `STIPOPE` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`≈, `RFEC`≈, `RFECTXT`≈ | estatico + motor |

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
2. `result`
3. `result`
4. `result`

### Observaciones del análisis

- CTE: `datos`, `fechas`
- Temporales: `#Datos`, `#Datos1`, `#Datos2`, `#Datos3`, `#FCROWS`, `#FCROWS1`, `#FCROWS2`, `#FCROWS3`, `#FCROWSJSON`, `#FCROWSJSON1`, `#FCROWSJSON2`, `#FCROWSJSON3`, `#FinJSON`, `#FinJSON1`, `#FinJSON2`, `#FinJSON3`, `#SubProducto`, `#gg`, `#gg1`, `#gg2`, `#gg3`, `#temp`, `#temp1`, `#temp1FC`, `#temp1FC1`, `#temp1FC2`, `#temp1FC3`, `#temp2`, `#temp3`, `#tempFC`, `#tempFC1`, `#tempFC2`, `#tempFC3`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `RDESTER` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013?)
- ⚠️ Columna sin resolver `RDESCOR` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013?)
- ⚠️ Columna sin resolver `RDESGRU` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013?)
- ⚠️ Columna sin resolver `RDESADM` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013?)
- ⚠️ Columna sin resolver `RDESPROD` (¿storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003 o storage.com_act.SDAS013?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
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
