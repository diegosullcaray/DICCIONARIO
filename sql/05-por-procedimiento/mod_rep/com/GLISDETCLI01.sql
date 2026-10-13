-- mod_rep.com.GLISDETCLI01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: DET_CLI_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GLISDETCLI01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GLISDETCLI01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.VCAH001 · lee · 5 columna(s)
SELECT TOP (100) [HCODSEC], [HDESCLI], [HNUMDOC], [HPAIS], [HTIPDOC]
FROM [storage].[com_act].[VCAH001] WITH (NOLOCK);

-- storage.gpr.HDETPER01 · lee · 10 columna(s)
SELECT TOP (100) [HCIIU], [HCIUINFO], [HEMAIL], [HNUMDOC], [HNUMTELE], [HPAIS], [HTELEINFO], [HTIPDOC], [HVERCIIU], [HVERTEL]
FROM [storage].[gpr].[HDETPER01] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 2 columna(s)
SELECT TOP (100) [HCODBT], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);

-- storage.ref.RDPAIS001 · lee · 2 columna(s)
SELECT TOP (100) [RDPAIS], [RPAIS]
FROM [storage].[ref].[RDPAIS001] WITH (NOLOCK);

-- storage.ref.RDTD001 · lee · 2 columna(s)
SELECT TOP (100) [RDTIPDOC], [RTIPDOC]
FROM [storage].[ref].[RDTD001] WITH (NOLOCK);

-- storage.ref.REGCIIU003 · lee · 2 columna(s)
SELECT TOP (100) [RCODCIIU], [RDESCIIU]
FROM [storage].[ref].[REGCIIU003] WITH (NOLOCK);
