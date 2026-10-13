-- mod_rep.com.RSRDMA023: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: R_APADRINA_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSRDMA023.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSRDMA023'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HBDE001 · lee · 4 columna(s)
SELECT TOP (100) [HCODOPE], [HDIAATR], [HFECPRO], [HREGG]
FROM [storage].[com_act].[HBDE001] WITH (NOLOCK);

-- storage.com_act.VCAH001 · lee · 3 columna(s)
SELECT TOP (100) [HCODOPE], [HFECPRO], [HSALCAPMN]
FROM [storage].[com_act].[VCAH001] WITH (NOLOCK);

-- storage.com_act.VCAM001 · lee · 15 columna(s)
SELECT TOP (100) [HCODOPE], [HCODSEC], [HCTACLI], [HDESCLI], [HDIAATR], [HDSUCSEC], [HFECDES], [HFECPRO], [HINDCAR], [HMONDES], [HNOMREG], [HNUMDOC], [HSALCAPMN], [HTIPDOC], [HTOTCUO]
FROM [storage].[com_act].[VCAM001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 10 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUNI], [RDESCOR], [RDESSEC], [RDESUNI], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
