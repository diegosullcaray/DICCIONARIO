-- mod_rep.com.GCOMCRE01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: SEGUI_COMITE_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GCOMCRE01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GCOMCRE01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.WDCB001 · lee · 25 columna(s)
SELECT TOP (100) [HAVG_ASIST], [HAVG_DURA], [HAVG_OPE], [HCOM_10K], [HCOM_10_20K], [HCOM_DESEMB], [HCOM_FIRMA], [HCOM_FISICO], [HCOM_M20K], [HCOM_SDESEMB], [HCOM_SFIRMA], [HCOM_VIRTUAL], [HDESEMB_COM], [HDESEMB_SCOM], [HFECPRO], [HMAX_ASIST], [HMAX_DURA], [HMAX_OPE], [HNUM_COMITE], [HSCOM_10K], [HSCOM_10_20K], [HSCOM_M20K], [HTOT_OPEDESEMB], [hcodrel], [htipcod]
FROM [storage].[com_act].[WDCB001] WITH (NOLOCK);

-- storage.com_act.WDCB002 · lee · 7 columna(s)
SELECT TOP (100) [HFECPRO], [HSALCAPMN_CC], [HSALCAPMN_SC], [HSALVENMN_CC], [HSALVENMN_SC], [hcodrel], [htipcod]
FROM [storage].[com_act].[WDCB002] WITH (NOLOCK);

-- storage.com_act.wjas002 · lee · 6 columna(s)
SELECT TOP (100) [HCAST12M], [HFECPRO], [HRECCAST12M], [HVENTA_CARTMN12M], [hcodrel], [htipcod]
FROM [storage].[com_act].[wjas002] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RFEC], [rciebt]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
