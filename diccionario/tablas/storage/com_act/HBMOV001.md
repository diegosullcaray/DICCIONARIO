# STORAGE.com_act.HBMOV001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `STORAGE` · esquema `com_act` · 21 columna(s) usadas · 2 procedimiento(s) · tabla con 19 columna(s) en la base

Consultas listas: [sql/03-tablas/STORAGE/com_act/HBMOV001.sql](../../../../sql/03-tablas/STORAGE/com_act/HBMOV001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `GRUPo` | varchar(250) | 🗄️ motor | [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HCODGEOR` | varchar(250) | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HCODSEC` | varchar(10) | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HCTACLI` | int | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HDESCLI` | varchar(250) | 🗄️ motor | [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HDESPER` | varchar(250) | 🗄️ motor | [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HDISTR` | varchar(250) | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HDISTR_LLEGADA` | varchar(250) | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HDISTREC` | varchar(50) | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HDPT` | varchar(250) | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HFECEMI` | date | 🗄️ motor | [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `hfecpro` | date | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HFECREG` | date | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HMONTDIS` | float | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HMOTIV` | varchar(500) | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HNUMDOC` | int | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HNUMDOCCLI` | varchar(250) | 🗄️ motor | [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HNUMREG` | int | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `HPROV` | varchar(250) | ✅ confirmada | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `mm` | ⚠️ no existe | ≈ inferida | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |
| `yyyy` | ⚠️ no existe | ≈ inferida | [GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md), [GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLIMOVO01](../../../procedimientos/mod_rep/com/GLIMOVO01.md) | lee | `PLANMOV_01`, `PLANMOVPERFIL_01` |
| [mod_rep.com.GLIMOVRO01](../../../procedimientos/mod_rep/com/GLIMOVRO01.md) | lee | `PLANMOVR_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODGEOR`: _por documentar_
- `HCODSEC`: _por documentar_
- `HCTACLI`: _por documentar_
- `HDISTR`: _por documentar_
- `HDISTR_LLEGADA`: _por documentar_
- `HDISTREC`: _por documentar_
- `HDPT`: _por documentar_
- `hfecpro`: _por documentar_
- `HFECREG`: _por documentar_
- `HMONTDIS`: _por documentar_
- `HMOTIV`: _por documentar_
- `HNUMDOC`: _por documentar_
- `HNUMREG`: _por documentar_
- `HPROV`: _por documentar_
- `mm`: _por documentar_
- `yyyy`: _por documentar_
