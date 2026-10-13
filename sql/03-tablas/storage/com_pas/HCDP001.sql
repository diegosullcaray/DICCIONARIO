-- storage.com_pas.HCDP001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GSEGCAPBP01, strategos.mod_rep_com_act.GDCCAP_BP01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'*', N'HCODSEC', N'hfecpro', N'HPENDOC', N'HPEPAIS', N'HPETDOC', N'HSBCTA', N'HSBOPER', N'HSBSBOP') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_pas' AND c.TABLE_NAME = N'HCDP001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_pas.HCDP001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [*], [HCODSEC], [hfecpro], [HPENDOC], [HPEPAIS], [HPETDOC], [HSBCTA], [HSBOPER], [HSBSBOP]
FROM [storage].[com_pas].[HCDP001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [*] IS NULL THEN 1 ELSE 0 END) AS [nulos_*], COUNT(DISTINCT [*]) AS [distintos_*],
    SUM(CASE WHEN [HCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSEC], COUNT(DISTINCT [HCODSEC]) AS [distintos_HCODSEC],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [HPENDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPENDOC], COUNT(DISTINCT [HPENDOC]) AS [distintos_HPENDOC],
    SUM(CASE WHEN [HPEPAIS] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPEPAIS], COUNT(DISTINCT [HPEPAIS]) AS [distintos_HPEPAIS],
    SUM(CASE WHEN [HPETDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPETDOC], COUNT(DISTINCT [HPETDOC]) AS [distintos_HPETDOC],
    SUM(CASE WHEN [HSBCTA] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBCTA], COUNT(DISTINCT [HSBCTA]) AS [distintos_HSBCTA],
    SUM(CASE WHEN [HSBOPER] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBOPER], COUNT(DISTINCT [HSBOPER]) AS [distintos_HSBOPER],
    SUM(CASE WHEN [HSBSBOP] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBSBOP], COUNT(DISTINCT [HSBSBOP]) AS [distintos_HSBSBOP]
FROM [storage].[com_pas].[HCDP001] WITH (NOLOCK);
