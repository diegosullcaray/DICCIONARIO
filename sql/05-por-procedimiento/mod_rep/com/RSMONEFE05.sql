-- mod_rep.com.RSMONEFE05: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_MON_EFEC_SEC_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSMONEFE05.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSMONEFE05'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.WCED001 · lee · 28 columna(s)
SELECT TOP (100) [HCODMON], [HCODOPE], [HCODSEC], [HCTACLI], [HDCODSEC], [HDESCLI], [HDIAATR], [HESTC], [HFCCOM], [HFCFGEST], [HFCFVPP], [HFCMPP], [HFCRES], [HFCRSPB], [HFDGPR], [HFECDES], [HFGPR], [HFTVEN], [HINDUCUO], [HINDZCUO], [HMONDES], [HNIVSOB], [HPROBR], [HREGG], [HREGN], [HSALCAPMN], [HTRAM], [RDESPROD]
FROM [storage].[com_act].[WCED001] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 2 columna(s)
SELECT TOP (100) [HCODBT], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC], [RFECTXT]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
