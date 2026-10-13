-- storage.com_act.SDAE003
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRMENTOR001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'scodagr', N'SCODSEC', N'sfecpro', N'SSALINIMN', N'SSALMAN01MN', N'SSALRECMN') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'SDAE003'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.SDAE003') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [scodagr], [SCODSEC], [sfecpro], [SSALINIMN], [SSALMAN01MN], [SSALRECMN]
FROM [storage].[com_act].[SDAE003] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [scodagr] IS NULL THEN 1 ELSE 0 END) AS [nulos_scodagr], COUNT(DISTINCT [scodagr]) AS [distintos_scodagr],
    SUM(CASE WHEN [SCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODSEC], COUNT(DISTINCT [SCODSEC]) AS [distintos_SCODSEC],
    SUM(CASE WHEN [sfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_sfecpro], COUNT(DISTINCT [sfecpro]) AS [distintos_sfecpro],
    SUM(CASE WHEN [SSALINIMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSALINIMN], COUNT(DISTINCT [SSALINIMN]) AS [distintos_SSALINIMN],
    SUM(CASE WHEN [SSALMAN01MN] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSALMAN01MN], COUNT(DISTINCT [SSALMAN01MN]) AS [distintos_SSALMAN01MN],
    SUM(CASE WHEN [SSALRECMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSALRECMN], COUNT(DISTINCT [SSALRECMN]) AS [distintos_SSALRECMN]
FROM [storage].[com_act].[SDAE003] WITH (NOLOCK);
