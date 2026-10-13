-- mod_rep.com.RSSEGPAS01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_SEG_PAS_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSSEGPAS01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSSEGPAS01'), 1)
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

-- storage.com.VDMCOM01 · lee · 7 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HTIPCOD], [HVALVAR], [Tip_cod], [hfecpro], [tip_cod2]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RDIAFER], [RDIASEM], [RFEC]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.VJERCOR04 · lee · 10 columna(s)
SELECT TOP (100) [RCODAGE], [RCODFC], [RCODMAC], [RCODMAT], [RCODTER], [RDESAGE], [RDESFC], [RDESMAC], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR04] WITH (NOLOCK);
