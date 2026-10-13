-- storage.com_act.WTIPCLI001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RGRAFGESTCOM04, mod_rep.com.RGRAFGESTCOM06

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'hcodrel', N'hfecpro', N'HNUMCLIANTI', N'HNUMCLIINGR', N'HNUMCLIPROG', N'HNUMCLIVENC', N'htipcod') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'WTIPCLI001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.WTIPCLI001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [hcodrel], [hfecpro], [HNUMCLIANTI], [HNUMCLIINGR], [HNUMCLIPROG], [HNUMCLIVENC], [htipcod]
FROM [storage].[com_act].[WTIPCLI001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [hcodrel] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcodrel], COUNT(DISTINCT [hcodrel]) AS [distintos_hcodrel],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [HNUMCLIANTI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMCLIANTI], COUNT(DISTINCT [HNUMCLIANTI]) AS [distintos_HNUMCLIANTI],
    SUM(CASE WHEN [HNUMCLIINGR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMCLIINGR], COUNT(DISTINCT [HNUMCLIINGR]) AS [distintos_HNUMCLIINGR],
    SUM(CASE WHEN [HNUMCLIPROG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMCLIPROG], COUNT(DISTINCT [HNUMCLIPROG]) AS [distintos_HNUMCLIPROG],
    SUM(CASE WHEN [HNUMCLIVENC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMCLIVENC], COUNT(DISTINCT [HNUMCLIVENC]) AS [distintos_HNUMCLIVENC],
    SUM(CASE WHEN [htipcod] IS NULL THEN 1 ELSE 0 END) AS [nulos_htipcod], COUNT(DISTINCT [htipcod]) AS [distintos_htipcod]
FROM [storage].[com_act].[WTIPCLI001] WITH (NOLOCK);
