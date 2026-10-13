-- strategos.sys_met.HTTPTRACE
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: strategos.mod_rep_com_act.HTTPTRACE

USE strategos;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'request') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'sys_met' AND c.TABLE_NAME = N'HTTPTRACE'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'sys_met.HTTPTRACE') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [request]
FROM [strategos].[sys_met].[HTTPTRACE] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [request] IS NULL THEN 1 ELSE 0 END) AS [nulos_request], COUNT(DISTINCT [request]) AS [distintos_request]
FROM [strategos].[sys_met].[HTTPTRACE] WITH (NOLOCK);
