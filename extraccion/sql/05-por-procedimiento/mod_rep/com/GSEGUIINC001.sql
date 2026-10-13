-- mod_rep.com.GSEGUIINC001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: SEGUI_INC_SEC_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GSEGUIINC001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GSEGUIINC001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HCDA001 · lee · 2 columna(s)
SELECT TOP (100) [HASEOPER], [HFECPRO]
FROM [storage].[com_act].[HCDA001] WITH (NOLOCK);

-- storage.com_act.HRESINC001 · lee · 37 columna(s)
SELECT TOP (100) [HCLICIEN], [HCLICIEND], [HCLICIENO], [HCLIINI], [HCLIMET], [HCODREL], [HEBCAS01], [HEBCAS02], [HEBDET01], [HEBDET02], [HEBINI01], [HEBINI02], [HEBMAE01], [HEBMAE02], [HEBMAV01], [HEBMAV02], [HEBREC01], [HEBREC02], [HEFEC01MET], [HEFEC02MET], [HFECPRO], [HITMESN], [HITMESND], [HITMESNO], [HITMINN], [HITMINND], [HITMINNO], [HMDESN], [HMDESND], [HMDESNO], [HSALCIEN], [HSALCIEND], [HSALCIENO], [HSALINI], [HSALMET], [HTIPCOD], [des_gru]
FROM [storage].[com_act].[HRESINC001] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 2 columna(s)
SELECT TOP (100) [HCODBT], [HDESCAR]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);
