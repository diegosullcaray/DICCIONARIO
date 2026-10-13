-- mod_rep.com.RSRDFCA036: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: CARACT_pas_M_01, CARACT_pas_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSRDFCA036.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSRDFCA036'), 1)
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

-- mod_rep.util.FSEMVAR · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[util].[FSEMVAR] WITH (NOLOCK);

-- storage.com_pas.WJAS004 · lee · 4 columna(s)
SELECT TOP (100) [HCODREL], [RDESCPROD02], [hfecpro], [htipcod]
FROM [storage].[com_pas].[WJAS004] WITH (NOLOCK);

-- STORAGE.com_pas.WJAS007 · lee · 8 columna(s)
SELECT TOP (100) [HCODPERFEME], [HCODPERRUR], [HCODPERURB], [HCODREL], [HFECPRO], [HNUMCLI], [HTIPCOD], [RDESCPROD]
FROM [STORAGE].[com_pas].[WJAS007] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 2 columna(s)
SELECT TOP (100) [HCODVAR], [hfecpro]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.VJERCOR04 · lee · 12 columna(s)
SELECT TOP (100) [RCODAGE], [RCODAGEH], [RCODFC], [RCODMAC], [RCODMAT], [RCODTER], [RDESAGE], [RDESAGEH], [RDESFC], [RDESMAC], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR04] WITH (NOLOCK);
