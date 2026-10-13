-- mod_rep.com.RCORRES06: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: GREPORCORRE_06
-- Ficha: diccionario/procedimientos/mod_rep/com/RCORRES06.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.RCORRES06'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com.metas_corresponsales · lee · 7 columna(s)
SELECT TOP (100) [HCODOFI], [HDESCOR], [HFECPRO], [HTERDES], [HTIPMETA], [HVAL], [hfeccar]
FROM [storage].[com].[metas_corresponsales] WITH (NOLOCK);

-- storage.ref.VJERCOR03 · lee · 7 columna(s)
SELECT TOP (100) [RCODCOR], [RCODMAT], [RCODTER], [RDESAGE], [RDESCOR], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR03] WITH (NOLOCK);
