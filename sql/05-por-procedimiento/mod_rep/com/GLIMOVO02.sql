-- mod_rep.com.GLIMOVO02: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: PLANMOV_02, PLANMOVPERFIL_02
-- Ficha: diccionario/procedimientos/mod_rep/com/GLIMOVO02.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GLIMOVO02'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HBMOV003 · lee · 8 columna(s)
SELECT TOP (100) [HFECPRO], [codigo_bt], [filtro2], [filtro3], [filtro4], [filtro5], [filtro6], [filtro7]
FROM [storage].[com_act].[HBMOV003] WITH (NOLOCK);

-- storage.com_act.HBMOV004 · lee · 3 columna(s)
SELECT TOP (100) [CODIGO_BT], [FLAG_PAGADOR], [HFECPRO]
FROM [storage].[com_act].[HBMOV004] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 2 columna(s)
SELECT TOP (100) [HCODBT], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);
