-- storage.com_act.WJAS003
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSEGSECTOR001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODREL', N'HRATMORR', N'HTIPCOD', N'ORD', N'RDESGRUP') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'WJAS003'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.WJAS003') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODREL], [HRATMORR], [HTIPCOD], [ORD], [RDESGRUP]
FROM [storage].[com_act].[WJAS003] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODREL] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODREL], COUNT(DISTINCT [HCODREL]) AS [distintos_HCODREL],
    SUM(CASE WHEN [HRATMORR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HRATMORR], COUNT(DISTINCT [HRATMORR]) AS [distintos_HRATMORR],
    SUM(CASE WHEN [HTIPCOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPCOD], COUNT(DISTINCT [HTIPCOD]) AS [distintos_HTIPCOD],
    SUM(CASE WHEN [ORD] IS NULL THEN 1 ELSE 0 END) AS [nulos_ORD], COUNT(DISTINCT [ORD]) AS [distintos_ORD],
    SUM(CASE WHEN [RDESGRUP] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESGRUP], COUNT(DISTINCT [RDESGRUP]) AS [distintos_RDESGRUP]
FROM [storage].[com_act].[WJAS003] WITH (NOLOCK);
