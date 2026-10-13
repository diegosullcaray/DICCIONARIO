-- mod_rep.piv.TPIVVAR
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GCMCNUE001, mod_rep.com.GCMCNUE002, mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCMGMORA003, mod_rep.com.GDACDESEM01, mod_rep.com.GDCGEST_ACTIVAST01, mod_rep.com.GDCGEST_ACTIVAST03, mod_rep.com.GDCGEST_ACTIVAST04, mod_rep.com.GDCLIOPE01, mod_rep.com.GPASP001, mod_rep.com.GPDM001, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRCEROCUOTAO02, mod_rep.com.GRESCAMCOND03, mod_rep.com.GRESREAGRO01, mod_rep.com.GRESREPSEG_01, mod_rep.com.GRGCTABDIGO02, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.GRTABAPPO01, mod_rep.com.GRVGENCORO01, mod_rep.com.GRVGENCORO02, mod_rep.com.GSEGCAPBP01, mod_rep.com.GTOPCERCUO001, mod_rep.com.GTOPCERCUO002, mod_rep.com.GTOPCERCUO003, mod_rep.com.GTOPCERCUO004, mod_rep.com.GTOPCERCUO005, mod_rep.com.RENRDESEM01, mod_rep.com.RENROPE01, mod_rep.com.RGRAFGESTCOM01, mod_rep.com.RGRAFGESTCOM02, mod_rep.com.RGRAFSEGPAS01, mod_rep.com.RGRAFSEGPAS02, mod_rep.com.RMORAGP01, mod_rep.com.RSAGECOM01, mod_rep.com.RSAVAPOR01, mod_rep.com.RSCALCAR01, mod_rep.com.RSCALCAR02, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGCLIPAS01, mod_rep.com.RSCMGCLIPAS03, mod_rep.com.RSCMGFCA002, mod_rep.com.RSDATPRO01, mod_rep.com.RSDATPRO02, mod_rep.com.RSDATPRO03, mod_rep.com.RSDATPRO04, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSGETCOM01, mod_rep.com.RSMONEFE01, mod_rep.com.RSMONEFER01, mod_rep.com.RSMONEFEREPRO01, mod_rep.com.RSMONEFETRC01, mod_rep.com.RSPANSUP001, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA021, mod_rep.com.RSRDFCA022, mod_rep.com.RSRDFCA023, mod_rep.com.RSRDFCA024, mod_rep.com.RSRDFCA025, mod_rep.com.RSRDFCA026, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA029, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA031, mod_rep.com.RSRDFCA032, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA036, mod_rep.com.RSRDFCA037, mod_rep.com.RSSALCAR01, mod_rep.com.RSSALCAR02, mod_rep.com.RSSALCAR03, mod_rep.com.RSSALCARVIGE01, mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02, mod_rep.com.RSSEGPAS03, mod_rep.com.RSTABCOMER, mod_rep.com.RTABDIGCOM01

USE mod_rep;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'piv' AND c.TABLE_NAME = N'TPIVVAR'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'piv.TPIVVAR') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) *
FROM [mod_rep].[piv].[TPIVVAR] WITH (NOLOCK);
