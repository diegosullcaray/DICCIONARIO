-- mod_rep.com.RSMONEFER01
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 2
--   RS_MON_EFECREASIG_01     Monitor de Efectividades Reasignados  ·  params: tip_cod, cod_rel, fecha
--   RS_MON_EFECREASIGM_01    Monitor de Efectividades Reasignados Mensual  ·  params: tip_cod, cod_rel, fecha
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/RSMONEFER01.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.RSMONEFER01';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.RSMONEFER01')) AS definicion;
