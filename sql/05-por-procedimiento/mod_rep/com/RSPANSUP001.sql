-- mod_rep.com.RSPANSUP001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: PANEL_SUP_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSPANSUP001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSPANSUP001'), 1)
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

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- mod_sys_login.dbo.SUSEALT01 · lee · 1 columna(s)
SELECT TOP (100) [SFECCRE]
FROM [mod_sys_login].[dbo].[SUSEALT01] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 3 columna(s)
SELECT TOP (100) [HCODREL], [HFECPRO], [HTIPCOD]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.gpr.HPAD001 · lee · 2 columna(s)
SELECT TOP (100) [HCODPER], [HMAILPER]
FROM [storage].[gpr].[HPAD001] WITH (NOLOCK);

-- storage.gpr.HPVP001 · lee · 3 columna(s)
SELECT TOP (100) [HCODBT], [HDIAS], [HFECPRO]
FROM [storage].[gpr].[HPVP001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC], [RFECTXT]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.RECCA001 · lee · 2 columna(s)
SELECT TOP (100) [RCODTER], [RUSUADM]
FROM [storage].[ref].[RECCA001] WITH (NOLOCK);

-- storage.ref.RECCT001 · lee · 2 columna(s)
SELECT TOP (100) [RUSUADM], [rcodcor]
FROM [storage].[ref].[RECCT001] WITH (NOLOCK);

-- storage.ref.RECUC001 · lee · 2 columna(s)
SELECT TOP (100) [RCODADM], [RCODUNI]
FROM [storage].[ref].[RECUC001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 1 columna(s)
SELECT TOP (100) [RCODSEC]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
