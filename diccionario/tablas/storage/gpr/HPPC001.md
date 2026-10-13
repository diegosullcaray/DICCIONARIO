# storage.gpr.HPPC001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `gpr` · 7 columna(s) usadas · 7 procedimiento(s) · tabla con 16 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/gpr/HPPC001.sql](../../../../sql/03-tablas/storage/gpr/HPPC001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `hcodbt` | varchar(15) | ✅ confirmada | [GDASHKAY03](../../../procedimientos/mod_rep/com/GDASHKAY03.md), [GDASHKAY05](../../../procedimientos/mod_rep/com/GDASHKAY05.md), [GDASHKAY06](../../../procedimientos/mod_rep/com/GDASHKAY06.md), [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md), [GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md), [GSCAMP01](../../../procedimientos/mod_rep/com/GSCAMP01.md) | — |
| `HCODSUC` | int | ✅ confirmada | [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md), [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md) | — |
| `HDESCAR` | varchar(255) | ≈ inferida | [GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md) | — |
| `HDESPER` | varchar(255) | ≈ inferida | [GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md) | — |
| `HDESTER` | varchar(20) | ✅ confirmada | [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md) | — |
| `hfecpro` | date | ✅ confirmada | [GDASHKAY03](../../../procedimientos/mod_rep/com/GDASHKAY03.md), [GDASHKAY05](../../../procedimientos/mod_rep/com/GDASHKAY05.md), [GDASHKAY06](../../../procedimientos/mod_rep/com/GDASHKAY06.md), [GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md), [GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md), [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md) | — |
| `HNUMDOC` | varchar(10) | ✅ confirmada | [GSCAMP01](../../../procedimientos/mod_rep/com/GSCAMP01.md), [RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GDASHKAY03](../../../procedimientos/mod_rep/com/GDASHKAY03.md) | lee | `rankKay_01` |
| [mod_rep.com.GDASHKAY05](../../../procedimientos/mod_rep/com/GDASHKAY05.md) | lee | `rankKayOpe_01` |
| [mod_rep.com.GDASHKAY06](../../../procedimientos/mod_rep/com/GDASHKAY06.md) | lee | `rankKayrecu_01` |
| [mod_rep.com.GLISAUTO01](../../../procedimientos/mod_rep/com/GLISAUTO01.md) | lee | `LST_AUT_01` |
| [mod_rep.com.GLISAUTRO05](../../../procedimientos/mod_rep/com/GLISAUTRO05.md) | lee | `GLISAUTRO_04` |
| [mod_rep.com.GSCAMP01](../../../procedimientos/mod_rep/com/GSCAMP01.md) | lee | `GSCAMP_01` |
| [mod_rep.com.RENRCOLAB01](../../../procedimientos/mod_rep/com/RENRCOLAB01.md) | lee | `enrolamiento_colaboradores_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `hcodbt`: _por documentar_
- `HCODSUC`: _por documentar_
- `HDESCAR`: _por documentar_
- `HDESPER`: _por documentar_
- `HDESTER`: _por documentar_
- `hfecpro`: _por documentar_
- `HNUMDOC`: _por documentar_
