-- storage.com_act.HTDA001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRTABAPPO01, mod_rep.com.GSEGCAPBP01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCANAL', N'HDESPROC', N'HFECPRO', N'HMONTO', N'HNUMDOC', N'HTIPDOC', N'htiptrax', N'HTOTINTE', N'RCODSUC') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'HTDA001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.HTDA001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCANAL], [HDESPROC], [HFECPRO], [HMONTO], [HNUMDOC], [HTIPDOC], [htiptrax], [HTOTINTE], [RCODSUC]
FROM [storage].[com_act].[HTDA001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCANAL] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCANAL], COUNT(DISTINCT [HCANAL]) AS [distintos_HCANAL],
    SUM(CASE WHEN [HDESPROC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESPROC], COUNT(DISTINCT [HDESPROC]) AS [distintos_HDESPROC],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HMONTO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HMONTO], COUNT(DISTINCT [HMONTO]) AS [distintos_HMONTO],
    SUM(CASE WHEN [HNUMDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMDOC], COUNT(DISTINCT [HNUMDOC]) AS [distintos_HNUMDOC],
    SUM(CASE WHEN [HTIPDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPDOC], COUNT(DISTINCT [HTIPDOC]) AS [distintos_HTIPDOC],
    SUM(CASE WHEN [htiptrax] IS NULL THEN 1 ELSE 0 END) AS [nulos_htiptrax], COUNT(DISTINCT [htiptrax]) AS [distintos_htiptrax],
    SUM(CASE WHEN [HTOTINTE] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTOTINTE], COUNT(DISTINCT [HTOTINTE]) AS [distintos_HTOTINTE],
    SUM(CASE WHEN [RCODSUC] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODSUC], COUNT(DISTINCT [RCODSUC]) AS [distintos_RCODSUC]
FROM [storage].[com_act].[HTDA001] WITH (NOLOCK);
