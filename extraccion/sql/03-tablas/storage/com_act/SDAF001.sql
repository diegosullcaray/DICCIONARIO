-- storage.com_act.SDAF001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSRDFCA021, mod_rep.com.RSRDFCA022, mod_rep.com.RSRDFCA023, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA031, mod_rep.com.RSRDFCA037, mod_rep.com.RSRDFCA038, mod_rep.com.RSRDFCA050, mod_rep.com.RSRDFCA050_3, mod_rep.com.RSRDFCA050_4, strategos.mod_rep_com_act.GDDESEMDIA

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'SFECPRO') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'SDAF001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.SDAF001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [SFECPRO]
FROM [storage].[com_act].[SDAF001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [SFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_SFECPRO], COUNT(DISTINCT [SFECPRO]) AS [distintos_SFECPRO]
FROM [storage].[com_act].[SDAF001] WITH (NOLOCK);
