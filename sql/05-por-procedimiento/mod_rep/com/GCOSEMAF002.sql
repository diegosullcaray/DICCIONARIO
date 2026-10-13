-- mod_rep.com.GCOSEMAF002: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: COSESEMAFORO_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GCOSEMAF002.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GCOSEMAF002'), 1)
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

-- storage.com_act.RETP001 · lee · 3 columna(s)
SELECT TOP (100) [RCODMOD], [RCODPROD], [RTIPOPE]
FROM [storage].[com_act].[RETP001] WITH (NOLOCK);

-- storage.com_act.RETP002 · lee · 4 columna(s)
SELECT TOP (100) [RCODMOD], [RCODPROD], [RSUBTIP], [RTIPOPE]
FROM [storage].[com_act].[RETP002] WITH (NOLOCK);

-- storage.com_act.RETP003 · lee · 1 columna(s)
SELECT TOP (100) [RCODPROD]
FROM [storage].[com_act].[RETP003] WITH (NOLOCK);

-- storage.com_act.RETP009 · lee · 3 columna(s)
SELECT TOP (100) [RCODMOD], [RDESSUBPROD], [RTIPOPE]
FROM [storage].[com_act].[RETP009] WITH (NOLOCK);

-- storage.com_act.SDAS013 · lee · 12 columna(s)
SELECT TOP (100) [SCODAGR], [SCODMOD], [SCODSEC], [SCOSECHA], [SFECPRO], [SNUMOPEBAS], [SNUMOPEMORH], [SSALCAPBAS], [SSALCAPMORH], [SSUBTIP], [STIPOPE], [sfecbas]
FROM [storage].[com_act].[SDAS013] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC], [RFECTXT]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
