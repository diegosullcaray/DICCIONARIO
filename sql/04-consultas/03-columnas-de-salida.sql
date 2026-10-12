-- Columnas que devuelve el primer conjunto de resultados de un SP, sin ejecutarlo.
-- Confirma la sección "Columnas que devuelve" de la ficha. Falla con SQL dinámico o tablas #temporales.

DECLARE @procedimiento nvarchar(300) = N'com.GSELREP001';

SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, is_nullable AS acepta_nulos,
       source_database AS base_origen, source_schema AS esquema_origen,
       source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(@procedimiento), 1)
ORDER BY column_ordinal;
