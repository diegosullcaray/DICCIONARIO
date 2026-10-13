-- storage.com_act.HRPDM002
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GLISDETCLIPDM01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HFFINVIG', N'HFINIVIG', N'HHORPRO', N'HMOREACC', N'HNUMDOC', N'HPAIS', N'HREACC', N'HTIPDOC') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'HRPDM002'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.HRPDM002') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HFFINVIG], [HFINIVIG], [HHORPRO], [HMOREACC], [HNUMDOC], [HPAIS], [HREACC], [HTIPDOC]
FROM [storage].[com_act].[HRPDM002] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HFFINVIG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFFINVIG], COUNT(DISTINCT [HFFINVIG]) AS [distintos_HFFINVIG],
    SUM(CASE WHEN [HFINIVIG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFINIVIG], COUNT(DISTINCT [HFINIVIG]) AS [distintos_HFINIVIG],
    SUM(CASE WHEN [HHORPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HHORPRO], COUNT(DISTINCT [HHORPRO]) AS [distintos_HHORPRO],
    SUM(CASE WHEN [HMOREACC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HMOREACC], COUNT(DISTINCT [HMOREACC]) AS [distintos_HMOREACC],
    SUM(CASE WHEN [HNUMDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMDOC], COUNT(DISTINCT [HNUMDOC]) AS [distintos_HNUMDOC],
    SUM(CASE WHEN [HPAIS] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPAIS], COUNT(DISTINCT [HPAIS]) AS [distintos_HPAIS],
    SUM(CASE WHEN [HREACC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HREACC], COUNT(DISTINCT [HREACC]) AS [distintos_HREACC],
    SUM(CASE WHEN [HTIPDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPDOC], COUNT(DISTINCT [HTIPDOC]) AS [distintos_HTIPDOC]
FROM [storage].[com_act].[HRPDM002] WITH (NOLOCK);
