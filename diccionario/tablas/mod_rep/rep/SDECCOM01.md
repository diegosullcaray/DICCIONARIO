# mod_rep.rep.SDECCOM01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `mod_rep` · esquema `rep` · 3 columna(s) usadas · 2 procedimiento(s) · tabla con 9 columna(s) en la base

Consultas listas: [sql/03-tablas/mod_rep/rep/SDECCOM01.sql](../../../../sql/03-tablas/mod_rep/rep/SDECCOM01.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SCODSUB` | varchar(20) not null | ✅ confirmada | [GSELREP002](../../../procedimientos/mod_rep/com/GSELREP002.md), [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `SNOMSUB` | varchar(250) | ✅ confirmada | [GSELREP002](../../../procedimientos/mod_rep/com/GSELREP002.md) | — |
| `STIPCOD` | smallint not null | ✅ confirmada | [GSELREP002](../../../procedimientos/mod_rep/com/GSELREP002.md), [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GSELREP002](../../../procedimientos/mod_rep/com/GSELREP002.md) | lee | `SEL_JEFE_01` |
| [mod_rep.rep.GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | lee | `GSREVA01`, `GSREVA101`, `GSREVA201` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `SCODSUB`: _por documentar_
- `SNOMSUB`: _por documentar_
- `STIPCOD`: _por documentar_
