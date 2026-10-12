-- Firma real de un procedimiento: nombre, tipo, largo, salida y si tiene valor por defecto.
-- Sirve para comparar con RTPREP.params de fuente/reportes.json sin extraer el cuerpo.

DECLARE @procedimiento nvarchar(300) = N'com.GSELREP002';

SELECT p.parameter_id AS orden, p.name AS parametro, TYPE_NAME(p.user_type_id) AS tipo,
       p.max_length AS largo, p.precision, p.scale, p.is_output AS salida,
       p.has_default_value AS tiene_defecto
FROM sys.parameters p
WHERE p.object_id = OBJECT_ID(@procedimiento)
ORDER BY p.parameter_id;
