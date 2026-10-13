-- MOD-0001 · Rollback
-- 1. Volver a apuntar GST_ACTIVAS_06 y GST_ACTIVAS_M_06 a mod_rep.com.GDCGEST_ACTIVAST01 en la tabla de
--    reportes del backend (el mismo lugar donde se hizo el cambio del paso 6 de 02-analisis.md).
-- 2. Recién entonces, borrar el SP nuevo. El original nunca se tocó.

USE mod_rep;
GO
DROP PROCEDURE IF EXISTS [com].[GDCGEST_ACTIVAST01_NEW];
GO
