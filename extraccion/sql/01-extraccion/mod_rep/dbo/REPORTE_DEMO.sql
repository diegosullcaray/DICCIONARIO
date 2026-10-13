-- mod_rep.dbo.REPORTE_DEMO
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 1
--   reporte-demo             Reporte Demo  ·  params: fecha, cod_user_bt
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/dbo/REPORTE_DEMO.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'dbo.REPORTE_DEMO';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'dbo.REPORTE_DEMO')) AS definicion;
