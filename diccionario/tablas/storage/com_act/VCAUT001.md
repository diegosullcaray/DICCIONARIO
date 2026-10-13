# storage.com_act.VCAUT001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 5 columna(s) usadas · 1 procedimiento(s) · vista con 6 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/VCAUT001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/VCAUT001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODSEC` | varchar(10) | ✅ confirmada | [GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md) | — |
| `HCODUSAUT` | varchar(50) | ✅ confirmada | [GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md) | — |
| `HSALCAPMN` | numeric(38,2) | 🗄️ motor | [GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md) | — |
| `HSALVENMN` | numeric(38,2) | 🗄️ motor | [GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md) | lee | `GLISAUTRO_04` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODSEC`: _por documentar_
- `HCODUSAUT`: _por documentar_
- `HFECPRO`: _por documentar_
