-- ¿Qué procedimientos, vistas o funciones de esta base mencionan una columna o tabla?
-- Búsqueda de texto en las definiciones: encuentra también SQL dinámico, que el motor no registra.
-- Cambiar @buscar y ejecutar en cada base (mod_rep, strategos, …).

DECLARE @buscar nvarchar(200) = N'HFCRES';

SELECT s.name AS esquema, o.name AS objeto, o.type_desc AS tipo, o.modify_date AS modificado
FROM sys.sql_modules m
JOIN sys.objects o ON o.object_id = m.object_id
JOIN sys.schemas s ON s.schema_id = o.schema_id
WHERE m.definition LIKE N'%' + @buscar + N'%'
ORDER BY s.name, o.name;
