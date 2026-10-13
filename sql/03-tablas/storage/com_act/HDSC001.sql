-- storage.com_act.HDSC001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSPANSUP003

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCARGO', N'HFECPRO', N'HPERSUP', N'HREG') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'HDSC001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.HDSC001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCARGO], [HFECPRO], [HPERSUP], [HREG]
FROM [storage].[com_act].[HDSC001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCARGO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCARGO], COUNT(DISTINCT [HCARGO]) AS [distintos_HCARGO],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HPERSUP] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPERSUP], COUNT(DISTINCT [HPERSUP]) AS [distintos_HPERSUP],
    SUM(CASE WHEN [HREG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HREG], COUNT(DISTINCT [HREG]) AS [distintos_HREG]
FROM [storage].[com_act].[HDSC001] WITH (NOLOCK);
