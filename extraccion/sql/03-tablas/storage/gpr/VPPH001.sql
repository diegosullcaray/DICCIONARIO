-- storage.gpr.VPPH001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GDASHKAY06, mod_rep.com.GLIMOVO02, mod_rep.com.GLIMOVO05, mod_rep.com.GLIMOVO06, mod_rep.com.GLIMOVRO01, mod_rep.com.GLIMOVRO05, mod_rep.com.GLIMOVRO06, mod_rep.com.GLISCAPRET01, mod_rep.com.GLISDETCLI01, mod_rep.com.GLISDETCLIPDM01, mod_rep.com.GLISPROSP01, mod_rep.com.GRESCLIREP01, mod_rep.com.GRESPDATOS01, mod_rep.com.GRESPDATOS02, mod_rep.com.GSEGUIINC001, mod_rep.com.RENRPAS01, mod_rep.com.RESDMOV02, mod_rep.com.RSDESEMP02, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSMONEFE05, mod_rep.com.RSPROYCOLDES006, mod_rep.com.RSPROYCOLDES007, mod_rep.com.RSPROYCOLDES008

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'hcodbt', N'HDESCAR', N'HDESPER', N'HMAILPER', N'HNUMDOC') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'gpr' AND c.TABLE_NAME = N'VPPH001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'gpr.VPPH001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [hcodbt], [HDESCAR], [HDESPER], [HMAILPER], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [hcodbt] IS NULL THEN 1 ELSE 0 END) AS [nulos_hcodbt], COUNT(DISTINCT [hcodbt]) AS [distintos_hcodbt],
    SUM(CASE WHEN [HDESCAR] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESCAR], COUNT(DISTINCT [HDESCAR]) AS [distintos_HDESCAR],
    SUM(CASE WHEN [HDESPER] IS NULL THEN 1 ELSE 0 END) AS [nulos_HDESPER], COUNT(DISTINCT [HDESPER]) AS [distintos_HDESPER],
    SUM(CASE WHEN [HMAILPER] IS NULL THEN 1 ELSE 0 END) AS [nulos_HMAILPER], COUNT(DISTINCT [HMAILPER]) AS [distintos_HMAILPER],
    SUM(CASE WHEN [HNUMDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUMDOC], COUNT(DISTINCT [HNUMDOC]) AS [distintos_HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);
