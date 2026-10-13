-- mod_rep.com.GLISDETCLIPDM01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: REACT_PDM_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GLISDETCLIPDM01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GLISDETCLIPDM01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HRPDM002 · lee · 8 columna(s)
SELECT TOP (100) [HFFINVIG], [HFINIVIG], [HHORPRO], [HMOREACC], [HNUMDOC], [HPAIS], [HREACC], [HTIPDOC]
FROM [storage].[com_act].[HRPDM002] WITH (NOLOCK);

-- storage.com_act.VRPDM001 · lee · 21 columna(s)
SELECT TOP (100) [HCODSEC], [HCTACLI], [HDCLI], [HDGRP], [HDIAATR], [HDPROP], [HENTID], [HFECPRO], [HFFINVIG], [HFINIVIG], [HFUVEN], [HHORPRO], [HMONDESMN], [HNUMDOC], [HPAIS], [HSEMF], [HTELF01], [HTIPBASE], [HTIPDOC], [HTIPIN], [HTIPOF]
FROM [storage].[com_act].[VRPDM001] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 2 columna(s)
SELECT TOP (100) [HCODBT], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);
