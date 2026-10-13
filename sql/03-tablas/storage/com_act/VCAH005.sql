-- storage.com_act.VCAH005
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSDESEMB, mod_rep.com.RSDESEMB02, mod_rep.com.RSRDFCA037

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'haseoper', N'HCODOPE', N'hfecpro', N'HMONDESMN', N'HNUMTAS', N'idrango', N'idrango2', N'RangoDesembolso', N'RangoDesembolso2') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'VCAH005'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.VCAH005') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [haseoper], [HCODOPE], [hfecpro], [HMONDESMN], [HNUMTAS], [idrango], [idrango2], [RangoDesembolso], [RangoDesembolso2]
FROM [storage].[com_act].[VCAH005] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [haseoper] IS NULL THEN 1 ELSE 0 END) AS [nulos_haseoper], COUNT(DISTINCT [haseoper]) AS [distintos_haseoper],
    SUM(CASE WHEN [HCODOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODOPE], COUNT(DISTINCT [HCODOPE]) AS [distintos_HCODOPE],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [HMONDESMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HMONDESMN], COUNT(DISTINCT [HMONDESMN]) AS [distintos_HMONDESMN],
    SUM(CASE WHEN [HNUMTAS] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMTAS], COUNT(DISTINCT [HNUMTAS]) AS [distintos_HNUMTAS],
    SUM(CASE WHEN [idrango] IS NULL THEN 1 ELSE 0 END) AS [nulos_idrango], COUNT(DISTINCT [idrango]) AS [distintos_idrango],
    SUM(CASE WHEN [idrango2] IS NULL THEN 1 ELSE 0 END) AS [nulos_idrango2], COUNT(DISTINCT [idrango2]) AS [distintos_idrango2],
    SUM(CASE WHEN [RangoDesembolso] IS NULL THEN 1 ELSE 0 END) AS [nulos_RangoDesembolso], COUNT(DISTINCT [RangoDesembolso]) AS [distintos_RangoDesembolso],
    SUM(CASE WHEN [RangoDesembolso2] IS NULL THEN 1 ELSE 0 END) AS [nulos_RangoDesembolso2], COUNT(DISTINCT [RangoDesembolso2]) AS [distintos_RangoDesembolso2]
FROM [storage].[com_act].[VCAH005] WITH (NOLOCK);
