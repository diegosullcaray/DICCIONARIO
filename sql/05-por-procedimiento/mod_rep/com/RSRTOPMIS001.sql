-- mod_rep.com.RSRTOPMIS001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: prod_misi_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSRTOPMIS001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSRTOPMIS001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.RETP006 · lee · 4 columna(s)
SELECT TOP (100) [RCODMOD], [RDESSUBP], [RSUBTIP], [RTIPOPE]
FROM [storage].[com_act].[RETP006] WITH (NOLOCK);

-- storage.com_act.SDAF002 · lee · 2 columna(s)
SELECT TOP (100) [scodagr], [sfecpro]
FROM [storage].[com_act].[SDAF002] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 5 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HTIPCOD], [HVALVAR], [hfecpro]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 10 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESTER], [RINDFEC], [rfecpro]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
