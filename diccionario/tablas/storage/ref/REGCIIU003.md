# storage.ref.REGCIIU003

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `ref` · 2 columna(s) usadas · 3 procedimiento(s) · tabla con 3 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/ref/REGCIIU003.sql](../../../../sql/03-tablas/storage/ref/REGCIIU003.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `RCODCIIU` | char(4) not null | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [GSELCIUT001](../../../procedimientos/mod_rep/com/GSELCIUT001.md), [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md) | — |
| `RDESCIIU` | varchar(500) | ✅ confirmada | [GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md), [GSELCIUT001](../../../procedimientos/mod_rep/com/GSELCIUT001.md), [GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLISDETCLI01](../../../procedimientos/mod_rep/com/GLISDETCLI01.md) | lee | `DET_CLI_01` |
| [mod_rep.com.GSELCIUT001](../../../procedimientos/mod_rep/com/GSELCIUT001.md) | lee | `SEL_CIU_01` |
| [mod_rep.com.GSELJERAR001](../../../procedimientos/mod_rep/com/GSELJERAR001.md) | lee | `SEL_JER_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `RCODCIIU`: _por documentar_
- `RDESCIIU`: _por documentar_
