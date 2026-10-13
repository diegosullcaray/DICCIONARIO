-- mod_rep.util.FFMTVAR
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCMGMORA003, mod_rep.com.GCOMCRE01, mod_rep.com.GCOMCRE02, mod_rep.com.GDCLIOPE01, mod_rep.com.GSEGCAPBP01, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGFCA002, mod_rep.com.RSDESEMP01, mod_rep.com.RSDESEMP02, mod_rep.com.RSDESEMPAS01, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSRDFCA011

USE mod_rep;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'util' AND c.TABLE_NAME = N'FFMTVAR'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'util.FFMTVAR') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) *
FROM [mod_rep].[util].[FFMTVAR] WITH (NOLOCK);
