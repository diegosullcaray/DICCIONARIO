# storage.com_act.SDAS021

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 2 columna(s) usadas · 3 procedimiento(s) · tabla con 13 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/SDAS021.sql](../../../../sql/03-tablas/storage/com_act/SDAS021.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SCORRES` | varchar(250) | ✅ confirmada | [RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md) | — |
| `sfecpro` | date | 🎯 exacta | [RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRTABCORRO01](../../../procedimientos/mod_rep/com/GRTABCORRO01.md) | lee | `TABDIG_02` |
| [mod_rep.com.RCORRES01](../../../procedimientos/mod_rep/com/RCORRES01.md) | lee | `GREPORCORRE_01` |
| [mod_rep.com.RCORRES05](../../../procedimientos/mod_rep/com/RCORRES05.md) | lee | `GREPORCORRE_05` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `SCORRES`: _por documentar_
- `sfecpro`: _por documentar_
