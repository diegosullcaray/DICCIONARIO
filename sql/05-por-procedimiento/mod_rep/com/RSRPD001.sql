-- mod_rep.com.RSRPD001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_MON_CAR_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSRPD001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSRPD001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- FCMIS_REP.dbo.ControlCargaData · lee · 6 columna(s)
SELECT TOP (100) [BitAct], [FechaRep], [FechaRepAnt], [descripcion], [fechaAct], [id]
FROM [FCMIS_REP].[dbo].[ControlCargaData] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- strategos.etl.ABPCONF01 · lee · 5 columna(s)
SELECT TOP (100) [HCODPRO], [HDESLOG], [HDESPRO], [HSTATUS], [HTIPPRO]
FROM [strategos].[etl].[ABPCONF01] WITH (NOLOCK);

-- strategos.etl.ABPEVLOG01 · lee · 5 columna(s)
SELECT TOP (100) [HCODPRO], [HDESPRO], [HDESTAD], [HFECLOG], [HFECPRO]
FROM [strategos].[etl].[ABPEVLOG01] WITH (NOLOCK);
