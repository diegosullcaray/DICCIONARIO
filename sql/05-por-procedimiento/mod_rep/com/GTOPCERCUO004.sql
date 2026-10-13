-- mod_rep.com.GTOPCERCUO004: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: CEROCUOTA_TOPCNUEVA_04, CEROCUOTA_TOPCNUEVA_M_04
-- Ficha: diccionario/procedimientos/mod_rep/com/GTOPCERCUO004.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GTOPCERCUO004'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HCDA001 · lee · 1 columna(s)
SELECT TOP (100) [HFECPRO]
FROM [storage].[com_act].[HCDA001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 6 columna(s)
SELECT TOP (100) [RDESCOR], [RDESGRU], [RDESTER], [RDESUNI], [RINDFEC], [rfecpro]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
