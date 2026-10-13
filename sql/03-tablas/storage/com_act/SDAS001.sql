-- storage.com_act.SDAS001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GDCEROCN003, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRCEROCUOTAO02, mod_rep.com.GRMENTOR001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'scodagr', N'SCODSEC', N'sfecpro', N'SNUMOPEZC', N'SSALCAPMN', N'SSALZCMN') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'SDAS001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.SDAS001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [scodagr], [SCODSEC], [sfecpro], [SNUMOPEZC], [SSALCAPMN], [SSALZCMN]
FROM [storage].[com_act].[SDAS001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [scodagr] IS NULL THEN 1 ELSE 0 END) AS [nulos_scodagr], COUNT(DISTINCT [scodagr]) AS [distintos_scodagr],
    SUM(CASE WHEN [SCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODSEC], COUNT(DISTINCT [SCODSEC]) AS [distintos_SCODSEC],
    SUM(CASE WHEN [sfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_sfecpro], COUNT(DISTINCT [sfecpro]) AS [distintos_sfecpro],
    SUM(CASE WHEN [SNUMOPEZC] IS NULL THEN 1 ELSE 0 END) AS [nulos_SNUMOPEZC], COUNT(DISTINCT [SNUMOPEZC]) AS [distintos_SNUMOPEZC],
    SUM(CASE WHEN [SSALCAPMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSALCAPMN], COUNT(DISTINCT [SSALCAPMN]) AS [distintos_SSALCAPMN],
    SUM(CASE WHEN [SSALZCMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSALZCMN], COUNT(DISTINCT [SSALZCMN]) AS [distintos_SSALZCMN]
FROM [storage].[com_act].[SDAS001] WITH (NOLOCK);
