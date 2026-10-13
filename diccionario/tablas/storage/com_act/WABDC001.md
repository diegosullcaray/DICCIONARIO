# storage.com_act.WABDC001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 6 columna(s) usadas · 1 procedimiento(s) · tabla con 20 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WABDC001.sql](../../../../sql/03-tablas/storage/com_act/WABDC001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODSEC` | varchar(10) | ✅ confirmada | [RSAGECOM01](../../../procedimientos/mod_rep/com/RSAGECOM01.md) | — |
| `HEVTO` | float not null | ✅ confirmada | [RSAGECOM01](../../../procedimientos/mod_rep/com/RSAGECOM01.md) | — |
| `HFECPRO` | date | ✅ confirmada | [RSAGECOM01](../../../procedimientos/mod_rep/com/RSAGECOM01.md) | — |
| `HINDBASE` | int not null | ✅ confirmada | [RSAGECOM01](../../../procedimientos/mod_rep/com/RSAGECOM01.md) | — |
| `HINDDESB` | int not null | ✅ confirmada | [RSAGECOM01](../../../procedimientos/mod_rep/com/RSAGECOM01.md) | — |
| `HNUMCON` | varchar(82) | ✅ confirmada | [RSAGECOM01](../../../procedimientos/mod_rep/com/RSAGECOM01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSAGECOM01](../../../procedimientos/mod_rep/com/RSAGECOM01.md) | lee | `RS_AGE_COM_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODSEC`: _por documentar_
- `HEVTO`: _por documentar_
- `HFECPRO`: _por documentar_
