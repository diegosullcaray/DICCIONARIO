-- storage.com_pas.WCAP002
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GRTABDIGO01, mod_rep.com.GRTABDIGO02

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HASEOPER', N'HFECPRO', N'HORD', N'HPENDOC', N'HPEPAIS', N'HPETDOC', N'HSBSUC') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_pas' AND c.TABLE_NAME = N'WCAP002'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_pas.WCAP002') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HASEOPER], [HFECPRO], [HORD], [HPENDOC], [HPEPAIS], [HPETDOC], [HSBSUC]
FROM [storage].[com_pas].[WCAP002] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HASEOPER] IS NULL THEN 1 ELSE 0 END) AS [nulos_HASEOPER], COUNT(DISTINCT [HASEOPER]) AS [distintos_HASEOPER],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HORD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HORD], COUNT(DISTINCT [HORD]) AS [distintos_HORD],
    SUM(CASE WHEN [HPENDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPENDOC], COUNT(DISTINCT [HPENDOC]) AS [distintos_HPENDOC],
    SUM(CASE WHEN [HPEPAIS] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPEPAIS], COUNT(DISTINCT [HPEPAIS]) AS [distintos_HPEPAIS],
    SUM(CASE WHEN [HPETDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPETDOC], COUNT(DISTINCT [HPETDOC]) AS [distintos_HPETDOC],
    SUM(CASE WHEN [HSBSUC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBSUC], COUNT(DISTINCT [HSBSUC]) AS [distintos_HSBSUC]
FROM [storage].[com_pas].[WCAP002] WITH (NOLOCK);
