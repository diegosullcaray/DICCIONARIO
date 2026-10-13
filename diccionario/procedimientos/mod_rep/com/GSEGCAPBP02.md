# mod_rep.com.GSEGCAPBP02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GSEGCAPBP02.sql](../../../../procedimientos/mod_rep/com/GSEGCAPBP02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GSEGCAPBP02.sql](../../../../sql/01-extraccion/mod_rep/com/GSEGCAPBP02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GSEGCAPBP02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GSEGCAPBP02.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `CAP_SEGUI_BP_FC_01` | Gestión Red de Agencias | `tip_cod`, `cod_rel`, `fec` | — |
| `CAP_SEGUI_FC_BP_01` | Gestión Red de Agencias | `tip_cod`, `cod_rel`, `fec` | reportes / actividad-diaria / Captaciones |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | varchar(10) | — |  | `fec` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_pas.RETP001](../../../tablas/storage/com_pas/RETP001.md) | lee | `RDESCPROD02`≈ | estatico + motor |
| [storage.com_pas.SDPF007](../../../tablas/storage/com_pas/SDPF007.md) | lee | `*`, `sfecpro` | estatico + motor |
| [storage.com_pas.WJAS010](../../../tablas/storage/com_pas/WJAS010.md) | lee | `ord`≈ | estatico + motor |
| [storage.ref.REABP01](../../../tablas/storage/ref/REABP01.md) | lee | `RCODAGE` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |

### Columnas que devuelve

`*`, `TPPMES2`, `TPPMES1`, `VARMESTPP`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#PRE`, `#SMBP`, `#TPMESPRE`, `#TPPMES`, `#fec`
- ⚠️ SQL dinámico: hay tablas que el análisis no puede ver
- ⚠️ Columna sin resolver `rord` (¿storage.ref.REABP01?)
- ⚠️ Columna sin resolver `sfecpro` (¿storage.ref.REABP01?)
- ⚠️ Columna sin resolver `SINTMESSALMN` (¿storage.ref.REABP01?)
- ⚠️ Columna sin resolver `SSALMN` (¿storage.ref.REABP01?)

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
