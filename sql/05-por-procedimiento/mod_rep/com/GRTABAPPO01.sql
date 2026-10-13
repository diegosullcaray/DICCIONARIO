-- mod_rep.com.GRTABAPPO01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: TABDIG_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GRTABAPPO01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRTABAPPO01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.piv.TPIVCONF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[piv].[TPIVCONF] WITH (NOLOCK);

-- mod_rep.piv.TPIVFIL · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[piv].[TPIVFIL] WITH (NOLOCK);

-- mod_rep.piv.TPIVVAR · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[piv].[TPIVVAR] WITH (NOLOCK);

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- storage.com_act.HTDA001 · lee · 9 columna(s)
SELECT TOP (100) [HCANAL], [HDESPROC], [HFECPRO], [HMONTO], [HNUMDOC], [HTIPDOC], [HTOTINTE], [RCODSUC], [htiptrax]
FROM [storage].[com_act].[HTDA001] WITH (NOLOCK);

-- storage.com_act.WHDV001 · lee · 2 columna(s)
SELECT TOP (100) [hcodrel], [htipcod]
FROM [storage].[com_act].[WHDV001] WITH (NOLOCK);

-- storage.com_act.WHDV002 · lee · 2 columna(s)
SELECT TOP (100) [hcodrel], [htipcod]
FROM [storage].[com_act].[WHDV002] WITH (NOLOCK);

-- storage.com_act.WHOP001 · lee · 2 columna(s)
SELECT TOP (100) [hcodrel], [htipcod]
FROM [storage].[com_act].[WHOP001] WITH (NOLOCK);

-- storage.com_act.WTRXMON001 · lee · 1 columna(s)
SELECT TOP (100) [RCODSUC]
FROM [storage].[com_act].[WTRXMON001] WITH (NOLOCK);

-- storage.com.WJAS004 · lee · 2 columna(s)
SELECT TOP (100) [hfecpro], [htipcod]
FROM [storage].[com].[WJAS004] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [MM], [RDIAFER], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.vjercor03 · lee · 10 columna(s)
SELECT TOP (100) [RCODAGE], [RCODCOR], [RCODFC], [RCODMAT], [RCODTER], [RDESAGE], [RDESCOR], [RDESFC], [RDESMAT], [RDESTER]
FROM [storage].[ref].[vjercor03] WITH (NOLOCK);
