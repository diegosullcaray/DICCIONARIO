# storage.com_act.SRIESGO001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 3 columna(s) usadas · 1 procedimiento(s) · tabla con 3 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_act/SRIESGO001.sql](../../../../extraccion/sql/03-tablas/storage/com_act/SRIESGO001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `cliente` | float | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `NIVEL_RIESGO` | nvarchar(255) | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |
| `NIVEL_SOB` | nvarchar(255) | 🎯 exacta | [GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GCOSELIS001](../../../procedimientos/mod_rep/com/GCOSELIS001.md) | lee | `COSELISTADO_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `cliente`: _por documentar_
- `NIVEL_RIESGO`: _por documentar_
- `NIVEL_SOB`: _por documentar_
