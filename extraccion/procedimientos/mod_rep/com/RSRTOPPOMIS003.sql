-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:31.283000
--EXEC [com].[RSRTOPPOMIS003] 7,'231','20250428','todos'                  
CREATE procedure [com].[RSRTOPPOMIS003]                  
@tip_cod nvarchar(50),@cod_rel varchar(50) ,@fec date ,@prod varchar(250)                                   
as                                  
begin                                  
 SET NOCOUNT ON;     
    
        
declare @headers varchar(max)                  
  select @headers  ='[                   
   { "label":"Descripción","key":"RDESUNI","cellStyle":{"text-align":"left","max-width":"200px","min-width":"200px","width":"200px"}},            
   { "label":"Corredor","key":"RDESCOR","cellStyle":{"text-align":"left","max-width":"200px","min-width":"200px","width":"200px"}},           
   { "label":"Territorio","key":"RDESTER","cellStyle":{"text-align":"left","max-width":"200px","min-width":"200px","width":"200px"}},           
   { "label":"# Clientes","key":"HNUMCLI","cellStyle":{"text-align":"center","min-width":"50px"}},                  
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
select 1,HTIPCOD,HCODREL,sum(isnull(HVALVAR,0)) HVALVAR                 
from storage.[com].[metas_saldos_anual] where hfecpro=DATEFROMPARTS(YEAR(GETDATE()), 12, 31)          
and HTIPCOD=18 and                  
HCODVAR in(10236,10237,10238,10239)        
group by HTIPCOD,HCODREL        
     
;WITH CTE_A AS (    
select HCODSEC,    
count(distinct CASE WHEN HINDVULN  in(1,2,3)  THEN HCODPER ELSE null END) ds_num_vulnerables,    
count(distinct CASE WHEN HINDBANC=1 THEN HCODPER ELSE null END) ds_num_bancarizado,    
count(distinct CASE WHEN HINDGEN=1 THEN HCODPER ELSE null END) ds_num_mujeres,    
count(distinct CASE WHEN  HINDRUR=1 THEN HCODPER ELSE null END) ds_num_rural    
from storage.com_act.WACLI007 where hfecpro=@fec    
GROUP BY HCODSEC    
),    
cte_b as (    
SELECT isnull(cast(b.rcodcor as varchar(250)),9999)rcodcor,isnull(b.RDESCOR,'SIN ASIGNAR') RDESCOR,isnull(b.RDESTER,'SIN ASIGNAR')RDESTER,RDESUNI,B.RCODUNI,    
       sum(ds_num_vulnerables+ds_num_bancarizado+ds_num_mujeres+ds_num_rural) HNUMCLI    
FROM CTE_A a    
left join (  select distinct  RCODSEC,RDESCOR,RDESTER,RCODTER,RCODGRU,RCODCOR,RCODUNI,RCODUCO,RDESUNI                  
    from storage.ref.WJERCOR03                   
    where rfecpro=@fec and RINDFEC='actual'                  
    AND case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                                         
    when @tip_cod=20 then cast(RCODTER as nvarchar(10))                                      
    when @tip_cod=19 then cast(RCODCOR as varchar(250))                                           
    when @tip_cod=18 then cast(RCODUNI as varchar(250))                  
    when @tip_cod=17 then cast(RCODUCO as varchar(250))else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                  
                      
    )b                  
on a.HCODSEC=b.RCODSEC         
where case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                                         
    when @tip_cod=20 then cast(RCODTER as nvarchar(10))                              
    when @tip_cod=19 then cast(RCODCOR as varchar(250))                                           
    when @tip_cod=18 then cast(RCODUNI as varchar(250))                  
    when @tip_cod=17 then cast(RCODUCO as varchar(250))else '1' end=IIF(@tip_cod=7,'1',@cod_rel)      
group by isnull(cast(b.rcodcor as varchar(250)),9999),isnull(b.RDESCOR,'SIN ASIGNAR'),isnull(b.RDESTER,'SIN ASIGNAR'),RDESUNI,B.RCODUNI    
),    
cte_c as (    
select distinct a.*,b.HVALVAR    from cte_b a    
left join #Metas b                
on a.RCODUNI=b.HCODREL     
),    
cte_d as (    
select HNUMCLI,hvalvar meta,HNUMCLI-hvalvar distancia_meta ,CASE WHEN hvalvar=0 THEN '0' ELSE FORMAT(cast(HNUMCLI as float) / hvalvar ,'P') END percent_  ,              
rdescor RDESCOR,RDESTER , RDESUNI             
from cte_c    
)    
select  *  -- ,0 valor             
from cte_d               
order by HNUMCLI desc      
    
