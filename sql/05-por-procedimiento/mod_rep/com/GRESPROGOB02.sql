-- mod_rep.com.GRESPROGOB02: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RPROGOB_03, RPROGOB_M_03, RPROGOB_04, RPROGOB_M_04
-- Ficha: diccionario/procedimientos/mod_rep/com/GRESPROGOB02.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRESPROGOB02'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- storage.com_act.HCDA001 · lee · 5 columna(s)
SELECT TOP (100) [HASEOPER], [HCODMOD], [HFECPRO], [HSUBTIP], [HTIPOPE]
FROM [storage].[com_act].[HCDA001] WITH (NOLOCK);

-- storage.com_act.RETP001 · lee · 3 columna(s)
SELECT TOP (100) [RCODMOD], [RCODPROD], [RTIPOPE]
FROM [storage].[com_act].[RETP001] WITH (NOLOCK);

-- storage.com_act.RETP002 · lee · 4 columna(s)
SELECT TOP (100) [RCODMOD], [RCODPROD], [RSUBTIP], [RTIPOPE]
FROM [storage].[com_act].[RETP002] WITH (NOLOCK);

-- storage.com_act.RETP003 · lee · 3 columna(s)
SELECT TOP (100) [RCODPROD], [RDESGRU01], [RDESPROD]
FROM [storage].[com_act].[RETP003] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 16 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESFC], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
