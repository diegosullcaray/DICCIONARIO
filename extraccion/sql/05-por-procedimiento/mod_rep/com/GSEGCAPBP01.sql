-- mod_rep.com.GSEGCAPBP01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: CAP_SEGUI_BP_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GSEGCAPBP01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GSEGCAPBP01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HTDA001 · lee · 4 columna(s)
SELECT TOP (100) [HCANAL], [HNUMDOC], [HTIPDOC], [hfecpro]
FROM [storage].[com_act].[HTDA001] WITH (NOLOCK);

-- storage.com_act.WAPPCLI001 · lee · 2 columna(s)
SELECT TOP (100) [HTIPNUMDOC], [hfecpro]
FROM [storage].[com_act].[WAPPCLI001] WITH (NOLOCK);

-- storage.com_pas.HCDP001 · lee · 8 columna(s)
SELECT TOP (100) [HCODSEC], [HPENDOC], [HPEPAIS], [HPETDOC], [HSBCTA], [HSBOPER], [HSBSBOP], [hfecpro]
FROM [storage].[com_pas].[HCDP001] WITH (NOLOCK);

-- storage.com_pas.RETP001 · lee · 1 columna(s)
SELECT TOP (100) [RDESCPROD02]
FROM [storage].[com_pas].[RETP001] WITH (NOLOCK);

-- storage.com_pas.WJAS009 · lee · 4 columna(s)
SELECT TOP (100) [HCODREL], [HFECPRO], [HTIPCOD], [RDESCPROD]
FROM [storage].[com_pas].[WJAS009] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.REABP001 · lee · 2 columna(s)
SELECT TOP (100) [RESTACT], [RESTSEC]
FROM [storage].[ref].[REABP001] WITH (NOLOCK);

-- storage.ref.REABP002 · lee · 2 columna(s)
SELECT TOP (100) [RCODZBP], [RDESZBP]
FROM [storage].[ref].[REABP002] WITH (NOLOCK);

-- storage.ref.VJERCOR04 · lee · 9 columna(s)
SELECT TOP (100) [RCODAGEH], [RCODMAC], [RCODMAT], [RCODTER], [RDESAGEH], [RDESFC], [RDESMAC], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR04] WITH (NOLOCK);
