-- mod_rep.com.RCORRES05: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GREPORCORRE_05
-- Ficha: diccionario/procedimientos/mod_rep/com/RCORRES05.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RCORRES05'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- STORAGE.com_act.HCGEO002 · lee · 1 columna(s)
SELECT TOP (100) [HNOMCOR]
FROM [STORAGE].[com_act].[HCGEO002] WITH (NOLOCK);

-- storage.com_act.HCMC001 · lee · 2 columna(s)
SELECT TOP (100) [HMUNICB], [HNOMBREPTO]
FROM [storage].[com_act].[HCMC001] WITH (NOLOCK);

-- storage.com_act.SDAS021 · lee · 1 columna(s)
SELECT TOP (100) [SCORRES]
FROM [storage].[com_act].[SDAS021] WITH (NOLOCK);

-- storage.ref.vjercor03 · lee · 6 columna(s)
SELECT TOP (100) [RCODCOR], [RCODMAT], [RCODTER], [RDESCOR], [RDESMAT], [RDESTER]
FROM [storage].[ref].[vjercor03] WITH (NOLOCK);
