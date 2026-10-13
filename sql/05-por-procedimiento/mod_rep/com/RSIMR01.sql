-- mod_rep.com.RSIMR01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RSIMR_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSIMR01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSIMR01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.WIMR001 · lee · 2 columna(s)
SELECT TOP (100) [haseoper], [hfecpro]
FROM [storage].[com_act].[WIMR001] WITH (NOLOCK);

-- storage.ref.rcalen001 · lee · 2 columna(s)
SELECT TOP (100) [RFEC], [rciebt]
FROM [storage].[ref].[rcalen001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 8 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODTER], [RCODUCO], [RCODUNI], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
