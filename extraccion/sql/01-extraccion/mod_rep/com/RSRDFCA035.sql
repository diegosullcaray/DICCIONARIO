-- mod_rep.com.RSRDFCA035
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 2
--   CARACT_CARTERA_01        CARACT.CARTERA  ·  params: tip_cod, cod_rel, fec, prod
--   CARACT_CARTERA_M_01      CARACT.CARTERA.Mensual  ·  params: tip_cod, cod_rel, fec, prod
--
-- En reportes.json aparece también como: "mod_rep.[com].[RSRDFCA035]"
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/RSRDFCA035.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.RSRDFCA035';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.RSRDFCA035')) AS definicion;
