-- mod_rep.com.RSSALCAR03: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_SAL_CAR_03
-- Ficha: diccionario/procedimientos/mod_rep/com/RSSALCAR03.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSSALCAR03'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.WJAS001 · lee · 5 columna(s)
SELECT TOP (100) [HCODREL], [HFECPRO], [HNUMSECGMES], [HNUMSECIMES], [HTIPCOD]
FROM [storage].[com_act].[WJAS001] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 5 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HFECPRO], [HTIPCOD], [HVALVAR]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC], [RFECTXT]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 16 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESFC], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
