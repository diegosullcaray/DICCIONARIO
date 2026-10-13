-- mod_rep.com.GLISPROSP01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: LIS_PROSPE_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GLISPROSP01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GLISPROSP01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HCMC002 · lee · 40 columna(s)
SELECT TOP (100) [HAPENOMB], [HAPERTCTA], [HASEASIG], [HCANACAP], [HCELULAR], [HCODSEC], [HCODSECASIG], [HCONSLNE], [HCONSRCC], [HCONSRUC], [HCTALICEF], [HDCIIU], [HDEPA], [HDESAGE], [HDESASE], [HDESCOR], [HDESTER], [HDIREC], [HDISTR], [HESTDCORE], [HFECINSTAL], [HFECPRO], [HFIRMADN], [HFOTNEGO], [HGEOLATI], [HGEOLON], [HIDCORRES], [HINSTALAD], [HLICFUNCI], [HMESINST], [HNOMCOM], [HNUMDOC], [HNUMRUC], [HPROSPEC], [HPROV], [HTAPERCC], [HTIPAGENT], [HTIPVINC], [HVINFAMI], [HZONA]
FROM [storage].[com_act].[HCMC002] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 2 columna(s)
SELECT TOP (100) [HCODBT], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);
