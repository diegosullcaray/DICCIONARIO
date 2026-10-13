-- storage.com_act.WCMAG001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RAGROMIX, mod_rep.com.RS_AGROMIX_CHART, mod_rep.com.RS_AGROMIX_CHART2, mod_rep.com.RS_AGROMIX_CHART3, mod_rep.com.RS_AGROMIX_CHART4

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'haseoper', N'HCAPMON', N'HCTACLI', N'HEXTENS', N'hfecpro', N'HVENMON') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'WCMAG001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.WCMAG001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [haseoper], [HCAPMON], [HCTACLI], [HEXTENS], [hfecpro], [HVENMON]
FROM [storage].[com_act].[WCMAG001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [haseoper] IS NULL THEN 1 ELSE 0 END) AS [nulos_haseoper], COUNT(DISTINCT [haseoper]) AS [distintos_haseoper],
    SUM(CASE WHEN [HCAPMON] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCAPMON], COUNT(DISTINCT [HCAPMON]) AS [distintos_HCAPMON],
    SUM(CASE WHEN [HCTACLI] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCTACLI], COUNT(DISTINCT [HCTACLI]) AS [distintos_HCTACLI],
    SUM(CASE WHEN [HEXTENS] IS NULL THEN 1 ELSE 0 END) AS [nulos_HEXTENS], COUNT(DISTINCT [HEXTENS]) AS [distintos_HEXTENS],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [HVENMON] IS NULL THEN 1 ELSE 0 END) AS [nulos_HVENMON], COUNT(DISTINCT [HVENMON]) AS [distintos_HVENMON]
FROM [storage].[com_act].[WCMAG001] WITH (NOLOCK);
