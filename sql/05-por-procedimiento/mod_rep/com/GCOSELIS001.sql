-- mod_rep.com.GCOSELIS001: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: COSELISTADO_02
-- Ficha: diccionario/procedimientos/mod_rep/com/GCOSELIS001.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GCOSELIS001'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- storage.com_act.HCDA001 · lee · 14 columna(s)
SELECT TOP (100) [HCODMON], [HCODOPE], [HCTACLI], [HDCODSEC], [HDESCLI], [HDSUCCLI], [HDTIPOPE], [HFECMOR], [HFECPRO], [HINDCAR], [HMONDES], [HNUMDOC], [HSALVENMN], [HTIPDOC]
FROM [storage].[com_act].[HCDA001] WITH (NOLOCK);

-- storage.com_act.RETP001 · lee · 3 columna(s)
SELECT TOP (100) [RCODMOD], [RCODPROD], [RTIPOPE]
FROM [storage].[com_act].[RETP001] WITH (NOLOCK);

-- storage.com_act.RETP002 · lee · 4 columna(s)
SELECT TOP (100) [RCODMOD], [RCODPROD], [RSUBTIP], [RTIPOPE]
FROM [storage].[com_act].[RETP002] WITH (NOLOCK);

-- storage.com_act.RETP003 · lee · 2 columna(s)
SELECT TOP (100) [RCODPROD], [RDESPROD]
FROM [storage].[com_act].[RETP003] WITH (NOLOCK);

-- storage.com_act.SRCC001 · lee · 8 columna(s)
SELECT TOP (100) [Ndoc_Ident], [Nro_Empre], [PCPP], [PDef], [PDud], [PNor], [PPer], [Saldo]
FROM [storage].[com_act].[SRCC001] WITH (NOLOCK);

-- storage.com_act.SRIESGO001 · lee · 3 columna(s)
SELECT TOP (100) [NIVEL_RIESGO], [NIVEL_SOB], [cliente]
FROM [storage].[com_act].[SRIESGO001] WITH (NOLOCK);

-- storage.com_act.WBCH001 · lee · 3 columna(s)
SELECT TOP (100) [HFECBAS], [HINDMORH], [hcosecha]
FROM [storage].[com_act].[WBCH001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RCIEBT], [RFEC]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
