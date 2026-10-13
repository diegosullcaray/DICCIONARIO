-- mod_rep.com.GLISAUTO01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: LST_AUT_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GLISAUTO01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GLISAUTO01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.BTPCRA001 · lee · 26 columna(s)
SELECT TOP (100) [CARGO_ADM], [FECHA_INGRESO], [HFECPRO], [SAGENCIA], [SAUTSUG], [SAUTWF], [SAVGMRAPROB], [SC12M1], [SC12M2], [SC12M3], [SC12MACUM], [SC3M1], [SC3M2], [SC3M3], [SC3MACUM], [SCODSEC], [SCOMENT], [SFILMR], [SMRAPROB1], [SMRAPROB2], [SMRAPROB3], [SNOMADM], [SREGION], [STERRITORIO], [Segmentacion], [usuario]
FROM [storage].[com_act].[BTPCRA001] WITH (NOLOCK);

-- storage.com_act.BTPCRC001 · lee · 27 columna(s)
SELECT TOP (100) [AGENCIA], [Col0], [Comentarios], [HFECPRO], [REGION], [SAUTSUG], [SAUTSUGF], [SAUTWF], [SAVGMRAPRO], [SC12M1], [SC12M2], [SC12M3], [SC12MACUM], [SC3M1], [SC3M2], [SC3M3], [SC3MACUM], [SCARCOOR], [SCODSEC], [SFILMR], [SMR1], [SMR2], [SMR3], [SMRPROP], [SNOMCOOR], [Segmentacion], [TERRITORIO]
FROM [storage].[com_act].[BTPCRC001] WITH (NOLOCK);

-- storage.com_act.BTPCRS001 · lee · 24 columna(s)
SELECT TOP (100) [AGENCIA], [Col0], [Fecha de ingreso], [HFECPRO], [REGION], [Resultado], [SANTIGFC], [SC12M1], [SC12M2], [SC12M3], [SC3M1], [SC3M2], [SC3M3], [SCARSEC], [SCODSEC], [SCUMPANTIGFC], [SDCODSEC], [SMR1], [SMR2], [SMR3], [SMR4], [SMRTEND3M], [SNIVAUT], [TERRITORIO]
FROM [storage].[com_act].[BTPCRS001] WITH (NOLOCK);

-- storage.com_act.BTPCRT001 · lee · 23 columna(s)
SELECT TOP (100) [Col0], [HFECPRO], [SAGSUP], [SAGTOT], [SAVGC12M], [SAVGC3M], [SAVGMRAPROB], [SC12M1], [SC12M2], [SC12M3], [SC3M1], [SC3M2], [SC3M3], [SCARGO], [SCODSEC], [SDCODSEC], [SDREG], [SDTER], [SMAPROB2], [SMRAPROB3], [SPAGSUP], [SRESUL], [SRMAPROB1]
FROM [storage].[com_act].[BTPCRT001] WITH (NOLOCK);

-- storage.gpr.HPPC001 · lee · 3 columna(s)
SELECT TOP (100) [HCODBT], [HCODSUC], [HFECPRO]
FROM [storage].[gpr].[HPPC001] WITH (NOLOCK);
