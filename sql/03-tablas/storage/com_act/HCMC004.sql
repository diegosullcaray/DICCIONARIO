-- storage.com_act.HCMC004
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRTABCORRO01, mod_rep.com.RDETCORR01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODREDEXT', N'HCODSUC', N'HESTCORR', N'HFECINSTALA', N'HFECPRO', N'HNOMCOR') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'HCMC004'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.HCMC004') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODREDEXT], [HCODSUC], [HESTCORR], [HFECINSTALA], [HFECPRO], [HNOMCOR]
FROM [storage].[com_act].[HCMC004] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODREDEXT] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODREDEXT], COUNT(DISTINCT [HCODREDEXT]) AS [distintos_HCODREDEXT],
    SUM(CASE WHEN [HCODSUC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSUC], COUNT(DISTINCT [HCODSUC]) AS [distintos_HCODSUC],
    SUM(CASE WHEN [HESTCORR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HESTCORR], COUNT(DISTINCT [HESTCORR]) AS [distintos_HESTCORR],
    SUM(CASE WHEN [HFECINSTALA] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECINSTALA], COUNT(DISTINCT [HFECINSTALA]) AS [distintos_HFECINSTALA],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HNOMCOR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNOMCOR], COUNT(DISTINCT [HNOMCOR]) AS [distintos_HNOMCOR]
FROM [storage].[com_act].[HCMC004] WITH (NOLOCK);
