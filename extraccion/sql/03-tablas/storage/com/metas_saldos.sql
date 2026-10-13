-- storage.com.metas_saldos
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRESREPSEG05, mod_rep.com.RPROSCORR005, mod_rep.com.RSSEGPDM01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'10044', N'10062', N'8000', N'HCODREL', N'hcodvar', N'hfecpro', N'HTIPCOD', N'htipmeta', N'HVALVAR', N'PVT') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com' AND c.TABLE_NAME = N'metas_saldos'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com.metas_saldos') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [10044], [10062], [8000], [HCODREL], [hcodvar], [hfecpro], [HTIPCOD], [htipmeta], [HVALVAR], [PVT]
FROM [storage].[com].[metas_saldos] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [10044] IS NULL THEN 1 ELSE 0 END) AS [nulos_10044], COUNT(DISTINCT [10044]) AS [distintos_10044],
    SUM(CASE WHEN [10062] IS NULL THEN 1 ELSE 0 END) AS [nulos_10062], COUNT(DISTINCT [10062]) AS [distintos_10062],
    SUM(CASE WHEN [8000] IS NULL THEN 1 ELSE 0 END) AS [nulos_8000], COUNT(DISTINCT [8000]) AS [distintos_8000],
    SUM(CASE WHEN [HCODREL] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODREL], COUNT(DISTINCT [HCODREL]) AS [distintos_HCODREL],
    SUM(CASE WHEN [hcodvar] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcodvar], COUNT(DISTINCT [hcodvar]) AS [distintos_hcodvar],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [HTIPCOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPCOD], COUNT(DISTINCT [HTIPCOD]) AS [distintos_HTIPCOD],
    SUM(CASE WHEN [htipmeta] IS NULL THEN 1 ELSE 0 END) AS [nulos_htipmeta], COUNT(DISTINCT [htipmeta]) AS [distintos_htipmeta],
    SUM(CASE WHEN [HVALVAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HVALVAR], COUNT(DISTINCT [HVALVAR]) AS [distintos_HVALVAR],
    SUM(CASE WHEN [PVT] IS NULL THEN 1 ELSE 0 END) AS [nulos_PVT], COUNT(DISTINCT [PVT]) AS [distintos_PVT]
FROM [storage].[com].[metas_saldos] WITH (NOLOCK);
