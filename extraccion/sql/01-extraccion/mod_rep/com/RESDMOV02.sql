-- mod_rep.com.RESDMOV02
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 2
--   RESNMOVR_01              Mov. Resumen Detalle Recuperaciones  ·  params: tip_cod, cod_rel
--   RESNMOV_02               Mov. Resumen Detalle Analista  ·  params: tip_cod, cod_rel
--
-- En reportes.json aparece también como: "mod_rep.[com].[RESDMOV02]"
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/RESDMOV02.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.RESDMOV02';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.RESDMOV02')) AS definicion;
