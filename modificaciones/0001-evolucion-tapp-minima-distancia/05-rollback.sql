-- MOD-0001 · Rollback
-- 1. Volver a apuntar GST_ACTIVAS_06 y GST_ACTIVAS_M_06 al original en el catálogo del backend (deshace
--    06-activacion.sql). El front vuelve a mostrar la tabla sin TAPP Mínima ni Distancia.
-- 2. Recién entonces, borrar el SP nuevo. El original nunca se tocó.
-- ESCRIBE en la base: lo ejecuta quien tenga permiso.

USE mod_rep;
GO

BEGIN TRANSACTION;
UPDATE rep.RREGREP01
SET    RTPREP = REPLACE(RTPREP, '"mod_rep.com.GDCGEST_ACTIVAST01_NEW"', '"mod_rep.com.GDCGEST_ACTIVAST01"')
WHERE  RCODREP IN ('GST_ACTIVAS_06', 'GST_ACTIVAS_M_06')
  AND  CHARINDEX('"mod_rep.com.GDCGEST_ACTIVAST01_NEW"', RTPREP) > 0;
SELECT RCODREP, RTPREP FROM rep.RREGREP01 WHERE RCODREP IN ('GST_ACTIVAS_06', 'GST_ACTIVAS_M_06');
-- Revisar que los dos apunten a mod_rep.com.GDCGEST_ACTIVAST01 y elegir:
-- COMMIT TRANSACTION;   o   ROLLBACK TRANSACTION;
GO

-- Solo después del COMMIT anterior (si no, el reporte apuntaría a un SP que ya no existe):
-- DROP PROCEDURE IF EXISTS [com].[GDCGEST_ACTIVAST01_NEW];
