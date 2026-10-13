-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-03-29 17:18:28.610000
--exec [com].[RPROSCORR004] 7,'231','20220328'                          
CREATE procedure [com].[RPROSCORR004]                          
@tip_cod int,@cod_rel varchar(20), @fecha date                            
as                          
begin                          
set nocount on;                            
                             
DECLARE @Query nvarchar(max);DECLARE @Query2 nvarchar(max);                        
SET LANGUAGE Spanish                        
----------------                        
declare @TP int      
      
       
       
select  a.HFECPRO,a.HDESAGE,a.HZONA,a.HPROSPEC,a.HINSTALAD,a.HAPERTCTA,a.HMESINST      
into #Result --drop table #Result  select distinct HINSTALAD from storage.[com_act].HCMC002       
from storage.[com_act].HCMC002 a      
      
alter table #Result --DROP TABLE #Result      
add RCODTER int null,RCODCOR int null,RCODMAT int null,RCODAGE INT NULL,      
    RDESTER varchar(250)null,RDESCOR varchar(250)null,RDESMAT Varchar(250)null, RDESAGE VARCHAR(250)NULL      
      
update a      
set a.RCODTER=b.RCODTER,a.RCODCOR=b.RCODCOR,a.RCODMAT=b.RCODMAT,A.RCODAGE=B.RCODAGE,      
   a.RDESTER=b.RDESTER,a.RDESCOR=b.RDESCOR,a.RDESMAT=b.RDESMAT,A.RDESAGE=B.RDESAGE      
from #Result a       
inner join storage.ref.vjercor03 b on   a.HDESAGE=b.rdesage      
        
        
select @TP=count(*)       
 from #Result      
 where      
case when @tip_cod =7 then '1'      
        when @tip_cod =15 then RCODTER      
  when @tip_cod =14 then RCODCOR      
  when @tip_cod =4 then  RCODMAT end = case when @tip_cod =7 then '1' else @cod_rel end       
         
         
;with cte_a  as (      
select  HFECPRO,isnull(HDESAGE,'FC') HDESAGE,HZONA,HPROSPEC,RCODTER,RCODCOR,RCODMAT,RDESTER,RDESCOR,RDESMAT,RCODAGE,RDESAGE,      
COUNT(*) NumProspecto,      
count(case when HZONA='RURAL' then HZONA       
     when HZONA='URBANA' then HZONA      
     when HZONA IS NULL then HDESAGE else null end) NumInstalado       
from  #Result      
group by         
grouping sets((HFECPRO,HDESAGE,HZONA,HPROSPEC,RCODTER,RCODCOR,RCODMAT,RDESTER,RDESCOR,RDESMAT,RCODAGE,RDESAGE),())        
),      
cte_b as (      
select HZONA,       
    cast(sum(NumInstalado) as float) NumInstalado         
from cte_a        
where      
case when @tip_cod =7 then '1'      
        when @tip_cod =15 then RCODTER      
  when @tip_cod =14 then RCODCOR      
  when @tip_cod =4 then  RCODMAT end = case when @tip_cod =7 then '1' else @cod_rel end       
         
GROUP BY  HZONA      
)      
select 1 D,*,NumInstalado/ @TP PP INTO #Res  from cte_b        
where hzona is not null --drop table #Result  drop table #Res      
  
--SELECT D,HZONA,ROUND(PP * 100,2) PP FROM #Res     
        
  DECLARE @json NVARCHAR(MAX)  , @json2 Nvarchar(max)                               
select  @json =                                
(                                                
   select     /*'graphName' = '',                                           
    'graphSubName' = '',                                              
          'categoryIds' = '~[`"meses`"]~',  */                                 
   /* 'data' = (select   */                                                            
         'name' = '''' + CONVERT(varchar(250),A.HZONA) + '''',                        
    'y'= '' + CONVERT(varchar(250),A.PP) + '' -- + CAST(ROUND(PP * 100,2) AS VARCHAR(250)) + ''   
   from #Res A                                                       
        for json path)                    
                 
select replace(replace( replace(replace(replace(replace(replace(replace(replace(@json,'"~',''),'~"',''),'`\',''),'"name":"','"name":'),'","y":"',',"y":'),'"},{"','},{"'),'"}]','}]') ,'"name"','name'),'"y"','y') TCAD                           
select replace(replace( replace(replace(replace(replace(replace(replace(replace(@json,'"~',''),'~"',''),'`\',''),'"name":"','"name":'),'","y":"',',"y":'),'"},{"','},{"'),'"}]','}]') ,'"name"','name'),'"y"','y') TCAD                           
select replace(replace( replace(replace(replace(replace(replace(replace(replace(@json,'"~',''),'~"',''),'`\',''),'"name":"','"name":'),'","y":"',',"y":'),'"},{"','},{"'),'"}]','}]') ,'"name"','name'),'"y"','y') TCAD                           
                  
             
end
