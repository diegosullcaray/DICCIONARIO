-- mod_rep.com.GSELJERAR001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: SEL_JER_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GSELJERAR001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GSELJERAR001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- storage.com_act.HCMC001 · lee · 4 columna(s)
SELECT TOP (100) [HESTADOTX], [HFECPRO], [HNOMBREPTO], [HNOMTITCB]
FROM [storage].[com_act].[HCMC001] WITH (NOLOCK);

-- storage.ref.REGCIIU003 · lee · 2 columna(s)
SELECT TOP (100) [RCODCIIU], [RDESCIIU]
FROM [storage].[ref].[REGCIIU003] WITH (NOLOCK);

-- storage.ref.REUBI01 · lee · 3 columna(s)
SELECT TOP (100) [RDESDEP], [RDESDIS], [RDESPRO]
FROM [storage].[ref].[REUBI01] WITH (NOLOCK);

-- storage.ref.vjercor03 · lee · 4 columna(s)
SELECT TOP (100) [RDESAGE], [RDESCOR], [RDESMAT], [RDESTER]
FROM [storage].[ref].[vjercor03] WITH (NOLOCK);
