-- storage.com_pas.wjas007
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSRDFCA036

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODPERFEME', N'HCODPERRUR', N'HCODPERURB', N'HCODREL', N'HFECPRO', N'HNUMCLI', N'HTIPCOD', N'RDESCPROD') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_pas' AND c.TABLE_NAME = N'wjas007'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_pas.wjas007') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODPERFEME], [HCODPERRUR], [HCODPERURB], [HCODREL], [HFECPRO], [HNUMCLI], [HTIPCOD], [RDESCPROD]
FROM [storage].[com_pas].[wjas007] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODPERFEME] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODPERFEME], COUNT(DISTINCT [HCODPERFEME]) AS [distintos_HCODPERFEME],
    SUM(CASE WHEN [HCODPERRUR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODPERRUR], COUNT(DISTINCT [HCODPERRUR]) AS [distintos_HCODPERRUR],
    SUM(CASE WHEN [HCODPERURB] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODPERURB], COUNT(DISTINCT [HCODPERURB]) AS [distintos_HCODPERURB],
    SUM(CASE WHEN [HCODREL] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODREL], COUNT(DISTINCT [HCODREL]) AS [distintos_HCODREL],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HNUMCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMCLI], COUNT(DISTINCT [HNUMCLI]) AS [distintos_HNUMCLI],
    SUM(CASE WHEN [HTIPCOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPCOD], COUNT(DISTINCT [HTIPCOD]) AS [distintos_HTIPCOD],
    SUM(CASE WHEN [RDESCPROD] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESCPROD], COUNT(DISTINCT [RDESCPROD]) AS [distintos_RDESCPROD]
FROM [storage].[com_pas].[wjas007] WITH (NOLOCK);
