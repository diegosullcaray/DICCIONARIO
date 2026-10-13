-- mod_rep.com.RAGROMIX: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RS_AGROMIX_01
-- Ficha: diccionario/procedimientos/mod_rep/com/RAGROMIX.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RAGROMIX'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.WCMAG001 · lee · 6 columna(s)
SELECT TOP (100) [HCAPMON], [HCTACLI], [HEXTENS], [HVENMON], [haseoper], [hfecpro]
FROM [storage].[com_act].[WCMAG001] WITH (NOLOCK);

-- storage.ref.RCALEN001 · lee · 2 columna(s)
SELECT TOP (100) [RCIEBT], [RFEC]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- storage.ref.WJERCOR03 · lee · 16 columna(s)
SELECT TOP (100) [RCODFC], [RDESFC], [RDESGRU], [RcodUCO], [RdesUCO], [rcodcor], [rcodgru], [rcodsec], [rcodter], [rcoduni], [rdescor], [rdessec], [rdester], [rdesuni], [rfecpro], [rindfec]
FROM [storage].[ref].[WJERCOR03] WITH (NOLOCK);
