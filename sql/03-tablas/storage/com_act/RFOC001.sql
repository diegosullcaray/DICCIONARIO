-- storage.com_act.RFOC001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RINCEGP01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'RCODOPE', N'ROPEFEC') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'RFOC001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.RFOC001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [RCODOPE], [ROPEFEC]
FROM [storage].[com_act].[RFOC001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [RCODOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODOPE], COUNT(DISTINCT [RCODOPE]) AS [distintos_RCODOPE],
    SUM(CASE WHEN [ROPEFEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_ROPEFEC], COUNT(DISTINCT [ROPEFEC]) AS [distintos_ROPEFEC]
FROM [storage].[com_act].[RFOC001] WITH (NOLOCK);
