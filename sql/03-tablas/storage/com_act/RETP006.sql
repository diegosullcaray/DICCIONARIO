-- storage.com_act.RETP006
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSRTOPMIS001, mod_rep.com.RSRTOPMIS002, mod_rep.com.RSRTOPMIS003, mod_rep.com.RSRTOPMIS004

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'RCODMOD', N'RDESSUBP', N'RSUBTIP', N'RTIPOPE') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'RETP006'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.RETP006') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [RCODMOD], [RDESSUBP], [RSUBTIP], [RTIPOPE]
FROM [storage].[com_act].[RETP006] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [RCODMOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODMOD], COUNT(DISTINCT [RCODMOD]) AS [distintos_RCODMOD],
    SUM(CASE WHEN [RDESSUBP] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESSUBP], COUNT(DISTINCT [RDESSUBP]) AS [distintos_RDESSUBP],
    SUM(CASE WHEN [RSUBTIP] IS NULL THEN 1 ELSE 0 END) AS [nulos_RSUBTIP], COUNT(DISTINCT [RSUBTIP]) AS [distintos_RSUBTIP],
    SUM(CASE WHEN [RTIPOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_RTIPOPE], COUNT(DISTINCT [RTIPOPE]) AS [distintos_RTIPOPE]
FROM [storage].[com_act].[RETP006] WITH (NOLOCK);
