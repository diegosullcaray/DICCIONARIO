-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:06.190000
--exec com.RREPGESTCOM03 7,'231','20260429'    
--exec mod_rep.com.RREPGESTCOM03 7,'231','20260429'   
CREATE procedure [com].[RREPGESTCOM03]    
@tip_cod varchar(5),@cod_rel varchar(25),@fecha DATE      
as    
begin    
SET NOCOUNT ON;   
--declare @tip_cod varchar(5)=7,@cod_rel varchar(25)='231',@fecha DATE ='20260429'  
  
  
set @tip_cod= case when @tip_cod='7' then '21' else @tip_cod end    
set @cod_rel= case when @cod_rel='231' then '1' else @cod_rel end    
  
;with cte_a as (  
select max(rfec)rfec  from storage.ref.rcalen001 where rfec<=@fecha and RDIAFER=0  
union all  
select top 11 rfec from storage.ref.rcalen001 where rfec<@fecha and RCIEBT=1 order by 1 desc  
)  
select RFEC,ROW_NUMBER() over(order by RFEC asc) ord       
into #Fechas   --drop table #Fechas  select * from #Fechas    
from cte_a     
  
declare @fec1 varchar(10),@fec2 varchar(10),@fec3 varchar(10),@fec4 varchar(10),@fec5 varchar(10),@fec6 varchar(10),  
  @fec7 varchar(10),@fec8 varchar(10),@fec9 varchar(10),@fec10 varchar(10),@fec11 varchar(10),@fec12 varchar(10)   
  
