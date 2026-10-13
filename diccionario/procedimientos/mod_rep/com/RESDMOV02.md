# mod_rep.com.RESDMOV02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RESDMOV02.sql](../../../../procedimientos/mod_rep/com/RESDMOV02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RESDMOV02.sql](../../../../sql/01-extraccion/mod_rep/com/RESDMOV02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RESDMOV02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RESDMOV02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RESNMOVR_01` | Mov. Resumen Detalle Recuperaciones | `tip_cod`, `cod_rel` | reportes / actividad-diaria |
| `RESNMOV_02` | Mov. Resumen Detalle Analista | `tip_cod`, `cod_rel` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(8) | 'NOW' |  | — |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [mod_sys_admin.dbo.VUSEPROF02](../../../tablas/mod_sys_admin/dbo/VUSEPROF02.md) | lee | `SCODPROFN`, `SCODUSE` | estatico + motor |
| [storage.com_act.HBMOV002](../../../tablas/storage/com_act/HBMOV002.md) | lee | `HCARGO`, `HCARTERA`, `HCODSEC`, `HCOMETARIO`, `HCORREDOR`, `HDESCTO`, `HDESPL_VALIDOG`, `HDISTPROMG`, `HFECPRO`, `HMONTOMOV`, `HNOMBRE`, `HPAGOFINAL`, `HPLANDATOS`, `HRECLAMO`, `HSUCURSAL`, `HTERRITORIO`, `HTOT_DESPLAZAMIENTO` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HMAILPER`, `HNUMDOC` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `HFECPRO`, `HCODSEC`, `HNOMBRE`, `HCARGO`, `HTERRITORIO`, `HCORREDOR`, `HTOT_DESPLAZAMIENTO`, `HDESPL_VALIDOG`, `HDISTPROMG`, `HMONTOMOV`, `HPLANDATOS`, `HRECLAMO`, `HDESCTO`, `HPAGOFINAL`, `HCOMETARIO`, `HCARTERA`
2. `HFECPRO`, `HCODSEC`, `HNOMBRE`, `HCARGO`, `HTERRITORIO`, `HCORREDOR`, `HTOT_DESPLAZAMIENTO`, `HDESPL_VALIDOG`, `HDISTPROMG`, `HMONTOMOV`, `HPLANDATOS`, `HRECLAMO`, `HDESCTO`, `HPAGOFINAL`, `HCOMETARIO`, `HCARTERA`
3. `*`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
