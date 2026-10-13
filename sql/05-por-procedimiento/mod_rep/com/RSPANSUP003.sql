-- mod_rep.com.RSPANSUP003: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: PANEL_SUP_03
-- Ficha: diccionario/procedimientos/mod_rep/com/RSPANSUP003.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSPANSUP003'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.api.FUSECDIV01 · — · 0 columna(s)
SELECT TOP (100) *
FROM [storage].[api].[FUSECDIV01] WITH (NOLOCK);

-- storage.com_act.HDSC001 · lee · 4 columna(s)
SELECT TOP (100) [HCARGO], [HFECPRO], [HPERSUP], [HREG]
FROM [storage].[com_act].[HDSC001] WITH (NOLOCK);

-- storage.com_act.HMSUP001 · lee · 10 columna(s)
SELECT TOP (100) [HDESREL], [HFECPRO], [HPOSTCOORPDM], [HPOSTGREG], [HPOSTJAGRO], [HPOSTJINCL], [HPRECOORPDM], [HPREGREG], [HPREJAGRO], [HPREJINCL]
FROM [storage].[com_act].[HMSUP001] WITH (NOLOCK);

-- storage.com_act.SDAS006 · lee · 6 columna(s)
SELECT TOP (100) [SCARGO], [SCODAGR], [SFECPRO], [SOPECONF], [SOPEPRE], [SSUCCLI]
FROM [storage].[com_act].[SDAS006] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 4 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC], [RFECTXT], [day]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.REAM001 · lee · 2 columna(s)
SELECT TOP (100) [RCODAGE], [RCODMAT]
FROM [storage].[ref].[REAM001] WITH (NOLOCK);

-- storage.ref.REMR001 · lee · 3 columna(s)
SELECT TOP (100) [RCODMAT], [RCODREG], [RDESMAT]
FROM [storage].[ref].[REMR001] WITH (NOLOCK);

-- storage.ref.RERT001 · lee · 3 columna(s)
SELECT TOP (100) [RCODREG], [RCODTER], [RDESREG]
FROM [storage].[ref].[RERT001] WITH (NOLOCK);
