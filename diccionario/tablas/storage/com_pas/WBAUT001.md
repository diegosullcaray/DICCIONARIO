# storage.com_pas.WBAUT001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 2 columna(s) usadas · 1 procedimiento(s) · tabla con 88 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_pas/WBAUT001.sql](../../../../sql/03-tablas/storage/com_pas/WBAUT001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCOFIC` | smallint | 🎯 exacta | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GDCGEST_PASIVAST01](../../../procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md) | lee | `GST_PASIVA_01`, `GST_PASIVA_02`, `GST_PASIVA_03`, `GST_PASIVA_M_01`, `GST_PASIVA_M_02`, `GST_PASIVA_M_03` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCOFIC`: _por documentar_
- `HFECPRO`: _por documentar_
