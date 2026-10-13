# mod_rep.com.RGRAFGESTCOM05

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RGRAFGESTCOM05.sql](../../../../extraccion/procedimientos/mod_rep/com/RGRAFGESTCOM05.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RGRAFGESTCOM05.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RGRAFGESTCOM05.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RGRAFGESTCOM05.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RGRAFGESTCOM05.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRAF_GEST_COM_05` | Graf Gestión Comercial | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@fecha` | DATE | — |  | `fecha` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `hcodrel`, `hfecpro`, `hnumcli`, `htipcod` | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `hcodrel`, `hcodvar`, `hfecpro`, `htipcod`, `HVALVAR` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RCIEBT`, `RDIAFER`, `RFEC` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `rfecpro`, `rindfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`categories`, `PATH`, `WITHOUT_ARRAY_WRAPPER`

### Observaciones del análisis

- CTE: `cte_a`, `cte_a_`, `cte_b`, `cte_bb`
- Temporales: `#Fechas`, `#jerar`, `#r`, `#wjas001`
- ⚠️ Columna sin resolver `hfecpro` (¿storage.com_act.WJAS001?)
- ⚠️ Columna sin resolver `hnumcli` (¿storage.com_act.WJAS001?)

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
