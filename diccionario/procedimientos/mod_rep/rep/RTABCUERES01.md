# mod_rep.rep.RTABCUERES01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `rep` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/rep/RTABCUERES01.sql](../../../../extraccion/procedimientos/mod_rep/rep/RTABCUERES01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/rep/RTABCUERES01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/rep/RTABCUERES01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/rep/RTABCUERES01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/rep/RTABCUERES01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `TAB_CUE_RES_01` | Cuenta de Resultados | `fecha`, `tip_cod`, `cod_rel` | reportes / actividad-mensual<br>reportes / actividad-mensual / Rentabilidad |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@fecha` | varchar(8) | 'NOW' |  | `fecha` |
| 2 | `@tip_cod` | int | — |  | `tip_cod` |
| 3 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.REVARPYG](../../../tablas/mod_rep/dbo/REVARPYG.md) | lee | `codigo`, `descripcion`, `pos`, `style` | estatico + motor |
| [mod_rep.dbo.WREPPYG001](../../../tablas/mod_rep/dbo/WREPPYG001.md) | lee | `WACUMAA`, `WACUMACT`, `WACUMT1`, `WACUMT2`, `WACUMT3`, `WACUMT4`, `WCODMOD`, `WCODREL`, `WCODUNI`, `WCODVAR`, `WFECPRO`, `WSUBTIP`, `WTIPOPE`, `WVALAA`, `WVALACT`, `WVALANT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

1. `dummy`
2. `style`, `cuenta_codigo`, `cuenta_nombre`, `orden`, `periodo_anio_anterior`, `periodo_anterior`, `periodo_actual`, `variacion_periodo_anterior`, `acumulado_anio_anterior`, `acumulado_actual`, `variacion_acumulado`, `variacion_acumulado_pct`, `trimestre_1`, `trimestre_2`, `trimestre_3`, `trimestre_4`, `total_anio`

### Observaciones del análisis

- Temporales: `#pyg`
- ⚠️ Columna sin resolver `WACUMT1` (¿mod_rep.dbo.REVARPYG?)
- ⚠️ Columna sin resolver `WACUMT2` (¿mod_rep.dbo.REVARPYG?)
- ⚠️ Columna sin resolver `WACUMT3` (¿mod_rep.dbo.REVARPYG?)
- ⚠️ Columna sin resolver `WACUMT4` (¿mod_rep.dbo.REVARPYG?)

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
