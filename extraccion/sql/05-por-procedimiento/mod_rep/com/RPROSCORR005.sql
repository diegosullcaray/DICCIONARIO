-- mod_rep.com.RPROSCORR005: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GREPROSPCORRE_06
-- Ficha: diccionario/procedimientos/mod_rep/com/RPROSCORR005.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RPROSCORR005'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HCMC002 · lee · 3 columna(s)
SELECT TOP (100) [HDESAGE], [HFECINSTAL], [HINSTALAD]
FROM [storage].[com_act].[HCMC002] WITH (NOLOCK);

-- storage.com.metas_saldos · lee · 3 columna(s)
SELECT TOP (100) [HTIPCOD], [hcodvar], [hfecpro]
FROM [storage].[com].[metas_saldos] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RCIEBT], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.VJERCOR03 · lee · 8 columna(s)
SELECT TOP (100) [RCODAGE], [RCODCOR], [RCODMAT], [RCODTER], [RDESAGE], [RDESCOR], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR03] WITH (NOLOCK);
