-- storage.ref.wjercor03
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.DINCEPDM01, mod_rep.com.GDCGEST_ACTIVAST02, mod_rep.com.GLIMOVO01, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRESDESCRE02, mod_rep.com.GRESPROGOB01, mod_rep.com.GRESPROGOB02, mod_rep.com.GRESREPSEG01, mod_rep.com.GRESREPSEG02, mod_rep.com.GRESREPSEG05, mod_rep.com.GRESREPSEG06, mod_rep.com.GRMENTOR001, mod_rep.com.GSELJERAR002, mod_rep.com.GTOPCERCUO001, mod_rep.com.GTOPCERCUO002, mod_rep.com.GTOPCERCUO003, mod_rep.com.GTOPCERCUO004, mod_rep.com.GTOPCERCUO005, mod_rep.com.RGRAFGESTCOM05, mod_rep.com.RGRAFGESTCOM06, mod_rep.com.RINCEGP01, mod_rep.com.RRANKM01, mod_rep.com.RSAGECOM01, mod_rep.com.RSDESEMP01, mod_rep.com.RSGETCOM01, mod_rep.com.RSIMR01, mod_rep.com.RSLISTCCN01, mod_rep.com.RSMONEFE01, mod_rep.com.RSMONEFE02, mod_rep.com.RSMONEFE03, mod_rep.com.RSMONEFER02, mod_rep.com.RSMONEFETRC01, mod_rep.com.RSPANSUP001, mod_rep.com.RSPANSUP002, mod_rep.com.RSRDFCA027, mod_rep.com.RSRDFCA028, mod_rep.com.RSRDFCA030, mod_rep.com.RSRDFCA035, mod_rep.com.RSRDFCA037, mod_rep.com.RSRDMA023, mod_rep.com.RSRTOPMIS001, mod_rep.com.RSRTOPMIS002, mod_rep.com.RSRTOPMIS003, mod_rep.com.RSRTOPMIS004, mod_rep.com.RSSEGPDM01, storage.com.RGRAFGESTCOM07_

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'*', N'RCODCOR', N'RCODFC', N'RCODGRU', N'rcodsec', N'RCODTER', N'RCODUCO', N'RCODUNI', N'rdescor', N'RDESFC', N'RDESGRU', N'rdessec', N'rdester', N'RDESUCO', N'rdesuni', N'rfecpro', N'rindfec') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'ref' AND c.TABLE_NAME = N'wjercor03'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'ref.wjercor03') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [*], [RCODCOR], [RCODFC], [RCODGRU], [rcodsec], [RCODTER], [RCODUCO], [RCODUNI], [rdescor], [RDESFC], [RDESGRU], [rdessec], [rdester], [RDESUCO], [rdesuni], [rfecpro], [rindfec]
FROM [storage].[ref].[wjercor03] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [*] IS NULL THEN 1 ELSE 0 END) AS [nulos_*], COUNT(DISTINCT [*]) AS [distintos_*],
    SUM(CASE WHEN [RCODCOR] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODCOR], COUNT(DISTINCT [RCODCOR]) AS [distintos_RCODCOR],
    SUM(CASE WHEN [RCODFC] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODFC], COUNT(DISTINCT [RCODFC]) AS [distintos_RCODFC],
    SUM(CASE WHEN [RCODGRU] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODGRU], COUNT(DISTINCT [RCODGRU]) AS [distintos_RCODGRU],
    SUM(CASE WHEN [rcodsec] IS NULL THEN 1 ELSE 0 END) AS [nulos_rcodsec], COUNT(DISTINCT [rcodsec]) AS [distintos_rcodsec],
    SUM(CASE WHEN [RCODTER] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODTER], COUNT(DISTINCT [RCODTER]) AS [distintos_RCODTER],
    SUM(CASE WHEN [RCODUCO] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODUCO], COUNT(DISTINCT [RCODUCO]) AS [distintos_RCODUCO],
    SUM(CASE WHEN [RCODUNI] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCODUNI], COUNT(DISTINCT [RCODUNI]) AS [distintos_RCODUNI],
    SUM(CASE WHEN [rdescor] IS NULL THEN 1 ELSE 0 END) AS [nulos_rdescor], COUNT(DISTINCT [rdescor]) AS [distintos_rdescor],
    SUM(CASE WHEN [RDESFC] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESFC], COUNT(DISTINCT [RDESFC]) AS [distintos_RDESFC],
    SUM(CASE WHEN [RDESGRU] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESGRU], COUNT(DISTINCT [RDESGRU]) AS [distintos_RDESGRU],
    SUM(CASE WHEN [rdessec] IS NULL THEN 1 ELSE 0 END) AS [nulos_rdessec], COUNT(DISTINCT [rdessec]) AS [distintos_rdessec],
    SUM(CASE WHEN [rdester] IS NULL THEN 1 ELSE 0 END) AS [nulos_rdester], COUNT(DISTINCT [rdester]) AS [distintos_rdester],
    SUM(CASE WHEN [RDESUCO] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDESUCO], COUNT(DISTINCT [RDESUCO]) AS [distintos_RDESUCO],
    SUM(CASE WHEN [rdesuni] IS NULL THEN 1 ELSE 0 END) AS [nulos_rdesuni], COUNT(DISTINCT [rdesuni]) AS [distintos_rdesuni],
    SUM(CASE WHEN [rfecpro] IS NULL THEN 1 ELSE 0 END) AS [nulos_rfecpro], COUNT(DISTINCT [rfecpro]) AS [distintos_rfecpro],
    SUM(CASE WHEN [rindfec] IS NULL THEN 1 ELSE 0 END) AS [nulos_rindfec], COUNT(DISTINCT [rindfec]) AS [distintos_rindfec]
FROM [storage].[ref].[wjercor03] WITH (NOLOCK);
