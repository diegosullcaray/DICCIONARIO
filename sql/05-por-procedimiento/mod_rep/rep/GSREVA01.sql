-- mod_rep.rep.GSREVA01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GSREVA01, GSREVA101, GSREVA201
-- Ficha: diccionario/procedimientos/mod_rep/rep/GSREVA01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'rep.GSREVA01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.rep.RREGVAR01 · lee · 6 columna(s)
SELECT TOP (100) [RALIVAR], [RAMBGRU], [RCODVAR], [RDESVAR], [RFORV01], [RFORV02]
FROM [mod_rep].[rep].[RREGVAR01] WITH (NOLOCK);

-- mod_rep.rep.SDECCOM01 · lee · 2 columna(s)
SELECT TOP (100) [SCODSUB], [STIPCOD]
FROM [mod_rep].[rep].[SDECCOM01] WITH (NOLOCK);

-- mod_rep.reva.SVARREVA01 · lee · 6 columna(s)
SELECT TOP (100) [SAMBFIL], [SAMBGRU], [SCODMOD], [SCODVAR], [SDESVAR], [SORDREV]
FROM [mod_rep].[reva].[SVARREVA01] WITH (NOLOCK);
