-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-08-11 11:25:46.313000
--exec [com].[RCORRES05] 7,'231','20210921'                      
CREATE procedure [com].[RCORRES05]                      
@tip_cod int,@cod_rel varchar(20), @fecha date                        
as                      
begin                      
set nocount on;                        
                         
DECLARE @Query nvarchar(max);DECLARE @Query2 nvarchar(max);                    
SET LANGUAGE Spanish                    
----------------                    
create table #Geo          
(          
ID int identity(1,1)not null,          
Departamento varchar(250)null,          
CodDep varchar(50)null          
)          
insert into #Geo values('Ica','pe-ic')          
insert into #Geo values('Cusco','pe-cs')          
insert into #Geo values('Ucayali','pe-uc')          
insert into #Geo values('Madre de dios','pe-md')          
insert into #Geo values('San Martín','pe-sm')          
insert into #Geo values('Amazonas','pe-am')          
insert into #Geo values('Loreto','pe-lo')          
insert into #Geo values('Ayacucho','pe-ay')          
insert into #Geo values('Lima Provincia','pe-145')          
insert into #Geo values('Huancavelica','pe-hv')          
insert into #Geo values('Junín','pe-ju')          
insert into #Geo values('Lima','pe-lr')          
insert into #Geo values('Lambayeque','pe-lb')          
insert into #Geo values('Tumbes','pe-tu')          
insert into #Geo values('Apurímac','pe-ap')          
insert into #Geo values('Arequipa','pe-ar')          
insert into #Geo values('Callao','pe-cl')          
insert into #Geo values('Moquegua','pe-mq')          
insert into #Geo values('Tacna','pe-ta')          
insert into #Geo values('Ancash','pe-an')          
insert into #Geo values('Cajamarca','pe-cj')          
insert into #Geo values('Huánuco','pe-hc')          
insert into #Geo values('Callao Provincia','pe-3341')          
insert into #Geo values('La libertad','pe-ll')          
insert into #Geo values('Pasco','pe-pa')          
insert into #Geo values('Piura','pe-pi')      
    
    
select distinct a.SCORRES,b.HMUNICB into #cte_corres --drop table #cte_corres    
from storage.[com_act].[SDAS021] a    
inner join storage.com_act.HCMC001 b on a.SCORRES=b.HNOMBREPTO  --select top 5 * from storage.com_act.HCMC001    
    
;with CTE_A AS (    
 select  HFECPRO,HNOMCOR,b.HMUNICB as HDEPAR,    
  HCOORDE,HTERRIT,HCORRED,HAGENCI,    
    REPLACE(HCOORDE, SUBSTRING(HCOORDE, CHARINDEX(',', HCOORDE), LEN(HCOORDE)), '') 'Latitud'    
    ,SUBSTRING(    
        HCOORDE,    
        CHARINDEX(',', HCOORDE)+1,    
        LEN(HCOORDE)-CHARINDEX('@', HCOORDE)    
    ) 'Longitud'    
from STORAGE.com_act.HCGEO002  a   --select  * from STORAGE.com_act.HCGEO002 where hnomcor like '%LIBRERIA BAZAR EVANS%' and HCORRED='UCAYALI - LORETO'  
inner join #cte_corres b on a.HNOMCOR=b.SCORRES    -- update STORAGE.com_act.HCGEO002 set HCOORDE='-11.33757968,-75.20593268'  where hnomcor like '%LIBRERIA BAZAR EVANS%'  and HCORRED='UCAYALI - LORETO'  
),    
a as (      --select top 5 * from storage.com_act.HCGEO001    
 SELECT HTERRIT,HCORRED,HAGENCI,Latitud,Longitud,HNOMCOR,a.HDEPAR               
  FROM CTE_A  a           
  inner join (select distinct case when @tip_cod=7 then '1'                    
            when @tip_cod=15 then RDESTER                    
         when @tip_cod=14 then RDESCOR                    
         when @tip_cod=4 then RDESMAT                     
       end RDESJER                      
       from storage.ref.vjercor03                     
       where case when @tip_cod=7 then 1                    
                     when @tip_cod=15 then RCODTER                    
                     when @tip_cod=14 then RCODCOR                    
                     when @tip_cod=4 then RCODMAT                    
                 end =case when @tip_cod=7 then 1 else @cod_rel end) B                    
  ON CASE WHEN @TIP_COD=7 THEN '1'                    
    WHEN @tip_cod=15 then HTERRIT                    
    when @tip_cod=14 then HCORRED                    
    when @tip_cod=4 then HAGENCI end = B.RDESJER               
)      
select * into #a from a      
--SELECT * FROM #a      
         
  select a.CodDep,count(b.HNOMCOR)  as CountCorresponsales           
  into #CorresponsaleGeoCount --select*from #CorresponsaleGeoCount          
  from #Geo a  --select*from #Geo          
  left join (select  * from #a )   b          
  on a.Departamento=b.HDEPAR          
  group by a.CodDep       
    
  DECLARE @json NVARCHAR(MAX)  , @json2 Nvarchar(max)                           
select  @json =                            
(                                            
   select  TOP 100  /*'graphName' = '',                                       
    'graphSubName' = '',                                          
          'categoryIds' = '~[`"meses`"]~',  */                             
   /* 'data' = (select   */                                                        
         'label' = '' + CONVERT(varchar(250),A.HNOMCOR) + '',                    
    'lat'= '' + CONVERT(varchar(250),A.Latitud) + '',                    
  'lng'= '' + CONVERT(varchar(250),A.Longitud) + ''  --,  
 --  'draggable'= 'true'''                
              
   from #a A                                                   
        for json path)                
            
select  @json2 =                            
(                                            
   select   /*'graphName' = '',                                       
    'graphSubName' = '',                                          
          'categoryIds' = '~[`"meses`"]~',  */                             
   /* 'data' = (select   */                                                        
         CodDep = ''+ CodDep + '",' + CONVERT(varchar(250),CountCorresponsales)           
   from #CorresponsaleGeoCount A       --select*from #CorresponsaleGeoCount                                            
        for json path)                          
                                               
 --  for json PATH                          
                          
 --)                            
                
          
select replace(replace(replace(replace(replace(replace(replace(@json,'"~',''),'~"',''),'`\',''),'"lat":"','"lat":'),'","lng":"',',"lng":'),'"},{"','},{"'),'"}]','}]') TCAD                       
          
          
select replace(replace(replace(replace(replace(replace(replace(@json,'"~',''),'~"',''),'`\',''),'"lat":"','"lat":'),'","lng":"',',"lng":'),'"},{"','},{"'),'"}]','}]') TCAD                       
          
          
 select    replace(replace(replace(@json2,'"}',']'),'{"CodDep":','['),'\','') TCAD         
         
end
