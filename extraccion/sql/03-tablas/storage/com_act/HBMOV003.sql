-- storage.com_act.HBMOV003
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GLIMOVO02, mod_rep.com.GLIMOVO05, mod_rep.com.GLIMOVO06, mod_rep.com.GLIMOVRO05, mod_rep.com.GLIMOVRO06

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'codigo_bt', N'Cta_Cliente', N'Distrito', N'FECHA', N'filtro2', N'filtro3', N'filtro4', N'filtro5', N'filtro6', N'filtro7', N'HCOMENT', N'HFECPRO', N'HLATIT', N'HLONG', N'HORA') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'HBMOV003'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.HBMOV003') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [codigo_bt], [Cta_Cliente], [Distrito], [FECHA], [filtro2], [filtro3], [filtro4], [filtro5], [filtro6], [filtro7], [HCOMENT], [HFECPRO], [HLATIT], [HLONG], [HORA]
FROM [storage].[com_act].[HBMOV003] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [codigo_bt] IS NULL THEN 1 ELSE 0 END) AS [nulos_codigo_bt], COUNT(DISTINCT [codigo_bt]) AS [distintos_codigo_bt],
    SUM(CASE WHEN [Cta_Cliente] IS NULL THEN 1 ELSE 0 END) AS [nulos_Cta_Cliente], COUNT(DISTINCT [Cta_Cliente]) AS [distintos_Cta_Cliente],
    SUM(CASE WHEN [Distrito] IS NULL THEN 1 ELSE 0 END) AS [nulos_Distrito], COUNT(DISTINCT [Distrito]) AS [distintos_Distrito],
    SUM(CASE WHEN [FECHA] IS NULL THEN 1 ELSE 0 END) AS [nulos_FECHA], COUNT(DISTINCT [FECHA]) AS [distintos_FECHA],
    SUM(CASE WHEN [filtro2] IS NULL THEN 1 ELSE 0 END) AS [nulos_filtro2], COUNT(DISTINCT [filtro2]) AS [distintos_filtro2],
    SUM(CASE WHEN [filtro3] IS NULL THEN 1 ELSE 0 END) AS [nulos_filtro3], COUNT(DISTINCT [filtro3]) AS [distintos_filtro3],
    SUM(CASE WHEN [filtro4] IS NULL THEN 1 ELSE 0 END) AS [nulos_filtro4], COUNT(DISTINCT [filtro4]) AS [distintos_filtro4],
    SUM(CASE WHEN [filtro5] IS NULL THEN 1 ELSE 0 END) AS [nulos_filtro5], COUNT(DISTINCT [filtro5]) AS [distintos_filtro5],
    SUM(CASE WHEN [filtro6] IS NULL THEN 1 ELSE 0 END) AS [nulos_filtro6], COUNT(DISTINCT [filtro6]) AS [distintos_filtro6],
    SUM(CASE WHEN [filtro7] IS NULL THEN 1 ELSE 0 END) AS [nulos_filtro7], COUNT(DISTINCT [filtro7]) AS [distintos_filtro7],
    SUM(CASE WHEN [HCOMENT] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCOMENT], COUNT(DISTINCT [HCOMENT]) AS [distintos_HCOMENT],
    SUM(CASE WHEN [HFECPRO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HFECPRO], COUNT(DISTINCT [HFECPRO]) AS [distintos_HFECPRO],
    SUM(CASE WHEN [HLATIT] IS NULL THEN 1 ELSE 0 END) AS [nulos_HLATIT], COUNT(DISTINCT [HLATIT]) AS [distintos_HLATIT],
    SUM(CASE WHEN [HLONG] IS NULL THEN 1 ELSE 0 END) AS [nulos_HLONG], COUNT(DISTINCT [HLONG]) AS [distintos_HLONG],
    SUM(CASE WHEN [HORA] IS NULL THEN 1 ELSE 0 END) AS [nulos_HORA], COUNT(DISTINCT [HORA]) AS [distintos_HORA]
FROM [storage].[com_act].[HBMOV003] WITH (NOLOCK);
