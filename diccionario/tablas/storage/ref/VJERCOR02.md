# storage.ref.VJERCOR02

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `ref` · 9 columna(s) usadas · 2 procedimiento(s) · vista con 12 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/ref/VJERCOR02.sql](../../../../extraccion/sql/03-tablas/storage/ref/VJERCOR02.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `rcodage` | int | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md), [RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | — |
| `RCODAGEH` | int | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md), [RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | — |
| `RCODCOR` | int | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md), [RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | — |
| `RCODMAT` | int | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md), [RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | — |
| `RCODTER` | smallint | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md), [RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | — |
| `RDESAGE` | varchar(50) | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md), [RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | — |
| `RDESCOR` | varchar(255) | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md), [RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | — |
| `RDESMAT` | varchar(50) | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md), [RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | — |
| `RDESTER` | varchar(150) | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md), [RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md) | lee | `enrolamiento_colaboradores_01` |
| [mod_rep.com.RSHHCARB001](../../../procedimientos/mod_rep/com/RSHHCARB001.md) | lee | `HCARBONO_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `rcodage`: _por documentar_
- `RCODAGEH`: _por documentar_
- `rcodcor`: _por documentar_
- `rcodmat`: _por documentar_
- `rcodter`: _por documentar_
- `RDESAGE`: _por documentar_
- `RDESCOR`: _por documentar_
- `RDESMAT`: _por documentar_
- `RDESTER`: _por documentar_
