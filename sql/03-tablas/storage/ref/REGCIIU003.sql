-- storage.ref.REGCIIU003
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GLISDETCLI01, mod_rep.com.GSELCIUT001, mod_rep.com.GSELJERAR001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'RCODCIIU', N'RDESCIIU') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'ref' AND c.TABLE_NAME = N'REGCIIU003'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'ref.REGCIIU003') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [RCODCIIU], [RDESCIIU]
FROM [storage].[ref].[REGCIIU003] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [RCODCIIU] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODCIIU], COUNT(DISTINCT [RCODCIIU]) AS [distintos_RCODCIIU],
    SUM(CASE WHEN [RDESCIIU] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESCIIU], COUNT(DISTINCT [RDESCIIU]) AS [distintos_RDESCIIU]
FROM [storage].[ref].[REGCIIU003] WITH (NOLOCK);
