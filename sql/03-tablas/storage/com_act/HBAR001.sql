-- storage.com_act.HBAR001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRESCLIREP01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODOPE', N'HMONCUO', N'HPREG01', N'HPREG02', N'HPREG03', N'HPREG04', N'HTIPCUO') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'HBAR001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.HBAR001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODOPE], [HMONCUO], [HPREG01], [HPREG02], [HPREG03], [HPREG04], [HTIPCUO]
FROM [storage].[com_act].[HBAR001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODOPE], COUNT(DISTINCT [HCODOPE]) AS [distintos_HCODOPE],
    SUM(CASE WHEN [HMONCUO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HMONCUO], COUNT(DISTINCT [HMONCUO]) AS [distintos_HMONCUO],
    SUM(CASE WHEN [HPREG01] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPREG01], COUNT(DISTINCT [HPREG01]) AS [distintos_HPREG01],
    SUM(CASE WHEN [HPREG02] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPREG02], COUNT(DISTINCT [HPREG02]) AS [distintos_HPREG02],
    SUM(CASE WHEN [HPREG03] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPREG03], COUNT(DISTINCT [HPREG03]) AS [distintos_HPREG03],
    SUM(CASE WHEN [HPREG04] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPREG04], COUNT(DISTINCT [HPREG04]) AS [distintos_HPREG04],
    SUM(CASE WHEN [HTIPCUO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPCUO], COUNT(DISTINCT [HTIPCUO]) AS [distintos_HTIPCUO]
FROM [storage].[com_act].[HBAR001] WITH (NOLOCK);
