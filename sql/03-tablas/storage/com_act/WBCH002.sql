-- storage.com_act.WBCH002
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GPRECOSELIS001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'hCODSEC', N'HDESCLI', N'HDTIPOPE', N'HFECPRO', N'RDESPROD') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'WBCH002'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.WBCH002') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [hCODSEC], [HDESCLI], [HDTIPOPE], [HFECPRO], [RDESPROD]
FROM [storage].[com_act].[WBCH002] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [hCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_hCODSEC], COUNT(DISTINCT [hCODSEC]) AS [distintos_hCODSEC],
    SUM(CASE WHEN [HDESCLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESCLI], COUNT(DISTINCT [HDESCLI]) AS [distintos_HDESCLI],
    SUM(CASE WHEN [HDTIPOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDTIPOPE], COUNT(DISTINCT [HDTIPOPE]) AS [distintos_HDTIPOPE],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [RDESPROD] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESPROD], COUNT(DISTINCT [RDESPROD]) AS [distintos_RDESPROD]
FROM [storage].[com_act].[WBCH002] WITH (NOLOCK);
