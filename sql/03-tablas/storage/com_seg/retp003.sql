-- storage.com_seg.retp003
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRESREPSEG_01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'hcodmod', N'HCODSEG', N'HDESSEG', N'HSUBTIP', N'HTIPOPE') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_seg' AND c.TABLE_NAME = N'retp003'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_seg.retp003') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [hcodmod], [HCODSEG], [HDESSEG], [HSUBTIP], [HTIPOPE]
FROM [storage].[com_seg].[retp003] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [hcodmod] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcodmod], COUNT(DISTINCT [hcodmod]) AS [distintos_hcodmod],
    SUM(CASE WHEN [HCODSEG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSEG], COUNT(DISTINCT [HCODSEG]) AS [distintos_HCODSEG],
    SUM(CASE WHEN [HDESSEG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESSEG], COUNT(DISTINCT [HDESSEG]) AS [distintos_HDESSEG],
    SUM(CASE WHEN [HSUBTIP] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSUBTIP], COUNT(DISTINCT [HSUBTIP]) AS [distintos_HSUBTIP],
    SUM(CASE WHEN [HTIPOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPOPE], COUNT(DISTINCT [HTIPOPE]) AS [distintos_HTIPOPE]
FROM [storage].[com_seg].[retp003] WITH (NOLOCK);
