-- mod_rep.com.RSRDFCA037: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: CMG_CARTERA_02
-- Ficha: diccionario/procedimientos/mod_rep/com/RSRDFCA037.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSRDFCA037'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.SDAF001 · lee · 1 columna(s)
SELECT TOP (100) [SFECPRO]
FROM [storage].[com_act].[SDAF001] WITH (NOLOCK);

-- storage.com_act.SDAF003 · lee · 8 columna(s)
SELECT TOP (100) [SCODAGR], [SCODSEC], [SFECDES], [SFECPRO], [SHORPRO], [SMONDESMN], [SNUMOPE], [SSUCCLI]
FROM [storage].[com_act].[SDAF003] WITH (NOLOCK);

-- storage.com_act.SDAS004 · lee · 8 columna(s)
SELECT TOP (100) [SCODAGR], [SCODSEC], [SFECPRO], [SMDESMN], [SSCAPFMN], [SSCAPIMN], [SSCASMN], [SSUCCLI]
FROM [storage].[com_act].[SDAS004] WITH (NOLOCK);

-- storage.com_act.SDAS010 · lee · 2 columna(s)
SELECT TOP (100) [SFECPRO], [SHORPRO]
FROM [storage].[com_act].[SDAS010] WITH (NOLOCK);

-- storage.com_act.VCAH005 · lee · 5 columna(s)
SELECT TOP (100) [HMONDESMN], [HNUMTAS], [haseoper], [hcodope], [hfecpro]
FROM [storage].[com_act].[VCAH005] WITH (NOLOCK);

-- storage.com_act.WGATH002 · lee · 93 columna(s)
SELECT TOP (100) [HAUTO], [HCAPP1], [HCAPP2], [HCAPP3], [HCAPP4], [HCAPP5], [HCASE], [HCCLI], [HCOFI], [HCRT10], [HCRT11], [HCRT12], [HCRT2], [HCRT3], [HCRT4], [HCRT5], [HCRT6], [HCRT7], [HCRT8], [HCRT9], [HDASE], [HDOFI], [HDTDOC], [HFAPP1], [HFAPP2], [HFAPP3], [HFAPP4], [HFAPP5], [HFDES], [HGESTTAS], [HHAPP1], [HHAPP2], [HHAPP3], [HHAPP4], [HHAPP5], [HMDES], [HMOD], [HNAPP1], [HNAPP2], [HNAPP3], [HNAPP4], [HNAPP5], [HNCLI], [HNCUO], [HNDOC], [HOPER], [HPBS], [HPLZO], [HPROD], [HREGI], [HSOLI], [HSUBTIP], [HTBAS], [HTDES], [HTERR], [HTMER], [HTMIN], [HTOPE], [HTSEG], [HTSOL], [HTTAR], [HUAPP1], [HUAPP2], [HUAPP3], [HUAPP4], [HUAPP5], [HUCAP], [HUCAP_FIN], [HUFAP], [HUHAP], [HUNAP], [HUUAP], [HVARI1], [HVARI2], [HVARI3], [HVARI4], [HVARI5], [ID], [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [RFEC], [hfecpro], [ord]
FROM [storage].[com_act].[WGATH002] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 6 columna(s)
SELECT TOP (100) [HCODREL], [HCODVAR], [HFECPRO], [HTIPMETA], [HVALVAR], [htipcod]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 16 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESFC], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [rcodsec], [rfecpro], [rindfec]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
