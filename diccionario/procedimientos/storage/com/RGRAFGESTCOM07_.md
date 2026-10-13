# storage.com.RGRAFGESTCOM07_

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `storage` · `com` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/storage/com/RGRAFGESTCOM07_.sql](../../../../extraccion/procedimientos/storage/com/RGRAFGESTCOM07_.sql) |
| Extracción | [extraccion/sql/01-extraccion/storage/com/RGRAFGESTCOM07_.sql](../../../../extraccion/sql/01-extraccion/storage/com/RGRAFGESTCOM07_.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/storage/com/RGRAFGESTCOM07_.sql](../../../../extraccion/sql/05-por-procedimiento/storage/com/RGRAFGESTCOM07_.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `GRAF_GEST_COM_07_` | DEV Graf Gestión Comercial | `tip_cod`, `cod_rel`, `fecha` | — |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tip_cod` | int | — |  | `tip_cod` |
| 2 | `@cod_rel` | varchar(20) | — |  | `cod_rel` |
| 3 | `@Fecha` | varchar(10) | — |  | `fecha` |

### Tablas y columnas (2)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.WJAS001](../../../tablas/storage/com_act/WJAS001.md) | lee | `hcodrel`, `hfecpro`, `hnumcli`, `htipcod` | estatico + motor |
| [storage.ref.WJERCOR03](../../../tablas/storage/ref/WJERCOR03.md) | lee | `RCODCOR`, `RCODFC`, `RCODGRU`, `RCODTER`, `RCODUCO`, `RCODUNI`, `RDESCOR`, `RDESGRU`, `RDESTER`, `RDESUCO`, `RDESUNI`, `RFECPRO`, `RINDFEC` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`categories`, `PATH`, `WITHOUT_ARRAY_WRAPPER`

### Observaciones del análisis

- Temporales: `#DataFinal`, `#Jerarquia`

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/storage.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
