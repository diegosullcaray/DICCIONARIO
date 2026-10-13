-- mod_rep.com.RSGETCOM01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_GEST_COM_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RSGETCOM01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSGETCOM01'), 1)
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

-- storage.com_act.WJAS001 · lee · 8 columna(s)
SELECT TOP (100) [HCODREL], [HFECPRO], [HNUMCLI], [HNUMCLIN], [HNUMSECGMES], [HNUMSECIMES], [HTIPCOD], [HVSALVIGMN]
FROM [storage].[com_act].[WJAS001] WITH (NOLOCK);

-- storage.COM_ACT.WRODASAL001 · lee · 8 columna(s)
SELECT TOP (100) [HCODREL], [HRODAM], [HSALNOVIG], [HSALVIGEN], [HTIPCOD], [TMMHSALNOVIG], [TMMRODAMIENTO], [TMMSALVIGE]
FROM [storage].[COM_ACT].[WRODASAL001] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 6 columna(s)
SELECT TOP (100) [HCODREL], [HTIPCOD], [HTIPMETA], [hcodvar], [hfecpro], [month]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.rcalen001 · lee · 4 columna(s)
SELECT TOP (100) [RDIASEM], [month], [rdiafer], [rfec]
FROM [storage].[ref].[rcalen001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 16 columna(s)
SELECT TOP (100) [RCODCOR], [RCODFC], [RCODGRU], [RCODSEC], [RCODTER], [RCODUCO], [RCODUNI], [RDESCOR], [RDESFC], [RDESGRU], [RDESSEC], [RDESTER], [RDESUCO], [RDESUNI], [rfecpro], [rindfec]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
