# storage.com_act.SDAF002

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 16 columna(s) usadas · 10 procedimiento(s) · tabla con 15 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/SDAF002.sql](../../../../sql/03-tablas/storage/com_act/SDAF002.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `*` | ⚠️ no existe | 🎯 exacta | [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG06](../../../procedimientos/mod_rep/com/GRESREPSEG06.md) | — |
| `SCLINUE` | int | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SCODAGR` | int | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md), [RSRTOPMIS001](../../../procedimientos/mod_rep/com/RSRTOPMIS001.md), [RSRTOPMIS002](../../../procedimientos/mod_rep/com/RSRTOPMIS002.md), [RSRTOPMIS003](../../../procedimientos/mod_rep/com/RSRTOPMIS003.md), [RSRTOPMIS004](../../../procedimientos/mod_rep/com/RSRTOPMIS004.md) | — |
| `SCODMOD` | smallint | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG06](../../../procedimientos/mod_rep/com/GRESREPSEG06.md) | — |
| `SCODSEC` | varchar(10) | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `SFECPRO` | date | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG06](../../../procedimientos/mod_rep/com/GRESREPSEG06.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md), [RSRTOPMIS001](../../../procedimientos/mod_rep/com/RSRTOPMIS001.md), [RSRTOPMIS002](../../../procedimientos/mod_rep/com/RSRTOPMIS002.md), [RSRTOPMIS003](../../../procedimientos/mod_rep/com/RSRTOPMIS003.md), [RSRTOPMIS004](../../../procedimientos/mod_rep/com/RSRTOPMIS004.md) | — |
| `SINTMESMN` | numeric(38,8) | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SMDNUEMN` | numeric(32,2) | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SMONDESMN` | numeric(32,2) | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SNUMCLI` | int | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SNUMOPE` | int | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `SNUMSEC` | smallint | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SOPENUE` | int | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SSUBTIP` | int | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG06](../../../procedimientos/mod_rep/com/GRESREPSEG06.md) | — |
| `SSUCCLI` | smallint | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `STIPOPE` | smallint | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG06](../../../procedimientos/mod_rep/com/GRESREPSEG06.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md) | lee | `GRSCMISREP_01` |
| [mod_rep.com.GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md) | lee | `GRSCMIS_01` |
| [mod_rep.com.GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md) | lee | `GRSCMIS_02` |
| [mod_rep.com.GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | lee | `GRSCMIS_04` |
| [mod_rep.com.GRESREPSEG06](../../../procedimientos/mod_rep/com/GRESREPSEG06.md) | lee | `GRSCMIS_05` |
| [mod_rep.com.GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | lee | `RMENTORIN_01` |
| [mod_rep.com.RSRTOPMIS001](../../../procedimientos/mod_rep/com/RSRTOPMIS001.md) | lee | `prod_misi_01` |
| [mod_rep.com.RSRTOPMIS002](../../../procedimientos/mod_rep/com/RSRTOPMIS002.md) | lee | `prod_misi_02` |
| [mod_rep.com.RSRTOPMIS003](../../../procedimientos/mod_rep/com/RSRTOPMIS003.md) | lee | `prod_misi_03` |
| [mod_rep.com.RSRTOPMIS004](../../../procedimientos/mod_rep/com/RSRTOPMIS004.md) | lee | `prod_misi_04` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `*`: _por documentar_
- `SCODAGR`: _por documentar_
- `SCODMOD`: _por documentar_
- `scodsec`: _por documentar_
- `SFECPRO`: _por documentar_
- `SNUMOPE`: _por documentar_
- `SSUBTIP`: _por documentar_
- `STIPOPE`: _por documentar_
