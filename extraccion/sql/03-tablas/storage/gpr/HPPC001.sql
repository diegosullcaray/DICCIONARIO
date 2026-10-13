-- storage.gpr.HPPC001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GDASHKAY03, mod_rep.com.GDASHKAY05, mod_rep.com.GDASHKAY06, mod_rep.com.GLISAUTO01, mod_rep.com.GLISAUTRO05, mod_rep.com.GSCAMP01, mod_rep.com.RENRCOLAB01, mod_rep.com.RSMONEFE05

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'hcodbt', N'HCODSUC', N'HDESCAR', N'HDESPER', N'HDESTER', N'hfecpro', N'HNUMDOC') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'gpr' AND c.TABLE_NAME = N'HPPC001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'gpr.HPPC001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [hcodbt], [HCODSUC], [HDESCAR], [HDESPER], [HDESTER], [hfecpro], [HNUMDOC]
FROM [storage].[gpr].[HPPC001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [hcodbt] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcodbt], COUNT(DISTINCT [hcodbt]) AS [distintos_hcodbt],
    SUM(CASE WHEN [HCODSUC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSUC], COUNT(DISTINCT [HCODSUC]) AS [distintos_HCODSUC],
    SUM(CASE WHEN [HDESCAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESCAR], COUNT(DISTINCT [HDESCAR]) AS [distintos_HDESCAR],
    SUM(CASE WHEN [HDESPER] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESPER], COUNT(DISTINCT [HDESPER]) AS [distintos_HDESPER],
    SUM(CASE WHEN [HDESTER] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESTER], COUNT(DISTINCT [HDESTER]) AS [distintos_HDESTER],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [HNUMDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMDOC], COUNT(DISTINCT [HNUMDOC]) AS [distintos_HNUMDOC]
FROM [storage].[gpr].[HPPC001] WITH (NOLOCK);
