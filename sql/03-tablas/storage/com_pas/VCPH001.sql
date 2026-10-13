-- storage.com_pas.VCPH001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.RENRPAS01, mod_rep.com.RENRPAS02

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'HCODSEC', N'HESTADO', N'HPENDOC', N'HPETDOC', N'HSBFECH', N'HSBMOD', N'HSBSDO1', N'HSBSUC', N'HSBTOPE', N'HUSERBP') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'com_pas' AND c.TABLE_NAME = N'VCPH001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'com_pas.VCPH001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [HCODSEC], [HESTADO], [HPENDOC], [HPETDOC], [HSBFECH], [HSBMOD], [HSBSDO1], [HSBSUC], [HSBTOPE], [HUSERBP]
FROM [storage].[com_pas].[VCPH001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [HCODSEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HCODSEC], COUNT(DISTINCT [HCODSEC]) AS [distintos_HCODSEC],
    SUM(CASE WHEN [HESTADO] IS NULL THEN 1 ELSE 0 END) AS [nulos_HESTADO], COUNT(DISTINCT [HESTADO]) AS [distintos_HESTADO],
    SUM(CASE WHEN [HPENDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPENDOC], COUNT(DISTINCT [HPENDOC]) AS [distintos_HPENDOC],
    SUM(CASE WHEN [HPETDOC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HPETDOC], COUNT(DISTINCT [HPETDOC]) AS [distintos_HPETDOC],
    SUM(CASE WHEN [HSBFECH] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBFECH], COUNT(DISTINCT [HSBFECH]) AS [distintos_HSBFECH],
    SUM(CASE WHEN [HSBMOD] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBMOD], COUNT(DISTINCT [HSBMOD]) AS [distintos_HSBMOD],
    SUM(CASE WHEN [HSBSDO1] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBSDO1], COUNT(DISTINCT [HSBSDO1]) AS [distintos_HSBSDO1],
    SUM(CASE WHEN [HSBSUC] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBSUC], COUNT(DISTINCT [HSBSUC]) AS [distintos_HSBSUC],
    SUM(CASE WHEN [HSBTOPE] IS NULL THEN 1 ELSE 0 END) AS [nulos_HSBTOPE], COUNT(DISTINCT [HSBTOPE]) AS [distintos_HSBTOPE],
    SUM(CASE WHEN [HUSERBP] IS NULL THEN 1 ELSE 0 END) AS [nulos_HUSERBP], COUNT(DISTINCT [HUSERBP]) AS [distintos_HUSERBP]
FROM [storage].[com_pas].[VCPH001] WITH (NOLOCK);
