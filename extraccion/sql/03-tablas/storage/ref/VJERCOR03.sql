-- storage.ref.VJERCOR03
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GDCGEST_PASIVAST01, mod_rep.com.GRTABAPPO01, mod_rep.com.GRTABCORRO01, mod_rep.com.GSELJERAR001, mod_rep.com.RCORRES01, mod_rep.com.RCORRES05, mod_rep.com.RCORRES06, mod_rep.com.RDETCORR01, mod_rep.com.RENRPAS02, mod_rep.com.RPROSCORR002, mod_rep.com.RPROSCORR004, mod_rep.com.RPROSCORR005, mod_rep.com.RPROSCORR006

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'RCODAGE', N'RCODCOR', N'RCODFC', N'RCODMAT', N'RCODTER', N'RDESAGE', N'RDESCOR', N'RDESFC', N'RDESMAT', N'RDESTER') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'ref' AND c.TABLE_NAME = N'VJERCOR03'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'ref.VJERCOR03') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [RCODAGE], [RCODCOR], [RCODFC], [RCODMAT], [RCODTER], [RDESAGE], [RDESCOR], [RDESFC], [RDESMAT], [RDESTER]
FROM [storage].[ref].[VJERCOR03] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [RCODAGE] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODAGE], COUNT(DISTINCT [RCODAGE]) AS [distintos_RCODAGE],
    SUM(CASE WHEN [RCODCOR] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODCOR], COUNT(DISTINCT [RCODCOR]) AS [distintos_RCODCOR],
    SUM(CASE WHEN [RCODFC] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODFC], COUNT(DISTINCT [RCODFC]) AS [distintos_RCODFC],
    SUM(CASE WHEN [RCODMAT] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODMAT], COUNT(DISTINCT [RCODMAT]) AS [distintos_RCODMAT],
    SUM(CASE WHEN [RCODTER] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODTER], COUNT(DISTINCT [RCODTER]) AS [distintos_RCODTER],
    SUM(CASE WHEN [RDESAGE] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESAGE], COUNT(DISTINCT [RDESAGE]) AS [distintos_RDESAGE],
    SUM(CASE WHEN [RDESCOR] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESCOR], COUNT(DISTINCT [RDESCOR]) AS [distintos_RDESCOR],
    SUM(CASE WHEN [RDESFC] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESFC], COUNT(DISTINCT [RDESFC]) AS [distintos_RDESFC],
    SUM(CASE WHEN [RDESMAT] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESMAT], COUNT(DISTINCT [RDESMAT]) AS [distintos_RDESMAT],
    SUM(CASE WHEN [RDESTER] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESTER], COUNT(DISTINCT [RDESTER]) AS [distintos_RDESTER]
FROM [storage].[ref].[VJERCOR03] WITH (NOLOCK);
