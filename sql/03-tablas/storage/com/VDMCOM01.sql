-- storage.com.VDMCOM01
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GCMCNUE001, mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA001_SIMP, mod_rep.com.GCMGMORA003, mod_rep.com.GDACDESEM01, mod_rep.com.GDCLIOPE01, mod_rep.com.GRESREPSEG01, mod_rep.com.GRESREPSEG05, mod_rep.com.GRESREPSEG06, mod_rep.com.GRESREPSEG_01, mod_rep.com.GRMENTOR001, mod_rep.com.GRMENTOR002, mod_rep.com.RGRAFGESTCOM03, mod_rep.com.RGRAFGESTCOM05, mod_rep.com.RINCEGP01, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGFCA002, mod_rep.com.RSDESEMP01, mod_rep.com.RSDESEMP02, mod_rep.com.RSDESEMPAS01, mod_rep.com.RSGETCOM01, mod_rep.com.RSPANSUP001, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA036, mod_rep.com.RSRDFCA037, mod_rep.com.RSRTOPMIS001, mod_rep.com.RSRTOPMIS002, mod_rep.com.RSRTOPMIS003, mod_rep.com.RSRTOPMIS004, mod_rep.com.RSSALCAR01, mod_rep.com.RSSALCARVIGE01, mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02, mod_rep.com.RSSEGPAS03, mod_rep.com.RSTABCOMER

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODREL', N'HCODVAR', N'hfecpro', N'HTIPCOD', N'HTIPMETA', N'HVALVAR', N'Tip_cod', N'tip_cod2') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com' AND c.TABLE_NAME = N'VDMCOM01'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com.VDMCOM01') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODREL], [HCODVAR], [hfecpro], [HTIPCOD], [HTIPMETA], [HVALVAR], [Tip_cod], [tip_cod2]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODREL] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODREL], COUNT(DISTINCT [HCODREL]) AS [distintos_HCODREL],
    SUM(CASE WHEN [HCODVAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODVAR], COUNT(DISTINCT [HCODVAR]) AS [distintos_HCODVAR],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [HTIPCOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPCOD], COUNT(DISTINCT [HTIPCOD]) AS [distintos_HTIPCOD],
    SUM(CASE WHEN [HTIPMETA] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPMETA], COUNT(DISTINCT [HTIPMETA]) AS [distintos_HTIPMETA],
    SUM(CASE WHEN [HVALVAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HVALVAR], COUNT(DISTINCT [HVALVAR]) AS [distintos_HVALVAR],
    SUM(CASE WHEN [Tip_cod] IS NULL THEN 1 ELSE 0 END) AS [nulos_Tip_cod], COUNT(DISTINCT [Tip_cod]) AS [distintos_Tip_cod],
    SUM(CASE WHEN [tip_cod2] IS NULL THEN 1 ELSE 0 END) AS [nulos_tip_cod2], COUNT(DISTINCT [tip_cod2]) AS [distintos_tip_cod2]
FROM [storage].[com].[VDMCOM01] WITH (NOLOCK);
