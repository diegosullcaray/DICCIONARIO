-- storage.com_act.SRCC001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GCOSELIS001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'Ndoc_Ident', N'Nro_Empre', N'PCPP', N'PDef', N'PDud', N'PNor', N'PPer', N'Saldo') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'SRCC001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.SRCC001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [Ndoc_Ident], [Nro_Empre], [PCPP], [PDef], [PDud], [PNor], [PPer], [Saldo]
FROM [storage].[com_act].[SRCC001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [Ndoc_Ident] IS NULL THEN 1 ELSE 0 END) AS [nulos_Ndoc_Ident], COUNT(DISTINCT [Ndoc_Ident]) AS [distintos_Ndoc_Ident],
    SUM(CASE WHEN [Nro_Empre] IS NULL THEN 1 ELSE 0 END) AS [nulos_Nro_Empre], COUNT(DISTINCT [Nro_Empre]) AS [distintos_Nro_Empre],
    SUM(CASE WHEN [PCPP] IS NULL THEN 1 ELSE 0 END) AS [nulos_PCPP], COUNT(DISTINCT [PCPP]) AS [distintos_PCPP],
    SUM(CASE WHEN [PDef] IS NULL THEN 1 ELSE 0 END) AS [nulos_PDef], COUNT(DISTINCT [PDef]) AS [distintos_PDef],
    SUM(CASE WHEN [PDud] IS NULL THEN 1 ELSE 0 END) AS [nulos_PDud], COUNT(DISTINCT [PDud]) AS [distintos_PDud],
    SUM(CASE WHEN [PNor] IS NULL THEN 1 ELSE 0 END) AS [nulos_PNor], COUNT(DISTINCT [PNor]) AS [distintos_PNor],
    SUM(CASE WHEN [PPer] IS NULL THEN 1 ELSE 0 END) AS [nulos_PPer], COUNT(DISTINCT [PPer]) AS [distintos_PPer],
    SUM(CASE WHEN [Saldo] IS NULL THEN 1 ELSE 0 END) AS [nulos_Saldo], COUNT(DISTINCT [Saldo]) AS [distintos_Saldo]
FROM [storage].[com_act].[SRCC001] WITH (NOLOCK);
