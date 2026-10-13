# storage.com_act.HBPDATOS001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 5 columna(s) usadas · 2 procedimiento(s) · tabla con 5 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/HBPDATOS001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/HBPDATOS001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCINDI` | varchar(12) | 🗄️ motor | [GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md) | — |
| `HCODSEC` | varchar(20) | ✅ confirmada | [GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md) | — |
| `hfecpro` | date | ✅ confirmada | [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md), [GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md) | — |
| `HRATIO` | numeric(17,2) | 🗄️ motor | [GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md) | — |
| `HTIPO` | varchar(50) | 🗄️ motor | [GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md) | lee | `P_Datos_01` |
| [mod_rep.com.GRESPDATOS02](../../../procedimientos/mod_rep/com/GRESPDATOS02.md) | lee | `P_Datos_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODSEC`: _por documentar_
- `hfecpro`: _por documentar_
