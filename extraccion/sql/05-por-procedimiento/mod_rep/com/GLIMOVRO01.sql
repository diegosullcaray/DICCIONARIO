-- mod_rep.com.GLIMOVRO01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: PLANMOVR_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GLIMOVRO01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GLIMOVRO01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_sys_admin.dbo.SUSEPROF01 · lee · 2 columna(s)
SELECT TOP (100) [SCODPROFN], [SCODUSE]
FROM [mod_sys_admin].[dbo].[SUSEPROF01] WITH (NOLOCK);

-- storage.com_act.HBMOV001 · lee · 19 columna(s)
SELECT TOP (100) [GRUPo], [HCODGEOR], [HCODSEC], [HCTACLI], [HDESCLI], [HDESPER], [HDISTR], [HDISTREC], [HDISTR_LLEGADA], [HDPT], [HFECEMI], [HFECREG], [HMONTDIS], [HMOTIV], [HNUMDOC], [HNUMDOCCLI], [HNUMREG], [HPROV], [hfecpro]
FROM [storage].[com_act].[HBMOV001] WITH (NOLOCK);

-- storage.com_act.VCAH001 · lee · 2 columna(s)
SELECT TOP (100) [hctacli], [hdescli]
FROM [storage].[com_act].[VCAH001] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 3 columna(s)
SELECT TOP (100) [HCODBT], [HMAILPER], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);
