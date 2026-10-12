-- SP modificados en los últimos N días: candidatos a volver a extraer.
-- Comparar con la fecha de commit de procedimientos/<base>/<esquema>/<SP>.sql.

DECLARE @dias int = 30;

SELECT s.name AS esquema, o.name AS procedimiento, o.create_date AS creado, o.modify_date AS modificado
FROM sys.procedures o
JOIN sys.schemas s ON s.schema_id = o.schema_id
WHERE o.modify_date >= DATEADD(DAY, -@dias, GETDATE())
ORDER BY o.modify_date DESC;
