# mod_rep.com.GDCLIOPE01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/GDCLIOPE01.sql](../../../../procedimientos/mod_rep/com/GDCLIOPE01.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/GDCLIOPE01.sql](../../../../sql/01-extraccion/mod_rep/com/GDCLIOPE01.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/GDCLIOPE01.sql](../../../../sql/05-por-procedimiento/mod_rep/com/GDCLIOPE01.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `Clientes_Ope_01` | Clientes y Operaciones | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Clientes |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (12)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [mod_rep.dbo.a](../../../tablas/mod_rep/dbo/a.md) | — | — | motor |
| [mod_rep.piv.TPIVCONF](../../../tablas/mod_rep/piv/TPIVCONF.md) | — | — | motor |
| [mod_rep.piv.TPIVFIL](../../../tablas/mod_rep/piv/TPIVFIL.md) | — | — | motor |
| [mod_rep.piv.TPIVVAR](../../../tablas/mod_rep/piv/TPIVVAR.md) | — | — | motor |
| [mod_rep.rep.FFTHCOLDEF](../../../tablas/mod_rep/rep/FFTHCOLDEF.md) | — | — | motor |
| [mod_rep.rep.TTHCOLDEF](../../../tablas/mod_rep/rep/TTHCOLDEF.md) | — | — | motor |
| [mod_rep.util.FFMTVAR](../../../tablas/mod_rep/util/FFMTVAR.md) | — | — | motor |
| [mod_rep.util.FSEMVAR](../../../tablas/mod_rep/util/FSEMVAR.md) | — | — | motor |
| [storage.com_act.WACLI001](../../../tablas/storage/com_act/WACLI001.md) | lee | `hfecpro` | estatico + motor |
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `hfecpro`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`≈, `hfecpro`≈ | estatico + motor |
| [storage.ref.RCALEN001](../../../tablas/storage/ref/RCALEN001.md) | lee | `RDIAFER`, `RFEC`, `RFECTXT` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jerar, output | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jerar, @columns, =, '"vars"', @config, =, @tconf | no |
| `piv.GPIVRES01` | @variables, =, @tvars, @filters, =, @tfil, @rows, =, @jerar, @columns, =, '"vars"', @config, =, @tconf | no |

### Columnas que devuelve

1. `result`
2. `fila`, `cod_fc`, `cod_cter`, `style`, `descripcion`, `stock_cli`, `var_cli`, `ope_desem`, `meta_ope_desem`, `meta_var_cli`, `sem_var_cli`, `dist_meta_var_cli`, `sem_ope_desem`, `dist_meta_ope_desem`

### Observaciones del análisis

- Temporales: `#DES`, `#DESAN`, `#Des`, `#Result000`

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
