-- mod_rep.com.GRTABCORRO01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: TABDIG_02
-- Ficha: diccionario/procedimientos/mod_rep/com/GRTABCORRO01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRTABCORRO01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HCMC001 · lee · 3 columna(s)
SELECT TOP (100) [HCODIGOCB], [HESTADOTX], [hfecpro]
FROM [storage].[com_act].[HCMC001] WITH (NOLOCK);

-- storage.com_act.HCMC004 · lee · 6 columna(s)
SELECT TOP (100) [HCODREDEXT], [HCODSUC], [HESTCORR], [HFECINSTALA], [HFECPRO], [HNOMCOR]
FROM [storage].[com_act].[HCMC004] WITH (NOLOCK);

-- storage.com_act.SDAS021 · lee · 4 columna(s)
SELECT TOP (100) [SAGENCI], [SCORRED], [SCORRES], [STERRIT]
FROM [storage].[com_act].[SDAS021] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.VJERCOR03 · lee · 7 columna(s)
SELECT TOP (100) [RCODAGE], [RCODCOR], [RCODMAT], [RCODTER], [RDESCOR], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR03] WITH (NOLOCK);
