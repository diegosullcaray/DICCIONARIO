-- mod_rep.com.DINCEPDM01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: DET_INCEN_PDM_01
-- Ficha: diccionario/procedimientos/mod_rep/com/DINCEPDM01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.DINCEPDM01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HDGP001 · lee · 20 columna(s)
SELECT TOP (100) [HASES], [HCODA], [HCODS], [HDNIP], [HDOCC], [HEJEC], [HESTG], [HESTI], [HFALG], [HFECPRO], [HINST], [HMODU], [HNCTA], [HNOMC], [HNOMG], [HNROG], [HOPER], [HROWID], [HSTOP], [HTOPE]
FROM [storage].[com_act].[HDGP001] WITH (NOLOCK);

-- storage.com_act.RFGP001 · lee · 1 columna(s)
SELECT TOP (100) [RFECG]
FROM [storage].[com_act].[RFGP001] WITH (NOLOCK);

-- storage.com_act.VCAH002 · lee · 110 columna(s)
SELECT TOP (100) [HASEOPER], [HASEORI], [HCAPPEN], [HCARCOB], [HCARNCOB], [HCLFSBS], [HCODCIIU], [HCODCNV], [HCODEMP], [HCODMOD], [HCODMON], [HCODOPE], [HCODSEC], [HCODSECANT], [HCRESBS], [HCTACLI], [HCTAFIA], [HCUOPEN], [HCUOVEN], [HDCODCNV], [HDCODSEC], [HDESCIIU], [HDESCLI], [HDESCRE], [HDESMOD], [HDESRUB], [HDESTOPE], [HDIAATR], [HDINDCAM], [HDIREC], [HDNIVAPR], [HDOCCON], [HDOCFIA], [HDPAIS], [HDSUBTIP], [HDSUCCLI], [HDSUCSEC], [HDTIPOPE], [HESTOPE], [HFECCLF], [HFECDES], [HFECDESA], [HFECMOR], [HFECPER], [HFECPRC], [HFECPRO], [HFECUCC], [HFRCPAG], [HGENPER], [HHORREG], [HINDCAM], [HINDCAR], [HINDIM], [HINDMETA], [HINDTIPCB], [HINGDIF], [HINTCMP], [HINTMOR], [HINTVEN], [HMONDES], [HMONDESMN], [HMONGAR], [HMONPRV], [HNASEORI], [HNDOCSEC], [HNIVAPR], [HNOMFIA], [HNOMREG], [HNUMCOR], [HNUMCRCLI], [HNUMDOC], [HNUMLET], [HNUMREN], [HNUMRUB], [HNUMTAS], [HNUMTHR], [HOCUP], [HPAIS], [HPAPEL], [HPRIVEN], [HRANDIA], [HRESID], [HRIECBCLI], [HRIECBOPE], [HROWID], [HSALCAP], [HSALCAPMN], [HSALCAR], [HSALRIE], [HSALVEN], [HSALVENMN], [HSHKCMB], [HSITCRE], [HSUBOPE], [HSUBTIP], [HSUCCLI], [HSUCOPER], [HSUCSEC], [HTIPCAR], [HTIPCMB], [HTIPDOC], [HTIPOPE], [HTIPPER], [HTOTCUO], [HTOTDEU], [HTOTGAR], [HUBIGEO], [HULTVEN], [HUSUPRO], [HVENATR]
FROM [storage].[com_act].[VCAH002] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 13 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODTER], [RCODUCO], [RCODUNI], [RDESUCO], [rcodsec], [rdescor], [rdessec], [rdester], [rdesuni], [rfecpro], [rindfec]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
