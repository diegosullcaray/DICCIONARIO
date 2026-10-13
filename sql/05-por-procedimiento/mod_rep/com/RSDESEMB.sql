-- mod_rep.com.RSDESEMB: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_DESEMB_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSDESEMB.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSDESEMB'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.VCAH005 · lee · 9 columna(s)
SELECT TOP (100) [HCODOPE], [HMONDESMN], [HNUMTAS], [RangoDesembolso], [RangoDesembolso2], [haseoper], [hfecpro], [idrango], [idrango2]
FROM [storage].[com_act].[VCAH005] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RCIEBT], [RDIAFER], [rfec]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
