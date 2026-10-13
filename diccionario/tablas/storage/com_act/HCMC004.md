# storage.com_act.HCMC004

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 6 columna(s) usadas · 2 procedimiento(s) · tabla con 42 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/HCMC004.sql](../../../../sql/03-tablas/storage/com_act/HCMC004.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODREDEXT` | varchar(6) | ✅ confirmada | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HCODSUC` | numeric(3,0) | ✅ confirmada | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HESTCORR` | varchar(2) | ✅ confirmada | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HFECINSTALA` | date | ✅ confirmada | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md), [RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | — |
| `HNOMCOR` | varchar(40) | ≈ inferida | [GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md) | lee | `TABDIG_02` |
| [mod_rep.com.RDETCORR01](../../../procedimientos/mod_rep/com/RDETCORR01.md) | lee | `RDETCORR_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODREDEXT`: _por documentar_
- `HCODSUC`: _por documentar_
- `HESTCORR`: _por documentar_
- `HFECINSTALA`: _por documentar_
- `HFECPRO`: _por documentar_
- `HNOMCOR`: _por documentar_
