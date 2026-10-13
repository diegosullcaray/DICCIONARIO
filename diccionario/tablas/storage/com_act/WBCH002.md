# storage.com_act.WBCH002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 10 columna(s) usadas · 1 procedimiento(s) · tabla con 25 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WBCH002.sql](../../../../sql/03-tablas/storage/com_act/WBCH002.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODMOD` | smallint not null | 🧩 por estructura | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |
| `HCODOPE` | int | 🧩 por estructura | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |
| `hCODSEC` | varchar(10) | 🎯 exacta | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |
| `HCTACLI` | int | 🧩 por estructura | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |
| `HDESCLI` | varchar(40) | 🎯 exacta | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |
| `HDTIPOPE` | varchar(40) | 🎯 exacta | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |
| `HFECPRO` | date | ✅ confirmada | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |
| `HMONDESMN` | numeric(35,6) | 🧩 por estructura | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |
| `HSUCCLI` | smallint | 🧩 por estructura | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |
| `RDESPROD` | varchar(150) | 🎯 exacta | [GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GPRECOSELIS001](../../../procedimientos/mod_rep/com/GPRECOSELIS001.md) | lee | `PRECOSELISTADO_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hCODSEC`: _por documentar_
- `HDESCLI`: _por documentar_
- `HDTIPOPE`: _por documentar_
- `HFECPRO`: _por documentar_
- `RDESPROD`: _por documentar_
