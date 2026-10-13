-- LS_FCMIS_REP.FCMIS_REP.dbo.ControlCargaData
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSRPD001

USE FCMIS_REP;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'BitAct', N'descripcion', N'fechaAct', N'FechaRep', N'FechaRepAnt', N'id') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'dbo' AND c.TABLE_NAME = N'ControlCargaData'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'dbo.ControlCargaData') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [BitAct], [descripcion], [fechaAct], [FechaRep], [FechaRepAnt], [id]
FROM [FCMIS_REP].[dbo].[ControlCargaData] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [BitAct] IS NULL THEN 1 ELSE 0 END) AS [nulos_BitAct], COUNT(DISTINCT [BitAct]) AS [distintos_BitAct],
    SUM(CASE WHEN [descripcion] IS NULL THEN 1 ELSE 0 END) AS [nulos_descripcion], COUNT(DISTINCT [descripcion]) AS [distintos_descripcion],
    SUM(CASE WHEN [fechaAct] IS NULL THEN 1 ELSE 0 END) AS [nulos_fechaAct], COUNT(DISTINCT [fechaAct]) AS [distintos_fechaAct],
    SUM(CASE WHEN [FechaRep] IS NULL THEN 1 ELSE 0 END) AS [nulos_FechaRep], COUNT(DISTINCT [FechaRep]) AS [distintos_FechaRep],
    SUM(CASE WHEN [FechaRepAnt] IS NULL THEN 1 ELSE 0 END) AS [nulos_FechaRepAnt], COUNT(DISTINCT [FechaRepAnt]) AS [distintos_FechaRepAnt],
    SUM(CASE WHEN [id] IS NULL THEN 1 ELSE 0 END) AS [nulos_id], COUNT(DISTINCT [id]) AS [distintos_id]
FROM [FCMIS_REP].[dbo].[ControlCargaData] WITH (NOLOCK);
