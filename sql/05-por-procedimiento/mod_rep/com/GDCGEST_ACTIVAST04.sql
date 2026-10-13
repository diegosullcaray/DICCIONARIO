-- mod_rep.com.GDCGEST_ACTIVAST04: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GST_ACTIVAS_09, GST_ACTIVAS_10
-- Ficha: diccionario/procedimientos/mod_rep/com/GDCGEST_ACTIVAST04.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GDCGEST_ACTIVAST04'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.WACLI001 · lee · 1 columna(s)
SELECT TOP (100) [hfecpro]
FROM [storage].[com_act].[WACLI001] WITH (NOLOCK);

-- storage.com_act.WGATH002 · lee · 20 columna(s)
SELECT TOP (100) [HFECPRO], [HGESTTAS], [HMDES], [HTDES], [HTMIN], [HUCAP_FIN], [ORD], [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [RFEC]
FROM [storage].[com_act].[WGATH002] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 4 columna(s)
SELECT TOP (100) [RANI], [RDIAFER], [RMESNOM], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
