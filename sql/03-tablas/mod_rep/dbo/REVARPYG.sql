-- mod_rep.dbo.REVARPYG
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.rep.RTABCUERES01

USE mod_rep;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'codigo', N'descripcion', N'pos', N'style') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'dbo' AND c.TABLE_NAME = N'REVARPYG'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'dbo.REVARPYG') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [codigo], [descripcion], [pos], [style]
FROM [mod_rep].[dbo].[REVARPYG] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [codigo] IS NULL THEN 1 ELSE 0 END) AS [nulos_codigo], COUNT(DISTINCT [codigo]) AS [distintos_codigo],
    SUM(CASE WHEN [descripcion] IS NULL THEN 1 ELSE 0 END) AS [nulos_descripcion], COUNT(DISTINCT [descripcion]) AS [distintos_descripcion],
    SUM(CASE WHEN [pos] IS NULL THEN 1 ELSE 0 END) AS [nulos_pos], COUNT(DISTINCT [pos]) AS [distintos_pos],
    SUM(CASE WHEN [style] IS NULL THEN 1 ELSE 0 END) AS [nulos_style], COUNT(DISTINCT [style]) AS [distintos_style]
FROM [mod_rep].[dbo].[REVARPYG] WITH (NOLOCK);
