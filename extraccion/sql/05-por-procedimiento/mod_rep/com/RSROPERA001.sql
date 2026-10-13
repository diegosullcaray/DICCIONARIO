-- mod_rep.com.RSROPERA001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: TB_PANEL_OPE_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSROPERA001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSROPERA001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_pas.wjas007 · lee · 5 columna(s)
SELECT TOP (100) [HCODREL], [HFECPRO], [HNUMCLI], [HTIPCOD], [RDESCPROD]
FROM [storage].[com_pas].[wjas007] WITH (NOLOCK);

-- storage.com_pas.WJAS008 · lee · 6 columna(s)
SELECT TOP (100) [HCODREL], [HSALFENO], [HSALFESI], [HTIPCOD], [RDESCPROD], [hfecpro]
FROM [storage].[com_pas].[WJAS008] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 2 columna(s)
SELECT TOP (100) [HCODVAR], [hfecpro]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.VJERCOR04 · lee · 9 columna(s)
SELECT TOP (100) [RCODAGEH], [RCODMAC], [RCODMAT], [RCODTER], [RDESAGEH], [RDESFC], [RDESMAC], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR04] WITH (NOLOCK);
