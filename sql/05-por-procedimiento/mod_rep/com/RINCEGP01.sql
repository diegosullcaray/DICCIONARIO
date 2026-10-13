-- mod_rep.com.RINCEGP01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RESINCGRUP_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RINCEGP01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RINCEGP01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- storage.com_act.HCDR001 · lee · 3 columna(s)
SELECT TOP (100) [HCODOPE], [HFECPRO], [HFECREP]
FROM [storage].[com_act].[HCDR001] WITH (NOLOCK);

-- storage.com_act.HCDR002 · lee · 3 columna(s)
SELECT TOP (100) [HCODOPE], [HFECPRO], [HFECREP]
FROM [storage].[com_act].[HCDR002] WITH (NOLOCK);

-- storage.com_act.HDGP001 · lee · 4 columna(s)
SELECT TOP (100) [HESTG], [HESTI], [HFECPRO], [HNROG]
FROM [storage].[com_act].[HDGP001] WITH (NOLOCK);

-- storage.com_act.RFOC001 · lee · 2 columna(s)
SELECT TOP (100) [RCODOPE], [ROPEFEC]
FROM [storage].[com_act].[RFOC001] WITH (NOLOCK);

-- storage.com_act.VCAH001 · lee · 108 columna(s)
SELECT TOP (100) [HASEOPER], [HASEORI], [HCAPPEN], [HCARCOB], [HCARNCOB], [HCLFSBS], [HCODCIIU], [HCODCNV], [HCODEMP], [HCODMOD], [HCODMON], [HCODOPE], [HCODSEC], [HCODSECANT], [HCRESBS], [HCTACLI], [HCTAFIA], [HCUOPEN], [HCUOVEN], [HDCODCNV], [HDCODSEC], [HDESCIIU], [HDESCLI], [HDESCRE], [HDESMOD], [HDESRUB], [HDESTOPE], [HDIAATR], [HDINDCAM], [HDIREC], [HDNIVAPR], [HDOCCON], [HDOCFIA], [HDPAIS], [HDSUBTIP], [HDSUCCLI], [HDSUCSEC], [HDTIPOPE], [HESTOPE], [HFECCLF], [HFECDES], [HFECMOR], [HFECPER], [HFECPRC], [HFECPRO], [HFECUCC], [HFRCPAG], [HGENPER], [HHORREG], [HINDCAM], [HINDCAR], [HINDIM], [HINDMETA], [HINDTIPCB], [HINGDIF], [HINTCMP], [HINTMOR], [HINTVEN], [HMONDES], [HMONGAR], [HMONPRV], [HNASEORI], [HNDOCSEC], [HNIVAPR], [HNOMFIA], [HNOMREG], [HNUMCOR], [HNUMCRCLI], [HNUMDOC], [HNUMLET], [HNUMREN], [HNUMRUB], [HNUMTAS], [HNUMTHR], [HOCUP], [HPAIS], [HPAPEL], [HPRIVEN], [HRANDIA], [HRESID], [HRIECBCLI], [HRIECBOPE], [HROWID], [HSALCAP], [HSALCAPMN], [HSALCAR], [HSALRIE], [HSALVEN], [HSALVENMN], [HSHKCMB], [HSITCRE], [HSUBOPE], [HSUBTIP], [HSUCCLI], [HSUCOPER], [HSUCSEC], [HTIPCAR], [HTIPCMB], [HTIPDOC], [HTIPOPE], [HTIPPER], [HTOTCUO], [HTOTDEU], [HTOTGAR], [HUBIGEO], [HULTVEN], [HUSUPRO], [HVENATR]
FROM [storage].[com_act].[VCAH001] WITH (NOLOCK);

-- storage.com_act.VCAM001 · lee · 104 columna(s)
SELECT TOP (100) [HASEOPER], [HASEORI], [HCAPPEN], [HCARCOB], [HCARNCOB], [HCLFSBS], [HCODCIIU], [HCODCNV], [HCODEMP], [HCODMOD], [HCODMON], [HCODOPE], [HCODSEC], [HCRESBS], [HCTACLI], [HCTAFIA], [HCUOPEN], [HCUOVEN], [HDCODCNV], [HDCODSEC], [HDESCIIU], [HDESCLI], [HDESCRE], [HDESMOD], [HDESRUB], [HDESTOPE], [HDIAATR], [HDINDCAM], [HDIREC], [HDNIVAPR], [HDOCCON], [HDOCFIA], [HDPAIS], [HDSUBTIP], [HDSUCCLI], [HDSUCSEC], [HDTIPOPE], [HESTOPE], [HFECCLF], [HFECDES], [HFECMOR], [HFECPER], [HFECPRC], [HFECPRO], [HFECUCC], [HFRCPAG], [HGENPER], [HHORREG], [HINDCAM], [HINDCAR], [HINDTIPCB], [HINGDIF], [HINTCMP], [HINTMOR], [HINTVEN], [HMONDES], [HMONGAR], [HMONPRV], [HNASEORI], [HNIVAPR], [HNOMFIA], [HNOMREG], [HNUMCOR], [HNUMCRCLI], [HNUMDOC], [HNUMLET], [HNUMREN], [HNUMRUB], [HNUMTAS], [HNUMTHR], [HOCUP], [HPAIS], [HPAPEL], [HPRIVEN], [HRANDIA], [HRESID], [HRIECBCLI], [HRIECBOPE], [HROWID], [HSALCAP], [HSALCAPMN], [HSALCAR], [HSALRIE], [HSALVEN], [HSALVENMN], [HSHKCMB], [HSITCRE], [HSUBOPE], [HSUBTIP], [HSUCCLI], [HSUCOPER], [HSUCSEC], [HTIPCAR], [HTIPCMB], [HTIPDOC], [HTIPOPE], [HTIPPER], [HTOTCUO], [HTOTDEU], [HTOTGAR], [HUBIGEO], [HULTVEN], [HUSUPRO], [HVENATR]
FROM [storage].[com_act].[VCAM001] WITH (NOLOCK);

-- storage.com_act.WJAS001 · lee · 5 columna(s)
SELECT TOP (100) [HCODREL], [HFECPRO], [HNUMCLI], [HNUMCLIN], [HTIPCOD]
FROM [storage].[com_act].[WJAS001] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 3 columna(s)
SELECT TOP (100) [HCODVAR], [HFECPRO], [HTIPCOD]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC], [RFECTXT]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 16 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODTER], [RCODUCO], [RCODUNI], [RDESFC], [RDESGRU], [RDESSEC], [RDESUCO], [RINDFEC], [rcodsec], [rdescor], [rdester], [rdesuni], [rfecpro]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
