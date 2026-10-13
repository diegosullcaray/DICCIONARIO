-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-14 17:30:26.627000
--EXEC MOD_REP.com.[RCARDZCUO01] 7,'231','20260818'          
CREATE PROCEDURE [com].[RCARDZCUO01] --drop procedure com.RSGETCOM01_          
@tip_cod varchar(5), @cod_rel varchar(25), @Fecha DATE          
AS          
BEGIN          
SET NOCOUNT ON;            

declare @Fecha_ant date
select @Fecha_ant=  A.RFEC from storage.util.FVECFEC01(@Fecha,'cmg_4') A     

select '' as JSON

;with m_ant as ( 
 	select 'rep' Rep,  @Fecha_ant hfecpro, ISNULL(SUM (HSALCAPMN), 0)  saldo,
	SUM (case when nuevo_ingreso = 'SI' then HSALCAPMN end ) zcuonuevo
	,SUM (case when HDIAATR >60 then HSALCAPMN end ) may60
	,SUM (case when HDIAATR <=60 then HSALCAPMN end ) men60
	,CAST( @tip_cod AS VARCHAR(10)) HTIPCOD,CAST(@cod_rel AS VARCHAR(50)) HCODREL
	--into #DataFinal
	from storage.com_act.WZCUO001
	where HFECPRO = @Fecha_ant and CASE 
            WHEN @tip_cod = 21 THEN cast(RCODGRU as varchar)  
            WHEN @tip_cod = 20 THEN cast(RCODTER as varchar)  
            WHEN @tip_cod = 19 THEN cast(RCODCOR as varchar)  
            WHEN @tip_cod = 18 THEN cast(RCODUNI as varchar)  
            WHEN @tip_cod = 17 THEN cast(RCODUCO as varchar)  
            WHEN @tip_cod = 7  THEN cast(RCODFC as varchar) 
          END = @cod_rel   

),
m_act as (
	select  'rep' Rep,  @Fecha hfecpro, ISNULL(SUM (HSALCAPMN), 0)  saldo,
	SUM (case when nuevo_ingreso = 'SI' then HSALCAPMN end ) zcuonuevo
	,SUM (case when HDIAATR >60 then HSALCAPMN end ) may60
	,SUM (case when HDIAATR <=60 then HSALCAPMN end ) men60
	,CAST( @tip_cod AS VARCHAR(10)) HTIPCOD,CAST(@cod_rel AS VARCHAR(50)) HCODREL
	--into #DataFinal
	from storage.com_act.WZCUO001
	where HFECPRO = @Fecha and CASE 
            WHEN @tip_cod = 21 THEN cast(RCODGRU as varchar)  
            WHEN @tip_cod = 20 THEN cast(RCODTER as varchar)  
            WHEN @tip_cod = 19 THEN cast(RCODCOR as varchar)  
            WHEN @tip_cod = 18 THEN cast(RCODUNI as varchar)  
            WHEN @tip_cod = 17 THEN cast(RCODUCO as varchar)  
            WHEN @tip_cod = 7  THEN cast(RCODFC as varchar) 
          END = @cod_rel   

)
select @tip_cod htipcod, @cod_rel hcodrel, 1 Style,   A.saldo    saldo_act,B.saldo saldo_ant, (A.saldo - B.saldo)dif_saldo
,A.zcuonuevo zcuonuevo_act,B.zcuonuevo zcuonuevo_ant, (A.zcuonuevo - B.zcuonuevo)dif_zcuonuevo
,A.may60 may60_act,B.may60 may60_ant, (A.may60 - B.may60)dif_may60
,A.men60 men60_act,B.men60 men60_ant, (A.men60 - B.men60)dif_men60 
from m_act A full join m_ant B on A.Rep = B.Rep

END