end    
if @prod<>'TODOS'    
begin    
    
insert into #Metas  --select * from #Metas                
select HCODVAR,HTIPCOD,HCODREL,sum(HVALVAR)                  
from storage.[com].[metas_saldos_anual] where hfecpro=DATEFROMPARTS(YEAR(GETDATE()), 12, 31)                        
and HTIPCOD=18 and                  
HCODVAR = case when @prod='Mujer' then 10236                
         when @prod='Rural'  then 10237                
      when @prod='Bancarizado'  then 10238        
    when  @prod='Vulnerable' then 10239 end           
group by HCODVAR,HTIPCOD,HCODREL       
    
;WITH CTE_A AS (    
select HCODSEC,    
case when @prod='Mujer' then count(distinct CASE WHEN HINDGEN=1 THEN HCODPER ELSE null END)    
     when @prod='Rural' then count(distinct CASE WHEN  HINDRUR=1 THEN HCODPER ELSE null END)    
  when @prod='Bancarizado' then count(distinct CASE WHEN HINDBANC=1 THEN HCODPER ELSE null END)     
  when @prod='Vulnerable' then count(distinct CASE WHEN HINDVULN  in(1,2,3)  THEN HCODPER ELSE null END)    
end CLI     
from storage.com_act.WACLI007 where hfecpro=@fec    
GROUP BY HCODSEC    
),    
cte_b as (    
SELECT isnull(cast(b.rcodcor as varchar(250)),9999)rcodcor,isnull(b.RDESCOR,'SIN ASIGNAR') RDESCOR,isnull(b.RDESTER,'SIN ASIGNAR')RDESTER,RDESUNI,B.RCODUNI,    
       sum(CLI) HNUMCLI    
FROM CTE_A a    
left join (  select distinct  RCODSEC,RDESCOR,RDESTER,RCODTER,RCODGRU,RCODCOR,RCODUNI,RCODUCO  ,RDESUNI                 
    from storage.ref.WJERCOR03                   
    where rfecpro=@fec and RINDFEC='actual'                  
    AND case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                                         
    when @tip_cod=20 then cast(RCODTER as nvarchar(10))                                      
    when @tip_cod=19 then cast(RCODCOR as varchar(250))                                           
    when @tip_cod=18 then cast(RCODUNI as varchar(250))                  
    when @tip_cod=17 then cast(RCODUCO as varchar(250))else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                  
                      
    )b                  
on a.HCODSEC=b.RCODSEC         
where case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                                         
    when @tip_cod=20 then cast(RCODTER as nvarchar(10))                              
    when @tip_cod=19 then cast(RCODCOR as varchar(250))                                           
    when @tip_cod=18 then cast(RCODUNI as varchar(250))                  
    when @tip_cod=17 then cast(RCODUCO as varchar(250))else '1' end=IIF(@tip_cod=7,'1',@cod_rel)      
group by isnull(cast(b.rcodcor as varchar(250)),9999),isnull(b.RDESCOR,'SIN ASIGNAR'),isnull(b.RDESTER,'SIN ASIGNAR'),B.RDESUNI,B.RCODUNI    
),    
cte_c as (    
select distinct a.*,b.HVALVAR    from cte_b a    
left join #Metas b                
on a.RCODUNI=b.HCODREL     
),    
cte_d as (    
select HNUMCLI,hvalvar meta,HNUMCLI-hvalvar distancia_meta ,CASE WHEN hvalvar=0 THEN '0' ELSE FORMAT(cast(HNUMCLI as float) / hvalvar ,'P') END  percent_  ,              
RDESTER ,rdescor RDESCOR   ,RDESUNI          
from cte_c    
)    
select  *  -- ,0 valor             
from cte_d               
order by HNUMCLI desc      
end    
end
