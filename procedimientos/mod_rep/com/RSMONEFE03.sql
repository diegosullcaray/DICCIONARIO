-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-07 06:38:26.317000
  
 -- =============================================    
-- Author:  <Author,,Name>    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
--EXEC [com].[RSMONEFE03] 7,'231','1. -30-0'    
CREATE PROCEDURE [com].[RSMONEFE03]      
@tip_cod nvarchar(10),@cod_rel nvarchar(10),@tram nvarchar(20)       
AS      
BEGIN      
 -- SET NOCOUNT ON added to prevent extra result sets from      
 SET NOCOUNT ON;      
    
 declare @fecha date=dateadd(day,-1,GETDATE());    
 declare @fec date=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)    
     
     --1. -30-0      
 --declare @tip_cod int=6,@cod_rel nvarchar(10)='1',@tram nvarchar(20)='1. -30-0';      
 -- Result Headers Multiple      
 exec [rep].[FTHEACOLS01] 'RS_MON_EFEC_03';      
 -- Result Set      
 declare @count_global float--=(select count(HSALCAPMN) from storage.[com_act].WCED001 where A.HTRAM=@tram);      
 --'2. 1-30');      
      
 ;with cte_base as (      
  select ISNULL(A.HFCRES,'VACIO') HFCRES,A.HFGPR,A.HSALCAPMN       
  from storage.[com_act].WCED001 A         
   left join (select * from storage.[ref].WJERCOR03 where RFECPRO=@fec) B ON A.HCODSEC=B.RCODSEC --select * from  storage.[ref].VJERCOR01 B ON A.HCODSEC=B.RCODSEC      
   where    
   case   
    when @tip_cod=20 then ISNULL(cast(B.RCODTER as nvarchar(10)),'9999')    
 when @tip_cod=19 then cast(B.RCODCOR as nvarchar(10))  
 when @tip_cod=21 then cast(B.RCODGRU as nvarchar(5))        
 when @tip_cod=18 then cast(B.RCODUNI as varchar(50))
 when @tip_cod=17 then cast(B.RCODUCO as varchar(50))
 else '1' end=IIF(@tip_cod=7,'1',@cod_rel)     
      
    and A.HESTACT=IIF(@tram='1. -30-0','DETERIORADO',A.HESTACT)      
    and A.HTRAM=@tram--'2. 1-30'      
 ),      
 cte_count as (      
  select count(*)*1.000 as conteo      
  from cte_base      
 ),      
 cte_cp as (      
  select      
  1 [order],      
  1 [part],       
  case       
   when HFGPR IS NULL then 1      
   else 0 end style,        
  case       
   when HFGPR='NO' then 'COMPROMISO VIGENTE'      
   when HFGPR='SI' then 'COMPROMISO ROTO'      
   else 'TOTAL COMPROMISOS DE PAGO' end [desc],      
  COUNT(HSALCAPMN) as [count],SUM(HSALCAPMN) as [sum],      
  COUNT(HSALCAPMN)/max(conteo) [percent]      
  from cte_base      
  join cte_count on 1=1      
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
  COUNT(HSALCAPMN)/max(conteo) [percent]      
  from cte_base      
  join cte_count on 1=1      
  where HFCRES!='COMPROMISO DE PAGO'      
  GROUP BY       
   grouping sets ((),HFCRES)      
 ),      
 cte_t as (      
  select 3 [part],1 [order],2 as [style],'TOTAL GESTIONES' as [desc],COUNT(HSALCAPMN) as [count],SUM(HSALCAPMN) as [sum],COUNT(HSALCAPMN)/max(conteo) [percent]      
  from cte_base      
  join cte_count on 1=1      
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
