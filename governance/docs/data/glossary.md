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

| Estado | Significa |
|---|---|
| ⏳ pendiente | solo se conoce por `reportes.json`: falta extraer su cuerpo |
| ❌ no existe en la base | el motor confirma que el SP del catálogo no existe: el reporte falla (`sp-inexistente`) |
| 🔎 extraído | su cuerpo está en `procedimientos/` y fue analizado |
| ✅ validado | además, el motor resolvió sus dependencias sin error |

## Confianza de una columna

| Marca | Significa |
|---|---|
| ✅ confirmada | la registra el motor **y** la vio el análisis o la estructura |
| 🗄️ motor | solo la registra el motor (p. ej. la usa SQL dinámico o una vista) |
| 🎯 exacta | el analizador la vio calificada (`t.COL`) o en la lista de un `INSERT` |
| 🧩 por estructura | sin calificar entre varias tablas; la estructura real dice que solo una la tiene |
| ≈ inferida | sin calificar, en una consulta con una sola tabla de origen: probable, no seguro |

Si ninguna de las tablas candidatas tiene la columna, es un alias o una columna de CTE y no se atribuye.
Si varias la tienen, queda como hallazgo `columna-sin-resolver`.

## Tipos de objeto

| Término | Qué es |
|---|---|
| Tabla de trabajo | tabla permanente que el propio SP crea (`SELECT … INTO`) y borra en cada ejecución |
| Otros objetos | lo que el motor lista y no es tabla: funciones (`util.FFMTVAR`), tipos de tabla (`piv.TPIVCONF`), SP, alias sin resolver |
| Temporal | `#tabla` o `@variable` tabla: no se documenta como tabla del diccionario |

## Operaciones sobre una tabla

`lee` · `inserta` · `actualiza` · `elimina` · `fusiona` (MERGE) · `crea` (SELECT INTO / CREATE) ·
`trunca` · `escribe` (el motor dice que se escribe, sin decir cómo).

## Otros

| Término | Qué es |
|---|---|
| Base | base de datos de SQL Server (`mod_rep`, `strategos`, `mod_gpa`, `mod_sec`, `storage`) |
| Esquema implícito | tabla nombrada sin esquema (`FROM TABLA`): se asume el del SP, pero SQL Server la resuelve según el usuario que ejecuta. Confirmar con el motor |
| Analizador estático | `governance/scripts/lib/tsql.mjs`: lee el texto del SP sin ejecutarlo |
| Estructura | columnas reales de las tablas, de `INFORMATION_SCHEMA` (`fuente/estructura/`) |
| Línea base | hallazgos conocidos que no bloquean `npm run verificar` (`governance/linea-base.json`) |
| Motor | lo que SQL Server registra en `sys.dm_sql_referenced_entities` y `sys.sql_expression_dependencies` |
| `FTHEACOLS01` | SP `mod_rep.rep.FTHEACOLS01`. `GSELREP001` lo invoca con su propio RCODREP (`SEL_EFEC_01`) antes del SELECT principal. Su función está **por confirmar** (el nombre sugiere cabecera de columnas); no figura en `reportes.json` |
