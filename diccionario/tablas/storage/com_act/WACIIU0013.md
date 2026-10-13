# storage.com_act.WACIIU0013

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 14 columna(s) usadas · 1 procedimiento(s) · tabla con 15 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/WACIIU0013.sql](../../../../extraccion/sql/03-tablas/storage/com_act/WACIIU0013.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODSEC` | varchar(10) | ✅ confirmada | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `HCUOVEN` | int | 🗄️ motor | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `hfecpro` | varchar(10) not null | ✅ confirmada | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `hfecproc` | varchar(50) | ✅ confirmada | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `HSALVENMN` | numeric(38,2) | 🗄️ motor | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `MontoDesembolsados` | numeric(38,2) | 🗄️ motor | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `MontoDesembolsadosNuevos` | numeric(38,2) | 🗄️ motor | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `MontoDesembolsadosRecurrentes` | numeric(38,2) | 🗄️ motor | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `NDesembolsados` | int | 🗄️ motor | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `NDesembolsadosNuevos` | int | 🗄️ motor | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `NDesembolsadosRecurrentes` | int | 🗄️ motor | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `ord` | int | ✅ confirmada | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `RDESGRUP` | varchar(50) not null | ✅ confirmada | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `SalCapi` | numeric(38,2) | ✅ confirmada | [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | lee | `Sec_ciiu_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODSEC`: _por documentar_
- `hfecpro`: _por documentar_
- `hfecproc`: _por documentar_
- `ord`: _por documentar_
- `RDESGRUP`: _por documentar_
- `SalCapi`: _por documentar_
