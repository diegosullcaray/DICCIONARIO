-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:32.480000
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--EXEC [com].[RSGESMOEF001] 7,'231','1. -30-0'
CREATE PROCEDURE [com].[RSGESMOEF001]
@tip_cod nvarchar(10),@cod_rel nvarchar(10),@tram nvarchar(20) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
     --1. -30-0
	--declare @tip_cod int=6,@cod_rel nvarchar(10)='1';
	-- Result Headers Multiple
	exec [rep].[FTHEACOLS01] 'rda/administracion/mora/monitor_efectividades_03';
	-- Result Set
	declare @count_global float=(select count(HSALCAPMN) from storage.[com_act].WCED001 where HTRAM=@tram);
	--'2. 1-30');

	with cte_base as (
		select ISNULL(A.HFCRES,'VACIO') HFCRES,A.HFGPR,A.HSALCAPMN 
		from storage.[com_act].WCED001 A
		left join storage.[com_act].VLCH001 B  on A.HCODSEC=B.RCODPAR  
		where
		A.HESTACT=IIF(@tram='1. -30-0','DETERIORADO',A.HESTACT) and
		A.HTRAM=@tram--'2. 1-30'
		and case when @tip_cod=6 then A.RCODTER else '-' end=case when @tip_cod=6 then @cod_rel else '-' end
		and case when @tip_cod=5 then A.RCODREG else '-' end=case when @tip_cod=5 then @cod_rel else '-' end
		and case when @tip_cod=4 then A.RCODMAT else '-' end=case when @tip_cod=4 then @cod_rel else '-' end
		and case when @tip_cod=8 then B.RCODCOR else '-' end=case when @tip_cod=8 then @cod_rel else '-' end
	),
	cte_cp as (
		select
		1 [order],
		1 [part], 
		case 
			when HFGPR IS NULL then 1
			else 0 end style,  
		case 
			when HFGPR='NO' then 'COMPROMISO ROTO'
			when HFGPR='SI' then 'COMPROMISO VIGENTE'
			else 'TOTAL COMPROMISOS DE PAGO' end [desc],
		COUNT(HSALCAPMN) as [count],SUM(HSALCAPMN) as [sum],
		COUNT(HSALCAPMN)/@count_global [percent]
		from cte_base
		where HFCRES='COMPROMISO DE PAGO'
		GROUP BY 
			grouping sets ((),HFGPR)
	),
	cte_otr as (
		select
		2 [part],
		ROW_NUMBER() OVER ( ORDER BY (case when HFCRES IS NULL then 1 else 0 end) asc,COUNT(HSALCAPMN) desc) [order], 
		case 
			when HFCRES IS NULL then 1
			else 0 end style,  
		case 
			when HFCRES IS NOT NULL then HFCRES
			else 'TOTAL OTROS' end [desc],
		COUNT(HSALCAPMN) as [count],SUM(HSALCAPMN) as [sum],
		COUNT(HSALCAPMN)/@count_global [percent]
		from cte_base
		where HFCRES!='COMPROMISO DE PAGO'
		GROUP BY 
			grouping sets ((),HFCRES)
	),
	cte_t as (
		select 3 [part],1 [order],2 as [style],'TOTAL GESTIONES' as [desc],COUNT(HSALCAPMN) as [count],SUM(HSALCAPMN) as [sum],COUNT(HSALCAPMN)/@count_global [percent]
		from cte_base
	),
	cte_report as (
		select [part],[order],[style],[desc],[count],[sum],[percent]
		from cte_cp
		union all
		select [part],[order],[style],[desc],[count],[sum],[percent]
		from cte_otr
		union all
		select [part],[order],[style],[desc],[count],[sum],[percent]
		from cte_t
	)
	select [style],[desc],[count],[sum],[percent]
	from cte_report
	order by [part] asc ,[order] asc
	
	
END
