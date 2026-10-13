-- mod_rep.reva.SVARREVA01
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.rep.GSREVA01

USE mod_rep;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'SAMBFIL', N'SAMBGRU', N'SCODMOD', N'SCODVAR', N'SDESVAR', N'SORDREV') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'reva' AND c.TABLE_NAME = N'SVARREVA01'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'reva.SVARREVA01') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [SAMBFIL], [SAMBGRU], [SCODMOD], [SCODVAR], [SDESVAR], [SORDREV]
FROM [mod_rep].[reva].[SVARREVA01] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [SAMBFIL] IS NULL THEN 1 ELSE 0 END) AS [nulos_SAMBFIL], COUNT(DISTINCT [SAMBFIL]) AS [distintos_SAMBFIL],
    SUM(CASE WHEN [SAMBGRU] IS NULL THEN 1 ELSE 0 END) AS [nulos_SAMBGRU], COUNT(DISTINCT [SAMBGRU]) AS [distintos_SAMBGRU],
    SUM(CASE WHEN [SCODMOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODMOD], COUNT(DISTINCT [SCODMOD]) AS [distintos_SCODMOD],
    SUM(CASE WHEN [SCODVAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODVAR], COUNT(DISTINCT [SCODVAR]) AS [distintos_SCODVAR],
    SUM(CASE WHEN [SDESVAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_SDESVAR], COUNT(DISTINCT [SDESVAR]) AS [distintos_SDESVAR],
    SUM(CASE WHEN [SORDREV] IS NULL THEN 1 ELSE 0 END) AS [nulos_SORDREV], COUNT(DISTINCT [SORDREV]) AS [distintos_SORDREV]
FROM [mod_rep].[reva].[SVARREVA01] WITH (NOLOCK);
