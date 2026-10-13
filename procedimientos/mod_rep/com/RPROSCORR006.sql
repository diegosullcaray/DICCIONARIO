-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-03-29 17:18:21.217000
--EXEC [com].[RPROSCORR006]  7,'231','20220328'    
CREATE PROCEDURE [com].[RPROSCORR006]       
@tip_cod int,@cod_rel varchar(20), @fecha date                  
AS               
begin              
 set nocount on;          
        
 declare @TP int        
        
         
         
select  a.HFECPRO,a.HDESAGE,a.HZONA,a.HPROSPEC,a.HINSTALAD,a.HAPERTCTA,a.HMESINST    
into #Result --drop table #Result    
from storage.[com_act].HCMC002 a    
    
alter table #Result --DROP TABLE #Result    
add RCODTER int null,RCODCOR int null,RCODMAT int null,RCODAGE INT NULL,    
    RDESTER varchar(250)null,RDESCOR varchar(250)null,RDESMAT Varchar(250)null, RDESAGE VARCHAR(250)NULL    
    
update a    
set a.RCODTER=b.RCODTER,a.RCODCOR=b.RCODCOR,a.RCODMAT=b.RCODMAT,A.RCODAGE=B.RCODAGE,    
   a.RDESTER=b.RDESTER,a.RDESCOR=b.RDESCOR,a.RDESMAT=b.RDESMAT,A.RDESAGE=B.RDESAGE    
from #Result a     
inner join storage.ref.vjercor03 b on   a.HDESAGE=b.rdesage    
      
    
;with cte_a  as (    
select  HFECPRO,isnull(HDESAGE,'FC') HDESAGE,HZONA,HPROSPEC,HINSTALAD,HAPERTCTA,HMESINST,RCODTER,RCODCOR,RCODMAT,RDESTER,RDESCOR,RDESMAT,RCODAGE,RDESAGE,    
COUNT(*) NumProspecto,    
count(case when HPROSPEC='NO APLICA' then HDESAGE else null end) NumNOCalifica,    
count(case when HPROSPEC='APLICA' and HINSTALAD='NO' AND HAPERTCTA='NO' then HDESAGE else null end) NumEva,    
count(case when HINSTALAD='NO' AND HAPERTCTA='SI' then HDESAGE else null end) NumProceso,    
count(case when HINSTALAD='SI' then HDESAGE else null end) NumInstalado,    
 cast(count(case when HINSTALAD='SI' then HDESAGE else null end) as float) / COUNT(*) PercentInsta     
from  #Result    
group by       
grouping sets((HFECPRO,HDESAGE,HZONA,HPROSPEC,HINSTALAD,HAPERTCTA,HMESINST,RCODTER,RCODCOR,RCODMAT,RDESTER,RDESCOR,RDESMAT,RCODAGE,RDESAGE),())      
),    
cte_b as (    
select distinct case when @tip_cod=7 then  RDESTER     
            when @tip_cod=15 then  RDESCOR     
   when @tip_cod=14 then  RDESMAT     
   when @tip_cod=4 then  RDESAGE end descripcion,    
   case when @tip_cod=7 then  RCODTER     
            when @tip_cod=15 then  RCODCOR     
   when @tip_cod=14 then  RCODMAT     
   when @tip_cod=4 then  RCODAGE end Coddesc    
   ,HZONA,sum(NumProspecto)NumProspecto ,sum(NumNOCalifica)NumNOCalifica,sum(NumEva)NumEva,sum(NumProceso)NumProceso,    
   cast(sum(NumInstalado) as float) NumInstalado,cast(sum(NumInstalado) as float) /  sum(NumProspecto) PercentInsta    
         
from cte_a      
where    
case when @tip_cod =7 then '1'    
        when @tip_cod =15 then RCODTER    
  when @tip_cod =14 then RCODCOR    
  when @tip_cod =4 then  RCODMAT end = case when @tip_cod =7 then '1' else @cod_rel end      
       
GROUP BY     
case when @tip_cod=7 then  RDESTER     
            when @tip_cod=15 then  RDESCOR     
   when @tip_cod=14 then  RDESMAT     
   when @tip_cod=4 then  RDESAGE end,    
case when @tip_cod=7 then  RCODTER     
            when @tip_cod=15 then  RCODCOR     
   when @tip_cod=14 then  RCODMAT     
   when @tip_cod=4 then  RCODAGE end ,HZONA   
)    
select * into #Total from cte_b where descripcion is not null --drop table #Result  drop table #Res   DROP TABLE #Total  
  
set @TP=(select sum(NumProceso)+ sum(NumInstalado)  from #Total)       
  
SELECT HZONA,SUM(NumProceso) + SUM(NumInstalado) dat INTO #Res2 FROM #Total   
WHERE HZONA IS NOT NULL  
GROUP BY HZONA  
  
set @TP=(select sum(NumProceso)+ sum(NumInstalado)  from #Total)  
  
select 1 D,HZONA,dat/@TP PP INTO #Res from #Res2  
         
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
                    
          
END
