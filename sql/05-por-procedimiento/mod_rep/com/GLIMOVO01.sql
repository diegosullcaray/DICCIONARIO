-- mod_rep.com.GLIMOVO01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: PLANMOV_01, PLANMOVPERFIL_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GLIMOVO01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GLIMOVO01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- STORAGE.com_act.HBMOV001 · lee · 16 columna(s)
SELECT TOP (100) [HCODGEOR], [HCODSEC], [HCTACLI], [HDISTR], [HDISTREC], [HDISTR_LLEGADA], [HDPT], [HFECREG], [HMONTDIS], [HMOTIV], [HNUMDOC], [HNUMREG], [HPROV], [hfecpro], [mm], [yyyy]
FROM [STORAGE].[com_act].[HBMOV001] WITH (NOLOCK);

-- storage.com_act.VCAH001 · lee · 2 columna(s)
SELECT TOP (100) [hctacli], [hdescli]
FROM [storage].[com_act].[VCAH001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 16 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESFC], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
