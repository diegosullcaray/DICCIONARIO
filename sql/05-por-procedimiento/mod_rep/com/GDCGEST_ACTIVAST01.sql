-- mod_rep.com.GDCGEST_ACTIVAST01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GST_ACTIVAS_01, GST_ACTIVAS_02, GST_ACTIVAS_03, GST_ACTIVAS_04, GST_ACTIVAS_05, GST_ACTIVAS_06, GST_ACTIVAS_M_01, GST_ACTIVAS_M_02, GST_ACTIVAS_M_03, GST_ACTIVAS_M_04, GST_ACTIVAS_M_05, GST_ACTIVAS_M_06
-- Ficha: diccionario/procedimientos/mod_rep/com/GDCGEST_ACTIVAST01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GDCGEST_ACTIVAST01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.RETP001 · lee · 3 columna(s)
SELECT TOP (100) [RCODMOD], [RCODPROD], [RTIPOPE]
FROM [storage].[com_act].[RETP001] WITH (NOLOCK);

-- storage.com_act.RETP002 · lee · 4 columna(s)
SELECT TOP (100) [RCODMOD], [RCODPROD], [RSUBTIP], [RTIPOPE]
FROM [storage].[com_act].[RETP002] WITH (NOLOCK);

-- storage.com_act.RETP003 · lee · 3 columna(s)
SELECT TOP (100) [RCODPROD], [RDESGRU01], [RDESPROD]
FROM [storage].[com_act].[RETP003] WITH (NOLOCK);

-- storage.com_act.WACLI001 · lee · 1 columna(s)
SELECT TOP (100) [hfecpro]
FROM [storage].[com_act].[WACLI001] WITH (NOLOCK);

-- storage.com_act.WGATH002 · lee · 93 columna(s)
SELECT TOP (100) [HAUTO], [HCAPP1], [HCAPP2], [HCAPP3], [HCAPP4], [HCAPP5], [HCASE], [HCCLI], [HCOFI], [HCRT10], [HCRT11], [HCRT12], [HCRT2], [HCRT3], [HCRT4], [HCRT5], [HCRT6], [HCRT7], [HCRT8], [HCRT9], [HDASE], [HDOFI], [HDTDOC], [HFAPP1], [HFAPP2], [HFAPP3], [HFAPP4], [HFAPP5], [HFDES], [HFECPRO], [HGESTTAS], [HHAPP1], [HHAPP2], [HHAPP3], [HHAPP4], [HHAPP5], [HMDES], [HMOD], [HNAPP1], [HNAPP2], [HNAPP3], [HNAPP4], [HNAPP5], [HNCLI], [HNCUO], [HNDOC], [HOPER], [HPBS], [HPLZO], [HPROD], [HREGI], [HSOLI], [HSUBTIP], [HTBAS], [HTDES], [HTERR], [HTMER], [HTMIN], [HTOPE], [HTSEG], [HTSOL], [HTTAR], [HUAPP1], [HUAPP2], [HUAPP3], [HUAPP4], [HUAPP5], [HUCAP], [HUCAP_FIN], [HUFAP], [HUHAP], [HUNAP], [HUUAP], [HVARI1], [HVARI2], [HVARI3], [HVARI4], [HVARI5], [ID], [ORD], [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [RFEC]
FROM [storage].[com_act].[WGATH002] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 4 columna(s)
SELECT TOP (100) [RANI], [RDIAFER], [RMESNOM], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
