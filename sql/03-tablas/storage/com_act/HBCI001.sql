-- storage.com_act.HBCI001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RCDATREACT01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODSEC', N'HCTACLI', N'HFECPRO', N'HFLAGES', N'HSUCCLI') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'HBCI001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.HBCI001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODSEC], [HCTACLI], [HFECPRO], [HFLAGES], [HSUCCLI]
FROM [storage].[com_act].[HBCI001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSEC], COUNT(DISTINCT [HCODSEC]) AS [distintos_HCODSEC],
    SUM(CASE WHEN [HCTACLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCTACLI], COUNT(DISTINCT [HCTACLI]) AS [distintos_HCTACLI],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HFLAGES] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFLAGES], COUNT(DISTINCT [HFLAGES]) AS [distintos_HFLAGES],
    SUM(CASE WHEN [HSUCCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSUCCLI], COUNT(DISTINCT [HSUCCLI]) AS [distintos_HSUCCLI]
FROM [storage].[com_act].[HBCI001] WITH (NOLOCK);
