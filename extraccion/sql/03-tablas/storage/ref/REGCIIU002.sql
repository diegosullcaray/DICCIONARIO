-- storage.ref.REGCIIU002
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GSELCIUT002

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HDESGIRO', N'HSECECO') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'ref' AND c.TABLE_NAME = N'REGCIIU002'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'ref.REGCIIU002') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HDESGIRO], [HSECECO]
FROM [storage].[ref].[REGCIIU002] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HDESGIRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESGIRO], COUNT(DISTINCT [HDESGIRO]) AS [distintos_HDESGIRO],
    SUM(CASE WHEN [HSECECO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSECECO], COUNT(DISTINCT [HSECECO]) AS [distintos_HSECECO]
FROM [storage].[ref].[REGCIIU002] WITH (NOLOCK);
