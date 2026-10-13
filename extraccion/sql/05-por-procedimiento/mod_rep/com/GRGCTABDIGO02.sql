-- mod_rep.com.GRGCTABDIGO02: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GCTABDIG_VR2_OPE_02
-- Ficha: diccionario/procedimientos/mod_rep/com/GRGCTABDIGO02.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRGCTABDIGO02'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.WUSABCLIENR001 · lee · 3 columna(s)
SELECT TOP (100) [HCODREL], [hfecpro], [htipcod]
FROM [storage].[com_act].[WUSABCLIENR001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.VJERCOR04 · lee · 9 columna(s)
SELECT TOP (100) [RCODAGEH], [RCODMAC], [RCODMAT], [RCODTER], [RDESAGEH], [RDESFC], [RDESMAC], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR04] WITH (NOLOCK);
