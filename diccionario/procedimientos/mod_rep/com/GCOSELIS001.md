# mod_rep.com.GCOSELIS001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/GCOSELIS001.sql](../../../../extraccion/procedimientos/mod_rep/com/GCOSELIS001.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/GCOSELIS001.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/GCOSELIS001.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/GCOSELIS001.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/GCOSELIS001.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `COSELISTADO_02` | Listado Cosechas | `tip_cod`, `cod_rel`, `fec`, `prod`, `subpro`, `madu`, `pagen`, `nom` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(50) | — |  | `fec` |
| 4 | `@prod` | varchar(250) | — |  | `prod` |
| 5 | `@subpro` | varchar(250) | — |  | `subpro` |
| 6 | `@madu` | varchar(20) | — |  | `madu` |
| 7 | `@pagen` | int | 1 |  | `pagen` |
| 8 | `@nom` | VARCHAR(500) | — |  | `nom` |

### Tablas y columnas (8)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `HCODMON`, `HCODOPE`, `HCTACLI`, `HDCODSEC`, `HDESCLI`, `HDSUCCLI`, `HDTIPOPE`, `HFECMOR`, `HFECPRO`, `HINDCAR`, `HMONDES`, `HNUMDOC`, `HSALVENMN`, `HTIPCMB`, `HTIPDOC` | estatico + motor |
| [storage.com_act.RETP001](../../../tablas/storage/com_act/RETP001.md) | lee | `RCODMOD`, `RCODPROD`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP002](../../../tablas/storage/com_act/RETP002.md) | lee | `RCODMOD`, `RCODPROD`, `RSUBTIP`, `RTIPOPE` | estatico + motor |
| [storage.com_act.RETP003](../../../tablas/storage/com_act/RETP003.md) | lee | `RCODPROD`, `RDESPROD` | estatico + motor |
| [storage.com_act.SRCC001](../../../tablas/storage/com_act/SRCC001.md) | lee | `Ndoc_Ident`, `Nro_Empre`, `PCPP`, `PDef`, `PDud`, `PNor`, `PPer`, `Saldo` | estatico + motor |
| [storage.com_act.SRIESGO001](../../../tablas/storage/com_act/SRIESGO001.md) | lee | `cliente`, `NIVEL_RIESGO`, `NIVEL_SOB` | estatico + motor |
| [storage.com_act.WBCH001](../../../tablas/storage/com_act/WBCH001.md) | lee | `hcosecha`≈, `HFECBAS`≈, `HINDMORH` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `RFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.ref.FJERCOR01` (función) | — | no |

### Columnas que devuelve

1. `result`
2. `*`
3. `Total`

### Observaciones del análisis

- CTE: `cte_a`, `cte_base`, `datos`
- Temporales: `#F`
- ⚠️ Columna sin resolver `HTIPCMB` (¿storage.com_act.HCDA001 o storage.com_act.RETP001 o storage.com_act.RETP002 o storage.com_act.RETP003?)
- ⚠️ Columna sin resolver `HRANDES` (¿storage.com_act.SRCC001 o storage.com_act.SRIESGO001?)
- ⚠️ Columna sin resolver `RDESPROD` (¿storage.com_act.SRCC001 o storage.com_act.SRIESGO001?)

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
