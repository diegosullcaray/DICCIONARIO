-- Lote de extracción: base strategos · 9 procedimiento(s)
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera.
--
-- 1. Ejecutar en SSMS con "Resultados a cuadrícula".
-- 2. `existe = 0` → el SP del catálogo ya no está en la base: registrarlo como hallazgo.
-- 3. Copiar `definicion` de cada fila a su `destino` (activar en SSMS:
--    Herramientas > Opciones > Resultados > Cuadrícula > "Conservar CR/LF al copiar").
--    Para automatizarlo: governance/scripts/extraer-definiciones.ps1

USE strategos;
GO
SET NOCOUNT ON;

DECLARE @catalogo TABLE (esquema sysname, nombre sysname, destino nvarchar(400), extraido bit);
INSERT INTO @catalogo (esquema, nombre, destino, extraido) VALUES
     (N'mod_rep_com_act', N'CABGMRESULUNINEGB01', N'procedimientos/strategos/mod_rep_com_act/CABGMRESULUNINEGB01.sql', 1)
    ,(N'mod_rep_com_act', N'GDACTITASA01', N'procedimientos/strategos/mod_rep_com_act/GDACTITASA01.sql', 1)
    ,(N'mod_rep_com_act', N'GDCCAP_BP01', N'procedimientos/strategos/mod_rep_com_act/GDCCAP_BP01.sql', 1)
    ,(N'mod_rep_com_act', N'GDDESEMDIA', N'procedimientos/strategos/mod_rep_com_act/GDDESEMDIA.sql', 1)
    ,(N'mod_rep_com_act', N'GDEFECTMORA01', N'procedimientos/strategos/mod_rep_com_act/GDEFECTMORA01.sql', 1)
    ,(N'mod_rep_com_act', N'GDPORTAGRO01', N'procedimientos/strategos/mod_rep_com_act/GDPORTAGRO01.sql', 1)
    ,(N'mod_rep_com_act', N'GDPSUPERV01', N'procedimientos/strategos/mod_rep_com_act/GDPSUPERV01.sql', 1)
    ,(N'mod_rep_com_act', N'GDPSUPERV02', N'procedimientos/strategos/mod_rep_com_act/GDPSUPERV02.sql', 1)
    ,(N'mod_rep_com_act', N'HTTPTRACE', N'procedimientos/strategos/mod_rep_com_act/HTTPTRACE.sql', 1)
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
