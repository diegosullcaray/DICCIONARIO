# mod_rep.com.RSRDFCA007

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSRDFCA007.sql](../../../../procedimientos/mod_rep/com/RSRDFCA007.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSRDFCA007.sql](../../../../sql/01-extraccion/mod_rep/com/RSRDFCA007.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSRDFCA007.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSRDFCA007.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `Clientes_01` | Clientes | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Comercial Ejecutivo |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(10) | — |  | `cod_rel` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`≈, `HFECPRO`≈, `HTIPCOD`≈, `HVALVAR`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars"', @config = @tconf | no |

### Columnas que devuelve

1. `result`
2. `fila`, `cod_n1`, `cod_n2`, `style`, `descripcion`, `meta_cli_act`, `meta_var_cli_act`, `num_cli_act_MA`, `Var_Cli_act_Mes`, `Var_Cli_act_Anio`, `num_cli_nuev_MA`, `Var_Cli_nuev_Mes`, `Var_Cli_nuev_Anio`, `num_cli_ind_MA`, `Var_Cli_ind_Mes`, `Var_Cli_ind_Anio`, `num_cli_pdm_MA`, `Var_Cli_pdm_Mes`, `Var_Cli_pdm_Anio`

### Observaciones del análisis

- CTE: `cte_cli_antanual`, `cte_cli_ayer`, `cte_cli_mesant`, `cte_m`
- Temporales: `#CliAnual`, `#CliAyer`, `#CliMA`
- ⚠️ PIVOT/UNPIVOT presente: las columnas pivotadas no se resuelven.

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.rep.FFTHCOLDEF`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)
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
