-- storage.ref.ResGridCiiu2
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSEGSECTOR001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'codvars', N'ROWI', N'style', N'vars') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'ref' AND c.TABLE_NAME = N'ResGridCiiu2'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'ref.ResGridCiiu2') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [codvars], [ROWI], [style], [vars]
FROM [storage].[ref].[ResGridCiiu2] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [codvars] IS NULL THEN 1 ELSE 0 END) AS [nulos_codvars], COUNT(DISTINCT [codvars]) AS [distintos_codvars],
    SUM(CASE WHEN [ROWI] IS NULL THEN 1 ELSE 0 END) AS [nulos_ROWI], COUNT(DISTINCT [ROWI]) AS [distintos_ROWI],
    SUM(CASE WHEN [style] IS NULL THEN 1 ELSE 0 END) AS [nulos_style], COUNT(DISTINCT [style]) AS [distintos_style],
    SUM(CASE WHEN [vars] IS NULL THEN 1 ELSE 0 END) AS [nulos_vars], COUNT(DISTINCT [vars]) AS [distintos_vars]
FROM [storage].[ref].[ResGridCiiu2] WITH (NOLOCK);
