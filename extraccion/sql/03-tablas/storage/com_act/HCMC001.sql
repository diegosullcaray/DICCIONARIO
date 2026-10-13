-- storage.com_act.HCMC001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRTABCORRO01, mod_rep.com.GSELJERAR001, mod_rep.com.RCORRES01, mod_rep.com.RCORRES05, mod_rep.com.RDETCORR01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCAUSAL', N'HCODIGOCB', N'HESTADOTX', N'HFECHAMOV', N'hfecpro', N'HMUNICB', N'HNOMBREPTO', N'HNOMTITCB', N'HTIPOTRN', N'HVALORTX') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'HCMC001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.HCMC001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCAUSAL], [HCODIGOCB], [HESTADOTX], [HFECHAMOV], [hfecpro], [HMUNICB], [HNOMBREPTO], [HNOMTITCB], [HTIPOTRN], [HVALORTX]
FROM [storage].[com_act].[HCMC001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCAUSAL] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCAUSAL], COUNT(DISTINCT [HCAUSAL]) AS [distintos_HCAUSAL],
    SUM(CASE WHEN [HCODIGOCB] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODIGOCB], COUNT(DISTINCT [HCODIGOCB]) AS [distintos_HCODIGOCB],
    SUM(CASE WHEN [HESTADOTX] IS NULL THEN 1 ELSE 0 END) AS [nulos_HESTADOTX], COUNT(DISTINCT [HESTADOTX]) AS [distintos_HESTADOTX],
    SUM(CASE WHEN [HFECHAMOV] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECHAMOV], COUNT(DISTINCT [HFECHAMOV]) AS [distintos_HFECHAMOV],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [HMUNICB] IS NULL THEN 1 ELSE 0 END) AS [nulos_HMUNICB], COUNT(DISTINCT [HMUNICB]) AS [distintos_HMUNICB],
    SUM(CASE WHEN [HNOMBREPTO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNOMBREPTO], COUNT(DISTINCT [HNOMBREPTO]) AS [distintos_HNOMBREPTO],
    SUM(CASE WHEN [HNOMTITCB] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNOMTITCB], COUNT(DISTINCT [HNOMTITCB]) AS [distintos_HNOMTITCB],
    SUM(CASE WHEN [HTIPOTRN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HTIPOTRN], COUNT(DISTINCT [HTIPOTRN]) AS [distintos_HTIPOTRN],
    SUM(CASE WHEN [HVALORTX] IS NULL THEN 1 ELSE 0 END) AS [nulos_HVALORTX], COUNT(DISTINCT [HVALORTX]) AS [distintos_HVALORTX]
FROM [storage].[com_act].[HCMC001] WITH (NOLOCK);
