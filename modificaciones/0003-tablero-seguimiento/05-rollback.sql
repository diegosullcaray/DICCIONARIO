-- MOD-0003 · Rollback. ESCRIBE en la base: lo ejecuta quien tenga permiso.
-- 1. Quitar el reporte del catálogo (deshace 06-activacion.sql). 2. Recién entonces, borrar el SP.
USE mod_rep;
GO
BEGIN TRANSACTION;
DELETE FROM rep.RREGREP01 WHERE RCODREP = 'TAB_SEG_01';
SELECT @@ROWCOUNT AS filas_borradas;   -- debe decir 1
-- COMMIT TRANSACTION;   o   ROLLBACK TRANSACTION;
GO
-- Solo después del COMMIT:
-- DROP PROCEDURE IF EXISTS [com].[RTABSEG01];
