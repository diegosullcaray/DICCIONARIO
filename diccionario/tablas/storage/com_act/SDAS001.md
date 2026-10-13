# storage.com_act.SDAS001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 6 columna(s) usadas · 4 procedimiento(s) · tabla con 27 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/SDAS001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/SDAS001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `scodagr` | tinyint | ✅ confirmada | [GDCEROCN003](../../../procedimientos/mod_rep/com/GDCEROCN003.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `SCODSEC` | varchar(10) | ✅ confirmada | [GDCEROCN003](../../../procedimientos/mod_rep/com/GDCEROCN003.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `sfecpro` | date | ✅ confirmada | [GDCEROCN003](../../../procedimientos/mod_rep/com/GDCEROCN003.md), [GRCEROCUOTAO01](../../../procedimientos/mod_rep/com/GRCEROCUOTAO01.md), [GRCEROCUOTAO02](../../../procedimientos/mod_rep/com/GRCEROCUOTAO02.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `SNUMOPEZC` | int | ≈ inferida | [GDCEROCN003](../../../procedimientos/mod_rep/com/GDCEROCN003.md) | — |
| `SSALCAPMN` | numeric(32,2) | ✅ confirmada | [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `SSALZCMN` | numeric(32,2) | ≈ inferida | [GDCEROCN003](../../../procedimientos/mod_rep/com/GDCEROCN003.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GDCEROCN003](../../../procedimientos/mod_rep/com/GDCEROCN003.md) | lee | `REP_CERCUOT_01` |
| [mod_rep.com.GRCEROCUOTAO01](../../../procedimientos/mod_rep/com/GRCEROCUOTAO01.md) | lee | `CEROYCUOTA_01` |
| [mod_rep.com.GRCEROCUOTAO02](../../../procedimientos/mod_rep/com/GRCEROCUOTAO02.md) | lee | `CEROYCUOTA_02` |
| [mod_rep.com.GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | lee | `RMENTORIN_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `scodagr`: _por documentar_
- `SCODSEC`: _por documentar_
- `sfecpro`: _por documentar_
- `SNUMOPEZC`: _por documentar_
- `SSALCAPMN`: _por documentar_
- `SSALZCMN`: _por documentar_
