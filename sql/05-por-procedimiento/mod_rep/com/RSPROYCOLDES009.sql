-- mod_rep.com.RSPROYCOLDES009: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: PROYEC_COLREC_03
-- Ficha: diccionario/procedimientos/mod_rep/com/RSPROYCOLDES009.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSPROYCOLDES009'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.com.Datos_PD · elimina-objeto, lee · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[com].[Datos_PD] WITH (NOLOCK);

-- mod_rep.dbo.Datos_PD · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[dbo].[Datos_PD] WITH (NOLOCK);

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- STORAGE.com_act.HBPDR001 · lee · 2 columna(s)
SELECT TOP (100) [HFECPRO], [hfecreg]
FROM [STORAGE].[com_act].[HBPDR001] WITH (NOLOCK);
