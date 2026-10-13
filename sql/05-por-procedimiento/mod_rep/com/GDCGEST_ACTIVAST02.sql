-- mod_rep.com.GDCGEST_ACTIVAST02: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: reporte_autonomia_newdiaria_01, reporte_autonomia_new_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GDCGEST_ACTIVAST02.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GDCGEST_ACTIVAST02'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.dbo.a · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[dbo].[a] WITH (NOLOCK);

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- storage.com_act.WGATH001 · lee · 14 columna(s)
SELECT TOP (100) [HFECPRO], [HGESTTAS], [HMDES], [HUCAP_FIN], [ORD], [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESUCO], [RDESUNI], [RFEC]
FROM [storage].[com_act].[WGATH001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 4 columna(s)
SELECT TOP (100) [RANI], [RCIEMES], [RMESNOM], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 6 columna(s)
SELECT TOP (100) [RCODSEC], [RDESCOR], [RDESGRU], [RDESSEC], [RDESTER], [RFECPRO]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
