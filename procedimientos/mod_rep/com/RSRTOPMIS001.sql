-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-10-10 18:23:23.127000
--EXEC [com].[RSRTOPMIS003] 7,'231','20240910','Crédito Educativo'    
CREATE procedure [com].[RSRTOPMIS001]    
@tip_cod nvarchar(50),@cod_rel varchar(50) ,@fec date ,@prod varchar(250)                     
as                    
begin                    
 SET NOCOUNT ON;        
--declare @tip_cod int=7 ,@cod_rel varchar(50)='231' ,@fec date='20240910',@prod varchar(250)='Agua y Saneamiento'          
    
declare @headers varchar(max)        
  select @headers  ='[         
   { "label":"Descripción","key":"RDESCOR","cellStyle":{"text-align":"left","max-width":"200px","min-width":"200px","width":"200px"}},   
   { "label":"Territorio","key":"RDESTER","cellStyle":{"text-align":"left","max-width":"200px","min-width":"200px","width":"200px"}}, 
   { "label":"# Operaciones","key":"SNUMOPE","cellStyle":{"text-align":"center","min-width":"50px"}},        
   { "label":"Meta","key":"meta","cellStyle":{"text-align":"center","min-width":"50px"}},        
   { "label":"Distancia Meta","key":"distancia_meta","cellStyle":{"text-align":"center","min-width":"70px"}},        
   { "label":"%","key":"percent_","cellStyle":{"text-align":"center","min-width":"80px"}} ] '         
   
  
select @headers      
  
  
create table #Metas  
(HCODVAR int null,  
HTIPCOD int null,  
HCODREL varchar(250)null,  
HVALVAR float null)  
  
if @prod='TODOS'  
begin  
insert into #Metas  
select 1,HTIPCOD,HCODREL,sum(HVALVAR ) HVALVAR   
from [storage].[com].[VDMCOM01] where hfecpro=eomonth(@fec)  
and HTIPCOD=19 and    
HCODVAR in(10035,10036,10037)  
group by HTIPCOD,HCODREL  
end  
else   
begin  
insert into #Metas  --select * from #Metas  
select HCODVAR,HTIPCOD,HCODREL,sum(HVALVAR)    
from [storage].[com].[VDMCOM01] where hfecpro=eomonth(@fec)  
and HTIPCOD=19 and    
HCODVAR = case when @prod='Agua y Saneamiento' then 10036  
         when @prod='Crédito Educativo'  then 10035  
      when @prod='Emprendimiento Mujer'  then 10037 end  
group by HCODVAR,HTIPCOD,HCODREL  
  
end     
  

;with cte_a as (    
select *     
from storage.[com_act].[SDAF002]     
where sfecpro=@fec and scodagr=6    
),    
cte_b as (    
select a.SFECPRO,a.SCODSEC,a.SMONDESMN,a.SNUMCLI,a.SOPENUE,a.SNUMOPE,b.RDESSUBP   
from cte_a a     
inner join storage.com_act.RETP006  b    
on a.SCODMOD=b.RCODMOD and a.STIPOPE=b.RTIPOPE and a.SSUBTIP=b.RSUBTIP    
),    
cte_bb as (    
select *   
from cte_b   
where case when @prod='TODOS' then '1' else RDESSUBP end=case when @prod='TODOS' then '1' else @prod end    
),    
cte_c as (    
select a.SFECPRO,isnull(b.rcodcor,9999)rcodcor,isnull(b.RDESCOR,'SIN ASIGNAR') RDESCOR,isnull(b.RDESTER,'SIN ASIGNAR')RDESTER,sum(a.SNUMOPE) SNUMOPE     
from cte_bb a    
left join (  select distinct  RCODSEC,RDESCOR,RDESTER,RCODTER,RCODGRU,RCODCOR,RCODUNI,RCODUCO     
    from storage.ref.WJERCOR03     
    where rfecpro=@fec and RINDFEC='actual'    
    AND case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                           
    when @tip_cod=20 then cast(RCODTER as nvarchar(10))                        
    when @tip_cod=19 then cast(RCODCOR as varchar(250))                             
    when @tip_cod=18 then cast(RCODUNI as varchar(250))    
    when @tip_cod=17 then cast(RCODUCO as varchar(250))else '1' end=IIF(@tip_cod=7,'1',@cod_rel)           
        
    )b    
on a.SCODSEC=b.RCODSEC    
where case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                           
    when @tip_cod=20 then cast(RCODTER as nvarchar(10))                        
    when @tip_cod=19 then cast(RCODCOR as varchar(250))                             
    when @tip_cod=18 then cast(RCODUNI as varchar(250))    
    when @tip_cod=17 then cast(RCODUCO as varchar(250))else '1' end=IIF(@tip_cod=7,'1',@cod_rel)    
group by  a.SFECPRO,b.rcodcor,b.RDESCOR ,b.RDESTER  
)
,  
cte_cc as (  
select distinct a.*,b.HVALVAR   
from cte_c a   
left join #Metas b  
on a.rcodcor=b.HCODREL  
),  
cte_d as (  
select sfecpro,rdescor RDESCOR,SNUMOPE,hvalvar meta,SNUMOPE-hvalvar distancia_meta ,FORMAT(cast(SNUMOPE as float) / hvalvar ,'P')  percent_  ,
RDESTER
from cte_cc  
)  
select top 20 *    
from cte_d   
select '' sfecpro,'' RDESCOR,''SNUMOPE,'' meta,'' distancia_meta ,'' percent_  ,''RDESTER 
order by SNUMOPE desc     
end
