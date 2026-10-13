-- mod_rep.com.RSTABCOMER
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 1
--   RS_TAB_COM_01            TABLERO DIGITAL COMERCIAL  ·  params: tip_cod, cod_rel, fec
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/RSTABCOMER.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.RSTABCOMER';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.RSTABCOMER')) AS definicion;
