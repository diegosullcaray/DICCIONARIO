-- mod_rep.com.GRESREPSEG01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GRSCMIS_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GRESREPSEG01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRESREPSEG01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.SDAF002 · lee · 15 columna(s)
SELECT TOP (100) [SCLINUE], [SCODAGR], [SCODMOD], [SCODSEC], [SFECPRO], [SINTMESMN], [SMDNUEMN], [SMONDESMN], [SNUMCLI], [SNUMOPE], [SNUMSEC], [SOPENUE], [SSUBTIP], [SSUCCLI], [STIPOPE]
FROM [storage].[com_act].[SDAF002] WITH (NOLOCK);

-- storage.com_seg.SDSF001 · lee · 11 columna(s)
SELECT TOP (100) [SCODMOD], [SCODSEC], [SFECEMI], [SFECPRO], [SINDPGO], [SNUMPLZ], [SSUBTIP], [SSUCCLI], [STIPOPE], [scodagr], [scodseg]
FROM [storage].[com_seg].[SDSF001] WITH (NOLOCK);

-- storage.com_seg.VCSH006 · lee · 2 columna(s)
SELECT TOP (100) [HCODSEC], [HFECPRO]
FROM [storage].[com_seg].[VCSH006] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 6 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HTIPCOD], [HTIPMETA], [HVALVAR], [hfecpro]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 14 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
