-- mod_rep.com.RINCEPDM01
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 1
--   INCEN_PDM_01             INCENTIVOS PDM  ·  params: tip_cod, cod_rel, fecha
--
-- En reportes.json aparece también como: "mod_rep.[com].[RINCEPDM01]"
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/RINCEPDM01.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.RINCEPDM01';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.RINCEPDM01')) AS definicion;
