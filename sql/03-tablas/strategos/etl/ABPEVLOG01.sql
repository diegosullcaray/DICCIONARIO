-- strategos.etl.ABPEVLOG01
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSRPD001

USE strategos;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'dd', N'HCODPRO', N'HDESPRO', N'HDESTAD', N'HFECLOG', N'HFECPRO') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'etl' AND c.TABLE_NAME = N'ABPEVLOG01'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'etl.ABPEVLOG01') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [dd], [HCODPRO], [HDESPRO], [HDESTAD], [HFECLOG], [HFECPRO]
FROM [strategos].[etl].[ABPEVLOG01] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [dd] IS NULL THEN 1 ELSE 0 END) AS [nulos_dd], COUNT(DISTINCT [dd]) AS [distintos_dd],
    SUM(CASE WHEN [HCODPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODPRO], COUNT(DISTINCT [HCODPRO]) AS [distintos_HCODPRO],
    SUM(CASE WHEN [HDESPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESPRO], COUNT(DISTINCT [HDESPRO]) AS [distintos_HDESPRO],
    SUM(CASE WHEN [HDESTAD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESTAD], COUNT(DISTINCT [HDESTAD]) AS [distintos_HDESTAD],
    SUM(CASE WHEN [HFECLOG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECLOG], COUNT(DISTINCT [HFECLOG]) AS [distintos_HFECLOG],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO]
FROM [strategos].[etl].[ABPEVLOG01] WITH (NOLOCK);
