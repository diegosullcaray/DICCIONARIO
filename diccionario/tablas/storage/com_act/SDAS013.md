# storage.com_act.SDAS013

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 12 columna(s) usadas · 1 procedimiento(s) · tabla con 12 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/SDAS013.sql](../../../../sql/03-tablas/storage/com_act/SDAS013.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `SCODAGR` | tinyint | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `SCODMOD` | int | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `SCODSEC` | varchar(10) | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `SCOSECHA` | int not null | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `sfecbas` | date not null | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `SFECPRO` | ⚠️ no existe | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `SNUMOPEBAS` | int | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `SNUMOPEMORH` | int | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `SSALCAPBAS` | numeric(19,2) | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `SSALCAPMORH` | numeric(19,2) | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `SSUBTIP` | int | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |
| `STIPOPE` | int | 🎯 exacta | [GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GCOSEMAF002](../../../procedimientos/mod_rep/com/GCOSEMAF002.md) | lee | `COSESEMAFORO_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `SCODAGR`: _por documentar_
- `SCODMOD`: _por documentar_
- `SCODSEC`: _por documentar_
- `SCOSECHA`: _por documentar_
- `sfecbas`: _por documentar_
- `SFECPRO`: _por documentar_
- `SNUMOPEBAS`: _por documentar_
- `SNUMOPEMORH`: _por documentar_
- `SSALCAPBAS`: _por documentar_
- `SSALCAPMORH`: _por documentar_
- `SSUBTIP`: _por documentar_
- `STIPOPE`: _por documentar_
