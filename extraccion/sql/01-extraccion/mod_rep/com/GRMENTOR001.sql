-- mod_rep.com.GRMENTOR001
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 1
--   RMENTORIN_01             Reporte Mentoring 01  ·  params: tip_cod, cod_rel, fec, resp
--
-- En reportes.json aparece también como: "mod_rep.[com].[GRMENTOR001]"
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/GRMENTOR001.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.GRMENTOR001';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.GRMENTOR001')) AS definicion;
