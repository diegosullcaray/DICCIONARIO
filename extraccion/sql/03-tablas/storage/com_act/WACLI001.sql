-- storage.com_act.WACLI001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GDCGEST_ACTIVAST01, mod_rep.com.GDCGEST_ACTIVAST03, mod_rep.com.GDCGEST_ACTIVAST04, mod_rep.com.GDCLIOPE01, mod_rep.com.GRESREAGRO01, mod_rep.com.GRMENTOR001, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA011, mod_rep.com.RTABDIGCOM01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'hclinue', N'HCODSEC', N'hconcli', N'hfecpro', N'hinddes') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'WACLI001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.WACLI001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [hclinue], [HCODSEC], [hconcli], [hfecpro], [hinddes]
FROM [storage].[com_act].[WACLI001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [hclinue] IS NULL THEN 1 ELSE 0 END) AS [nulos_hclinue], COUNT(DISTINCT [hclinue]) AS [distintos_hclinue],
    SUM(CASE WHEN [HCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSEC], COUNT(DISTINCT [HCODSEC]) AS [distintos_HCODSEC],
    SUM(CASE WHEN [hconcli] IS NULL THEN 1 ELSE 0 END) AS [nulos_hconcli], COUNT(DISTINCT [hconcli]) AS [distintos_hconcli],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [hinddes] IS NULL THEN 1 ELSE 0 END) AS [nulos_hinddes], COUNT(DISTINCT [hinddes]) AS [distintos_hinddes]
FROM [storage].[com_act].[WACLI001] WITH (NOLOCK);
