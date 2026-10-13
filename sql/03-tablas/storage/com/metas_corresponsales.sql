-- storage.com.metas_corresponsales
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RCORRES06

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODOFI', N'HDESCOR', N'hfeccar', N'HFECPRO', N'HTERDES', N'HTIPMETA', N'HVAL') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com' AND c.TABLE_NAME = N'metas_corresponsales'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com.metas_corresponsales') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODOFI], [HDESCOR], [hfeccar], [HFECPRO], [HTERDES], [HTIPMETA], [HVAL]
FROM [storage].[com].[metas_corresponsales] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODOFI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODOFI], COUNT(DISTINCT [HCODOFI]) AS [distintos_HCODOFI],
    SUM(CASE WHEN [HDESCOR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESCOR], COUNT(DISTINCT [HDESCOR]) AS [distintos_HDESCOR],
    SUM(CASE WHEN [hfeccar] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfeccar], COUNT(DISTINCT [hfeccar]) AS [distintos_hfeccar],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HTERDES] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTERDES], COUNT(DISTINCT [HTERDES]) AS [distintos_HTERDES],
    SUM(CASE WHEN [HTIPMETA] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPMETA], COUNT(DISTINCT [HTIPMETA]) AS [distintos_HTIPMETA],
    SUM(CASE WHEN [HVAL] IS NULL THEN 1 ELSE 0 END) AS [nulos_HVAL], COUNT(DISTINCT [HVAL]) AS [distintos_HVAL]
FROM [storage].[com].[metas_corresponsales] WITH (NOLOCK);
