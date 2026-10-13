-- mod_rep.com.GDCGEST_PASIVAST01
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 6
--   GST_PASIVA_01            GESTION TASAS PASIVAS  ·  params: tip_cod, cod_rel, var, agr, calc, fec
--   GST_PASIVA_02            GESTION TASAS PASIVAS  ·  params: tip_cod, cod_rel, var, agr, calc, fec
--   GST_PASIVA_03            GESTION TASAS PASIVAS  ·  params: tip_cod, cod_rel, var, agr, calc, fec
--   GST_PASIVA_M_01          GESTION TASAS PASIVAS  ·  params: tip_cod, cod_rel, var, agr, calc, fec
--   GST_PASIVA_M_02          GESTION TASAS PASIVAS  ·  params: tip_cod, cod_rel, var, agr, calc, fec
--   GST_PASIVA_M_03          GESTION TASAS PASIVAS  ·  params: tip_cod, cod_rel, var, agr, calc, fec
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/GDCGEST_PASIVAST01.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.GDCGEST_PASIVAST01';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.GDCGEST_PASIVAST01')) AS definicion;
