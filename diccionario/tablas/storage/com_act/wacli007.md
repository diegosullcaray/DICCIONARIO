# storage.com_act.wacli007

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 7 columna(s) usadas · 3 procedimiento(s) · tabla con 10 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/wacli007.sql](../../../../sql/03-tablas/storage/com_act/wacli007.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODPER` | varchar(255) | ✅ confirmada | [RRANKM01](../../../procedimientos/mod_rep/com/RRANKM01.md), [RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md) | — |
| `hcodsec` | varchar(255) | ✅ confirmada | [RRANKM01](../../../procedimientos/mod_rep/com/RRANKM01.md), [RSDESEMP01](../../../procedimientos/mod_rep/com/RSDESEMP01.md), [RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md) | — |
| `hfecpro` | varchar(255) | ✅ confirmada | [RRANKM01](../../../procedimientos/mod_rep/com/RRANKM01.md), [RSDESEMP01](../../../procedimientos/mod_rep/com/RSDESEMP01.md), [RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md) | — |
| `HINDBANC` | int | 🧩 por estructura | [RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md) | — |
| `HINDGEN` | int | ✅ confirmada | [RRANKM01](../../../procedimientos/mod_rep/com/RRANKM01.md), [RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md) | — |
| `HINDMIGR` | int | 🧩 por estructura | [RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md) | — |
| `HINDRUR` | int | 🧩 por estructura | [RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RRANKM01](../../../procedimientos/mod_rep/com/RRANKM01.md) | lee | `RS_RANK_MUJ_01` |
| [mod_rep.com.RSDESEMP01](../../../procedimientos/mod_rep/com/RSDESEMP01.md) | lee | `DESEMP_SOC_01`, `DESE_SOC_01` |
| [mod_rep.com.RSDESEMP02](../../../procedimientos/mod_rep/com/RSDESEMP02.md) | lee | `DESE_SOC_AS_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODPER`: _por documentar_
- `hcodsec`: _por documentar_
- `hfecpro`: _por documentar_
- `HINDGEN`: _por documentar_
