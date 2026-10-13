-- mod_rep.com.RSRDFCA050: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: Monitor_Dese_misi_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSRDFCA050.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSRDFCA050'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HCDA001 · lee · 1 columna(s)
SELECT TOP (100) [HFECPRO]
FROM [storage].[com_act].[HCDA001] WITH (NOLOCK);

-- storage.com_act.RETP006 · lee · 4 columna(s)
SELECT TOP (100) [RCODMOD], [RDESSUBP], [RSUBTIP], [RTIPOPE]
FROM [storage].[com_act].[RETP006] WITH (NOLOCK);

-- storage.com_act.SDAF001 · lee · 1 columna(s)
SELECT TOP (100) [SFECPRO]
FROM [storage].[com_act].[SDAF001] WITH (NOLOCK);

-- storage.com_act.SDAF003 · lee · 9 columna(s)
SELECT TOP (100) [SCODAGR], [SCODMOD], [SFECDES], [SFECPRO], [SHORPRO], [SMONDESMN], [SNUMOPE], [SSUBTIP], [STIPOPE]
FROM [storage].[com_act].[SDAF003] WITH (NOLOCK);

-- storage.com_act.SDAS004 · lee · 9 columna(s)
SELECT TOP (100) [HCODMOD], [HSUBTIP], [HTIPOPE], [SCODAGR], [SFECPRO], [SMDESMN], [SSCAPFMN], [SSCAPIMN], [SSCASMN]
FROM [storage].[com_act].[SDAS004] WITH (NOLOCK);

-- storage.com_act.SDAS010 · lee · 2 columna(s)
SELECT TOP (100) [SFECPRO], [SHORPRO]
FROM [storage].[com_act].[SDAS010] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 16 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESFC], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
