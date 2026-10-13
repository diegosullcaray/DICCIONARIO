-- mod_rep.rep.SDECCOM01
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GSELREP002, mod_rep.rep.GSREVA01

USE mod_rep;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'SCODSUB', N'SNOMSUB', N'STIPCOD') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'rep' AND c.TABLE_NAME = N'SDECCOM01'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'rep.SDECCOM01') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [SCODSUB], [SNOMSUB], [STIPCOD]
FROM [mod_rep].[rep].[SDECCOM01] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [SCODSUB] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODSUB], COUNT(DISTINCT [SCODSUB]) AS [distintos_SCODSUB],
    SUM(CASE WHEN [SNOMSUB] IS NULL THEN 1 ELSE 0 END) AS [nulos_SNOMSUB], COUNT(DISTINCT [SNOMSUB]) AS [distintos_SNOMSUB],
    SUM(CASE WHEN [STIPCOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_STIPCOD], COUNT(DISTINCT [STIPCOD]) AS [distintos_STIPCOD]
FROM [mod_rep].[rep].[SDECCOM01] WITH (NOLOCK);
