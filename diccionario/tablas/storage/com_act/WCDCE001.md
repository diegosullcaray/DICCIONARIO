# storage.com_act.WCDCE001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 3 columna(s) usadas · 1 procedimiento(s) · tabla con 9 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WCDCE001.sql](../../../../sql/03-tablas/storage/com_act/WCDCE001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODOPE` | int | 🗄️ motor | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `HCODSEC` | varchar(10) | ✅ confirmada | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `hfecpro` | date not null | ✅ confirmada | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | lee | `RMENTORIN_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODSEC`: _por documentar_
- `hfecpro`: _por documentar_
