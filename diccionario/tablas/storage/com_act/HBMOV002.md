# storage.com_act.HBMOV002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 17 columna(s) usadas · 1 procedimiento(s) · tabla con 17 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/HBMOV002.sql](../../../../sql/03-tablas/storage/com_act/HBMOV002.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCARGO` | varchar(250) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HCARTERA` | numeric(17,2) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HCODSEC` | varchar(10) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HCOMETARIO` | varchar(300) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HCORREDOR` | varchar(250) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HDESCTO` | numeric(10,2) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HDESPL_VALIDOG` | smallint | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HDISTPROMG` | float | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HFECPRO` | date | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HMONTOMOV` | numeric(10,2) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HNOMBRE` | varchar(250) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HPAGOFINAL` | numeric(10,2) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HPLANDATOS` | numeric(10,2) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HRECLAMO` | numeric(10,2) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HSUCURSAL` | varchar(250) | 🗄️ motor | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HTERRITORIO` | varchar(250) | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |
| `HTOT_DESPLAZAMIENTO` | smallint | ✅ confirmada | [RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RESDMOV02](../../../procedimientos/mod_rep/com/RESDMOV02.md) | lee | `RESNMOVR_01`, `RESNMOV_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCARGO`: _por documentar_
- `HCARTERA`: _por documentar_
- `HCODSEC`: _por documentar_
- `HCOMETARIO`: _por documentar_
- `HCORREDOR`: _por documentar_
- `HDESCTO`: _por documentar_
- `HDESPL_VALIDOG`: _por documentar_
- `HDISTPROMG`: _por documentar_
- `HFECPRO`: _por documentar_
- `HMONTOMOV`: _por documentar_
- `HNOMBRE`: _por documentar_
- `HPAGOFINAL`: _por documentar_
- `HPLANDATOS`: _por documentar_
- `HRECLAMO`: _por documentar_
- `HTERRITORIO`: _por documentar_
- `HTOT_DESPLAZAMIENTO`: _por documentar_
