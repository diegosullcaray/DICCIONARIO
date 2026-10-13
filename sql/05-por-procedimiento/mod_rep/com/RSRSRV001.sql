-- mod_rep.com.RSRSRV001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RECSERV_PAS_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSRSRV001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSRSRV001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- storage.com_pas.wjas005 · lee · 14 columna(s)
SELECT TOP (100) [CANAL], [CANT_TX_ANIO_ACT], [CANT_TX_MES_ACT], [CANT_TX_MES_ANT], [CANT_TX_ULT_DIA], [EMPRESA], [HCODREL], [HFECPRO], [HTIPCOD], [MON_TX_ANIO_ACT], [MON_TX_MES_ACT], [MON_TX_MES_ANT], [MON_TX_ULT_DIA], [SERVICIO]
FROM [storage].[com_pas].[wjas005] WITH (NOLOCK);
