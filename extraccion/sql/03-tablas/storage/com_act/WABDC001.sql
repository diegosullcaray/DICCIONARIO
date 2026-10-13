-- storage.com_act.WABDC001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSAGECOM01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODSEC', N'HEVTO', N'HFECPRO', N'HINDBASE', N'HINDDESB', N'HNUMCON') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'WABDC001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.WABDC001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODSEC], [HEVTO], [HFECPRO], [HINDBASE], [HINDDESB], [HNUMCON]
FROM [storage].[com_act].[WABDC001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSEC], COUNT(DISTINCT [HCODSEC]) AS [distintos_HCODSEC],
    SUM(CASE WHEN [HEVTO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HEVTO], COUNT(DISTINCT [HEVTO]) AS [distintos_HEVTO],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HINDBASE] IS NULL THEN 1 ELSE 0 END) AS [nulos_HINDBASE], COUNT(DISTINCT [HINDBASE]) AS [distintos_HINDBASE],
    SUM(CASE WHEN [HINDDESB] IS NULL THEN 1 ELSE 0 END) AS [nulos_HINDDESB], COUNT(DISTINCT [HINDDESB]) AS [distintos_HINDDESB],
    SUM(CASE WHEN [HNUMCON] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMCON], COUNT(DISTINCT [HNUMCON]) AS [distintos_HNUMCON]
FROM [storage].[com_act].[WABDC001] WITH (NOLOCK);
