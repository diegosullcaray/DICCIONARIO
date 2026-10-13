-- storage.com_act.wjas005
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSMONRENT01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCLISAL1M', N'HCLISAL3M', N'HCLIVENC', N'HCODREL', N'HFECPRO', N'HRATRET', N'HTIPCOD') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'wjas005'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.wjas005') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCLISAL1M], [HCLISAL3M], [HCLIVENC], [HCODREL], [HFECPRO], [HRATRET], [HTIPCOD]
FROM [storage].[com_act].[wjas005] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCLISAL1M] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCLISAL1M], COUNT(DISTINCT [HCLISAL1M]) AS [distintos_HCLISAL1M],
    SUM(CASE WHEN [HCLISAL3M] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCLISAL3M], COUNT(DISTINCT [HCLISAL3M]) AS [distintos_HCLISAL3M],
    SUM(CASE WHEN [HCLIVENC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCLIVENC], COUNT(DISTINCT [HCLIVENC]) AS [distintos_HCLIVENC],
    SUM(CASE WHEN [HCODREL] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODREL], COUNT(DISTINCT [HCODREL]) AS [distintos_HCODREL],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HRATRET] IS NULL THEN 1 ELSE 0 END) AS [nulos_HRATRET], COUNT(DISTINCT [HRATRET]) AS [distintos_HRATRET],
    SUM(CASE WHEN [HTIPCOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPCOD], COUNT(DISTINCT [HTIPCOD]) AS [distintos_HTIPCOD]
FROM [storage].[com_act].[wjas005] WITH (NOLOCK);
