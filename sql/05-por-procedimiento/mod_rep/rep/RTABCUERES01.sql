-- mod_rep.rep.RTABCUERES01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: TAB_CUE_RES_01
-- Ficha: diccionario/procedimientos/mod_rep/rep/RTABCUERES01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'rep.RTABCUERES01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- mod_rep.dbo.REVARPYG · lee · 4 columna(s)
SELECT TOP (100) [codigo], [descripcion], [pos], [style]
FROM [mod_rep].[dbo].[REVARPYG] WITH (NOLOCK);

-- mod_rep.dbo.WREPPYG001 · lee · 16 columna(s)
SELECT TOP (100) [WACUMAA], [WACUMACT], [WACUMT1], [WACUMT2], [WACUMT3], [WACUMT4], [WCODMOD], [WCODREL], [WCODUNI], [WCODVAR], [WFECPRO], [WSUBTIP], [WTIPOPE], [WVALAA], [WVALACT], [WVALANT]
FROM [mod_rep].[dbo].[WREPPYG001] WITH (NOLOCK);
