-- mod_rep.com.RSCLIVULNER01
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 2
--   CLI_VULNERABLE_01        Filtro Clientes Vulnerables  ·  params: tip_cod, cod_rel, fec
--   CLI_VULNERABLE_01        Filtro Clientes Vulnerables  ·  params: tip_cod, cod_rel, fec
--
-- En reportes.json aparece también como: "mod_rep.[com].[RSCLIVULNER01]"
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/RSCLIVULNER01.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.RSCLIVULNER01';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.RSCLIVULNER01')) AS definicion;
