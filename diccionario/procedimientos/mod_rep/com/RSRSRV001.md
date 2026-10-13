# mod_rep.com.RSRSRV001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSRSRV001.sql](../../../../extraccion/procedimientos/mod_rep/com/RSRSRV001.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSRSRV001.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSRSRV001.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSRSRV001.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSRSRV001.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RECSERV_PAS_01` | Recaudos Pasivos | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Captaciones |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_pas.WJAS005](../../../tablas/storage/com_pas/WJAS005.md) | lee | `CANAL`, `CANT_TX_ANIO_ACT`, `CANT_TX_MES_ACT`, `CANT_TX_MES_ANT`, `CANT_TX_ULT_DIA`, `EMPRESA`, `HCODREL`, `HFECPRO`, `HTIPCOD`, `ING_X_MONREC_ANIO_ACT`, `ING_X_MONREC_MES_ACT`, `ING_X_MONREC_MES_ANT`, `ING_X_MONREC_ULT_DIA`, `MON_TX_ANIO_ACT`, `MON_TX_MES_ACT`, `MON_TX_MES_ANT`, `MON_TX_ULT_DIA`, `SERVICIO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`style`, `EMPRESA`, `SERVICIO`, `CANT_TX_MES_ANT`, `MON_TX_MES_ANT`, `CANT_TX_MES_ACT`, `MON_TX_MES_ACT`, `CANT_TX_ULT_DIA`, `MON_TX_ULT_DIA`, `CANT_TX_ANIO_ACT`, `MON_TX_ANIO_ACT`

### Observaciones del análisis

- Temporales: `#BT`, `#app`, `#bt`, `#cuadro`

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
