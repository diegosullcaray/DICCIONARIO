-- mod_rep.com.RSSEGPDM01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: SEG_PDM_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSSEGPDM01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSSEGPDM01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.WPDM001 · lee · 17 columna(s)
SELECT TOP (100) [HCODREL], [HFECPRO], [HNROG], [HNROG_ANT], [HNROG_DESEM], [HNUMCLI], [HNUMCLI_ANT], [HSALCAPMN], [HSALCAPMN_1_30], [HSALCAPMN_1_30_ANT], [HSALCAPMN_ANT], [HSALCAPMN_ma_30], [HSALCAPMN_ma_30_ANT], [HTIPCOD], [HULTVEN_RECUR_DESEM], [NUEVO_DESEM], [RECURRENTE_DESEM]
FROM [storage].[com_act].[WPDM001] WITH (NOLOCK);

-- storage.com.metas_saldos · lee · 10 columna(s)
SELECT TOP (100) [10044], [10062], [8000], [HCODREL], [HCODVAR], [HFECPRO], [HTIPCOD], [HTIPMETA], [HVALVAR], [PVT]
FROM [storage].[com].[metas_saldos] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 12 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESFC], [RDESGRU], [RDESTER], [RDESUCO], [RDESUNI]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
