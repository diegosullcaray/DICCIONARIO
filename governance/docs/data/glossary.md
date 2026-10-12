# Glosario

Vocabulario canónico del diccionario. Los términos de contrato coinciden con el
[glosario de MIS-angular-front](https://github.com/diegosullcaray/MIS-angular-front/blob/main/governance/docs/data/glossary.md):
el mismo nombre significa lo mismo en los dos repositorios.

## Términos del catálogo

| Término | Qué es |
|---|---|
| `RCODREP` | código de reporte en `fuente/reportes.json`. Es el `cod_rep` que pide el front |
| `RDESREP` | descripción del reporte, tal como figura en el backend |
| `RTPREP.name` | procedimiento que ejecuta el reporte, en la forma `base.esquema.SP` |
| `RTPREP.params` | parámetros que el backend envía, con su `order` |
| SP | procedimiento almacenado de SQL Server. Varios `RCODREP` pueden compartir uno |

## Parámetros de contrato (no se traducen)

Se escriben tal cual los usa el backend. Crear un sinónimo exige registrarlo acá.

| Término | Qué es | Variantes vistas en `reportes.json` |
|---|---|---|
| `tip_cod` | tipo de nodo de la jerarquía organizativa sobre el que se consulta | `tipcod` |
| `cod_rel` | código del nodo de jerarquía | `codrel` |
| `fec` | fecha de corte en formato compacto | — |
| `fecha` | fecha de corte en el formato largo que espera ese SP | `Fecha` |
| `pagen` | página, en consultas paginadas | — |
| `codmod` | código de módulo | — |

`fec` y `fecha` **no** son sinónimos: cada SP espera el suyo con su formato. El validador solo
agrupa variantes de mayúsculas o guion bajo de un mismo nombre (regla `parametro-con-variantes`).

## Estados de un SP

| Estado | Significa | Cómo se llega |
|---|---|---|
| ⏳ pendiente | solo se conoce por `reportes.json` | — |
| 🔎 extraído | su cuerpo está en `procedimientos/` y fue analizado | pegar el cuerpo y `npm run generar` |
| ✅ validado | además, el motor confirmó sus dependencias sin error | CSV de `sql/02-dependencias` en `fuente/dependencias/` |

## Confianza de una columna

| Marca | Significa |
|---|---|
| ✅ confirmada | la vio el analizador **y** la registra el motor |
| 🗄️ motor | solo la registra el motor (p. ej. la usa SQL dinámico o una vista) |
| 🎯 exacta | el analizador la vio calificada (`t.COL`) o en la lista de un `INSERT` |
| ≈ inferida | sin calificar, en una consulta con una sola tabla de origen: es probable, no seguro |

Una columna sin calificar en una consulta con varias tablas **no** se atribuye: queda como hallazgo
`columna-sin-resolver` con sus tablas candidatas.

## Operaciones sobre una tabla

`lee` · `inserta` · `actualiza` · `elimina` · `fusiona` (MERGE) · `crea` (SELECT INTO / CREATE) ·
`trunca` · `escribe` (el motor dice que se escribe, sin decir cómo).

## Otros

| Término | Qué es |
|---|---|
| Base | base de datos de SQL Server (`mod_rep`, `strategos`, `mod_gpa`, `mod_sec`, `storage`) |
| Esquema implícito | tabla nombrada sin esquema (`FROM TABLA`): se asume el del SP, pero SQL Server la resuelve según el usuario que ejecuta. Confirmar con el motor |
| Analizador estático | `governance/scripts/lib/tsql.mjs`: lee el texto del SP sin ejecutarlo |
| Motor | lo que SQL Server registra en `sys.dm_sql_referenced_entities` y `sys.sql_expression_dependencies` |
| `FTHEACOLS01` | SP `mod_rep.rep.FTHEACOLS01`. `GSELREP001` lo invoca con su propio RCODREP (`SEL_EFEC_01`) antes del SELECT principal. Su función está **por confirmar** (el nombre sugiere cabecera de columnas); no figura en `reportes.json` |
