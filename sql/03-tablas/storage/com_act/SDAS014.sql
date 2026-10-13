-- storage.com_act.SDAS014
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GPRECOSCUAD001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'SCODAGR', N'SCODMOD', N'SCODSEC', N'sfecbas', N'SNUMOPEBAS', N'SSALCAPBAS', N'SSUBTIP', N'STIPOPE') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'SDAS014'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.SDAS014') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [SCODAGR], [SCODMOD], [SCODSEC], [sfecbas], [SNUMOPEBAS], [SSALCAPBAS], [SSUBTIP], [STIPOPE]
FROM [storage].[com_act].[SDAS014] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [SCODAGR] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODAGR], COUNT(DISTINCT [SCODAGR]) AS [distintos_SCODAGR],
    SUM(CASE WHEN [SCODMOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODMOD], COUNT(DISTINCT [SCODMOD]) AS [distintos_SCODMOD],
    SUM(CASE WHEN [SCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODSEC], COUNT(DISTINCT [SCODSEC]) AS [distintos_SCODSEC],
    SUM(CASE WHEN [sfecbas] IS NULL THEN 1 ELSE 0 END) AS [nulos_sfecbas], COUNT(DISTINCT [sfecbas]) AS [distintos_sfecbas],
    SUM(CASE WHEN [SNUMOPEBAS] IS NULL THEN 1 ELSE 0 END) AS [nulos_SNUMOPEBAS], COUNT(DISTINCT [SNUMOPEBAS]) AS [distintos_SNUMOPEBAS],
    SUM(CASE WHEN [SSALCAPBAS] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSALCAPBAS], COUNT(DISTINCT [SSALCAPBAS]) AS [distintos_SSALCAPBAS],
    SUM(CASE WHEN [SSUBTIP] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSUBTIP], COUNT(DISTINCT [SSUBTIP]) AS [distintos_SSUBTIP],
    SUM(CASE WHEN [STIPOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_STIPOPE], COUNT(DISTINCT [STIPOPE]) AS [distintos_STIPOPE]
FROM [storage].[com_act].[SDAS014] WITH (NOLOCK);