set @fec1 =(select rfec from #Fechas where ord= 1  )  
set @fec2 =(select rfec from #Fechas where ord= 2 )  
set @fec3 =(select rfec from #Fechas where ord= 3 )  
set @fec4 =(select rfec from #Fechas where ord= 4 )  
set @fec5 =(select rfec from #Fechas where ord= 5 )  
set @fec6 =(select rfec from #Fechas where ord= 6 )  
set @fec7 =(select rfec from #Fechas where ord= 7 )  
set @fec8 =(select rfec from #Fechas where ord= 8 )  
set @fec9 =(select rfec from #Fechas where ord= 9 )  
set @fec10 =(select rfec from #Fechas where ord=10 )  
set @fec11 =(select rfec from #Fechas where ord=11 )  
set @fec12 =(select rfec from #Fechas where ord=12 )  
  
declare @headers varchar(max)    
select @headers  ='[   
 { "label":"Descripción","key":"descr","sticky": "true","cellStyle":{"text-align":"left","max-width":"50px","min-width":"50px","width":"50px"}},      
 { "label":"'+@fec2+'","key":"1","cellStyle":{"text-align":"right","max-width":"20px","min-width":"50px","width":"50px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec3+'","key":"2","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec4+'","key":"3","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec5+'","key":"4","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec6+'","key":"5","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec7+'","key":"6","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec8+'","key":"7","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec9+'","key":"8","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec10+'","key":"9","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec11+'","key":"10","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}},                      
 { "label":"'+@fec12+'","key":"11","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"format":{"type":"decimal"}}                       
  
]'  
  
select @headers  
  
declare @fec_ date    
set @fec_= (select max(RFEC) from #Fechas)   
  
select distinct @tip_cod HTIPCOD,case when @tip_cod=7 then CAST(RCODFC AS varchar(250))                  
            when @tip_cod=21 then CAST(RCODGRU AS varchar(250))                  
   when @tip_cod=20 then CAST(RCODTER AS varchar(250))                  
   when @tip_cod=19 then CAST(RCODCOR AS varchar(250))                  
   when @tip_cod=18 then CAST(RCODUNI AS varchar(250))                  
   when @tip_cod=17 then CAST(RCODUCO AS varchar(250))                  
  END HCODREL,                  
    case when @tip_cod=7 then RDESFC                  
            when @tip_cod=21 then RDESGRU                  
   when @tip_cod=20 then RDESTER                  
   when @tip_cod=19 then RDESCOR                  
   when @tip_cod=18 then RDESUNI                  
   when @tip_cod=17 then RDESUCO                  
  END htipdes,'1' nivel                  
into #Jerar                  
from storage.ref.WJERCOR03                   
where rfecpro=@fec_ and rindfec='actual'         and    
case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                         
     when @tip_cod=20 then cast(RCODTER as nvarchar(10))                      
     when @tip_cod=19 then CAST(RCODCOR  as nvarchar(10))                            
      when @tip_cod=18 then CAST(RCODUNI as nvarchar(10))     
     when @tip_cod=17 then CAST(RCODUCO  AS VARCHAR(10))    
   else '1' end=IIF(@tip_cod=7,'1',@cod_rel)              
union all    
  
select  distinct CASE WHEN @tip_cod=7 THEN 21                     
     WHEN @tip_cod=21 THEN 20                    
     WHEN @tip_cod=20 THEN 19                    
     WHEN @tip_cod=19 THEN 18                    
     WHEN @tip_cod=18 THEN 17                    
     WHEN @tip_cod=17 THEN 2                    
   END HTIPCOD,                    
                    
   case when @tip_cod=7 then CAST(RCODGRU AS varchar(250))                    
            when @tip_cod=21 then CAST(RCODTER  AS varchar(250))                    
   when @tip_cod=20 then CAST(RCODCOR  AS varchar(250))                    
   when @tip_cod=19 then CAST(RCODUNI  AS varchar(250))                    
   when @tip_cod=18 then CAST(RCODUCO  AS varchar(250))                    
   when @tip_cod=17 then CAST(RCODSEC  AS varchar(250))                    
  END hcodrel,                    
    case when @tip_cod=7 then  RDESGRU                    
            when @tip_cod=21 then RDESTER                    
   when @tip_cod=20 then RDESCOR                    
   when @tip_cod=19 then RDESUNI                    
   when @tip_cod=18 then RDESUCO                  
   when @tip_cod=17 then RDESSEC                    
  END HTIPDES,'2' nivel                    
--into #jerar                  
from storage.ref.WJERCOR03                     
where rfecpro=@fec_ and rindfec='actual'    and    
case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                         
     when @tip_cod=20 then cast(RCODTER as nvarchar(10))                      
     when @tip_cod=19 then CAST(RCODCOR  as nvarchar(10))                            
      when @tip_cod=18 then CAST(RCODUNI as nvarchar(10))     
     when @tip_cod=17 then CAST(RCODUCO  AS VARCHAR(10))    
   else '1' end=IIF(@tip_cod=7,'1',@cod_rel)      


select  a.rfec hfecpro,b.nivel ,a.ord, b.htipcod,b.hcodrel,b.hnumcli      
into #wjas001   --select distinct hfecpro,ord,ord2 from #wjas001     order by 1 asc  drop table #wjas001
from #Fechas a  ---select * from #Fechas    
inner join (select a.hfecpro,b.nivel,CASE WHEN a.htipcod=1 THEN 2 ELSE a.htipcod END htipcod,a.hcodrel,hnumcli     
   from storage.com_act.WJAS001 a    
   inner join #jerar b   --select * from #jerar    
   on CASE WHEN a.htipcod=1 THEN 2 ELSE a.htipcod END=b.htipcod and a.hcodrel=b.hcodrel    
   ) b      
on a.rfec=b.hfecpro    --exec storage.com_act.cwWJAS001 '20250531'


alter table #wjas001 add ord2 int null   --select * from #wjas001
update #wjas001 set ord2=ord-1   

select b.hfecpro,b.nivel,a.htipcod,a.ord,a.hcodrel,b.hnumcli - a.hnumcli TmmHnumcli , b.hnumcli cliStock  
into #Variacion   --drop table #Variacion  
from  #wjas001 a  
inner join #wjas001 b  
on a.ord=b.ord2  and a.htipcod=b.htipcod and a.hcodrel=b.hcodrel
  
alter table #Variacion    
add descr nvarchar(max)   


update a    
set a.descr=b.HTIPDES    
from #Variacion a     
inner join #jerar b    
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel    
 

SELECT  nivel,  
    descr,   
    [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12]  
into #T  --drop table #T
FROM   
    (  
        -- 1. Seleccionamos solo las columnas necesarias para el PIVOT  
        SELECT   
  nivel  ,  
            descr,   
            ord,   
            TmmHnumcli  
        FROM   
            #Variacion  
    ) AS TablaOrigen  
PIVOT   
    (  
        -- 2. Aplicamos la función de agregación (SUM) sobre el valor que queremos mostrar  
        SUM(TmmHnumcli)  
          
        -- 3. Definimos qué valores de la columna 'ord' se convertirán en nuestras nuevas columnas  
        FOR ord IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])  
    ) AS TablaPivot;  


select   
nivel style,descr,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]   
from #T order by nivel asc  
   
end
--select * from storage.com_act.WJAS001 where hfecpro='20260429' and htipcod=7
