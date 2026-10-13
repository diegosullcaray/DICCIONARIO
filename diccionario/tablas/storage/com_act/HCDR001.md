# storage.com_act.HCDR001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 3 columna(s) usadas · 3 procedimiento(s) · tabla con 24 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/HCDR001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/HCDR001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODOPE` | int | ≈ inferida | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECPRO` | date not null | ≈ inferida | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md), [RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md), [RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | — |
| `HFECREP` | date | ≈ inferida | [RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RINCEGP01](../../../procedimientos/mod_rep/com/RINCEGP01.md) | lee | `RESINCGRUP_01` |
| [mod_rep.com.RSMONEFE02](../../../procedimientos/mod_rep/com/RSMONEFE02.md) | lee | `RS_MON_EFEC_02`, `RS_MON_EFECM_02` |
| [mod_rep.com.RSMONEFER02](../../../procedimientos/mod_rep/com/RSMONEFER02.md) | lee | `RS_MON_EFECREASIG_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODOPE`: _por documentar_
- `HFECPRO`: _por documentar_
- `HFECREP`: _por documentar_
