-- storage.com_pas.WCLIENRO001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRTABDIGO01, mod_rep.com.GRTABDIGO02

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HAGUSER', N'hcodcan', N'HSBSUC') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_pas' AND c.TABLE_NAME = N'WCLIENRO001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_pas.WCLIENRO001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HAGUSER], [hcodcan], [HSBSUC]
FROM [storage].[com_pas].[WCLIENRO001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HAGUSER] IS NULL THEN 1 ELSE 0 END) AS [nulos_HAGUSER], COUNT(DISTINCT [HAGUSER]) AS [distintos_HAGUSER],
    SUM(CASE WHEN [hcodcan] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcodcan], COUNT(DISTINCT [hcodcan]) AS [distintos_hcodcan],
    SUM(CASE WHEN [HSBSUC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBSUC], COUNT(DISTINCT [HSBSUC]) AS [distintos_HSBSUC]
FROM [storage].[com_pas].[WCLIENRO001] WITH (NOLOCK);
