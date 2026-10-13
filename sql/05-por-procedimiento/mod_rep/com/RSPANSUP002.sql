-- mod_rep.com.RSPANSUP002: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: PANEL_SUP_02, PANEL_SUP_02
-- Ficha: diccionario/procedimientos/mod_rep/com/RSPANSUP002.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSPANSUP002'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.VDSC001 · lee · 13 columna(s)
SELECT TOP (100) [HAGDEP], [HASESUP], [HCARGO], [HCDEFIN], [HCODASE], [HDESCLI], [HFECPRO], [HFECVIS], [HJUSTIF], [HMDESOL], [HNTOPE], [HPERSUP], [HTCANAL]
FROM [storage].[com_act].[VDSC001] WITH (NOLOCK);

-- storage.ref.RCAR001 · lee · 2 columna(s)
SELECT TOP (100) [RCODCAR], [RDESCAR]
FROM [storage].[ref].[RCAR001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 5 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUNI]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
