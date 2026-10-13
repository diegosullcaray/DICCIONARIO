-- storage.gpr.HBASCAT001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_sec.dbo.GCATSEC01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'c1_1', N'c1_2', N'c1_3', N'c1_4', N'c1_5', N'c1_6', N'c2_1', N'c2_2', N'c2_3', N'c2_4', N'c2_5', N'c2_6', N'c3_1', N'c3_2', N'c3_3', N'c3_4', N'c3_5', N'c3_6', N'c4_1', N'c4_2', N'c4_3', N'c4_4', N'c4_5', N'c4_6', N'c5_1', N'c5_2', N'c5_3', N'c5_4', N'c5_5', N'c5_6', N'c6_1', N'c6_2', N'c6_3', N'c6_4', N'c6_5', N'c6_6', N'HCARSEC', N'HCATSEC', N'HCODSEC', N'HCOM001', N'HCOM002', N'HCOM003', N'HCOM004', N'HCOM005', N'HCOM006', N'HCOMFIN', N'HDESSEC', N'HFECPRO', N'HGENSEC', N'HNUMDOC', N'HREQ001', N'HREQ002', N'HREQ003', N'HREQ004') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'gpr' AND c.TABLE_NAME = N'HBASCAT001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'gpr.HBASCAT001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [c1_1], [c1_2], [c1_3], [c1_4], [c1_5], [c1_6], [c2_1], [c2_2], [c2_3], [c2_4], [c2_5], [c2_6], [c3_1], [c3_2], [c3_3], [c3_4], [c3_5], [c3_6], [c4_1], [c4_2], [c4_3], [c4_4], [c4_5], [c4_6], [c5_1], [c5_2], [c5_3], [c5_4], [c5_5], [c5_6], [c6_1], [c6_2], [c6_3], [c6_4], [c6_5], [c6_6], [HCARSEC], [HCATSEC], [HCODSEC], [HCOM001], [HCOM002], [HCOM003], [HCOM004], [HCOM005], [HCOM006], [HCOMFIN], [HDESSEC], [HFECPRO], [HGENSEC], [HNUMDOC], [HREQ001], [HREQ002], [HREQ003], [HREQ004]
FROM [storage].[gpr].[HBASCAT001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [c1_1] IS NULL THEN 1 ELSE 0 END) AS [nulos_c1_1], COUNT(DISTINCT [c1_1]) AS [distintos_c1_1],
    SUM(CASE WHEN [c1_2] IS NULL THEN 1 ELSE 0 END) AS [nulos_c1_2], COUNT(DISTINCT [c1_2]) AS [distintos_c1_2],
    SUM(CASE WHEN [c1_3] IS NULL THEN 1 ELSE 0 END) AS [nulos_c1_3], COUNT(DISTINCT [c1_3]) AS [distintos_c1_3],
    SUM(CASE WHEN [c1_4] IS NULL THEN 1 ELSE 0 END) AS [nulos_c1_4], COUNT(DISTINCT [c1_4]) AS [distintos_c1_4],
    SUM(CASE WHEN [c1_5] IS NULL THEN 1 ELSE 0 END) AS [nulos_c1_5], COUNT(DISTINCT [c1_5]) AS [distintos_c1_5],
    SUM(CASE WHEN [c1_6] IS NULL THEN 1 ELSE 0 END) AS [nulos_c1_6], COUNT(DISTINCT [c1_6]) AS [distintos_c1_6],
    SUM(CASE WHEN [c2_1] IS NULL THEN 1 ELSE 0 END) AS [nulos_c2_1], COUNT(DISTINCT [c2_1]) AS [distintos_c2_1],
    SUM(CASE WHEN [c2_2] IS NULL THEN 1 ELSE 0 END) AS [nulos_c2_2], COUNT(DISTINCT [c2_2]) AS [distintos_c2_2],
    SUM(CASE WHEN [c2_3] IS NULL THEN 1 ELSE 0 END) AS [nulos_c2_3], COUNT(DISTINCT [c2_3]) AS [distintos_c2_3],
    SUM(CASE WHEN [c2_4] IS NULL THEN 1 ELSE 0 END) AS [nulos_c2_4], COUNT(DISTINCT [c2_4]) AS [distintos_c2_4],
    SUM(CASE WHEN [c2_5] IS NULL THEN 1 ELSE 0 END) AS [nulos_c2_5], COUNT(DISTINCT [c2_5]) AS [distintos_c2_5],
    SUM(CASE WHEN [c2_6] IS NULL THEN 1 ELSE 0 END) AS [nulos_c2_6], COUNT(DISTINCT [c2_6]) AS [distintos_c2_6],
    SUM(CASE WHEN [c3_1] IS NULL THEN 1 ELSE 0 END) AS [nulos_c3_1], COUNT(DISTINCT [c3_1]) AS [distintos_c3_1],
    SUM(CASE WHEN [c3_2] IS NULL THEN 1 ELSE 0 END) AS [nulos_c3_2], COUNT(DISTINCT [c3_2]) AS [distintos_c3_2],
    SUM(CASE WHEN [c3_3] IS NULL THEN 1 ELSE 0 END) AS [nulos_c3_3], COUNT(DISTINCT [c3_3]) AS [distintos_c3_3],
    SUM(CASE WHEN [c3_4] IS NULL THEN 1 ELSE 0 END) AS [nulos_c3_4], COUNT(DISTINCT [c3_4]) AS [distintos_c3_4],
    SUM(CASE WHEN [c3_5] IS NULL THEN 1 ELSE 0 END) AS [nulos_c3_5], COUNT(DISTINCT [c3_5]) AS [distintos_c3_5],
    SUM(CASE WHEN [c3_6] IS NULL THEN 1 ELSE 0 END) AS [nulos_c3_6], COUNT(DISTINCT [c3_6]) AS [distintos_c3_6],
    SUM(CASE WHEN [c4_1] IS NULL THEN 1 ELSE 0 END) AS [nulos_c4_1], COUNT(DISTINCT [c4_1]) AS [distintos_c4_1],
    SUM(CASE WHEN [c4_2] IS NULL THEN 1 ELSE 0 END) AS [nulos_c4_2], COUNT(DISTINCT [c4_2]) AS [distintos_c4_2],
    SUM(CASE WHEN [c4_3] IS NULL THEN 1 ELSE 0 END) AS [nulos_c4_3], COUNT(DISTINCT [c4_3]) AS [distintos_c4_3],
    SUM(CASE WHEN [c4_4] IS NULL THEN 1 ELSE 0 END) AS [nulos_c4_4], COUNT(DISTINCT [c4_4]) AS [distintos_c4_4],
    SUM(CASE WHEN [c4_5] IS NULL THEN 1 ELSE 0 END) AS [nulos_c4_5], COUNT(DISTINCT [c4_5]) AS [distintos_c4_5],
    SUM(CASE WHEN [c4_6] IS NULL THEN 1 ELSE 0 END) AS [nulos_c4_6], COUNT(DISTINCT [c4_6]) AS [distintos_c4_6],
    SUM(CASE WHEN [c5_1] IS NULL THEN 1 ELSE 0 END) AS [nulos_c5_1], COUNT(DISTINCT [c5_1]) AS [distintos_c5_1],
    SUM(CASE WHEN [c5_2] IS NULL THEN 1 ELSE 0 END) AS [nulos_c5_2], COUNT(DISTINCT [c5_2]) AS [distintos_c5_2],
    SUM(CASE WHEN [c5_3] IS NULL THEN 1 ELSE 0 END) AS [nulos_c5_3], COUNT(DISTINCT [c5_3]) AS [distintos_c5_3],
    SUM(CASE WHEN [c5_4] IS NULL THEN 1 ELSE 0 END) AS [nulos_c5_4], COUNT(DISTINCT [c5_4]) AS [distintos_c5_4],
    SUM(CASE WHEN [c5_5] IS NULL THEN 1 ELSE 0 END) AS [nulos_c5_5], COUNT(DISTINCT [c5_5]) AS [distintos_c5_5],
    SUM(CASE WHEN [c5_6] IS NULL THEN 1 ELSE 0 END) AS [nulos_c5_6], COUNT(DISTINCT [c5_6]) AS [distintos_c5_6],
    SUM(CASE WHEN [c6_1] IS NULL THEN 1 ELSE 0 END) AS [nulos_c6_1], COUNT(DISTINCT [c6_1]) AS [distintos_c6_1],
    SUM(CASE WHEN [c6_2] IS NULL THEN 1 ELSE 0 END) AS [nulos_c6_2], COUNT(DISTINCT [c6_2]) AS [distintos_c6_2],
    SUM(CASE WHEN [c6_3] IS NULL THEN 1 ELSE 0 END) AS [nulos_c6_3], COUNT(DISTINCT [c6_3]) AS [distintos_c6_3],
    SUM(CASE WHEN [c6_4] IS NULL THEN 1 ELSE 0 END) AS [nulos_c6_4], COUNT(DISTINCT [c6_4]) AS [distintos_c6_4],
    SUM(CASE WHEN [c6_5] IS NULL THEN 1 ELSE 0 END) AS [nulos_c6_5], COUNT(DISTINCT [c6_5]) AS [distintos_c6_5],
    SUM(CASE WHEN [c6_6] IS NULL THEN 1 ELSE 0 END) AS [nulos_c6_6], COUNT(DISTINCT [c6_6]) AS [distintos_c6_6],
    SUM(CASE WHEN [HCARSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCARSEC], COUNT(DISTINCT [HCARSEC]) AS [distintos_HCARSEC],
    SUM(CASE WHEN [HCATSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCATSEC], COUNT(DISTINCT [HCATSEC]) AS [distintos_HCATSEC],
    SUM(CASE WHEN [HCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSEC], COUNT(DISTINCT [HCODSEC]) AS [distintos_HCODSEC],
    SUM(CASE WHEN [HCOM001] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOM001], COUNT(DISTINCT [HCOM001]) AS [distintos_HCOM001],
    SUM(CASE WHEN [HCOM002] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOM002], COUNT(DISTINCT [HCOM002]) AS [distintos_HCOM002],
    SUM(CASE WHEN [HCOM003] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOM003], COUNT(DISTINCT [HCOM003]) AS [distintos_HCOM003],
    SUM(CASE WHEN [HCOM004] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOM004], COUNT(DISTINCT [HCOM004]) AS [distintos_HCOM004],
    SUM(CASE WHEN [HCOM005] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOM005], COUNT(DISTINCT [HCOM005]) AS [distintos_HCOM005],
    SUM(CASE WHEN [HCOM006] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOM006], COUNT(DISTINCT [HCOM006]) AS [distintos_HCOM006],
    SUM(CASE WHEN [HCOMFIN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOMFIN], COUNT(DISTINCT [HCOMFIN]) AS [distintos_HCOMFIN],
    SUM(CASE WHEN [HDESSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESSEC], COUNT(DISTINCT [HDESSEC]) AS [distintos_HDESSEC],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HGENSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HGENSEC], COUNT(DISTINCT [HGENSEC]) AS [distintos_HGENSEC],
    SUM(CASE WHEN [HNUMDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMDOC], COUNT(DISTINCT [HNUMDOC]) AS [distintos_HNUMDOC],
    SUM(CASE WHEN [HREQ001] IS NULL THEN 1 ELSE 0 END) AS [nulos_HREQ001], COUNT(DISTINCT [HREQ001]) AS [distintos_HREQ001],
    SUM(CASE WHEN [HREQ002] IS NULL THEN 1 ELSE 0 END) AS [nulos_HREQ002], COUNT(DISTINCT [HREQ002]) AS [distintos_HREQ002],
    SUM(CASE WHEN [HREQ003] IS NULL THEN 1 ELSE 0 END) AS [nulos_HREQ003], COUNT(DISTINCT [HREQ003]) AS [distintos_HREQ003],
    SUM(CASE WHEN [HREQ004] IS NULL THEN 1 ELSE 0 END) AS [nulos_HREQ004], COUNT(DISTINCT [HREQ004]) AS [distintos_HREQ004]
FROM [storage].[gpr].[HBASCAT001] WITH (NOLOCK);
