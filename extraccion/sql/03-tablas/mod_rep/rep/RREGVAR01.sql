-- mod_rep.rep.RREGVAR01
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.rep.GSREVA01

USE mod_rep;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'RALIVAR', N'RAMBGRU', N'RCODVAR', N'RDESVAR', N'RFORV01', N'RFORV02') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'rep' AND c.TABLE_NAME = N'RREGVAR01'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'rep.RREGVAR01') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [RALIVAR], [RAMBGRU], [RCODVAR], [RDESVAR], [RFORV01], [RFORV02]
FROM [mod_rep].[rep].[RREGVAR01] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [RALIVAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_RALIVAR], COUNT(DISTINCT [RALIVAR]) AS [distintos_RALIVAR],
    SUM(CASE WHEN [RAMBGRU] IS NULL THEN 1 ELSE 0 END) AS [nulos_RAMBGRU], COUNT(DISTINCT [RAMBGRU]) AS [distintos_RAMBGRU],
    SUM(CASE WHEN [RCODVAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODVAR], COUNT(DISTINCT [RCODVAR]) AS [distintos_RCODVAR],
    SUM(CASE WHEN [RDESVAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESVAR], COUNT(DISTINCT [RDESVAR]) AS [distintos_RDESVAR],
    SUM(CASE WHEN [RFORV01] IS NULL THEN 1 ELSE 0 END) AS [nulos_RFORV01], COUNT(DISTINCT [RFORV01]) AS [distintos_RFORV01],
    SUM(CASE WHEN [RFORV02] IS NULL THEN 1 ELSE 0 END) AS [nulos_RFORV02], COUNT(DISTINCT [RFORV02]) AS [distintos_RFORV02]
FROM [mod_rep].[rep].[RREGVAR01] WITH (NOLOCK);
