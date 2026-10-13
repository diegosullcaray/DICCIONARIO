-- storage.com_pas.Wacli007
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSDESEMPAS01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODREL', N'HFECPRO', N'HFEMCLI', N'HMIGCLI', N'HRURCLI', N'HTIPCOD', N'HTOTCLI') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_pas' AND c.TABLE_NAME = N'Wacli007'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_pas.Wacli007') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODREL], [HFECPRO], [HFEMCLI], [HMIGCLI], [HRURCLI], [HTIPCOD], [HTOTCLI]
FROM [storage].[com_pas].[Wacli007] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODREL] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODREL], COUNT(DISTINCT [HCODREL]) AS [distintos_HCODREL],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HFEMCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFEMCLI], COUNT(DISTINCT [HFEMCLI]) AS [distintos_HFEMCLI],
    SUM(CASE WHEN [HMIGCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HMIGCLI], COUNT(DISTINCT [HMIGCLI]) AS [distintos_HMIGCLI],
    SUM(CASE WHEN [HRURCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HRURCLI], COUNT(DISTINCT [HRURCLI]) AS [distintos_HRURCLI],
    SUM(CASE WHEN [HTIPCOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPCOD], COUNT(DISTINCT [HTIPCOD]) AS [distintos_HTIPCOD],
    SUM(CASE WHEN [HTOTCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTOTCLI], COUNT(DISTINCT [HTOTCLI]) AS [distintos_HTOTCLI]
FROM [storage].[com_pas].[Wacli007] WITH (NOLOCK);
