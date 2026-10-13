# mod_rep.rep.RREGVAR01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `mod_rep` · esquema `rep` · 6 columna(s) usadas · 1 procedimiento(s) · tabla con 10 columna(s) en la base

Consultas listas: [sql/03-tablas/mod_rep/rep/RREGVAR01.sql](../../../../sql/03-tablas/mod_rep/rep/RREGVAR01.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `RALIVAR` | varchar(100) | ✅ confirmada | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `RAMBGRU` | varchar(500) | ✅ confirmada | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `RCODVAR` | smallint not null | ✅ confirmada | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `RDESVAR` | varchar(100) | ✅ confirmada | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `RFORV01` | varchar(15) | 🎯 exacta | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `RFORV02` | varchar(15) | 🎯 exacta | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.rep.GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | lee | `GSREVA01`, `GSREVA101`, `GSREVA201` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `RALIVAR`: _por documentar_
- `RAMBGRU`: _por documentar_
- `RCODVAR`: _por documentar_
- `RFORV01`: _por documentar_
- `RFORV02`: _por documentar_
