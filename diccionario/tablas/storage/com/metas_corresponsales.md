# storage.com.metas_corresponsales

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com` · 7 columna(s) usadas · 1 procedimiento(s) · tabla con 7 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com/metas_corresponsales.sql](../../../../extraccion/sql/03-tablas/storage/com/metas_corresponsales.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODOFI` | varchar(250) | 🗄️ motor | [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md) | — |
| `HDESCOR` | varchar(250) | 🗄️ motor | [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md) | — |
| `hfeccar` | date | ✅ confirmada | [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md) | — |
| `HFECPRO` | date | 🗄️ motor | [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md) | — |
| `HTERDES` | varchar(250) | 🗄️ motor | [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md) | — |
| `HTIPMETA` | char(1) | 🗄️ motor | [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md) | — |
| `HVAL` | int | 🗄️ motor | [RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RCORRES06](../../../procedimientos/mod_rep/com/RCORRES06.md) | lee | `GREPORCORRE_06` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hfeccar`: _por documentar_
