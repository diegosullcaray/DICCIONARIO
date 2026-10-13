-- mod_rep.com.RRANKM02: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_RANK_MUJ_02
-- Ficha: diccionario/procedimientos/mod_rep/com/RRANKM02.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RRANKM02'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HCDA001 · lee · 6 columna(s)
SELECT TOP (100) [HGENPER], [haseoper], [hfecpro], [hnumdoc], [hpais], [htipdoc]
FROM [storage].[com_act].[HCDA001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 16 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESFC], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [rfecpro], [rindfec]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
