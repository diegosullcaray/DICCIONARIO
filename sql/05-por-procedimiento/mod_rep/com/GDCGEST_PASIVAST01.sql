-- mod_rep.com.GDCGEST_PASIVAST01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GST_PASIVA_01, GST_PASIVA_02, GST_PASIVA_03, GST_PASIVA_M_01, GST_PASIVA_M_02, GST_PASIVA_M_03
-- Ficha: diccionario/procedimientos/mod_rep/com/GDCGEST_PASIVAST01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GDCGEST_PASIVAST01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_pas.WBAUT001 · lee · 2 columna(s)
SELECT TOP (100) [HCOFIC], [HFECPRO]
FROM [storage].[com_pas].[WBAUT001] WITH (NOLOCK);

-- storage.ref.VJERCOR03 · lee · 10 columna(s)
SELECT TOP (100) [RCODAGE], [RCODCOR], [RCODFC], [RCODMAT], [RCODTER], [RDESAGE], [RDESCOR], [RDESFC], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR03] WITH (NOLOCK);
