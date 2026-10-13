-- mod_rep.com.GDASHKAY05: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: rankKayOpe_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GDASHKAY05.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GDASHKAY05'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.rep.FFTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);

-- mod_rep.rep.TTHCOLDEF · — · 0 columna(s)
SELECT TOP (100) *
FROM [mod_rep].[rep].[TTHCOLDEF] WITH (NOLOCK);

-- storage.com.HBDK004 · lee · 8 columna(s)
SELECT TOP (100) [HBLOACU], [HCOLCAR], [HCOLDOC], [HCOLNOM], [HCOLTIP], [HDESTER], [HFECPRO], [hcolbt]
FROM [storage].[com].[HBDK004] WITH (NOLOCK);

-- storage.com.HBDK005 · lee · 20 columna(s)
SELECT TOP (100) [HBAGECORR], [HBAGESAT], [HBAHORRO], [HBCTS], [HBDIGITA], [HBDPF], [HBFOREXT], [HBFRENO], [HBFUERAOF], [HBMSEG], [HBPTOBAS], [HBRIEOPE], [HBSOAT], [HCOLCAR], [HCOLDOC], [HCOLNOM], [HCOLTIP], [HDESTER], [HFECPRO], [hcolbt]
FROM [storage].[com].[HBDK005] WITH (NOLOCK);

-- storage.gpr.HPPC001 · lee · 2 columna(s)
SELECT TOP (100) [hcodbt], [hfecpro]
FROM [storage].[gpr].[HPPC001] WITH (NOLOCK);
