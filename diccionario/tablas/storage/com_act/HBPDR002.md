# storage.com_act.HBPDR002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 3 columna(s) usadas · 2 procedimiento(s) · tabla con 36 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/HBPDR002.sql](../../../../extraccion/sql/03-tablas/storage/com_act/HBPDR002.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `hfecpro` | date not null | ✅ confirmada | [RSPROYCOLDES001](../../../procedimientos/mod_rep/com/RSPROYCOLDES001.md), [RSPROYCOLDES003](../../../procedimientos/mod_rep/com/RSPROYCOLDES003.md) | — |
| `HFECREG` | date | ✅ confirmada | [RSPROYCOLDES001](../../../procedimientos/mod_rep/com/RSPROYCOLDES001.md), [RSPROYCOLDES003](../../../procedimientos/mod_rep/com/RSPROYCOLDES003.md) | — |
| `HHORPRO` | tinyint not null | ✅ confirmada | [RSPROYCOLDES001](../../../procedimientos/mod_rep/com/RSPROYCOLDES001.md), [RSPROYCOLDES003](../../../procedimientos/mod_rep/com/RSPROYCOLDES003.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSPROYCOLDES001](../../../procedimientos/mod_rep/com/RSPROYCOLDES001.md) | lee | `PROYEC_COLREC_01` |
| [mod_rep.com.RSPROYCOLDES003](../../../procedimientos/mod_rep/com/RSPROYCOLDES003.md) | lee | `PROYEC_DIACOLREC_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hfecpro`: _por documentar_
- `HFECREG`: _por documentar_
- `HHORPRO`: _por documentar_
