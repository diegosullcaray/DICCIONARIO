-- mod_rep.com.GDASHKAY03: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: rankKay_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GDASHKAY03.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GDASHKAY03'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com.HBDK002 · lee · 8 columna(s)
SELECT TOP (100) [HBLOACU], [HCOLCAR], [HCOLDOC], [HCOLNOM], [HCOLTIP], [HDESTER], [HFECPRO], [hcolbt]
FROM [storage].[com].[HBDK002] WITH (NOLOCK);

-- storage.com.HBDK003 · lee · 33 columna(s)
SELECT TOP (100) [HBADMCOM], [HBAMONES], [HBASECOM], [HBCANDAD], [HBCAPCOM], [HBCLILAB], [HBCLINUE], [HBCLINUE1], [HBCUMMET], [HBDESRED], [HBDESSOC], [HBDESZBP], [HBDIGITA], [HBEFE1A30], [HBEFE30A1], [HBFOREXT], [HBGRUDES], [HBMORREA], [HBPTOBAS], [HBRIEOPE], [HBROTTOT], [HBSALAGR], [HBSALCAR], [HBSTOCLI], [HBSUPERV], [HBVARCLI], [HCOLCAR], [HCOLDOC], [HCOLNOM], [HCOLTIP], [HDESTER], [HFECPRO], [hcolbt]
FROM [storage].[com].[HBDK003] WITH (NOLOCK);

-- storage.gpr.HPPC001 · lee · 2 columna(s)
SELECT TOP (100) [hcodbt], [hfecpro]
FROM [storage].[gpr].[HPPC001] WITH (NOLOCK);
