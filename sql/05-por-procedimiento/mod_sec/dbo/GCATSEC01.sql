-- mod_sec.dbo.GCATSEC01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: REP_CATEGO_ASE_01
-- Ficha: diccionario/procedimientos/mod_sec/dbo/GCATSEC01.md

USE mod_sec;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'dbo.GCATSEC01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.gpr.HBASCAT001 · lee · 54 columna(s)
SELECT TOP (100) [HCARSEC], [HCATSEC], [HCODSEC], [HCOM001], [HCOM002], [HCOM003], [HCOM004], [HCOM005], [HCOM006], [HCOMFIN], [HDESSEC], [HFECPRO], [HGENSEC], [HNUMDOC], [HREQ001], [HREQ002], [HREQ003], [HREQ004], [c1_1], [c1_2], [c1_3], [c1_4], [c1_5], [c1_6], [c2_1], [c2_2], [c2_3], [c2_4], [c2_5], [c2_6], [c3_1], [c3_2], [c3_3], [c3_4], [c3_5], [c3_6], [c4_1], [c4_2], [c4_3], [c4_4], [c4_5], [c4_6], [c5_1], [c5_2], [c5_3], [c5_4], [c5_5], [c5_6], [c6_1], [c6_2], [c6_3], [c6_4], [c6_5], [c6_6]
FROM [storage].[gpr].[HBASCAT001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 4 columna(s)
SELECT TOP (100) [RANI], [RCIEBT], [RFEC], [RMESNOM]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
