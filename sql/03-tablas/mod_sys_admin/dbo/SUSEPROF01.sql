-- mod_sys_admin.dbo.SUSEPROF01
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GLIMOVRO01, mod_rep.com.GLIMOVRO05, mod_rep.com.GLIMOVRO06

USE mod_sys_admin;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'SCODPROFN', N'SCODUSE') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'dbo' AND c.TABLE_NAME = N'SUSEPROF01'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'dbo.SUSEPROF01') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [SCODPROFN], [SCODUSE]
FROM [mod_sys_admin].[dbo].[SUSEPROF01] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [SCODPROFN] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODPROFN], COUNT(DISTINCT [SCODPROFN]) AS [distintos_SCODPROFN],
    SUM(CASE WHEN [SCODUSE] IS NULL THEN 1 ELSE 0 END) AS [nulos_SCODUSE], COUNT(DISTINCT [SCODUSE]) AS [distintos_SCODUSE]
FROM [mod_sys_admin].[dbo].[SUSEPROF01] WITH (NOLOCK);
