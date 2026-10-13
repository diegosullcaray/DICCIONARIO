-- mod_rep.com.GRESCLIREP01: tablas y columnas que usa
-- Generado por governance/scripts/generar-diccionario.mjs. No editar: se regenera.
-- Reportes: RES_SEC_REP_01
-- Ficha: diccionario/procedimientos/mod_rep/com/GRESCLIREP01.md

USE mod_rep;
GO

-- 1. Columnas que devuelve el SP, sin ejecutarlo (falla con SQL dinámico o #temporales).
SELECT column_ordinal AS orden, name AS columna, system_type_name AS tipo, source_database AS base_origen,
       source_schema AS esquema_origen, source_table AS tabla_origen, source_column AS columna_origen
FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(N'com.GRESCLIREP01'), 1)
ORDER BY column_ordinal;

-- 2. Muestra de cada tabla con las columnas que usa este SP.

-- storage.com_act.HBAR001 · lee · 7 columna(s)
SELECT TOP (100) [HCODOPE], [HMONCUO], [HPREG01], [HPREG02], [HPREG03], [HPREG04], [HTIPCUO]
FROM [storage].[com_act].[HBAR001] WITH (NOLOCK);

-- storage.com_act.WBCR001 · lee · 17 columna(s)
SELECT TOP (100) [HBGCTACLI], [HBGNOMCLI], [HCODOPE], [HCODSEC], [HCTACLI], [HCUOPEN], [HDESCLI], [HFECDES], [HFECMOR], [HFLAGREAC], [HGRUPROD], [HNOMG], [HNUMDOC], [HPAIS], [HSALCAPMN], [HTIPDOC], [RDESPROD]
FROM [storage].[com_act].[WBCR001] WITH (NOLOCK);

-- storage.gpr.HDETPER01 · lee · 4 columna(s)
SELECT TOP (100) [HNUMDOC], [HNUMTELE], [HPAIS], [HTIPDOC]
FROM [storage].[gpr].[HDETPER01] WITH (NOLOCK);

-- storage.gpr.VPPH001 · lee · 2 columna(s)
SELECT TOP (100) [HCODBT], [HNUMDOC]
FROM [storage].[gpr].[VPPH001] WITH (NOLOCK);
