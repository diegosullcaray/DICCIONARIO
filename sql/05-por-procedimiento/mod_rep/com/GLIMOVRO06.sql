-- mod_rep.com.GLIMOVRO06: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: PLANMOVR_04
-- Ficha: diccionario/procedimientos/mod_rep/com/GLIMOVRO06.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GLIMOVRO06'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_sys_admin.dbo.SUSEPROF01 · lee · 2 columna(s)
SELECT TOP (100) [SCODPROFN], [SCODUSE]
FROM [mod_sys_admin].[dbo].[SUSEPROF01] WITH (NOLOCK);

-- storage.com_act.HBMOV003 · lee · 15 columna(s)
SELECT TOP (100) [CODIGO_BT], [Cta_Cliente], [Distrito], [FECHA], [FILTRO2], [FILTRO3], [FILTRO4], [FILTRO5], [FILTRO6], [FILTRO7], [HCOMENT], [HFECPRO], [HLATIT], [HLONG], [HORA]
FROM [storage].[com_act].[HBMOV003] WITH (NOLOCK);

-- storage.com_act.HCDA001 · lee · 3 columna(s)
SELECT TOP (100) [HCTACLI], [HDESCLI], [HFECPRO]
FROM [storage].[com_act].[HCDA001] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 3 columna(s)
SELECT TOP (100) [HCODBT], [HMAILPER], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RFEC], [rciebt]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
