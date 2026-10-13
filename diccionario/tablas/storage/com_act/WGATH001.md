# storage.com_act.WGATH001

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `com_act` · 14 columna(s) usadas · 1 procedimiento(s) · tabla con 91 columna(s) en la base

Consultas listas: [sql/03-tablas/storage/com_act/WGATH001.sql](../../../../sql/03-tablas/storage/com_act/WGATH001.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `HFECPRO` | date | ✅ confirmada | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `HGESTTAS` | int | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `HMDES` | numeric(17,2) | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `HUCAP_FIN` | varchar(50) not null | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `ORD` | bigint | ✅ confirmada | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `RCODCOR` | smallint | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `RCODGRU` | smallint | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `RCODSEC` | varchar(10) | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `RCODTER` | varchar(13) not null | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `RCODUCO` | ⚠️ no existe | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `RCODUNI` | smallint | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `RDESUCO` | ⚠️ no existe | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `RDESUNI` | varchar(100) | 🎯 exacta | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |
| `RFEC` | date | ✅ confirmada | [GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GDCGEST_ACTIVAST02](../../../procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md) | lee | `reporte_autonomia_newdiaria_01`, `reporte_autonomia_new_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `HFECPRO`: _por documentar_
- `HGESTTAS`: _por documentar_
- `HMDES`: _por documentar_
- `HUCAP_FIN`: _por documentar_
- `ORD`: _por documentar_
- `RCODCOR`: _por documentar_
- `RCODGRU`: _por documentar_
- `RCODSEC`: _por documentar_
- `RCODTER`: _por documentar_
- `RCODUCO`: _por documentar_
- `RCODUNI`: _por documentar_
- `RDESUCO`: _por documentar_
- `RDESUNI`: _por documentar_
- `RFEC`: _por documentar_
