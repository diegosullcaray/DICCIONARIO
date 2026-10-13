# storage.com_pas.WJAS004

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 4 columna(s) usadas · 1 procedimiento(s) · tabla con 11 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_pas/WJAS004.sql](../../../../sql/03-tablas/storage/com_pas/WJAS004.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODREL` | varchar(50) | 🎯 exacta | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | — |
| `hfecpro` | date not null | ≈ inferida | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | — |
| `htipcod` | int not null | ≈ inferida | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | — |
| `RDESCPROD02` | varchar(50) | ≈ inferida | [RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSRDFCA036](../../../procedimientos/mod_rep/com/RSRDFCA036.md) | lee | `CARACT_pas_M_01`, `CARACT_pas_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODREL`: _por documentar_
- `hfecpro`: _por documentar_
- `htipcod`: _por documentar_
- `RDESCPROD02`: _por documentar_
