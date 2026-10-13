-- storage.com_seg.SDSF001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRESREPSEG01, mod_rep.com.GRESREPSEG02, mod_rep.com.GRESREPSEG03, mod_rep.com.GRESREPSEG04, mod_rep.com.GRESREPSEG05, mod_rep.com.GRESREPSEG06, mod_rep.com.GRESREPSEG_01, mod_rep.com.GRMENTOR001, mod_rep.com.RSEGASE01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'*', N'scodagr', N'SCODMOD', N'SCODSEC', N'scodseg', N'SFECEMI', N'sfecpro', N'SINDPGO', N'SNUMPLZ', N'SSUBTIP', N'SSUCCLI', N'STIPOPE') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_seg' AND c.TABLE_NAME = N'SDSF001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_seg.SDSF001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [*], [scodagr], [SCODMOD], [SCODSEC], [scodseg], [SFECEMI], [sfecpro], [SINDPGO], [SNUMPLZ], [SSUBTIP], [SSUCCLI], [STIPOPE]
FROM [storage].[com_seg].[SDSF001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [*] IS NULL THEN 1 ELSE 0 END) AS [nulos_*], COUNT(DISTINCT [*]) AS [distintos_*],
    SUM(CASE WHEN [scodagr] IS NULL THEN 1 ELSE 0 END) AS [nulos_scodagr], COUNT(DISTINCT [scodagr]) AS [distintos_scodagr],
    SUM(CASE WHEN [SCODMOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODMOD], COUNT(DISTINCT [SCODMOD]) AS [distintos_SCODMOD],
    SUM(CASE WHEN [SCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODSEC], COUNT(DISTINCT [SCODSEC]) AS [distintos_SCODSEC],
    SUM(CASE WHEN [scodseg] IS NULL THEN 1 ELSE 0 END) AS [nulos_scodseg], COUNT(DISTINCT [scodseg]) AS [distintos_scodseg],
    SUM(CASE WHEN [SFECEMI] IS NULL THEN 1 ELSE 0 END) AS [nulos_SFECEMI], COUNT(DISTINCT [SFECEMI]) AS [distintos_SFECEMI],
    SUM(CASE WHEN [sfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_sfecpro], COUNT(DISTINCT [sfecpro]) AS [distintos_sfecpro],
    SUM(CASE WHEN [SINDPGO] IS NULL THEN 1 ELSE 0 END) AS [nulos_SINDPGO], COUNT(DISTINCT [SINDPGO]) AS [distintos_SINDPGO],
    SUM(CASE WHEN [SNUMPLZ] IS NULL THEN 1 ELSE 0 END) AS [nulos_SNUMPLZ], COUNT(DISTINCT [SNUMPLZ]) AS [distintos_SNUMPLZ],
    SUM(CASE WHEN [SSUBTIP] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSUBTIP], COUNT(DISTINCT [SSUBTIP]) AS [distintos_SSUBTIP],
    SUM(CASE WHEN [SSUCCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_SSUCCLI], COUNT(DISTINCT [SSUCCLI]) AS [distintos_SSUCCLI],
    SUM(CASE WHEN [STIPOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_STIPOPE], COUNT(DISTINCT [STIPOPE]) AS [distintos_STIPOPE]
FROM [storage].[com_seg].[SDSF001] WITH (NOLOCK);
