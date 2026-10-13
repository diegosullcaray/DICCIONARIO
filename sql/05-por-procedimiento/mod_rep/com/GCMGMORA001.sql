-- mod_rep.com.GCMGMORA001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: cuadro_Variable_Riesgo_01, cuadro_Variable_M_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GCMGMORA001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GCMGMORA001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.SBTVRIE001 · lee · 12 columna(s)
SELECT TOP (100) [SCODREL], [SFECPRO], [SGASPROVBRUTO12M], [SGASPROVCART], [SGASPROVCONTA], [SGASPROVOM3155], [SGASPROVVOLU], [SMONREC], [SRECCAST12M], [SSTKPROV], [STASREC], [STIPCOD]
FROM [storage].[com_act].[SBTVRIE001] WITH (NOLOCK);

-- storage.com_act.SDAS005 · lee · 3 columna(s)
SELECT TOP (100) [SCODAGR], [SFECPRO], [SSRECUMN]
FROM [storage].[com_act].[SDAS005] WITH (NOLOCK);

-- storage.com_act.wjas002 · lee · 5 columna(s)
SELECT TOP (100) [HFECPRO], [HVENTA_CARTMN], [HVENTA_CARTMN12M], [hcodrel], [htipcod]
FROM [storage].[com_act].[wjas002] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 6 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HFECPRO], [HTIPCOD], [HTIPMETA], [HVALVAR]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);
