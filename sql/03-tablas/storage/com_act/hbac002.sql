-- storage.com_act.hbac002
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSMONEFE02, mod_rep.com.RSMONEFER02

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODOPE', N'HFECEJC', N'hfecpro', N'HNUM_CONDONADO') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'hbac002'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.hbac002') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODOPE], [HFECEJC], [hfecpro], [HNUM_CONDONADO]
FROM [storage].[com_act].[hbac002] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODOPE], COUNT(DISTINCT [HCODOPE]) AS [distintos_HCODOPE],
    SUM(CASE WHEN [HFECEJC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECEJC], COUNT(DISTINCT [HFECEJC]) AS [distintos_HFECEJC],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [HNUM_CONDONADO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HNUM_CONDONADO], COUNT(DISTINCT [HNUM_CONDONADO]) AS [distintos_HNUM_CONDONADO]
FROM [storage].[com_act].[hbac002] WITH (NOLOCK);
