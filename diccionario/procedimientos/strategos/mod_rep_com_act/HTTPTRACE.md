# strategos.mod_rep_com_act.HTTPTRACE

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

| Campo | Valor |
|---|---|
| Base · esquema | `strategos` · `mod_rep_com_act` |
| Estado | ✅ validado |
| Cuerpo | [procedimientos/strategos/mod_rep_com_act/HTTPTRACE.sql](../../../../procedimientos/strategos/mod_rep_com_act/HTTPTRACE.sql) |
| Extracción | [sql/01-extraccion/strategos/mod_rep_com_act/HTTPTRACE.sql](../../../../sql/01-extraccion/strategos/mod_rep_com_act/HTTPTRACE.sql) |
| Consultar sus tablas | [sql/05-por-procedimiento/strategos/mod_rep_com_act/HTTPTRACE.sql](../../../../sql/05-por-procedimiento/strategos/mod_rep_com_act/HTTPTRACE.sql) |
| Consumido por el front MIS | no (según la última traza) |

### Reportes que lo ejecutan (1)

| RCODREP | Descripción | Parámetros enviados (en orden) | Pantalla del front |
|---|---|---|---|
| `HTTPTRACE_01` | Servicio Reporte de Uso | `tip_cod`, `cod_rel` | — |

### Firma

Sin parámetros.

### Tablas y columnas (1)

| Tabla | Operación | Columnas usadas | Fuente |
|---|---|---|---|
| [strategos.sys_met.HTTPTRACE](../../../tablas/strategos/sys_met/HTTPTRACE.md) | lee | `request` | estatico + motor |

`≈` columna inferida: sin calificar, en una consulta con una sola tabla de origen. Confirmar con el motor.

### Columnas que devuelve

`pagina`, `numVisi`

### Validación con el motor

Fuente: `fuente/dependencias/strategos.csv`.
<!-- generado:fin -->

## Propósito

_Por documentar: qué calcula, para quién y a qué fecha de corte._

## Reglas de negocio

_Por documentar: filtros fijos, exclusiones, tramos, redondeos._

## Notas del analista

_Trampas, dudas abiertas y a quién se consultó._
