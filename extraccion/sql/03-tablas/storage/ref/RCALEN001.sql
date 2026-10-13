-- storage.ref.RCALEN001
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Usada por: mod_rep.com.GCOMCRE01, mod_rep.com.GCOMCRE02, mod_rep.com.GCOSELIS001, mod_rep.com.GCOSEMAF002, mod_rep.com.GDACDESEM01, mod_rep.com.GDCEROCN003, mod_rep.com.GDCEROCN004, mod_rep.com.GDCGEST_ACTIVAST01, mod_rep.com.GDCGEST_ACTIVAST02, mod_rep.com.GDCGEST_ACTIVAST03, mod_rep.com.GDCGEST_ACTIVAST04, mod_rep.com.GDCLIOPE01, mod_rep.com.GLIMOVO05, mod_rep.com.GLIMOVO06, mod_rep.com.GLIMOVRO05, mod_rep.com.GLIMOVRO06, mod_rep.com.GLISAUTRO05, mod_rep.com.GPASP001, mod_rep.com.GPRECOSCUAD001, mod_rep.com.GPRECOSELIS001, mod_rep.com.GRCEROCUOTAO01, mod_rep.com.GRCEROCUOTAO02, mod_rep.com.GRESCAMCOND03, mod_rep.com.GRESDESCRE02, mod_rep.com.GRESREAGRO01, mod_rep.com.GRESREPSEG06, mod_rep.com.GRESREPSEG_01, mod_rep.com.GRGCTABDIGO02, mod_rep.com.GRGCTABDIGO03, mod_rep.com.GRMENTOR002, mod_rep.com.GRTABAPPO01, mod_rep.com.GRTABCORRO01, mod_rep.com.GRTABDIGO01, mod_rep.com.GRTABDIGO02, mod_rep.com.GRVGENCORO01, mod_rep.com.GRVGENCORO02, mod_rep.com.GSEGCAPBP01, mod_rep.com.GSEGCAPRED01, mod_rep.com.RAGROMIX, mod_rep.com.RCORRES01, mod_rep.com.RDETCORR01, mod_rep.com.RENRDESEM01, mod_rep.com.RENROPE01, mod_rep.com.RENRPAS01, mod_rep.com.RENRPAS02, mod_rep.com.RESDMOV01, mod_rep.com.RESDMOV02, mod_rep.com.RFECREPMEN, mod_rep.com.RFECREPMEN02, mod_rep.com.RGRAFGESTCOM02, mod_rep.com.RGRAFGESTCOM03, mod_rep.com.RGRAFGESTCOM04, mod_rep.com.RGRAFGESTCOM05, mod_rep.com.RGRAFGESTCOM06, mod_rep.com.RGRAFGESTCOM07, mod_rep.com.RGRAFSEGPAS01, mod_rep.com.RGRAFSEGPAS02, mod_rep.com.RINCEGP01, mod_rep.com.RPROSCORR005, mod_rep.com.RREPGESTCOM02, mod_rep.com.RREPGESTCOM03, mod_rep.com.RSAGECOM01, mod_rep.com.RSAGECOM02, mod_rep.com.RSAGECOM03, mod_rep.com.RSAVAPOR01, mod_rep.com.RSCALCAR01, mod_rep.com.RSCALCAR02, mod_rep.com.RSCMGCF001, mod_rep.com.RSCMGCLIPAS01, mod_rep.com.RSCMGCLIPAS03, mod_rep.com.RSDATPRO01, mod_rep.com.RSDATPRO02, mod_rep.com.RSDATPRO03, mod_rep.com.RSDATPRO04, mod_rep.com.RSDESEMB, mod_rep.com.RSDESEMB02, mod_rep.com.RSDESEMP02, mod_rep.com.RSEGSECTOR001, mod_rep.com.RSGETCOM01, mod_rep.com.RSIMR01, mod_rep.com.RSLISTCCN01, mod_rep.com.RSMONEFE01, mod_rep.com.RSMONEFE02, mod_rep.com.RSMONEFE03, mod_rep.com.RSMONEFE05, mod_rep.com.RSMONEFER01, mod_rep.com.RSMONEFER02, mod_rep.com.RSMONEFEREPRO01, mod_rep.com.RSMONEFETRC01, mod_rep.com.RSMONRENT01, mod_rep.com.RSPANSUP001, mod_rep.com.RSPANSUP003, mod_rep.com.RSPROYCOLDES002, mod_rep.com.RSPROYCOLDES003, mod_rep.com.RSPROYCOLDES004, mod_rep.com.RSPROYCOLDES005, mod_rep.com.RSPROYCOLDES006, mod_rep.com.RSPROYCOLDES007, mod_rep.com.RSPROYCOLDES008, mod_rep.com.RSPROYCOLDES010, mod_rep.com.RSRDFCA007, mod_rep.com.RSRDFCA011, mod_rep.com.RSRDFCA021, mod_rep.com.RSRDFCA022, mod_rep.com.RSRDFCA023, mod_rep.com.RSRDFCA024, mod_rep.com.RSRDFCA025, mod_rep.com.RSRDFCA026, mod_rep.com.RSRDFCA029, mod_rep.com.RSRDFCA031, mod_rep.com.RSRDFCA032, mod_rep.com.RSRDFCA037, mod_rep.com.RSRDMA023, mod_rep.com.RSRPD001, mod_rep.com.RSSALCAR01, mod_rep.com.RSSALCAR02, mod_rep.com.RSSALCAR03, mod_rep.com.RSSALCARVIGE01, mod_rep.com.RSSALCARVIGE02, mod_rep.com.RSSEGPAS01, mod_rep.com.RSSEGPAS02, mod_rep.com.RSSEGPAS03, mod_rep.com.RSSEGPAS04, mod_rep.com.RSSEGPDM01, mod_rep.com.RSTABCOMER02, mod_rep.com.RS_AGE_COM_CR_01, mod_rep.com.RS_AGE_COM_CR_02, mod_rep.com.RS_AGE_COM_CR_M_01, mod_rep.com.RS_AGE_COM_CR_M_02, mod_rep.com.RS_AGE_COM_CR_M_03, mod_rep.com.RS_AGE_COM_CR_M_04, mod_rep.com.RTABDIGCOM01, mod_sec.dbo.GCATSEC01

