-- storage.com_seg.RETPP004
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02, mod_rep.com.RSSEGPAS03, mod_rep.com.RSSEGPAS04

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODSEG', N'hcomifc', N'HDESPLAN', N'hmonpri') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_seg' AND c.TABLE_NAME = N'RETPP004'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_seg.RETPP004') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODSEG], [hcomifc], [HDESPLAN], [hmonpri]
FROM [storage].[com_seg].[RETPP004] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODSEG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSEG], COUNT(DISTINCT [HCODSEG]) AS [distintos_HCODSEG],
    SUM(CASE WHEN [hcomifc] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcomifc], COUNT(DISTINCT [hcomifc]) AS [distintos_hcomifc],
    SUM(CASE WHEN [HDESPLAN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESPLAN], COUNT(DISTINCT [HDESPLAN]) AS [distintos_HDESPLAN],
    SUM(CASE WHEN [hmonpri] IS NULL THEN 1 ELSE 0 END) AS [nulos_hmonpri], COUNT(DISTINCT [hmonpri]) AS [distintos_hmonpri]
FROM [storage].[com_seg].[RETPP004] WITH (NOLOCK);
