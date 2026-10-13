# storage.com_act.SDAS014

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 8 columna(s) usadas · 1 procedimiento(s) · tabla con 13 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/SDAS014.sql](../../../../extraccion/sql/03-tablas/storage/com_act/SDAS014.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SCODAGR` | int | ✅ confirmada | [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | — |
| `SCODMOD` | smallint | 🎯 exacta | [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | — |
| `SCODSEC` | varchar(10) | 🎯 exacta | [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | — |
| `sfecbas` | date | ✅ confirmada | [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | — |
| `SNUMOPEBAS` | int | 🎯 exacta | [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | — |
| `SSALCAPBAS` | numeric(38,6) | 🎯 exacta | [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | — |
| `SSUBTIP` | int | 🎯 exacta | [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | — |
| `STIPOPE` | smallint | 🎯 exacta | [GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GPRECOSCUAD001](../../../procedimientos/mod_rep/com/GPRECOSCUAD001.md) | lee | `PRECOSECUADRO_03` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `SCODAGR`: _por documentar_
- `SCODMOD`: _por documentar_
- `SCODSEC`: _por documentar_
- `sfecbas`: _por documentar_
- `SNUMOPEBAS`: _por documentar_
- `SSALCAPBAS`: _por documentar_
- `SSUBTIP`: _por documentar_
- `STIPOPE`: _por documentar_
