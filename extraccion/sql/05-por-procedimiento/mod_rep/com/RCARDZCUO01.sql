-- mod_rep.com.RCARDZCUO01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_CARD_ZCUO_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RCARDZCUO01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RCARDZCUO01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.WZCUO001 · lee · 10 columna(s)
SELECT TOP (100) [HDIAATR], [HFECPRO], [HSALCAPMN], [RCODCOR], [RCODFC], [RCODGRU], [RCODTER], [RCODUCO], [RCODUNI], [nuevo_ingreso]
FROM [storage].[com_act].[WZCUO001] WITH (NOLOCK);
