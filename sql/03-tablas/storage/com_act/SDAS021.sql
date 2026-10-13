-- storage.com_act.SDAS021
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRTABCORRO01, mod_rep.com.RCORRES01, mod_rep.com.RCORRES05

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'SAGENCI', N'SCORRED', N'SCORRES', N'sfecpro', N'SMONTO', N'SNUMCORRE', N'SNUMTRANS', N'STERRIT', N'STICKPROM', N'STIPTRA') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'SDAS021'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.SDAS021') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [SAGENCI], [SCORRED], [SCORRES], [sfecpro], [SMONTO], [SNUMCORRE], [SNUMTRANS], [STERRIT], [STICKPROM], [STIPTRA]
FROM [storage].[com_act].[SDAS021] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [SAGENCI] IS NULL THEN 1 ELSE 0 END) AS [nulos_SAGENCI], COUNT(DISTINCT [SAGENCI]) AS [distintos_SAGENCI],
    SUM(CASE WHEN [SCORRED] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCORRED], COUNT(DISTINCT [SCORRED]) AS [distintos_SCORRED],
    SUM(CASE WHEN [SCORRES] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCORRES], COUNT(DISTINCT [SCORRES]) AS [distintos_SCORRES],
    SUM(CASE WHEN [sfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_sfecpro], COUNT(DISTINCT [sfecpro]) AS [distintos_sfecpro],
    SUM(CASE WHEN [SMONTO] IS NULL THEN 1 ELSE 0 END) AS [nulos_SMONTO], COUNT(DISTINCT [SMONTO]) AS [distintos_SMONTO],
    SUM(CASE WHEN [SNUMCORRE] IS NULL THEN 1 ELSE 0 END) AS [nulos_SNUMCORRE], COUNT(DISTINCT [SNUMCORRE]) AS [distintos_SNUMCORRE],
    SUM(CASE WHEN [SNUMTRANS] IS NULL THEN 1 ELSE 0 END) AS [nulos_SNUMTRANS], COUNT(DISTINCT [SNUMTRANS]) AS [distintos_SNUMTRANS],
    SUM(CASE WHEN [STERRIT] IS NULL THEN 1 ELSE 0 END) AS [nulos_STERRIT], COUNT(DISTINCT [STERRIT]) AS [distintos_STERRIT],
    SUM(CASE WHEN [STICKPROM] IS NULL THEN 1 ELSE 0 END) AS [nulos_STICKPROM], COUNT(DISTINCT [STICKPROM]) AS [distintos_STICKPROM],
    SUM(CASE WHEN [STIPTRA] IS NULL THEN 1 ELSE 0 END) AS [nulos_STIPTRA], COUNT(DISTINCT [STIPTRA]) AS [distintos_STIPTRA]
FROM [storage].[com_act].[SDAS021] WITH (NOLOCK);
