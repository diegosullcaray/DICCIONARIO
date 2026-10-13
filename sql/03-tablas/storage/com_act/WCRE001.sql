-- storage.com_act.WCRE001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSMONEFER03

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'GROUPING', N'hcodrel', N'HDESPROD', N'HEREDADO', N'HFECPRO', N'HSALDETMN', N'HSALINIMN', N'HSALMAN01MN', N'HSALRECMN', N'htipcod', N'HTRAM') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'WCRE001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.WCRE001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [GROUPING], [hcodrel], [HDESPROD], [HEREDADO], [HFECPRO], [HSALDETMN], [HSALINIMN], [HSALMAN01MN], [HSALRECMN], [htipcod], [HTRAM]
FROM [storage].[com_act].[WCRE001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [GROUPING] IS NULL THEN 1 ELSE 0 END) AS [nulos_GROUPING], COUNT(DISTINCT [GROUPING]) AS [distintos_GROUPING],
    SUM(CASE WHEN [hcodrel] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcodrel], COUNT(DISTINCT [hcodrel]) AS [distintos_hcodrel],
    SUM(CASE WHEN [HDESPROD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESPROD], COUNT(DISTINCT [HDESPROD]) AS [distintos_HDESPROD],
    SUM(CASE WHEN [HEREDADO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HEREDADO], COUNT(DISTINCT [HEREDADO]) AS [distintos_HEREDADO],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HSALDETMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSALDETMN], COUNT(DISTINCT [HSALDETMN]) AS [distintos_HSALDETMN],
    SUM(CASE WHEN [HSALINIMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSALINIMN], COUNT(DISTINCT [HSALINIMN]) AS [distintos_HSALINIMN],
    SUM(CASE WHEN [HSALMAN01MN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSALMAN01MN], COUNT(DISTINCT [HSALMAN01MN]) AS [distintos_HSALMAN01MN],
    SUM(CASE WHEN [HSALRECMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSALRECMN], COUNT(DISTINCT [HSALRECMN]) AS [distintos_HSALRECMN],
    SUM(CASE WHEN [htipcod] IS NULL THEN 1 ELSE 0 END) AS [nulos_htipcod], COUNT(DISTINCT [htipcod]) AS [distintos_htipcod],
    SUM(CASE WHEN [HTRAM] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTRAM], COUNT(DISTINCT [HTRAM]) AS [distintos_HTRAM]
FROM [storage].[com_act].[WCRE001] WITH (NOLOCK);
