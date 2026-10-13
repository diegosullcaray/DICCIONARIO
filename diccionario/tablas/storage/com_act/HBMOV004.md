# STORAGE.com_act.HBMOV004

<!-- generado:inicio ficha -->
<!-- Generado por governance/scripts/generar-diccionario.mjs. No editar dentro de este bloque: se regenera. -->

Base `STORAGE` · esquema `com_act` · 3 columna(s) usadas · 1 procedimiento(s) · tabla con 4 columna(s) en la base

Consultas listas: [sql/03-tablas/STORAGE/com_act/HBMOV004.sql](../../../../sql/03-tablas/STORAGE/com_act/HBMOV004.sql)

### Columnas usadas

| Columna | Tipo | Confianza | Usada por | Descripción |
|---|---|---|---|---|
| `CODIGO_BT` | varchar(25) | ✅ confirmada | [GLIMOVO02](../../../procedimientos/mod_rep/com/GLIMOVO02.md) | — |
| `FLAG_PAGADOR` | smallint | ✅ confirmada | [GLIMOVO02](../../../procedimientos/mod_rep/com/GLIMOVO02.md) | — |
| `HFECPRO` | date not null | ✅ confirmada | [GLIMOVO02](../../../procedimientos/mod_rep/com/GLIMOVO02.md) | — |

### Procedimientos que la usan

| Procedimiento | Operación | Reportes |
|---|---|---|
| [mod_rep.com.GLIMOVO02](../../../procedimientos/mod_rep/com/GLIMOVO02.md) | lee | `PLANMOV_02`, `PLANMOVPERFIL_02` |
<!-- generado:fin -->

## Descripción

_Por documentar: qué representa una fila, quién la carga y cada cuánto._

## Columnas

Una línea por columna con el formato `` - `COLUMNA`: descripción ``. El generador las copia a la tabla de arriba.

- `CODIGO_BT`: _por documentar_
- `FLAG_PAGADOR`: _por documentar_
- `HFECPRO`: _por documentar_
