-- mod_rep.com.GRESREPSEG06: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GRSCMIS_05
-- Ficha: diccionario/procedimientos/mod_rep/com/GRESREPSEG06.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRESREPSEG06'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.SDAF002 · lee · 4 columna(s)
SELECT TOP (100) [SCODMOD], [SSUBTIP], [STIPOPE], [sfecpro]
FROM [storage].[com_act].[SDAF002] WITH (NOLOCK);

-- storage.com_seg.SDSF001 · lee · 2 columna(s)
SELECT TOP (100) [scodseg], [sfecpro]
FROM [storage].[com_seg].[SDSF001] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 6 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HTIPCOD], [HTIPMETA], [HVALVAR], [hfecpro]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 8 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RINDFEC], [rfecpro]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
