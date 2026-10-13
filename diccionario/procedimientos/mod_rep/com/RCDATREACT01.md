# mod_rep.com.RCDATREACT01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `mod_rep` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/mod_rep/com/RCDATREACT01.sql](../../../../extraccion/procedimientos/mod_rep/com/RCDATREACT01.sql) |
| Extracción | [extraccion/sql/01-extraccion/mod_rep/com/RCDATREACT01.sql](../../../../extraccion/sql/01-extraccion/mod_rep/com/RCDATREACT01.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/mod_rep/com/RCDATREACT01.sql](../../../../extraccion/sql/05-por-procedimiento/mod_rep/com/RCDATREACT01.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `LSRC_DATA_REACT_01` | Data de Reactivados | `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@fecha` | date | — |  | `fecha` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.HBCI001](../../../tablas/storage/com_act/HBCI001.md) | lee | `HCODSEC`, `HCTACLI`, `HFECPRO`, `HFLAGES`, `HSUCCLI` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.rep.FTHEACOLS01` | 'LSRC_DATA_REACT_01' | no |

### Columnas que devuelve

`fecha`, `cod_oficina`, `sectorista_bt`, `cta_cliente`, `flag_gestion`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/mod_rep.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
