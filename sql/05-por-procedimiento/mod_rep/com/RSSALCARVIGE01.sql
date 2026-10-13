-- mod_rep.com.RSSALCARVIGE01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_SAL_CAR_04
-- Ficha: diccionario/procedimientos/mod_rep/com/RSSALCARVIGE01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RSSALCARVIGE01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

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

-- storage.com_act.WJAS001 · lee · 63 columna(s)
SELECT TOP (100) [HCANAMN], [HCANAPGMN], [HCANASPGMN], [HCODREL], [HMDESAPGMN], [HMDESASPGMN], [HMONDESAMN], [HMONDESMN], [HNUMBANCOMP], [HNUMBANEXC], [HNUMCLI], [HNUMCLIEDAD1], [HNUMCLIEDAD2], [HNUMCLIEDAD3], [HNUMCLIEDAD4], [HNUMCLIEDAD5], [HNUMCLIFEME], [HNUMCLIG], [HNUMCLII], [HNUMCLIINMI], [HNUMCLIJURI], [HNUMCLIMASC], [HNUMCLIMES], [HNUMCLIMESPG], [HNUMCLIMESSPG], [HNUMCLIN], [HNUMCLIPERU], [HNUMCLIPG], [HNUMCLIRUR], [HNUMCLISPG], [HNUMCLIURB], [HNUMOPE], [HNUMSECGMES], [HNUMSECGMESPG], [HNUMSECGMESSPG], [HNUMSECIMES], [HNUMSECIMESPG], [HNUMSECIMESSPG], [HNUMSECMES], [HNUMSECMESPG], [HNUMSECMESSPG], [HODESAPGMN], [HODESASPGMN], [HOPEDESA], [HSALMEDMN], [HSALMEDMNVIGE], [HSALMPGMN], [HSALMPGMNVIGE], [HSALMSPGMN], [HSALMSPGMNVIGE], [HTIPCOD], [HVSALMN], [HVSALPGMN], [HVSALSPGMN], [HVSALVIGMN], [HVSALVIGPG], [HVSALVIGSPG], [HVULEXPOBREZA], [HVULNERABLE], [HVULOTROS], [HVULPOBREZA], [HVULSINCALIF], [hfecpro]
FROM [storage].[com_act].[WJAS001] WITH (NOLOCK);

-- storage.com.VDMCOM01 · lee · 4 columna(s)
SELECT TOP (100) [HCODVAR], [HFECPRO], [HTIPCOD], [HVALVAR]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 3 columna(s)
SELECT TOP (100) [RDIAFER], [RFEC], [RFECTXT]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
