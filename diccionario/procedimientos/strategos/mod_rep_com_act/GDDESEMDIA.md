# strategos.mod_rep_com_act.GDDESEMDIA

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `strategos` · `mod_rep_com_act` |
| Estado | ✅ validado |
| Cuerpo | [extraccion/procedimientos/strategos/mod_rep_com_act/GDDESEMDIA.sql](../../../../extraccion/procedimientos/strategos/mod_rep_com_act/GDDESEMDIA.sql) |
| Extracción | [extraccion/sql/01-extraccion/strategos/mod_rep_com_act/GDDESEMDIA.sql](../../../../extraccion/sql/01-extraccion/strategos/mod_rep_com_act/GDDESEMDIA.sql) |
| Consultar sus tablas | [extraccion/sql/05-por-procedimiento/strategos/mod_rep_com_act/GDDESEMDIA.sql](../../../../extraccion/sql/05-por-procedimiento/strategos/mod_rep_com_act/GDDESEMDIA.sql) |
| Consumido por el front MIS | sí |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `DesemDiario_01` | Desembolsos Diarios | `tip_cod`, `cod_rel` | reportes / actividad-diaria / Cartera |

### Firma

| # | Parámetro | Tipo | Por defecto | Salida | En reportes.json |
|---:|---|---|---|---|---|
| 1 | `@tipcod` | int | — |  | `tip_cod` |
| 2 | `@codrel` | varchar(20) | — |  | `cod_rel` |

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [storage.com_act.SDAF001](../../../tablas/storage/com_act/SDAF001.md) | lee | `SFECPRO` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Procedimientos y funciones invocados

| Objeto | Argumentos | En el catálogo |
|---|---|---|
| `mod_rep.com.RSRDFCA020` | @tipcod, @codrel, @fec | no |

### Columnas que devuelve

No se detectó un SELECT final que devuelva filas.

### Validación con el motor

Fuente: `extraccion/fuente/dependencias/strategos.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
