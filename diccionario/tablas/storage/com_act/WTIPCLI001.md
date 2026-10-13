# STORAGE.COM_ACT.WTIPCLI001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 7 columna(s) usadas · 2 procedimiento(s) · tabla con 7 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WTIPCLI001.sql](../../../../sql/03-tablas/storage/com_act/WTIPCLI001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `hcodrel` | varchar(50) | 🎯 exacta | [RGRAFGESTCOM04](../../../procedimientos/mod_rep/com/RGRAFGESTCOM04.md), [RGRAFGESTCOM06](../../../procedimientos/mod_rep/com/RGRAFGESTCOM06.md) | — |
| `hfecpro` | date | ≈ inferida | [RGRAFGESTCOM04](../../../procedimientos/mod_rep/com/RGRAFGESTCOM04.md) | — |
| `HNUMCLIANTI` | int | 🧩 por estructura | [RGRAFGESTCOM06](../../../procedimientos/mod_rep/com/RGRAFGESTCOM06.md) | — |
| `HNUMCLIINGR` | int | 🧩 por estructura | [RGRAFGESTCOM06](../../../procedimientos/mod_rep/com/RGRAFGESTCOM06.md) | — |
| `HNUMCLIPROG` | int | 🧩 por estructura | [RGRAFGESTCOM06](../../../procedimientos/mod_rep/com/RGRAFGESTCOM06.md) | — |
| `HNUMCLIVENC` | int | 🧩 por estructura | [RGRAFGESTCOM06](../../../procedimientos/mod_rep/com/RGRAFGESTCOM06.md) | — |
| `htipcod` | int not null | 🎯 exacta | [RGRAFGESTCOM04](../../../procedimientos/mod_rep/com/RGRAFGESTCOM04.md), [RGRAFGESTCOM06](../../../procedimientos/mod_rep/com/RGRAFGESTCOM06.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RGRAFGESTCOM04](../../../procedimientos/mod_rep/com/RGRAFGESTCOM04.md) | lee | `GRAF_GEST_COM_04` |
| [mod_rep.com.RGRAFGESTCOM06](../../../procedimientos/mod_rep/com/RGRAFGESTCOM06.md) | lee | `GRAF_GEST_COM_06` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hcodrel`: _por documentar_
- `hfecpro`: _por documentar_
- `htipcod`: _por documentar_
