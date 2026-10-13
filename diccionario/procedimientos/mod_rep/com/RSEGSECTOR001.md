# mod_rep.com.RSEGSECTOR001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSEGSECTOR001.sql](../../../../procedimientos/mod_rep/com/RSEGSECTOR001.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSEGSECTOR001.sql](../../../../sql/01-extraccion/mod_rep/com/RSEGSECTOR001.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSEGSECTOR001.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSEGSECTOR001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `Sec_ciiu_01` | Seguimiento de Sectores | `tip_cod`, `cod_rel`, `fec`, `grup` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(250) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |
| 4 | `@grup` | varchar(50) | — |  | `grup` |

### Tablas y columnas (14)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [mod_rep.util.FFMTVAR](../../../tablas/mod_rep/util/FFMTVAR.md) | — | — | motor |
| [storage.com_act.WACIIU0012](../../../tablas/storage/com_act/WACIIU0012.md) | lee | `HFECPRO`≈ | estatico + motor |
| [storage.com_act.WACIIU0013](../../../tablas/storage/com_act/WACIIU0013.md) | lee | `HCODSEC`, `HCUOVEN`, `hfecpro`, `hfecproc`, `HSALVENMN`, `MontoDesembolsados`, `MontoDesembolsadosNuevos`, `MontoDesembolsadosRecurrentes`, `NDesembolsados`, `NDesembolsadosNuevos`, `NDesembolsadosRecurrentes`, `ord`, `RDESGRUP`, `SalCapi` | estatico + motor |
| [STORAGE.com_act.WJAS003](../../../tablas/STORAGE/com_act/WJAS003.md) | lee | `HCODREL`, `HRATMORR`, `HTIPCOD`, `ORD`, `RDESGRUP` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `hcodbt`, `HNUMDOC` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RANI`, `RANIBIS`, `RCIEBT`, `RCIEMES`, `RDIA`, `RDIAANI`, `RDIAFER`, `RDIASEM`, `RFEC`, `RFECTXT`, `RFINSEM`, `RFLAG01`, `RID`, `RMES`, `RMESNOM`, `RNOMDIASEM`, `RSEM` | estatico + motor |
| [storage.ref.ResGridCiiu2](../../../tablas/storage/ref/ResGridCiiu2.md) | lee | `codvars`, `ROWI`, `style`, `vars` | estatico + motor |
| [storage.ref.WJERCOR01](../../../tablas/storage/ref/WJERCOR01.md) | lee | `RCODSEC`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |

### Columnas que devuelve

1. `result`
2. `ROWI`, `style`, `vars`, `V1`, `Sem1`, `V2`, `Sem2`, `V3`, `Sem3`, `V4`, `Sem4`

### Observaciones del análisis

- CTE: `a`, `b`, `c`, `cuotavencidasector`, `fec`, `montodesembolsados`, `montodesembolsadosnuevos`, `montodesembolsadosrecurrentes`, `ndesembolsados`, `ndesembolsadosnuevos`, `ndesembolsadosrecurrentes`, `part`, `ratmora`, `salcap`, `salcapsector`, `saldovencidosector`
- Temporales: `#Fec`, `#PreResults`, `#Resultpre1`, `#Resultpre2`, `#SEM`, `#SalCap`, `#SalCapS`, `#subCab`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `ORD` (¿storage.com_act.WACIIU0013 o storage.ref.WJERCOR01?)
- ⚠️ Columna sin resolver `codvarsFormat` (¿storage.ref.ResGridCiiu2?)
- ⚠️ Columna sin resolver `Sem1` (¿storage.ref.ResGridCiiu2?)
- ⚠️ Columna sin resolver `Sem2` (¿storage.ref.ResGridCiiu2?)
- ⚠️ Columna sin resolver `Sem3` (¿storage.ref.ResGridCiiu2?)
- ⚠️ Columna sin resolver `Sem4` (¿storage.ref.ResGridCiiu2?)
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
