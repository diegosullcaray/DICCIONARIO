# storage.com_act.HBAC002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 4 columna(s) usadas · 2 procedimiento(s) · tabla con 5 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/HBAC002.sql](../../../../extraccion/sql/03-tablas/storage/com_act/HBAC002.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODOPE` | int | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECEJC` | date | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `hfecpro` | date not null | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HNUM_CONDONADO` | int | ✅ confirmada | [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | lee | `RS_MON_EFEC_02`, `RS_MON_EFECM_02` |
| [mod_rep.com.RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | lee | `RS_MON_EFECREASIG_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODOPE`: _por documentar_
- `HFECEJC`: _por documentar_
- `hfecpro`: _por documentar_
- `HNUM_CONDONADO`: _por documentar_
