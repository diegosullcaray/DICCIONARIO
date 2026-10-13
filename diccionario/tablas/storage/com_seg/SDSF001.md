# storage.com_seg.SDSF001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_seg` · 12 columna(s) usadas · 8 procedimiento(s) · tabla con 11 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_seg/SDSF001.sql](../../../../sql/03-tablas/storage/com_seg/SDSF001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `*` | ⚠️ no existe | 🎯 exacta | [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG06](../../../procedimientos/mod_rep/com/GRESREPSEG06.md) | — |
| `scodagr` | tinyint | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `SCODMOD` | smallint | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SCODSEC` | varchar(10) | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `scodseg` | smallint | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `SFECEMI` | date | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `sfecpro` | date | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG03](../../../procedimientos/mod_rep/com/GRESREPSEG03.md), [GRESREPSEG04](../../../procedimientos/mod_rep/com/GRESREPSEG04.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRESREPSEG06](../../../procedimientos/mod_rep/com/GRESREPSEG06.md), [GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `SINDPGO` | int | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SNUMPLZ` | int | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md), [GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | — |
| `SSUBTIP` | int | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `SSUCCLI` | smallint | 🗄️ motor | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |
| `STIPOPE` | smallint | ✅ confirmada | [GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md), [GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md), [GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRESREPSEG_01](../../../procedimientos/mod_rep/com/GRESREPSEG_01.md) | lee | `GRSCMISREP_01` |
| [mod_rep.com.GRESREPSEG01](../../../procedimientos/mod_rep/com/GRESREPSEG01.md) | lee | `GRSCMIS_01` |
| [mod_rep.com.GRESREPSEG02](../../../procedimientos/mod_rep/com/GRESREPSEG02.md) | lee | `GRSCMIS_02` |
| [mod_rep.com.GRESREPSEG03](../../../procedimientos/mod_rep/com/GRESREPSEG03.md) | lee | `GRSCMIS_03` |
| [mod_rep.com.GRESREPSEG04](../../../procedimientos/mod_rep/com/GRESREPSEG04.md) | lee | `SEG_AGRO_01` |
| [mod_rep.com.GRESREPSEG05](../../../procedimientos/mod_rep/com/GRESREPSEG05.md) | lee | `GRSCMIS_04` |
| [mod_rep.com.GRESREPSEG06](../../../procedimientos/mod_rep/com/GRESREPSEG06.md) | lee | `GRSCMIS_05` |
| [mod_rep.com.GRMENTOR001](../../../procedimientos/mod_rep/com/GRMENTOR001.md) | lee | `RMENTORIN_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `*`: _por documentar_
- `scodagr`: _por documentar_
- `SCODMOD`: _por documentar_
- `SCODSEC`: _por documentar_
- `scodseg`: _por documentar_
- `sfecpro`: _por documentar_
- `SSUBTIP`: _por documentar_
- `STIPOPE`: _por documentar_
