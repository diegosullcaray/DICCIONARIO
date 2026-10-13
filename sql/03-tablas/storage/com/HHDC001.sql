-- storage.com.HHDC001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSHHCARB001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODSUCU', N'HCTACONT', N'HFECPRO', N'HHCARBCA', N'HHCARBMO', N'HHUCARUN', N'HNOMBCTA') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com' AND c.TABLE_NAME = N'HHDC001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com.HHDC001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODSUCU], [HCTACONT], [HFECPRO], [HHCARBCA], [HHCARBMO], [HHUCARUN], [HNOMBCTA]
FROM [storage].[com].[HHDC001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODSUCU] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSUCU], COUNT(DISTINCT [HCODSUCU]) AS [distintos_HCODSUCU],
    SUM(CASE WHEN [HCTACONT] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCTACONT], COUNT(DISTINCT [HCTACONT]) AS [distintos_HCTACONT],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HHCARBCA] IS NULL THEN 1 ELSE 0 END) AS [nulos_HHCARBCA], COUNT(DISTINCT [HHCARBCA]) AS [distintos_HHCARBCA],
    SUM(CASE WHEN [HHCARBMO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HHCARBMO], COUNT(DISTINCT [HHCARBMO]) AS [distintos_HHCARBMO],
    SUM(CASE WHEN [HHUCARUN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HHUCARUN], COUNT(DISTINCT [HHUCARUN]) AS [distintos_HHUCARUN],
    SUM(CASE WHEN [HNOMBCTA] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNOMBCTA], COUNT(DISTINCT [HNOMBCTA]) AS [distintos_HNOMBCTA]
FROM [storage].[com].[HHDC001] WITH (NOLOCK);
