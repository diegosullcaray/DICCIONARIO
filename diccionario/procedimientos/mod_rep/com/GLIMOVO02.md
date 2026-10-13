# mod_rep.com.GLIMOVO02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GLIMOVO02.sql](../../../../procedimientos/mod_rep/com/GLIMOVO02.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GLIMOVO02.sql](../../../../sql/01-extraccion/mod_rep/com/GLIMOVO02.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GLIMOVO02.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GLIMOVO02.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (2)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `PLANMOV_02` | Planilla Movilidad | `tip_cod`, `cod_rel`, `fec` | — |
| `PLANMOVPERFIL_02` | Planilla Movilidad Perfil | `tip_cod`, `cod_rel`, `fec` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (3)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HBMOV003](../../../tablas/storage/com_act/HBMOV003.md) | lee | `codigo_bt`, `filtro2`, `filtro3`, `filtro4`, `filtro5`, `filtro6`, `filtro7`, `HFECPRO` | estatico + motor |
| [storage.com_act.HBMOV004](../../../tablas/storage/com_act/HBMOV004.md) | lee | `CODIGO_BT`, `FLAG_PAGADOR`, `HFECPRO` | estatico + motor |
| [storage.gpr.VPPH001](../../../tablas/storage/gpr/VPPH001.md) | lee | `HCODBT`, `HNUMDOC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `result`
2. `grupo`, `descripcion`, `Calculados`
3. `HFECEMI`, `style_HFECEMI`, `Fecha`

### Observaciones del análisis

- Temporales: `#rangos`, `#resultados`

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
