# storage.ref.wjercor01

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `storage` · esquema `ref` · 8 columna(s) usadas · 3 procedimiento(s) · tabla con 14 columna(s) en la base

Consultas listas: [extraccion/sql/03-tablas/storage/ref/wjercor01.sql](../../../../extraccion/sql/03-tablas/storage/ref/wjercor01.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `RCODADM` | ⚠️ no existe | 🎯 exacta | [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md) | — |
| `RCODCOR` | smallint | 🎯 exacta | [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md) | — |
| `RCODGRU` | smallint not null | 🎯 exacta | [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md) | — |
| `RCODSEC` | varchar(10) not null | ✅ confirmada | [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md), [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `RCODTER` | varchar(1) | 🎯 exacta | [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md) | — |
| `RDESGRU` | varchar(11) not null | ≈ inferida | [GRMENTOR002](../../../procedimientos/mod_rep/com/GRMENTOR002.md) | — |
| `RFECPRO` | date | ✅ confirmada | [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md), [GRMENTOR002](../../../procedimientos/mod_rep/com/GRMENTOR002.md), [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |
| `RINDFEC` | varchar(50) | ✅ confirmada | [GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md), [GRMENTOR002](../../../procedimientos/mod_rep/com/GRMENTOR002.md), [RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GRESPDATOS01](../../../procedimientos/mod_rep/com/GRESPDATOS01.md) | lee | `P_Datos_01` |
| [mod_rep.com.GRMENTOR002](../../../procedimientos/mod_rep/com/GRMENTOR002.md) | lee | `RMENTORIN_02` |
| [mod_rep.com.RSEGSECTOR001](../../../procedimientos/mod_rep/com/RSEGSECTOR001.md) | lee | `Sec_ciiu_01` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `RCODADM`: _por documentar_
- `RCODCOR`: _por documentar_
- `RCODGRU`: _por documentar_
- `RCODSEC`: _por documentar_
- `RCODTER`: _por documentar_
- `RDESGRU`: _por documentar_
- `RFECPRO`: _por documentar_
- `RINDFEC`: _por documentar_
