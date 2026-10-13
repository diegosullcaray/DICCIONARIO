# storage.com_act.WCCLISTADO01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 17 columna(s) usadas · 1 procedimiento(s) · tabla con 17 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WCCLISTADO01.sql](../../../../sql/03-tablas/storage/com_act/WCCLISTADO01.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODOPE` | int | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HCODSEC` | varchar(10) | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HCTACLI` | int | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HDESCIIU` | varchar(60) | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HDESCLI` | varchar(40) | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HDIAATR` | smallint | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HDSUCCLI` | varchar(40) | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HFCCOM` | varchar(56) | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HFCFGEST` | date | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HFECDES` | date | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HMONDES` | numeric(17,2) | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HSALCAPMN` | numeric(17,2) | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HSALVENMN` | numeric(17,2) | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `HSITCRE` | varchar(20) | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `IndCartera` | varchar(12) not null | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |
| `IndIngreso` | varchar(8) not null | ✅ confirmada | [RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSLISTCCN01](../../../procedimientos/mod_rep/com/RSLISTCCN01.md) | lee | `LCCUOTANUEVA_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODOPE`: _por documentar_
- `HCODSEC`: _por documentar_
- `HCTACLI`: _por documentar_
- `HDESCIIU`: _por documentar_
- `HDESCLI`: _por documentar_
- `HDIAATR`: _por documentar_
- `HDSUCCLI`: _por documentar_
- `HFCCOM`: _por documentar_
- `HFCFGEST`: _por documentar_
- `HFECDES`: _por documentar_
- `HFECPRO`: _por documentar_
- `HMONDES`: _por documentar_
- `HSALCAPMN`: _por documentar_
- `HSALVENMN`: _por documentar_
- `HSITCRE`: _por documentar_
- `IndCartera`: _por documentar_
- `IndIngreso`: _por documentar_
