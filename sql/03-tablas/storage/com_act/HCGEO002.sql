-- storage.com_act.HCGEO002
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RCORRES05

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HAGENCI', N'HCOORDE', N'HCORRED', N'HFECPRO', N'HNOMCOR', N'HTERRIT') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'HCGEO002'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.HCGEO002') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HAGENCI], [HCOORDE], [HCORRED], [HFECPRO], [HNOMCOR], [HTERRIT]
FROM [storage].[com_act].[HCGEO002] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HAGENCI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HAGENCI], COUNT(DISTINCT [HAGENCI]) AS [distintos_HAGENCI],
    SUM(CASE WHEN [HCOORDE] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOORDE], COUNT(DISTINCT [HCOORDE]) AS [distintos_HCOORDE],
    SUM(CASE WHEN [HCORRED] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCORRED], COUNT(DISTINCT [HCORRED]) AS [distintos_HCORRED],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HNOMCOR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNOMCOR], COUNT(DISTINCT [HNOMCOR]) AS [distintos_HNOMCOR],
    SUM(CASE WHEN [HTERRIT] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTERRIT], COUNT(DISTINCT [HTERRIT]) AS [distintos_HTERRIT]
FROM [storage].[com_act].[HCGEO002] WITH (NOLOCK);
