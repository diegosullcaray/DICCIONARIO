-- storage.com_act.SDAF003
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA037

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'SCODAGR', N'SCODSEC', N'SFECDES', N'SFECPRO', N'SHORPRO', N'SMONDESMN', N'SNUMOPE', N'SSUCCLI') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'SDAF003'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.SDAF003') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [SCODAGR], [SCODSEC], [SFECDES], [SFECPRO], [SHORPRO], [SMONDESMN], [SNUMOPE], [SSUCCLI]
FROM [storage].[com_act].[SDAF003] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [SCODAGR] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODAGR], COUNT(DISTINCT [SCODAGR]) AS [distintos_SCODAGR],
    SUM(CASE WHEN [SCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODSEC], COUNT(DISTINCT [SCODSEC]) AS [distintos_SCODSEC],
    SUM(CASE WHEN [SFECDES] IS NULL THEN 1 ELSE 0 END) AS [nulos_SFECDES], COUNT(DISTINCT [SFECDES]) AS [distintos_SFECDES],
    SUM(CASE WHEN [SFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_SFECPRO], COUNT(DISTINCT [SFECPRO]) AS [distintos_SFECPRO],
    SUM(CASE WHEN [SHORPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_SHORPRO], COUNT(DISTINCT [SHORPRO]) AS [distintos_SHORPRO],
    SUM(CASE WHEN [SMONDESMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_SMONDESMN], COUNT(DISTINCT [SMONDESMN]) AS [distintos_SMONDESMN],
    SUM(CASE WHEN [SNUMOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_SNUMOPE], COUNT(DISTINCT [SNUMOPE]) AS [distintos_SNUMOPE],
    SUM(CASE WHEN [SSUCCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSUCCLI], COUNT(DISTINCT [SSUCCLI]) AS [distintos_SSUCCLI]
FROM [storage].[com_act].[SDAF003] WITH (NOLOCK);
