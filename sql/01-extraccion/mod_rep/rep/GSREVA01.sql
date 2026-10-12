-- mod_rep.rep.GSREVA01
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 3
--   GSREVA01                 Reporte Reva  ·  params: Fecha, tipcod, codrel, codmod
--   GSREVA101                Reporte Reva  ·  params: Fecha, tipcod, codrel, codmod
--   GSREVA201                Reporte Reva  ·  params: Fecha, tipcod, codrel, codmod
--
-- En reportes.json aparece también como: "mod_rep.[rep].GSREVA01"
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: procedimientos/mod_rep/rep/GSREVA01.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'rep.GSREVA01';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'rep.GSREVA01')) AS definicion;
