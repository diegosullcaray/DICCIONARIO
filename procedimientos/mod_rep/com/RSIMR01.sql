-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-07-09 17:03:40.807000

--exec [com].[RSIMR01]  7 ,'231','20250708','0'  
CREATE  PROCEDURE [com].[RSIMR01]        
--@tip_cod int,@cod_rel varchar(20),@fec date,@fuga int,@prop int,@pagen int=1,@nom varchar(150)='0'       
@tip_cod int,@cod_rel varchar(20),@fec date , @f_ase varchar (20) =null 
      
AS                  
BEGIN                  
 SET NOCOUNT ON;     
  
 set @fec = '20250708'
--declare @fec as date = '20250331'

IF OBJECT_ID('tempdb..#fechas') IS NOT NULL DROP TABLE #fechas
;with fecs1 as (
  select  format(RFEC,'yyyyMMdd') F  from storage.[util].[FVECFEC01](@fec,'cmg_5,cmg_6') 
 ),
 fecs2 as(
  select top 1 RFEC  from storage.ref.rcalen001 where rfec < (select top 1 * from fecs1 order by f asc) and rciebt =1 order by RFEC desc 
  ),
  fechas as (
  select * from fecs1
  union
  select * from fecs2
  )
  select DENSE_RANK() OVER (ORDER BY F asc) AS R, * into #fechas from fechas
 
   
 declare @fecha1 as date, @fecha2 as date, @fecha3 as date 
 select @fecha1 = f from #fechas where r=1
 select @fecha2 = f from #fechas where r=2
 select @fecha3 = f from #fechas where r=3 

                  
              
                --,"backgroundColor": "#81A13C"
        
  declare @headers varchar(max)='[{"label":"Descripción","key":"descripcion"},'  
  select @headers+'
  {"label":"Ingresos a Mora (miles S/)","key":"blanco1","type":"custom_r",
	"subs":[{ "label":"'+format(@fecha1,'dd-MMM')+'","key":"col_1","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
			{ "label":"'+format(@fecha2,'dd-MMM')+'","key":"col_2","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
			{ "label":"'+format(@fecha3,'dd-MMM')+'","key":"col_3","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}]},
  {"label":"Salidas a Mora (miles S/)","key":"blanco2",
	"subs":[{ "label":"'+format(@fecha1,'dd-MMM')+'","key":"col_4","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
			{ "label":"'+format(@fecha2,'dd-MMM')+'","key":"col_5","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
			{ "label":"'+format(@fecha3,'dd-MMM')+'","key":"col_6","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}]},
  {"label":"Incremento MR (miles s/)","key":"blanco2",
	"subs":[{ "label":"'+format(@fecha1,'dd-MMM')+'","key":"col_7","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
			{ "label":"'+format(@fecha2,'dd-MMM')+'","key":"col_8","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
			{ "label":"'+format(@fecha3,'dd-MMM')+'","key":"col_9","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}]},
  {"label":"Var. Iintrames (S/ M)","key":"blanco2",
	"subs":[{ "label":"Ingresos","key":"col_10","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
			{ "label":"Salidas","key":"col_11","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},
			{ "label":"IMR","key":"col_12","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}]}]
  '
  --select @headers    
  

 

--#condonados,#reprogramados,#RESUMEN,#SALIDAS,#cd,#bd,#cas,#ven_ant,#ven_cierre

--declare @fec as date = '20250708', @tip_cod as int =7, @cod_rel as varchar(10) = '231',@f_ase as varchar=2


IF OBJECT_ID('tempdb..#Base') IS NOT NULL DROP TABLE #Base
IF OBJECT_ID('tempdb..#wjercor03') IS NOT NULL DROP TABLE #wjercor03

select * into #wjercor03 from storage.ref.WJERCOR03 where RFECPRO in (select f from #fechas) and RINDFEC = 'actual' and  
CASE cast(@tip_cod as varchar (10))
        WHEN 7 THEN cast(RCODFC as varchar (10))
        WHEN 21 THEN cast(RCODGRU as varchar (10))
        WHEN 20 THEN cast(RCODTER as varchar (10))
        WHEN 19 THEN cast(RCODCOR as varchar (10))
	    WHEN 18 THEN cast(RCODUNI as varchar (10))
		WHEN 17 THEN cast(RCODUCO as varchar (10))
    END = cast (@cod_rel as varchar(10))


select  distinct HDESPROD, HFECPRO, DENSE_RANK() OVER (ORDER BY HFECPRO asc) AS ORD  , SUM( case when HTIPO_IS = 'ingreso' then HMONTIPOMN else 0 end) ING
, SUM( case when HTIPO_IS = 'salida' then HMONTIPOMN else 0 end) SAL
, SUM( case when HTIPO_IS = 'ingreso' then HMONTIPOMN else 0 end) - SUM( case when HTIPO_IS = 'salida' then HMONTIPOMN else 0 end) INCRE
into #Base 
from  storage.com_act.WIMR001 A
left join  #wjercor03 B on A.haseoper =b.rcodsec and A.hfecpro = b.rfecpro  
where  hfecpro in (select f from #fechas) AND HFLAG_ASESOR like  (case when @f_ase is null or @f_ase = 0 then '%' else  @f_ase end ) 
group by HDESPROD,hfecpro
order by 2 
  



--select * from storage.ref.WJERCOR03 


 
 ;with cte_a as (select HDESPROD, ORD,ING   from #Base )
 select HDESPROD, [1],[2],[3] into #ING
 from cte_a
pivot(
  sum(ING)
  for ord in([1],[2],[3]  )
)q
 
 ;with cte_a as (select HDESPROD, ORD,SAL    from #Base )
 select HDESPROD, [1],[2],[3] into #SAL
 from cte_a
pivot(
  sum(SAL)
  for ord in([1],[2],[3]  )
)q
 
  ;with cte_a as (select HDESPROD, ORD,INCRE    from #Base )
 select HDESPROD, [1],[2],[3] into #INCRE
 from cte_a
pivot(
  sum(INCRE )
  for ord in([1],[2],[3]  )
)q


;with resultado as (
select '1' style, 'TOTAL IMR' descripcion,
sum(A.[1]) as col_1,  sum(A.[2]) as col_2	, sum(A.[3]) as col_3,
sum(B.[1]) as col_4,  sum(B.[2]) as col_5	, sum(B.[3]) as col_6,
sum(C.[1]) as col_7,  sum(C.[2]) as col_8	, sum(C.[3]) as col_9,
sum(A.[3]-A.[2]) as col_10, sum(B.[3]-B.[2]) as col_11,   sum(C.[3]-C.[2]) as col_12
from #ING A
left join #SAL B on A.HDESPROD = B.HDESPROD
left join #INCRE C on B.HDESPROD = C.HDESPROD
union
select '0', A.HDESPROD descripcion,
isnull(A.[1],0) as col_1,  isnull(A.[2],0) as col_2	, isnull(A.[3],0) as col_3,
isnull(B.[1],0) as col_4,  isnull(B.[2],0) as col_5	, isnull(B.[3],0) as col_6,
isnull(C.[1],0) as col_7,  isnull(C.[2],0) as col_8	, isnull(C.[3],0) as col_9,
isnull(A.[3],0)-isnull(A.[2],0) as col_10, isnull(B.[3],0)-isnull(B.[2],0) as col_11,   isnull(C.[3],0)-isnull(C.[2],0) as col_12
from #ING A
left join #SAL B on A.HDESPROD = B.HDESPROD
left join #INCRE C on B.HDESPROD = C.HDESPROD
)
select * from resultado order by Style desc, descripcion asc

drop table #ING,#SAL,#INCRE,#Base,#fechas
     
 --create table #rev (    
 --COL1   varchar (10),    
 --COL2   varchar (10),    
 --COL3   varchar (10),    
 --COL4   varchar (10),    
 --COL5   varchar (10)    
 --)    
    
 --insert into #rev    
 --select 'A1','B1','C1','D1','E1'      
 --union    
 --select 'AAAA','BBBB','CCCC','DDDD','CCCC'    
    
 --     select * from  #rev    
        
 --drop table  #rev    
end
