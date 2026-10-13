-- mod_rep.rep.FFTHCOLDEF
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.DINCEPDM01, mod_rep.com.GCMCNUE001, mod_rep.com.GCMCNUE002, mod_rep.com.GCMGCAP01, mod_rep.com.GCOMCRE01, mod_rep.com.GCOMCRE02, mod_rep.com.GCOSELIS001, mod_rep.com.GCOSEMAF002, mod_rep.com.GDASHKAY03, mod_rep.com.GDASHKAY05, mod_rep.com.GDASHKAY06, mod_rep.com.GDCGEST_ACTIVAST02, mod_rep.com.GDCLIOPE01, mod_rep.com.GLIMOVO01, mod_rep.com.GLIMOVO02, mod_rep.com.GLIMOVO05, mod_rep.com.GLIMOVO06, mod_rep.com.GLIMOVRO01, mod_rep.com.GLIMOVRO05, mod_rep.com.GLIMOVRO06, mod_rep.com.GLISAUTO01, mod_rep.com.GLISAUTRO05, mod_rep.com.GLISCAPRET01, mod_rep.com.GLISPROSP01, mod_rep.com.GPASP001, mod_rep.com.GPDM001, mod_rep.com.GPRECOSCUAD001, mod_rep.com.GPRECOSELIS001, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRCEROCUOTAO02, mod_rep.com.GRESCAMCOND01, mod_rep.com.GRESCAMCOND03, mod_rep.com.GRESCAMIMP01, mod_rep.com.GRESDESCRE02, mod_rep.com.GRESPDATOS01, mod_rep.com.GRESPDATOS02, mod_rep.com.GRESPROGOB01, mod_rep.com.GRESPROGOB02, mod_rep.com.GRESREAGRO01, mod_rep.com.GRESREPSEG05, mod_rep.com.GRESREPSEG06, mod_rep.com.GRESTOPIMP01, mod_rep.com.GRGCTABDIGO02, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.GRTABAPPO01, mod_rep.com.GRTABCORRO01, mod_rep.com.GRVGENCORO01, mod_rep.com.GRVGENCORO02, mod_rep.com.GSCAMP01, mod_rep.com.GSCASEG01, mod_rep.com.GSEGCAPBP01, mod_rep.com.GSEGCAPBP02, mod_rep.com.GSEGCAPRED01, mod_rep.com.GSELCIUT002, mod_rep.com.GSELJERAR001, mod_rep.com.GSELJERAR002, mod_rep.com.GSMODAGEN01, mod_rep.com.GTOPCERCUO001, mod_rep.com.GTOPCERCUO002, mod_rep.com.GTOPCERCUO003, mod_rep.com.GTOPCERCUO004, mod_rep.com.GTOPCERCUO005, mod_rep.com.RACTGP01, mod_rep.com.RCORRES01, mod_rep.com.RCORRES06, mod_rep.com.RDETCORR01, mod_rep.com.RENRCOLAB01, mod_rep.com.RENRDESEM01, mod_rep.com.RENROPE01, mod_rep.com.RENRPAS01, mod_rep.com.RENRPAS02, mod_rep.com.RESDMOV01, mod_rep.com.RESDMOV02, mod_rep.com.RINCEGP01, mod_rep.com.RMESA01, mod_rep.com.RMORAGP01, mod_rep.com.RPROSCORR002, mod_rep.com.RPROSCORR005, mod_rep.com.RSAPPUSO001, mod_rep.com.RSAVAPOR01, mod_rep.com.RSCALCAR01, mod_rep.com.RSCALCAR02, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGCLIPAS01, mod_rep.com.RSCMGCLIPAS02, mod_rep.com.RSCMGCLIPAS03, mod_rep.com.RSDATPRO01, mod_rep.com.RSDATPRO02, mod_rep.com.RSDATPRO03, mod_rep.com.RSDATPRO04, mod_rep.com.RSDESEMP01, mod_rep.com.RSDESEMP02, mod_rep.com.RSDESEMPAS01, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSHHCARB001, mod_rep.com.RSLISTCCN01, mod_rep.com.RSMONEFE01, mod_rep.com.RSMONEFE02, mod_rep.com.RSMONEFE05, mod_rep.com.RSMONEFER01, mod_rep.com.RSMONEFER02, mod_rep.com.RSMONEFEREPRO01, mod_rep.com.RSMONEFETRC01, mod_rep.com.RSPANSUP004, mod_rep.com.RSPANSUP005, mod_rep.com.RSPROYCOLDES001, mod_rep.com.RSPROYCOLDES002, mod_rep.com.RSPROYCOLDES003, mod_rep.com.RSPROYCOLDES004, mod_rep.com.RSPROYCOLDES005, mod_rep.com.RSPROYCOLDES006, mod_rep.com.RSPROYCOLDES007, mod_rep.com.RSPROYCOLDES008, mod_rep.com.RSPROYCOLDES009, mod_rep.com.RSPROYCOLDES010, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA029, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA036, mod_rep.com.RSRDMA023, mod_rep.com.RSRSRV001, mod_rep.com.RSSALCAR01, mod_rep.com.RSSALCAR02, mod_rep.com.RSSALCAR03, mod_rep.com.RSSALCARVIGE01, mod_rep.com.RSSEGPDM01, mod_rep.com.RS_AGE_COM_CR_01, mod_rep.com.RS_AGE_COM_CR_02, mod_rep.com.RS_AGE_COM_CR_M_01, mod_rep.com.RS_AGE_COM_CR_M_02, mod_rep.com.RS_AGE_COM_CR_M_03, mod_rep.com.RS_AGE_COM_CR_M_04

USE mod_rep;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'rep' AND c.TABLE_NAME = N'FFTHCOLDEF'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'rep.FFTHCOLDEF') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) *
FROM [mod_rep].[rep].[FFTHCOLDEF] WITH (NOLOCK);
