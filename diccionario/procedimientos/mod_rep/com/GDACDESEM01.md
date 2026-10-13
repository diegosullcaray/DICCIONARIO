# mod_rep.com.GDACDESEM01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GDACDESEM01.sql](../../../../procedimientos/mod_rep/com/GDACDESEM01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GDACDESEM01.sql](../../../../sql/01-extraccion/mod_rep/com/GDACDESEM01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GDACDESEM01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GDACDESEM01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `DESEMBOLSOS_01` | Desembolsos SIN FAE NI REACTIVA | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Comercial Ejecutivo |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (6)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [storage.com_act.SDAF002_SINFAEREACT](../../../tablas/storage/com_act/SDAF002_SINFAEREACT.md) | lee | `sfecpro`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`≈, `HFECPRO`≈, `HTIPCOD`≈, `HVALVAR`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jer, @columns, =, '"vars"', @config, =, @tconf | no |
| `rep.FTHEACOLS01` | 'DESEMBOLSOS_01' | no |

### Columnas que devuelve

`*`

### Observaciones del análisis

- CTE: `cte_act_ayer`, `cte_ant_antanual`, `cte_ant_mesant`, `cte_m`
- Temporales: `#ractAyer`, `#ractCierreAnteriorAnual`, `#ractCierreMes`, `#result`
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
