-- storage.com_act.WBCH001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GCOSELIS001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'hcosecha', N'HFECBAS', N'HINDMORH') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'WBCH001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.WBCH001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [hcosecha], [HFECBAS], [HINDMORH]
FROM [storage].[com_act].[WBCH001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [hcosecha] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcosecha], COUNT(DISTINCT [hcosecha]) AS [distintos_hcosecha],
    SUM(CASE WHEN [HFECBAS] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECBAS], COUNT(DISTINCT [HFECBAS]) AS [distintos_HFECBAS],
    SUM(CASE WHEN [HINDMORH] IS NULL THEN 1 ELSE 0 END) AS [nulos_HINDMORH], COUNT(DISTINCT [HINDMORH]) AS [distintos_HINDMORH]
FROM [storage].[com_act].[WBCH001] WITH (NOLOCK);
