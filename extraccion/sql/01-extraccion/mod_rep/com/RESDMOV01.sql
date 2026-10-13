-- mod_rep.com.RESDMOV01
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 1
--   RESNMOV_01               Mov. Resumen Detalle Comercial  ·  params: tip_cod, cod_rel
--
-- En reportes.json aparece también como: "mod_rep.[com].[RESDMOV01]"
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/RESDMOV01.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.RESDMOV01';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.RESDMOV01')) AS definicion;
