# mod_rep.com.RSTABCOMER02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RSTABCOMER02.sql](../../../../extraccion/procedimientos/mod_rep/com/RSTABCOMER02.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RSTABCOMER02.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RSTABCOMER02.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RSTABCOMER02.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RSTABCOMER02.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `Tab_Dig_Com_A_01` | Tablero Digital Comercial Asesor | `usuariobt`, `Fecha` | — |
| `RS_TAB_COM_02` | TABLERO DIGITAL COMERCIAL DETALLE | `usuariobt`, `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@usuariobt` | varchar(250) | — |  | `usuariobt` |
| 2 | `@Fecha` | date | — |  | `Fecha` |

### Tablas y columnas (4)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HCDA001](../../../tablas/storage/com_act/HCDA001.md) | lee | `haseoper`, `HDESCLI`, `hfecpro`, `HNUMDOC`, `HTIPDOC` | estatico + motor |
| [storage.com_act.HTDA001](../../../tablas/storage/com_act/HTDA001.md) | lee | `HFEC`, `hfecpro`, `HNUMDOC`, `HTIPDOC` | estatico + motor |
| [storage.com_act.WAPPCLI001](../../../tablas/storage/com_act/WAPPCLI001.md) | lee | `hfecpro`≈, `HTIPNUMDOC`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `rfec` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `(expresión 1)`
2. `*`
3. `meta`, `carteraCount`, `enroladoCount`, `usabilidadCount`

### Observaciones del análisis

- CTE: `cte_a`, `cte_b`
- Temporales: `#CRED`, `#Enrolado_Activos`, `#Tb`, `#Usa_Cartera`, `#Usabilidad`, `#cred`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
