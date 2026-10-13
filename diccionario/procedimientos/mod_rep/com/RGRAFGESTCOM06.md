# mod_rep.com.RGRAFGESTCOM06

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RGRAFGESTCOM06.sql](../../../../procedimientos/mod_rep/com/RGRAFGESTCOM06.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RGRAFGESTCOM06.sql](../../../../sql/01-extraccion/mod_rep/com/RGRAFGESTCOM06.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RGRAFGESTCOM06.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RGRAFGESTCOM06.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRAF_GEST_COM_06` | Graf Gestión Comercial | `tip_cod`, `cod_rel`, `fecha` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | varchar(5) | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(25) | — |  | `cod_rel` |
| 3 | `@fecha` | DATE | — |  | `fecha` |

### Tablas y columnas (5)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [storage.com_act.wjas001](../../../tablas/storage/com_act/WJAS001.md) | lee | `hcodrel`, `htipcod` | estatico + motor |
| [STORAGE.COM_ACT.WTIPCLI001](../../../tablas/STORAGE/COM_ACT/WTIPCLI001.md) | lee | `HCODREL`, `htipcod` | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/wjercor03.md) | lee | `RCODCOR`, `RCODGRU`, `RCODSEC`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESSEC`, `RDESTER`, `RDESUCO`, `RDESUNI`, `rfecpro`, `rindfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`categories`, `PATH`, `WITHOUT_ARRAY_WRAPPER`

### Observaciones del análisis

- CTE: `cte_a`
- Temporales: `#Fechas`, `#R1`, `#R2`, `#Resultado`, `#fechas`, `#jerar`
- ⚠️ Columna sin resolver `hfecpro` (¿STORAGE.COM_ACT.WTIPCLI001 o storage.com_act.wjas001?)
- ⚠️ Columna sin resolver `HNUMCLIN` (¿storage.com_act.wjas001?)
- ⚠️ Columna sin resolver `HNUMCLIINGR` (¿STORAGE.COM_ACT.WTIPCLI001?)
- ⚠️ Columna sin resolver `HNUMCLIVENC` (¿STORAGE.COM_ACT.WTIPCLI001?)
- ⚠️ Columna sin resolver `HNUMCLIPROG` (¿STORAGE.COM_ACT.WTIPCLI001?)
- ⚠️ Columna sin resolver `HNUMCLIANTI` (¿STORAGE.COM_ACT.WTIPCLI001?)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
