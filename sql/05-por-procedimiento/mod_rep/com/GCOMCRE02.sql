-- mod_rep.com.GCOMCRE02: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GCOMCRE_02
-- Ficha: diccionario/procedimientos/mod_rep/com/GCOMCRE02.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GCOMCRE02'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.wdcb003 · lee · 15 columna(s)
SELECT TOP (100) [HCODREL], [HCOM_10_20K], [HCOM_3K], [HCOM_3_5K], [HCOM_5_10K], [HCOM_M20K], [HDESEMB_COM], [HFECPRO], [HMAX_DURA_H], [HMIN_DURA_H], [HNUM_COMITE], [HOPE_APROB], [HOPE_OBS], [HOPE_RECH], [HTIPCOD]
FROM [storage].[com_act].[wdcb003] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
