-- mod_rep.dbo.a
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCOSEMAF002, mod_rep.com.GDCGEST_ACTIVAST02, mod_rep.com.GDCLIOPE01, mod_rep.com.GPDM001, mod_rep.com.GRESREPSEG03, mod_rep.com.GRESREPSEG04, mod_rep.com.GRESREPSEG06, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.GSEGCAPBP01, mod_rep.com.RCORRES06, mod_rep.com.RGRAFGESTCOM02, mod_rep.com.RGRAFGESTCOM05, mod_rep.com.RGRAFGESTCOM06, mod_rep.com.RMORAGP01, mod_rep.com.RPROSCORR002, mod_rep.com.RPROSCORR004, mod_rep.com.RPROSCORR005, mod_rep.com.RPROSCORR006, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSGETCOM01, mod_rep.com.RSMONEFE02, mod_rep.com.RSMONEFER02, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA037, mod_rep.com.RSTABCOMER, mod_rep.com.RTABDIGCOM01

USE mod_rep;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'dbo' AND c.TABLE_NAME = N'a'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'dbo.a') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) *
FROM [mod_rep].[dbo].[a] WITH (NOLOCK);
