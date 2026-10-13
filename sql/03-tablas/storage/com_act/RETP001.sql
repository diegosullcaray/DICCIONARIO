-- storage.com_act.RETP001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GCOSELIS001, mod_rep.com.GCOSEMAF002, mod_rep.com.GDCGEST_ACTIVAST01, mod_rep.com.GPRECOSCUAD001, mod_rep.com.GRESDESCRE02, mod_rep.com.GRESPROGOB02, mod_rep.com.GRESREPSEG05

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'RCODMOD', N'RCODPROD', N'RTIPOPE') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'RETP001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.RETP001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [RCODMOD], [RCODPROD], [RTIPOPE]
FROM [storage].[com_act].[RETP001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [RCODMOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODMOD], COUNT(DISTINCT [RCODMOD]) AS [distintos_RCODMOD],
    SUM(CASE WHEN [RCODPROD] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODPROD], COUNT(DISTINCT [RCODPROD]) AS [distintos_RCODPROD],
    SUM(CASE WHEN [RTIPOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_RTIPOPE], COUNT(DISTINCT [RTIPOPE]) AS [distintos_RTIPOPE]
FROM [storage].[com_act].[RETP001] WITH (NOLOCK);
