# storage.com_act.WJAS004

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 4 columna(s) usadas · 1 procedimiento(s) · tabla con 6 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/WJAS004.sql](../../../../extraccion/sql/03-tablas/storage/com_act/WJAS004.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODREL` | varchar(50) | 🎯 exacta | [RSRDFCA035](../../../procedimientos/mod_rep/com/RSRDFCA035.md) | — |
| `hfecpro` | date not null | 🧩 por estructura | [RSRDFCA035](../../../procedimientos/mod_rep/com/RSRDFCA035.md) | — |
| `htipcod` | int not null | 🧩 por estructura | [RSRDFCA035](../../../procedimientos/mod_rep/com/RSRDFCA035.md) | — |
| `RDESCPROD02` | varchar(50) | 🧩 por estructura | [RSRDFCA035](../../../procedimientos/mod_rep/com/RSRDFCA035.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSRDFCA035](../../../procedimientos/mod_rep/com/RSRDFCA035.md) | lee | `CARACT_CARTERA_01`, `CARACT_CARTERA_M_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODREL`: _por documentar_
- `hfecpro`: _por documentar_
- `htipcod`: _por documentar_
- `RDESCPROD02`: _por documentar_
