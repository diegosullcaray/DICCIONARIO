-- strategos.etl.ABPCONF01
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSRPD001

USE strategos;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODPRO', N'HDESLOG', N'HDESPRO', N'HSTATUS', N'HTIPPRO') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'etl' AND c.TABLE_NAME = N'ABPCONF01'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'etl.ABPCONF01') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODPRO], [HDESLOG], [HDESPRO], [HSTATUS], [HTIPPRO]
FROM [strategos].[etl].[ABPCONF01] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODPRO], COUNT(DISTINCT [HCODPRO]) AS [distintos_HCODPRO],
    SUM(CASE WHEN [HDESLOG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESLOG], COUNT(DISTINCT [HDESLOG]) AS [distintos_HDESLOG],
    SUM(CASE WHEN [HDESPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESPRO], COUNT(DISTINCT [HDESPRO]) AS [distintos_HDESPRO],
    SUM(CASE WHEN [HSTATUS] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSTATUS], COUNT(DISTINCT [HSTATUS]) AS [distintos_HSTATUS],
    SUM(CASE WHEN [HTIPPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPPRO], COUNT(DISTINCT [HTIPPRO]) AS [distintos_HTIPPRO]
FROM [strategos].[etl].[ABPCONF01] WITH (NOLOCK);
