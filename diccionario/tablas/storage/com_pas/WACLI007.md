# storage.com_pas.WACLI007

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_pas` · 7 columna(s) usadas · 1 procedimiento(s) · tabla con 11 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_pas/WACLI007.sql](../../../../sql/03-tablas/storage/com_pas/WACLI007.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HCODREL` | varchar(50) not null | 🎯 exacta | [RSDESEMPAS01](../../../procedimientos/mod_rep/com/RSDESEMPAS01.md) | — |
| `HFECPRO` | date not null | 🎯 exacta | [RSDESEMPAS01](../../../procedimientos/mod_rep/com/RSDESEMPAS01.md) | — |
| `HFEMCLI` | int not null | 🎯 exacta | [RSDESEMPAS01](../../../procedimientos/mod_rep/com/RSDESEMPAS01.md) | — |
| `HMIGCLI` | int not null | 🎯 exacta | [RSDESEMPAS01](../../../procedimientos/mod_rep/com/RSDESEMPAS01.md) | — |
| `HRURCLI` | int not null | 🎯 exacta | [RSDESEMPAS01](../../../procedimientos/mod_rep/com/RSDESEMPAS01.md) | — |
| `HTIPCOD` | int | 🎯 exacta | [RSDESEMPAS01](../../../procedimientos/mod_rep/com/RSDESEMPAS01.md) | — |
| `HTOTCLI` | int not null | 🎯 exacta | [RSDESEMPAS01](../../../procedimientos/mod_rep/com/RSDESEMPAS01.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.RSDESEMPAS01](../../../procedimientos/mod_rep/com/RSDESEMPAS01.md) | lee | `DESEMP_SOC_PAS_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HCODREL`: _por documentar_
- `HFECPRO`: _por documentar_
- `HFEMCLI`: _por documentar_
- `HMIGCLI`: _por documentar_
- `HRURCLI`: _por documentar_
- `HTIPCOD`: _por documentar_
- `HTOTCLI`: _por documentar_
