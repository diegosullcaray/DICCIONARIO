-- mod_rep.com.RSRTOPPOMIS002: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: pob_misi_02
-- Ficha: diccionario/procedimientos/mod_rep/com/RSRTOPPOMIS002.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSRTOPPOMIS002'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.wacli007 · lee · 7 columna(s)
SELECT TOP (100) [HCODPER], [HCODSEC], [HINDBANC], [HINDGEN], [HINDRUR], [HINDVULN], [hfecpro]
FROM [storage].[com_act].[wacli007] WITH (NOLOCK);

-- storage.com.metas_saldos_anual · lee · 5 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HTIPCOD], [HVALVAR], [hfecpro]
FROM [storage].[com].[metas_saldos_anual] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 10 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESTER], [RINDFEC], [rfecpro]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