USE storage;
GO

-- 1. Estructura real: tipo, largo y nulabilidad de cada columna.
SELECT c.ORDINAL_POSITION AS orden, c.COLUMN_NAME AS columna, c.DATA_TYPE AS tipo,
       c.CHARACTER_MAXIMUM_LENGTH AS largo, c.NUMERIC_PRECISION AS precision_num,
       c.NUMERIC_SCALE AS escala, c.IS_NULLABLE AS acepta_nulos,
       CASE WHEN c.COLUMN_NAME IN (N'RANI', N'RANIBIS', N'rciebt', N'RCIEMES', N'RDIA', N'RDIAANI', N'RDIAFER', N'RDIASEM', N'RFEC', N'RFECTXT', N'RFINSEM', N'RFLAG01', N'RID', N'RMES', N'RMESNOM', N'RNOMDIASEM', N'rsem') THEN 1 ELSE 0 END AS usada_por_reportes
FROM INFORMATION_SCHEMA.COLUMNS c
WHERE c.TABLE_SCHEMA = N'ref' AND c.TABLE_NAME = N'RCALEN001'
ORDER BY c.ORDINAL_POSITION;

-- 2. Tamaño (sin recorrer la tabla).
SELECT SUM(p.rows) AS filas
FROM sys.partitions p
WHERE p.object_id = OBJECT_ID(N'ref.RCALEN001') AND p.index_id IN (0, 1);

