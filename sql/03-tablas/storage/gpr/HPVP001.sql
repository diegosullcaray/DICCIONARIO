-- storage.gpr.HPVP001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSPANSUP001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODBT', N'HDIAS', N'HFECPRO') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'gpr' AND c.TABLE_NAME = N'HPVP001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'gpr.HPVP001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODBT], [HDIAS], [HFECPRO]
FROM [storage].[gpr].[HPVP001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODBT] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODBT], COUNT(DISTINCT [HCODBT]) AS [distintos_HCODBT],
    SUM(CASE WHEN [HDIAS] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDIAS], COUNT(DISTINCT [HDIAS]) AS [distintos_HDIAS],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO]
FROM [storage].[gpr].[HPVP001] WITH (NOLOCK);
