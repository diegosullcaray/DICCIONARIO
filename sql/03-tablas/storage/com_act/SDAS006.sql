-- storage.com_act.SDAS006
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSPANSUP003

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'SCARGO', N'SCODAGR', N'SFECPRO', N'SOPECONF', N'SOPEPRE', N'SSUCCLI') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'SDAS006'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.SDAS006') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [SCARGO], [SCODAGR], [SFECPRO], [SOPECONF], [SOPEPRE], [SSUCCLI]
FROM [storage].[com_act].[SDAS006] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [SCARGO] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCARGO], COUNT(DISTINCT [SCARGO]) AS [distintos_SCARGO],
    SUM(CASE WHEN [SCODAGR] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODAGR], COUNT(DISTINCT [SCODAGR]) AS [distintos_SCODAGR],
    SUM(CASE WHEN [SFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_SFECPRO], COUNT(DISTINCT [SFECPRO]) AS [distintos_SFECPRO],
    SUM(CASE WHEN [SOPECONF] IS NULL THEN 1 ELSE 0 END) AS [nulos_SOPECONF], COUNT(DISTINCT [SOPECONF]) AS [distintos_SOPECONF],
    SUM(CASE WHEN [SOPEPRE] IS NULL THEN 1 ELSE 0 END) AS [nulos_SOPEPRE], COUNT(DISTINCT [SOPEPRE]) AS [distintos_SOPEPRE],
    SUM(CASE WHEN [SSUCCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSUCCLI], COUNT(DISTINCT [SSUCCLI]) AS [distintos_SSUCCLI]
FROM [storage].[com_act].[SDAS006] WITH (NOLOCK);
