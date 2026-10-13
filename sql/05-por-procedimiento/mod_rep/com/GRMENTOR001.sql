-- mod_rep.com.GRMENTOR001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RMENTORIN_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GRMENTOR001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRMENTOR001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.dbo.a · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[dbo].[a] WITH (NOLOCK);

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

-- storage.com_act.SDAE002 · lee · 6 columna(s)
SELECT TOP (100) [SCODSEC], [SSALINIMN], [SSALMAN01MN], [SSALRECMN], [scodagr], [sfecpro]
FROM [storage].[com_act].[SDAE002] WITH (NOLOCK);

-- storage.com_act.SDAE003 · lee · 6 columna(s)
SELECT TOP (100) [SCODSEC], [SSALINIMN], [SSALMAN01MN], [SSALRECMN], [scodagr], [sfecpro]
FROM [storage].[com_act].[SDAE003] WITH (NOLOCK);

-- storage.com_act.SDAF002 · lee · 4 columna(s)
SELECT TOP (100) [SCODAGR], [SNUMOPE], [scodsec], [sfecpro]
FROM [storage].[com_act].[SDAF002] WITH (NOLOCK);

-- storage.com_act.SDAS001 · lee · 4 columna(s)
SELECT TOP (100) [SCODAGR], [SSALCAPMN], [scodsec], [sfecpro]
FROM [storage].[com_act].[SDAS001] WITH (NOLOCK);

-- storage.com_act.wacli001 · lee · 5 columna(s)
SELECT TOP (100) [HCODSEC], [hclinue], [hconcli], [hfecpro], [hinddes]
FROM [storage].[com_act].[wacli001] WITH (NOLOCK);

-- storage.com_act.WAPPCLI001 · lee · 3 columna(s)
SELECT TOP (100) [HAGUSER], [HFECPRO], [htipnumdoc]
FROM [storage].[com_act].[WAPPCLI001] WITH (NOLOCK);

-- storage.com_act.WCDCE001 · lee · 3 columna(s)
SELECT TOP (100) [HCODOPE], [HCODSEC], [hfecpro]
FROM [storage].[com_act].[WCDCE001] WITH (NOLOCK);

-- storage.com_act.WCLIRETE001 · lee · 4 columna(s)
SELECT TOP (100) [HFECPRO], [HNUMCLISTOCK], [HNUMRETENCION], [SCODSEC]
FROM [storage].[com_act].[WCLIRETE001] WITH (NOLOCK);

-- storage.com_act.WJAS001 · lee · 4 columna(s)
SELECT TOP (100) [HNUMCLI], [hcodrel], [hfecpro], [htipcod]
FROM [storage].[com_act].[WJAS001] WITH (NOLOCK);

-- storage.com_seg.SDSF001 · lee · 5 columna(s)
SELECT TOP (100) [SCODSEC], [SFECPRO], [SNUMPLZ], [scodagr], [scodseg]
FROM [storage].[com_seg].[SDSF001] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 5 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HFECPRO], [HTIPCOD], [HVALVAR]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 6 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUNI], [RFECPRO]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
