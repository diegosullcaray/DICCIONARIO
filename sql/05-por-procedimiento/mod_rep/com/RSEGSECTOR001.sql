-- mod_rep.com.RSEGSECTOR001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: Sec_ciiu_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSEGSECTOR001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSEGSECTOR001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.dbo.a · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[dbo].[a] WITH (NOLOCK);

-- mod_rep.piv.TPIVCONF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[piv].[TPIVCONF] WITH (NOLOCK);

-- mod_rep.piv.TPIVFIL · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[piv].[TPIVFIL] WITH (NOLOCK);

-- mod_rep.piv.TPIVVAR · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[piv].[TPIVVAR] WITH (NOLOCK);

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- mod_rep.util.FFMTVAR · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[util].[FFMTVAR] WITH (NOLOCK);

-- storage.com_act.WACIIU0012 · lee · 1 columna(s)
SELECT TOP (100) [HFECPRO]
FROM [storage].[com_act].[WACIIU0012] WITH (NOLOCK);

-- storage.com_act.WACIIU0013 · lee · 14 columna(s)
SELECT TOP (100) [HCODSEC], [HCUOVEN], [HSALVENMN], [MontoDesembolsados], [MontoDesembolsadosNuevos], [MontoDesembolsadosRecurrentes], [NDesembolsados], [NDesembolsadosNuevos], [NDesembolsadosRecurrentes], [RDESGRUP], [SalCapi], [hfecpro], [hfecproc], [ord]
FROM [storage].[com_act].[WACIIU0013] WITH (NOLOCK);

-- STORAGE.com_act.WJAS003 · lee · 5 columna(s)
SELECT TOP (100) [HCODREL], [HRATMORR], [HTIPCOD], [ORD], [RDESGRUP]
FROM [STORAGE].[com_act].[WJAS003] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 2 columna(s)
SELECT TOP (100) [HNUMDOC], [hcodbt]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 17 columna(s)
SELECT TOP (100) [RANI], [RANIBIS], [RCIEBT], [RCIEMES], [RDIA], [RDIAANI], [RDIAFER], [RDIASEM], [RFEC], [RFECTXT], [RFINSEM], [RFLAG01], [RID], [RMES], [RMESNOM], [RNOMDIASEM], [RSEM]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.ResGridCiiu2 · lee · 4 columna(s)
SELECT TOP (100) [ROWI], [codvars], [style], [vars]
FROM [storage].[ref].[ResGridCiiu2] WITH (NOLOCK);

-- storage.ref.WJERCOR01 · lee · 3 columna(s)
SELECT TOP (100) [RCODSEC], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR01] WITH (NOLOCK);
