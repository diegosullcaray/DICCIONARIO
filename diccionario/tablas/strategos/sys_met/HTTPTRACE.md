# strategos.sys_met.HTTPTRACE

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `strategos` · esquema `sys_met` · 1 columna(s) usadas · 1 procedimiento(s) · tabla con 6 columna(s) en la base

Consultas listas: [sql/03-tablas/strategos/sys_met/HTTPTRACE.sql](../../../../sql/03-tablas/strategos/sys_met/HTTPTRACE.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `request` | varchar(max) | ✅ confirmada | [HTTPTRACE](../../../procedimientos/strategos/mod_rep_com_act/HTTPTRACE.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [strategos.mod_rep_com_act.HTTPTRACE](../../../procedimientos/strategos/mod_rep_com_act/HTTPTRACE.md) | lee | `HTTPTRACE_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `request`: _por documentar_
