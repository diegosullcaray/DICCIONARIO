-- mod_rep.com.GRESCAMCOND01
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 2
--   GRESCONDO_02             Modulo de Condonaciones Mes Día   ·  params: tip_cod, cod_rel, tdcrMonto, tdcrMoti, diariomes, niveles
--   GRESCONDO_01             Modulo de Condonaciones  ·  params: tip_cod, cod_rel, tdcrMonto, tdcrMoti
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/GRESCAMCOND01.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.GRESCAMCOND01';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.GRESCAMCOND01')) AS definicion;
