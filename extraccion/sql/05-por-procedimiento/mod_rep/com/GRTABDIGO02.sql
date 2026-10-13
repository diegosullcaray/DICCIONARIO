-- mod_rep.com.GRTABDIGO02: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: TABDIG_VR2_COM_02
-- Ficha: diccionario/procedimientos/mod_rep/com/GRTABDIGO02.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRTABDIGO02'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_pas.WCAP002 · lee · 6 columna(s)
SELECT TOP (100) [HASEOPER], [HFECPRO], [HORD], [HPENDOC], [HPEPAIS], [HPETDOC]
FROM [storage].[com_pas].[WCAP002] WITH (NOLOCK);

-- storage.com_pas.WCLIENRO001 · lee · 2 columna(s)
SELECT TOP (100) [HAGUSER], [hcodcan]
FROM [storage].[com_pas].[WCLIENRO001] WITH (NOLOCK);

-- storage.com_pas.WMTCORRE001 · lee · 1 columna(s)
SELECT TOP (100) [HCODCAN]
FROM [storage].[com_pas].[WMTCORRE001] WITH (NOLOCK);

-- storage.com_pas.WTRXMONE001 · lee · 2 columna(s)
SELECT TOP (100) [HNUMDOC], [HTIPDOC]
FROM [storage].[com_pas].[WTRXMONE001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 7 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RDESUNI], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
