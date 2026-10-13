# storage.com_pas.VCPH001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 10 columna(s) usadas · 2 procedimiento(s) · vista con 66 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/com_pas/VCPH001.sql](../../../../extraccion/sql/03-tablas/storage/com_pas/VCPH001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODSEC` | tinyint | ✅ confirmada | [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | — |
| `HESTADO` | varchar(30) | ✅ confirmada | [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | — |
| `HPENDOC` | varchar(12) | ✅ confirmada | [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | — |
| `HPETDOC` | tinyint | ✅ confirmada | [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | — |
| `HSBFECH` | date not null | ✅ confirmada | [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | — |
| `HSBMOD` | smallint not null | ✅ confirmada | [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | — |
| `HSBSDO1` | numeric(17,2) | ✅ confirmada | [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | — |
| `HSBSUC` | smallint not null | ✅ confirmada | [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | — |
| `HSBTOPE` | smallint not null | ✅ confirmada | [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md), [RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | — |
| `HUSERBP` | varchar(10) | ✅ confirmada | [RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RENRPAS01](../../../procedimientos/mod_rep/com/RENRPAS01.md) | lee | `enrolamiento_pasivo_01` |
| [mod_rep.com.RENRPAS02](../../../procedimientos/mod_rep/com/RENRPAS02.md) | lee | `enrolamiento_pasivo_pas_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HPENDOC`: _por documentar_
- `HPETDOC`: _por documentar_
- `HSBMOD`: _por documentar_
