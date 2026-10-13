# mod_rep.com.RSMONEFER03

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSMONEFER03.sql](../../../../extraccion/procedimientos/mod_rep/com/RSMONEFER03.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSMONEFER03.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSMONEFER03.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSMONEFER03.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSMONEFER03.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_MON_EFECREASIG_03` | Efectividades Reasignados fechas | `tip_cod`, `cod_rel`, `fec`, `imp` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(10) | — |  | `fec` |
| 4 | `@imp` | smallint | 1 |  | `imp` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WCRE001](../../../tablas/storage/com_act/WCRE001.md) | lee | `hcodrel`≈, `HDESPROD`, `HEREDADO`, `HFECPRO`, `HSALDETMN`, `HSALINIMN`, `HSALMAN01MN`≈, `HSALRECMN`≈, `htipcod`≈, `HTRAM`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.com.FCMGCAB` (función) | — | no |
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

1. `@headers`
2. `desc`, `ord`, `style`, `SINI1_T1`, `SINI2_T1`, `DET1_T1`, `DET2_T1`, `EFEC1_T1`, `EFEC2_T1`, `SINI1_T2`, `SINI2_T2`, `DET1_T2`, `DET2_T2`, `EFEC1_T2`, `EFEC2_T2`, `SINI1_T3`, `SINI2_T3`, `DET1_T3`, `DET2_T3`, `EFEC1_T3`, `EFEC2_T3`, `SINI1_T4`, `SINI2_T4`, `DET1_T4`, `DET2_T4`, `EFEC1_T4`, `EFEC2_T4`

### Observaciones del análisis

- Temporales: `#fechas`, `#tabla`, `#tram1`, `#tram2`, `#tram3`, `#tram4`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
