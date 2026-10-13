-- mod_rep.com.GDMREP001
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 2
--   RS_MON_REP_01            Monitor de reprogramados  ·  params: cod_rel, fec, tip_cod, car
--   RS_MON_REP_SEC_01        Monitor de reprogramados  ·  params: cod_rel, fec, tip_cod, car
--
-- En reportes.json aparece también como: "mod_rep.[com].[GDMREP001]"
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/GDMREP001.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.GDMREP001';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.GDMREP001')) AS definicion;
