-- storage.com_act.SABT001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GSCAMP01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'SCODREL', N'SDESVAL', N'SFECPRO', N'SINDPDM', N'STIPCOD', N'SVAL') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'SABT001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.SABT001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [SCODREL], [SDESVAL], [SFECPRO], [SINDPDM], [STIPCOD], [SVAL]
FROM [storage].[com_act].[SABT001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [SCODREL] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODREL], COUNT(DISTINCT [SCODREL]) AS [distintos_SCODREL],
    SUM(CASE WHEN [SDESVAL] IS NULL THEN 1 ELSE 0 END) AS [nulos_SDESVAL], COUNT(DISTINCT [SDESVAL]) AS [distintos_SDESVAL],
    SUM(CASE WHEN [SFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_SFECPRO], COUNT(DISTINCT [SFECPRO]) AS [distintos_SFECPRO],
    SUM(CASE WHEN [SINDPDM] IS NULL THEN 1 ELSE 0 END) AS [nulos_SINDPDM], COUNT(DISTINCT [SINDPDM]) AS [distintos_SINDPDM],
    SUM(CASE WHEN [STIPCOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_STIPCOD], COUNT(DISTINCT [STIPCOD]) AS [distintos_STIPCOD],
    SUM(CASE WHEN [SVAL] IS NULL THEN 1 ELSE 0 END) AS [nulos_SVAL], COUNT(DISTINCT [SVAL]) AS [distintos_SVAL]
FROM [storage].[com_act].[SABT001] WITH (NOLOCK);
