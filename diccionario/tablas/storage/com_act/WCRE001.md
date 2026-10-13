# storage.com_act.WCRE001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 10 columna(s) usadas · 1 procedimiento(s) · tabla con 10 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WCRE001.sql](../../../../sql/03-tablas/storage/com_act/WCRE001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `hcodrel` | varchar(20) | ≈ inferida | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |
| `HDESPROD` | varchar(150) | 🎯 exacta | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |
| `HEREDADO` | smallint | 🎯 exacta | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |
| `HFECPRO` | date not null | 🎯 exacta | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |
| `HSALDETMN` | numeric(17,2) | 🎯 exacta | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |
| `HSALINIMN` | numeric(17,2) | 🎯 exacta | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |
| `HSALMAN01MN` | numeric(17,2) | ≈ inferida | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |
| `HSALRECMN` | numeric(17,2) | ≈ inferida | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |
| `htipcod` | smallint | ≈ inferida | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |
| `HTRAM` | varchar(10) | ≈ inferida | [RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSMONEFER03](../../../procedimientos/mod_rep/com/RSMONEFER03.md) | lee | `RS_MON_EFECREASIG_03` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `GROUPING`: _por documentar_
- `hcodrel`: _por documentar_
- `HDESPROD`: _por documentar_
- `HEREDADO`: _por documentar_
- `HFECPRO`: _por documentar_
- `HSALDETMN`: _por documentar_
- `HSALINIMN`: _por documentar_
- `HSALMAN01MN`: _por documentar_
- `HSALRECMN`: _por documentar_
- `htipcod`: _por documentar_
- `HTRAM`: _por documentar_
