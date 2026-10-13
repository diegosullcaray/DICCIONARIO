-- mod_rep.com.GRESPROGOB02
-- Generado por governance/scripts/generar-extraccion.mjs. No editar: se regenera desde extraccion/fuente/reportes.json.
--
-- Reportes (RCODREP) que ejecutan este SP: 4
--   RPROGOB_03               Reporte de cartera de progamas del gobierno  ·  params: cod_rel, tip_cod, fec, var
--   RPROGOB_M_03             Reporte de cartera de progamas del gobierno  ·  params: cod_rel, tip_cod, fec, var
--   RPROGOB_04               Reporte de cartera de progamas del gobierno  ·  params: cod_rel, tip_cod, fec, var
--   RPROGOB_M_04             Reporte de cartera de progamas del gobierno  ·  params: cod_rel, tip_cod, fec, var
--
-- Pegar el resultado (el CREATE PROCEDURE completo) en: extraccion/procedimientos/mod_rep/com/GRESPROGOB02.sql
-- sp_helptext corta las líneas de más de 255 caracteres; si el SP tiene líneas largas
-- usar la consulta OBJECT_DEFINITION de abajo o el lote de la base (_lotes/).

USE mod_rep;
GO
EXEC sp_helptext 'com.GRESPROGOB02';

-- SELECT OBJECT_DEFINITION(OBJECT_ID(N'com.GRESPROGOB02')) AS definicion;
