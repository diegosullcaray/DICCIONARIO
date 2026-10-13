# mod_rep.reva.SVARREVA01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `mod_rep` · esquema `reva` · 6 columna(s) usadas · 1 procedimiento(s) · tabla con 6 columna(s) en la base

Consultas listas: [sql/03-tablas/mod_rep/reva/SVARREVA01.sql](../../../../sql/03-tablas/mod_rep/reva/SVARREVA01.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SAMBFIL` | varchar(50) | 🗄️ motor | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `SAMBGRU` | varchar(50) | ✅ confirmada | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `SCODMOD` | smallint not null | ✅ confirmada | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `SCODVAR` | smallint not null | ✅ confirmada | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `SDESVAR` | varchar(250) | 🗄️ motor | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |
| `SORDREV` | int not null | ✅ confirmada | [GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.rep.GSREVA01](../../../procedimientos/mod_rep/rep/GSREVA01.md) | lee | `GSREVA01`, `GSREVA101`, `GSREVA201` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `SAMBGRU`: _por documentar_
- `SCODMOD`: _por documentar_
- `SCODVAR`: _por documentar_
- `SORDREV`: _por documentar_
