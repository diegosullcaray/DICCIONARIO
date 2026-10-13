-- mod_rep.com.GSELJERAR002: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: SEL_JER_MENTORING_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GSELJERAR002.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GSELJERAR002'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.ref.WJERCOR03 · lee · 8 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUNI], [RDESSEC], [RINDFEC], [rfecpro]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
