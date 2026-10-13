-- mod_rep.com.RSSEGPAS03: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_SEG_PAS_03
-- Ficha: diccionario/procedimientos/mod_rep/com/RSSEGPAS03.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSSEGPAS03'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_seg.RETC001 · lee · 2 columna(s)
SELECT TOP (100) [HCODSEG], [HCOMIFC]
FROM [storage].[com_seg].[RETC001] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 5 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HTIPCOD], [HVALVAR], [hfecpro]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RDIAFER], [RDIASEM], [RFEC]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
