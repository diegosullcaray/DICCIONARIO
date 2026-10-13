-- storage.ref.VJERCOR02
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RENRCOLAB01, mod_rep.com.RSHHCARB001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'rcodage', N'RCODAGEH', N'RCODCOR', N'RCODMAT', N'RCODTER', N'RDESAGE', N'RDESCOR', N'RDESMAT', N'RDESTER') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'ref' AND c.TABLE_NAME = N'VJERCOR02'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'ref.VJERCOR02') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [rcodage], [RCODAGEH], [RCODCOR], [RCODMAT], [RCODTER], [RDESAGE], [RDESCOR], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR02] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [rcodage] IS NULL THEN 1 ELSE 0 END) AS [nulos_rcodage], COUNT(DISTINCT [rcodage]) AS [distintos_rcodage],
    SUM(CASE WHEN [RCODAGEH] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODAGEH], COUNT(DISTINCT [RCODAGEH]) AS [distintos_RCODAGEH],
    SUM(CASE WHEN [RCODCOR] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODCOR], COUNT(DISTINCT [RCODCOR]) AS [distintos_RCODCOR],
    SUM(CASE WHEN [RCODMAT] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODMAT], COUNT(DISTINCT [RCODMAT]) AS [distintos_RCODMAT],
    SUM(CASE WHEN [RCODTER] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODTER], COUNT(DISTINCT [RCODTER]) AS [distintos_RCODTER],
    SUM(CASE WHEN [RDESAGE] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESAGE], COUNT(DISTINCT [RDESAGE]) AS [distintos_RDESAGE],
    SUM(CASE WHEN [RDESCOR] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESCOR], COUNT(DISTINCT [RDESCOR]) AS [distintos_RDESCOR],
    SUM(CASE WHEN [RDESMAT] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESMAT], COUNT(DISTINCT [RDESMAT]) AS [distintos_RDESMAT],
    SUM(CASE WHEN [RDESTER] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESTER], COUNT(DISTINCT [RDESTER]) AS [distintos_RDESTER]
FROM [storage].[ref].[VJERCOR02] WITH (NOLOCK);
