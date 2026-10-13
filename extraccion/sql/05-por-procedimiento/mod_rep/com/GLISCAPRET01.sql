-- mod_rep.com.GLISCAPRET01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: LIS_CAPRET_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GLISCAPRET01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GLISCAPRET01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com.VLDRD01 · lee · 17 columna(s)
SELECT TOP (100) [HCODOPE], [HCODSEC], [HCTACLI], [HDCLI], [HDIAATR], [HDREACC], [HDSITCRED], [HFECPRO], [HFFINVIG], [HFINIVIG], [HHORPRO], [HNUMDOC], [HPAIS], [HSALCAPMN], [HTIPDOC], [HTIPOPE], [HTIPSBS]
FROM [storage].[com].[VLDRD01] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 2 columna(s)
SELECT TOP (100) [HCODBT], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);
