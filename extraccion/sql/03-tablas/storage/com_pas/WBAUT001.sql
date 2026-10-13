-- storage.com_pas.WBAUT001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GDCGEST_PASIVAST01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'CANAL', N'HAOTASA', N'HCOFIC', N'HDMODU', N'HFECPRO', N'HMAPER', N'HRENOV', N'HTMAXI') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_pas' AND c.TABLE_NAME = N'WBAUT001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_pas.WBAUT001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [CANAL], [HAOTASA], [HCOFIC], [HDMODU], [HFECPRO], [HMAPER], [HRENOV], [HTMAXI]
FROM [storage].[com_pas].[WBAUT001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [CANAL] IS NULL THEN 1 ELSE 0 END) AS [nulos_CANAL], COUNT(DISTINCT [CANAL]) AS [distintos_CANAL],
    SUM(CASE WHEN [HAOTASA] IS NULL THEN 1 ELSE 0 END) AS [nulos_HAOTASA], COUNT(DISTINCT [HAOTASA]) AS [distintos_HAOTASA],
    SUM(CASE WHEN [HCOFIC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOFIC], COUNT(DISTINCT [HCOFIC]) AS [distintos_HCOFIC],
    SUM(CASE WHEN [HDMODU] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDMODU], COUNT(DISTINCT [HDMODU]) AS [distintos_HDMODU],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HMAPER] IS NULL THEN 1 ELSE 0 END) AS [nulos_HMAPER], COUNT(DISTINCT [HMAPER]) AS [distintos_HMAPER],
    SUM(CASE WHEN [HRENOV] IS NULL THEN 1 ELSE 0 END) AS [nulos_HRENOV], COUNT(DISTINCT [HRENOV]) AS [distintos_HRENOV],
    SUM(CASE WHEN [HTMAXI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTMAXI], COUNT(DISTINCT [HTMAXI]) AS [distintos_HTMAXI]
FROM [storage].[com_pas].[WBAUT001] WITH (NOLOCK);
