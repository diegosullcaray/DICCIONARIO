# storage.com_pas.HCDP001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 2 columna(s) usadas · 2 procedimiento(s) · tabla con 64 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_pas/HCDP001.sql](../../../../sql/03-tablas/storage/com_pas/HCDP001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `*` | ⚠️ no existe | 🎯 exacta | [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | — |
| `hfecpro` | date not null | ✅ confirmada | [GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md), [GDCCAP_BP01](../../../procedimientos/strategos/mod_rep_com_act/GDCCAP_BP01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GSEGCAPBP01](../../../procedimientos/mod_rep/com/GSEGCAPBP01.md) | lee | `CAP_SEGUI_BP_01` |
| [strategos.mod_rep_com_act.GDCCAP_BP01](../../../procedimientos/strategos/mod_rep_com_act/GDCCAP_BP01.md) | lee | `CaptaBP_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `*`: _por documentar_
- `hfecpro`: _por documentar_