-- 3. Muestra de las columnas que usan los reportes.
SELECT TOP (100) [RANI], [RANIBIS], [rciebt], [RCIEMES], [RDIA], [RDIAANI], [RDIAFER], [RDIASEM], [RFEC], [RFECTXT], [RFINSEM], [RFLAG01], [RID], [RMES], [RMESNOM], [RNOMDIASEM], [rsem]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);

-- 4. Perfil rápido: nulos y valores distintos por columna usada.
SELECT
    COUNT(*) AS filas,
    SUM(CASE WHEN [RANI] IS NULL THEN 1 ELSE 0 END) AS [nulos_RANI], COUNT(DISTINCT [RANI]) AS [distintos_RANI],
    SUM(CASE WHEN [RANIBIS] IS NULL THEN 1 ELSE 0 END) AS [nulos_RANIBIS], COUNT(DISTINCT [RANIBIS]) AS [distintos_RANIBIS],
    SUM(CASE WHEN [rciebt] IS NULL THEN 1 ELSE 0 END) AS [nulos_rciebt], COUNT(DISTINCT [rciebt]) AS [distintos_rciebt],
    SUM(CASE WHEN [RCIEMES] IS NULL THEN 1 ELSE 0 END) AS [nulos_RCIEMES], COUNT(DISTINCT [RCIEMES]) AS [distintos_RCIEMES],
    SUM(CASE WHEN [RDIA] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDIA], COUNT(DISTINCT [RDIA]) AS [distintos_RDIA],
    SUM(CASE WHEN [RDIAANI] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDIAANI], COUNT(DISTINCT [RDIAANI]) AS [distintos_RDIAANI],
    SUM(CASE WHEN [RDIAFER] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDIAFER], COUNT(DISTINCT [RDIAFER]) AS [distintos_RDIAFER],
    SUM(CASE WHEN [RDIASEM] IS NULL THEN 1 ELSE 0 END) AS [nulos_RDIASEM], COUNT(DISTINCT [RDIASEM]) AS [distintos_RDIASEM],
    SUM(CASE WHEN [RFEC] IS NULL THEN 1 ELSE 0 END) AS [nulos_RFEC], COUNT(DISTINCT [RFEC]) AS [distintos_RFEC],
    SUM(CASE WHEN [RFECTXT] IS NULL THEN 1 ELSE 0 END) AS [nulos_RFECTXT], COUNT(DISTINCT [RFECTXT]) AS [distintos_RFECTXT],
    SUM(CASE WHEN [RFINSEM] IS NULL THEN 1 ELSE 0 END) AS [nulos_RFINSEM], COUNT(DISTINCT [RFINSEM]) AS [distintos_RFINSEM],
    SUM(CASE WHEN [RFLAG01] IS NULL THEN 1 ELSE 0 END) AS [nulos_RFLAG01], COUNT(DISTINCT [RFLAG01]) AS [distintos_RFLAG01],
    SUM(CASE WHEN [RID] IS NULL THEN 1 ELSE 0 END) AS [nulos_RID], COUNT(DISTINCT [RID]) AS [distintos_RID],
    SUM(CASE WHEN [RMES] IS NULL THEN 1 ELSE 0 END) AS [nulos_RMES], COUNT(DISTINCT [RMES]) AS [distintos_RMES],
    SUM(CASE WHEN [RMESNOM] IS NULL THEN 1 ELSE 0 END) AS [nulos_RMESNOM], COUNT(DISTINCT [RMESNOM]) AS [distintos_RMESNOM],
    SUM(CASE WHEN [RNOMDIASEM] IS NULL THEN 1 ELSE 0 END) AS [nulos_RNOMDIASEM], COUNT(DISTINCT [RNOMDIASEM]) AS [distintos_RNOMDIASEM],
    SUM(CASE WHEN [rsem] IS NULL THEN 1 ELSE 0 END) AS [nulos_rsem], COUNT(DISTINCT [rsem]) AS [distintos_rsem]
FROM [storage].[ref].[RCALEN001] WITH (NOLOCK);
