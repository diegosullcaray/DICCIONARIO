# storage.com_pas.WCAP002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 7 columna(s) usadas · 2 procedimiento(s) · tabla con 8 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_pas/WCAP002.sql](../../../../extraccion/sql/03-tablas/storage/com_pas/WCAP002.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HASEOPER` | varchar(255) | 🎯 exacta | [GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | — |
| `HFECPRO` | varchar(255) | 🧩 por estructura | [GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | — |
| `HORD` | int | 🧩 por estructura | [GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | — |
| `HPENDOC` | varchar(255) | 🧩 por estructura | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | — |
| `HPEPAIS` | int | 🧩 por estructura | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | — |
| `HPETDOC` | int | 🧩 por estructura | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md), [GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | — |
| `HSBSUC` | int | 🎯 exacta | [GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRTABDIGO01](../../../procedimientos/mod_rep/com/GRTABDIGO01.md) | lee | `TABDIG_VR2_01` |
| [mod_rep.com.GRTABDIGO02](../../../procedimientos/mod_rep/com/GRTABDIGO02.md) | lee | `TABDIG_VR2_COM_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HASEOPER`: _por documentar_
- `HSBSUC`: _por documentar_
