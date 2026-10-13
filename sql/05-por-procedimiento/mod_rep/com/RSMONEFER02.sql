-- mod_rep.com.RSMONEFER02: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_MON_EFECREASIG_02
-- Ficha: diccionario/procedimientos/mod_rep/com/RSMONEFER02.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSMONEFER02'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.dbo.a · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[dbo].[a] WITH (NOLOCK);

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- storage.com_act.hbac002 · lee · 4 columna(s)
SELECT TOP (100) [HCODOPE], [HFECEJC], [HNUM_CONDONADO], [hfecpro]
FROM [storage].[com_act].[hbac002] WITH (NOLOCK);

-- storage.com_act.hbae001 · lee · 1 columna(s)
SELECT TOP (100) [hcodope]
FROM [storage].[com_act].[hbae001] WITH (NOLOCK);

-- storage.com_act.HCDR001 · lee · 2 columna(s)
SELECT TOP (100) [HCODOPE], [HFECPRO]
FROM [storage].[com_act].[HCDR001] WITH (NOLOCK);

-- storage.com_act.HCDR002 · lee · 2 columna(s)
SELECT TOP (100) [HCODOPE], [HFECPRO]
FROM [storage].[com_act].[HCDR002] WITH (NOLOCK);

-- storage.com_act.HDGP001 · lee · 4 columna(s)
SELECT TOP (100) [HNOMG], [HNROG], [HOPER], [hfecpro]
FROM [storage].[com_act].[HDGP001] WITH (NOLOCK);

-- storage.com_act.VCAM001 · lee · 104 columna(s)
SELECT TOP (100) [HASEOPER], [HASEORI], [HCAPPEN], [HCARCOB], [HCARNCOB], [HCLFSBS], [HCODCIIU], [HCODCNV], [HCODEMP], [HCODMOD], [HCODMON], [HCODOPE], [HCODSEC], [HCRESBS], [HCTACLI], [HCTAFIA], [HCUOPEN], [HCUOVEN], [HDCODCNV], [HDCODSEC], [HDESCIIU], [HDESCLI], [HDESCRE], [HDESMOD], [HDESRUB], [HDESTOPE], [HDIAATR], [HDINDCAM], [HDIREC], [HDNIVAPR], [HDOCCON], [HDOCFIA], [HDPAIS], [HDSUBTIP], [HDSUCCLI], [HDSUCSEC], [HDTIPOPE], [HESTOPE], [HFECCLF], [HFECDES], [HFECMOR], [HFECPER], [HFECPRC], [HFECPRO], [HFECUCC], [HFRCPAG], [HGENPER], [HHORREG], [HINDCAM], [HINDCAR], [HINDTIPCB], [HINGDIF], [HINTCMP], [HINTMOR], [HINTVEN], [HMONDES], [HMONGAR], [HMONPRV], [HNASEORI], [HNIVAPR], [HNOMFIA], [HNOMREG], [HNUMCOR], [HNUMCRCLI], [HNUMDOC], [HNUMLET], [HNUMREN], [HNUMRUB], [HNUMTAS], [HNUMTHR], [HOCUP], [HPAIS], [HPAPEL], [HPRIVEN], [HRANDIA], [HRESID], [HRIECBCLI], [HRIECBOPE], [HROWID], [HSALCAP], [HSALCAPMN], [HSALCAR], [HSALRIE], [HSALVEN], [HSALVENMN], [HSHKCMB], [HSITCRE], [HSUBOPE], [HSUBTIP], [HSUCCLI], [HSUCOPER], [HSUCSEC], [HTIPCAR], [HTIPCMB], [HTIPDOC], [HTIPOPE], [HTIPPER], [HTOTCUO], [HTOTDEU], [HTOTGAR], [HUBIGEO], [HULTVEN], [HUSUPRO], [HVENATR]
FROM [storage].[com_act].[VCAM001] WITH (NOLOCK);

-- storage.com_act.WCED002 · lee · 44 columna(s)
SELECT TOP (100) [HCODMON], [HCODOPE], [HCODSEC], [HCREDSBS], [HCTACLI], [HCUOPAG], [HDCODSEC], [HDESCLI], [HDIAATR], [HESTACT], [HESTC], [HFCCOM], [HFCFGEST], [HFCFVPP], [HFCMPP], [HFCRES], [HFCRSPB], [HFDGPR], [HFECDES], [HFECMOR], [HFECUCC], [HFGPR], [HFTVEN], [HINDUCUO], [HINDZCUO], [HMONDES], [HNIVRIEBT], [HNIVSOB], [HPROBR], [HREGG], [HREGN], [HSALCAPMN], [HSALINIMN], [HTOTCUO], [HTRAM], [HUBIGEO], [RCODMAT], [RCODREG], [RCODTER], [RDESAGE], [RDESMAT], [RDESPROD], [RDESREG], [RDESTER]
FROM [storage].[com_act].[WCED002] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC], [RFECTXT]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 9 columna(s)
SELECT TOP (100) [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUNI], [RDESCOR], [RDESTER], [RDESUNI], [RFECPRO]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
