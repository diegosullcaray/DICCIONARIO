-- mod_rep.com.RSDESEMP01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: DESEMP_SOC_01, DESE_SOC_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSDESEMP01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSDESEMP01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- mod_rep.util.FFMTVAR · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[util].[FFMTVAR] WITH (NOLOCK);

-- mod_rep.util.FSEMVAR · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[util].[FSEMVAR] WITH (NOLOCK);

-- storage.com_act.WACLI007 · lee · 2 columna(s)
SELECT TOP (100) [HCODSEC], [HFECPRO]
FROM [storage].[com_act].[WACLI007] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 6 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HFECPRO], [HTIPCOD], [HTIPMETA], [HVALVAR]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.wjercor03 · lee · 1 columna(s)
SELECT TOP (100) [Rfecpro]
FROM [storage].[ref].[wjercor03] WITH (NOLOCK);
