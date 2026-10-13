-- storage.com_act.WACIIU0013
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RSEGSECTOR001

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODSEC', N'HCUOVEN', N'hfecpro', N'hfecproc', N'HSALVENMN', N'MontoDesembolsados', N'MontoDesembolsadosNuevos', N'MontoDesembolsadosRecurrentes', N'NDesembolsados', N'NDesembolsadosNuevos', N'NDesembolsadosRecurrentes', N'ord', N'RDESGRUP', N'SalCapi') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_act' AND c.TABLE_NAME = N'WACIIU0013'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_act.WACIIU0013') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODSEC], [HCUOVEN], [hfecpro], [hfecproc], [HSALVENMN], [MontoDesembolsados], [MontoDesembolsadosNuevos], [MontoDesembolsadosRecurrentes], [NDesembolsados], [NDesembolsadosNuevos], [NDesembolsadosRecurrentes], [ord], [RDESGRUP], [SalCapi]
FROM [storage].[com_act].[WACIIU0013] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSEC], COUNT(DISTINCT [HCODSEC]) AS [distintos_HCODSEC],
    SUM(CASE WHEN [HCUOVEN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCUOVEN], COUNT(DISTINCT [HCUOVEN]) AS [distintos_HCUOVEN],
    SUM(CASE WHEN [hfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecpro], COUNT(DISTINCT [hfecpro]) AS [distintos_hfecpro],
    SUM(CASE WHEN [hfecproc] IS NULL THEN 1 ELSE 0 END) AS [nulos_hfecproc], COUNT(DISTINCT [hfecproc]) AS [distintos_hfecproc],
    SUM(CASE WHEN [HSALVENMN] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSALVENMN], COUNT(DISTINCT [HSALVENMN]) AS [distintos_HSALVENMN],
    SUM(CASE WHEN [MontoDesembolsados] IS NULL THEN 1 ELSE 0 END) AS [nulos_MontoDesembolsados], COUNT(DISTINCT [MontoDesembolsados]) AS [distintos_MontoDesembolsados],
    SUM(CASE WHEN [MontoDesembolsadosNuevos] IS NULL THEN 1 ELSE 0 END) AS [nulos_MontoDesembolsadosNuevos], COUNT(DISTINCT [MontoDesembolsadosNuevos]) AS [distintos_MontoDesembolsadosNuevos],
    SUM(CASE WHEN [MontoDesembolsadosRecurrentes] IS NULL THEN 1 ELSE 0 END) AS [nulos_MontoDesembolsadosRecurrentes], COUNT(DISTINCT [MontoDesembolsadosRecurrentes]) AS [distintos_MontoDesembolsadosRecurrentes],
    SUM(CASE WHEN [NDesembolsados] IS NULL THEN 1 ELSE 0 END) AS [nulos_NDesembolsados], COUNT(DISTINCT [NDesembolsados]) AS [distintos_NDesembolsados],
    SUM(CASE WHEN [NDesembolsadosNuevos] IS NULL THEN 1 ELSE 0 END) AS [nulos_NDesembolsadosNuevos], COUNT(DISTINCT [NDesembolsadosNuevos]) AS [distintos_NDesembolsadosNuevos],
    SUM(CASE WHEN [NDesembolsadosRecurrentes] IS NULL THEN 1 ELSE 0 END) AS [nulos_NDesembolsadosRecurrentes], COUNT(DISTINCT [NDesembolsadosRecurrentes]) AS [distintos_NDesembolsadosRecurrentes],
    SUM(CASE WHEN [ord] IS NULL THEN 1 ELSE 0 END) AS [nulos_ord], COUNT(DISTINCT [ord]) AS [distintos_ord],
    SUM(CASE WHEN [RDESGRUP] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESGRUP], COUNT(DISTINCT [RDESGRUP]) AS [distintos_RDESGRUP],
    SUM(CASE WHEN [SalCapi] IS NULL THEN 1 ELSE 0 END) AS [nulos_SalCapi], COUNT(DISTINCT [SalCapi]) AS [distintos_SalCapi]
FROM [storage].[com_act].[WACIIU0013] WITH (NOLOCK);
