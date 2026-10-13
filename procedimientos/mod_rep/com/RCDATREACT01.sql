-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.590000
--exec com.GRESCLIREP01 '75352553'
--EXEC [com].[RCDATREACT01] '20200417'
CREATE PROCEDURE [com].[RCDATREACT01]
@fecha date 
AS  
BEGIN  
 SET NOCOUNT ON;  
  
    exec mod_rep.rep.FTHEACOLS01 'LSRC_DATA_REACT_01'  

	select  HFECPRO fecha,HSUCCLI cod_oficina,HCODSEC sectorista_bt,HCTACLI cta_cliente,HFLAGES flag_gestion
	from [storage].[com_act].[HBCI001]
 
END
