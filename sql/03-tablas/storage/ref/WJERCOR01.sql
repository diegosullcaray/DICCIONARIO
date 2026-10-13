-- storage.ref.WJERCOR01
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRESPDATOS01, mod_rep.com.GRMENTOR002, mod_rep.com.RSEGSECTOR001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'RCODADM', N'RCODCOR', N'RCODGRU', N'RCODSEC', N'RCODTER', N'RDESGRU', N'RFECPRO', N'RINDFEC') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'ref' AND c.TABLE_NAME = N'WJERCOR01'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'ref.WJERCOR01') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [RCODADM], [RCODCOR], [RCODGRU], [RCODSEC], [RCODTER], [RDESGRU], [RFECPRO], [RINDFEC]
FROM [storage].[ref].[WJERCOR01] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [RCODADM] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODADM], COUNT(DISTINCT [RCODADM]) AS [distintos_RCODADM],
    SUM(CASE WHEN [RCODCOR] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODCOR], COUNT(DISTINCT [RCODCOR]) AS [distintos_RCODCOR],
    SUM(CASE WHEN [RCODGRU] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODGRU], COUNT(DISTINCT [RCODGRU]) AS [distintos_RCODGRU],
    SUM(CASE WHEN [RCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODSEC], COUNT(DISTINCT [RCODSEC]) AS [distintos_RCODSEC],
    SUM(CASE WHEN [RCODTER] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODTER], COUNT(DISTINCT [RCODTER]) AS [distintos_RCODTER],
    SUM(CASE WHEN [RDESGRU] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESGRU], COUNT(DISTINCT [RDESGRU]) AS [distintos_RDESGRU],
    SUM(CASE WHEN [RFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_RFECPRO], COUNT(DISTINCT [RFECPRO]) AS [distintos_RFECPRO],
    SUM(CASE WHEN [RINDFEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_RINDFEC], COUNT(DISTINCT [RINDFEC]) AS [distintos_RINDFEC]
FROM [storage].[ref].[WJERCOR01] WITH (NOLOCK);
