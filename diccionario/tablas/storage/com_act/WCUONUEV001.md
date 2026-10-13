# storage.com_act.WCUONUEV001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 10 columna(s) usadas · 1 procedimiento(s) · tabla con 10 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WCUONUEV001.sql](../../../../sql/03-tablas/storage/com_act/WCUONUEV001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODMOD` | smallint not null | 🗄️ motor | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |
| `HDIAATR` | smallint | ✅ confirmada | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |
| `HINDCAR` | varchar(20) | 🗄️ motor | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |
| `HSUBTIP` | int | 🗄️ motor | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |
| `HTIPOPE` | smallint | 🗄️ motor | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |
| `SCODSEC` | varchar(10) | 🗄️ motor | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |
| `SFECPRO` | date not null | 🗄️ motor | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |
| `SNUMOPEZCNUE` | int | 🗄️ motor | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |
| `SSALZCMNNUE` | numeric(38,2) | 🗄️ motor | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |
| `SSUCCLI` | int | 🗄️ motor | [GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GDCEROCN004](../../../procedimientos/mod_rep/com/GDCEROCN004.md) | lee | `REP_CERCUOT_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HDIAATR`: _por documentar_
