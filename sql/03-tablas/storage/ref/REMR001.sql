-- storage.ref.REMR001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSPANSUP003

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'RCODMAT', N'RCODREG', N'RDESMAT') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'ref' AND c.TABLE_NAME = N'REMR001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'ref.REMR001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [RCODMAT], [RCODREG], [RDESMAT]
FROM [storage].[ref].[REMR001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [RCODMAT] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODMAT], COUNT(DISTINCT [RCODMAT]) AS [distintos_RCODMAT],
    SUM(CASE WHEN [RCODREG] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODREG], COUNT(DISTINCT [RCODREG]) AS [distintos_RCODREG],
    SUM(CASE WHEN [RDESMAT] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESMAT], COUNT(DISTINCT [RDESMAT]) AS [distintos_RDESMAT]
FROM [storage].[ref].[REMR001] WITH (NOLOCK);
