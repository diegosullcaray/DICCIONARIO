-- mod_rep.com.GRESREPSEG_01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GRSCMISREP_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GRESREPSEG_01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRESREPSEG_01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.SDAF002 · lee · 2 columna(s)
SELECT TOP (100) [SCODAGR], [SFECPRO]
FROM [storage].[com_act].[SDAF002] WITH (NOLOCK);

-- storage.com_seg.retp003 · lee · 5 columna(s)
SELECT TOP (100) [HCODSEG], [HDESSEG], [HSUBTIP], [HTIPOPE], [hcodmod]
FROM [storage].[com_seg].[retp003] WITH (NOLOCK);

-- storage.com_seg.SDSF001 · lee · 3 columna(s)
SELECT TOP (100) [scodagr], [scodseg], [sfecpro]
FROM [storage].[com_seg].[SDSF001] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 3 columna(s)
SELECT TOP (100) [HTIPCOD], [hcodvar], [hfecpro]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
