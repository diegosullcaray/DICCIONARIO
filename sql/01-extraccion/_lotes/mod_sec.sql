-- Lote de extracción: base mod_sec · 1 procedimiento(s)
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera.
--
-- 1. Ejecutar en SSMS con "Resultados a cuadrícula".
-- 2. `existe = 0` → el SP del catálogo ya no está en la base: registrarlo como hallazgo.
-- 3. Copiar `definicion` de cada fila a su `destino` (activar en SSMS:
--    Herramientas > Opciones > Resultados > Cuadrícula > "Conservar CR/LF al copiar").
--    Para automatizarlo: governance/scripts/extraer-definiciones.ps1

USE mod_sec;
GO
SET NOCOUNT ON;

DECLARE @catalogo TABLE (esquema sysname, nombre sysname, destino nvarchar(400), extraido bit);
INSERT INTO @catalogo (esquema, nombre, destino, extraido) VALUES
     (N'dbo', N'GCATSEC01', N'procedimientos/mod_sec/dbo/GCATSEC01.sql', 1)
;

SELECT
    c.esquema,
    c.nombre,
    c.destino,
    c.extraido,
    CASE WHEN o.object_id IS NULL THEN 0 ELSE 1 END AS existe,
    o.create_date AS creado,
    o.modify_date AS modificado,
    OBJECT_DEFINITION(o.object_id) AS definicion
FROM @catalogo c
LEFT JOIN sys.objects o
    ON o.object_id = OBJECT_ID(QUOTENAME(c.esquema) + N'.' + QUOTENAME(c.nombre))
   AND o.type IN ('P', 'PC')
-- WHERE c.extraido = 0   -- descomentar para traer solo los pendientes
ORDER BY c.extraido, c.esquema, c.nombre;
