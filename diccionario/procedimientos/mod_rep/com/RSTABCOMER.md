# mod_rep.com.RSTABCOMER

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/mod_rep/com/RSTABCOMER.sql](../../../../procedimientos/mod_rep/com/RSTABCOMER.sql) |
| Extracción | [sql/01-extraccion/mod_rep/com/RSTABCOMER.sql](../../../../sql/01-extraccion/mod_rep/com/RSTABCOMER.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/mod_rep/com/RSTABCOMER.sql](../../../../sql/05-por-procedimiento/mod_rep/com/RSTABCOMER.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `RS_TAB_COM_01` | TABLERO DIGITAL COMERCIAL | `tip_cod`, `cod_rel`, `fec` | reportes<br>reportes / actividad-diaria / Tablero Digital<br>reportes / actividad-mensual |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@fec` | date | — |  | `fec` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `hfecpro`≈ | estatico + motor |
| [storage.com.VDMCOM01](../../../tablas/storage/com/VDMCOM01.md) | lee | `HCODVAR`≈, `hfecpro`≈ | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `storage.util.FVECFEC01` (función) | — | no |
| `piv.GPIVLEV01` | @tip_cod, @cod_rel, @jer output | no |
| `piv.GPIVRES01` | @variables = @tvars, @filters = @tfil, @rows = @jer, @columns = '"vars","fec"', @config = @tconf | no |

### Columnas que devuelve

1. `@head`
2. `*`, `cumplUsa`, `semCumpUsa`, `cumplUsaCar`, `semCumpUsaCart`, `htipcod`

### Observaciones del análisis

- Temporales: `#FECS`, `#R`, `#R_M`

### Otros objetos que referencia

Según el motor; no son tablas: funciones, SP, sinónimos, tipos de tabla o alias que SQL Server no resolvió.

- `mod_rep.dbo.a`
- `mod_rep.piv.TPIVCONF` (tipo de tabla)
- `mod_rep.piv.TPIVFIL` (tipo de tabla)
- `mod_rep.piv.TPIVVAR` (tipo de tabla)

### Validación con el motor

Fuente: `fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
