-- storage.com_act.wjas002
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GCMGMORA001, mod_rep.com.GCMGMORA003, mod_rep.com.GCOMCRE01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCAST12M', N'hcodrel', N'HFECPRO', N'HRECCAST12M', N'htipcod', N'HVENTA_CARTMN', N'HVENTA_CARTMN12M') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'wjas002'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.wjas002') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCAST12M], [hcodrel], [HFECPRO], [HRECCAST12M], [htipcod], [HVENTA_CARTMN], [HVENTA_CARTMN12M]
FROM [storage].[com_act].[wjas002] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCAST12M] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCAST12M], COUNT(DISTINCT [HCAST12M]) AS [distintos_HCAST12M],
    SUM(CASE WHEN [hcodrel] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcodrel], COUNT(DISTINCT [hcodrel]) AS [distintos_hcodrel],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HRECCAST12M] IS NULL THEN 1 ELSE 0 END) AS [nulos_HRECCAST12M], COUNT(DISTINCT [HRECCAST12M]) AS [distintos_HRECCAST12M],
    SUM(CASE WHEN [htipcod] IS NULL THEN 1 ELSE 0 END) AS [nulos_htipcod], COUNT(DISTINCT [htipcod]) AS [distintos_htipcod],
    SUM(CASE WHEN [HVENTA_CARTMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HVENTA_CARTMN], COUNT(DISTINCT [HVENTA_CARTMN]) AS [distintos_HVENTA_CARTMN],
    SUM(CASE WHEN [HVENTA_CARTMN12M] IS NULL THEN 1 ELSE 0 END) AS [nulos_HVENTA_CARTMN12M], COUNT(DISTINCT [HVENTA_CARTMN12M]) AS [distintos_HVENTA_CARTMN12M]
FROM [storage].[com_act].[wjas002] WITH (NOLOCK);
