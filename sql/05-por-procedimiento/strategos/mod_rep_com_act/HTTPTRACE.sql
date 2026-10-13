-- strategos.mod_rep_com_act.HTTPTRACE: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: HTTPTRACE_01
-- Ficha: diccionario/procedimientos/strategos/mod_rep_com_act/HTTPTRACE.md

USE strategos;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'mod_rep_com_act.HTTPTRACE'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- strategos.sys_met.HTTPTRACE · lee · 1 columna(s)
SELECT TOP (100) [request]
FROM [strategos].[sys_met].[HTTPTRACE] WITH (NOLOCK);
