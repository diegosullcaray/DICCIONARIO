-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:08.427000
--EXEC mod_rep.[com].RSCAPCOME01 '17','20260708',7                              
                           
CREATE PROCEDURE [com].[RSCAPCOME01](@codrel varchar(25), @Fecha date, @tipcod varchar(5))                             
AS                              
BEGIN                              
 SET NOCOUNT ON;                                
                 
--DECLARE @tipcod INT=17,@codrel VARCHAR(250)='1303',@Fecha DATE='20260707'      
----------------------------------------------------------------      
      
declare               
@fec1 varchar(20),@fec2 varchar(20),@fec3 varchar(20),@fec4 varchar(20),@fec5 varchar(20),                    
@fec6 varchar(20)                     
                              
select *                              
into #FECS                              
from storage.util.FVECFEC01(@Fecha,'cmg_1,cmg_2,cmg_3,cmg_4,cmg_5,cmg_6')                         
                    
select @fec1=rfec from #FECS where rord=1                    
select @fec2=rfec from #FECS where rord=2                    
select @fec3=rfec from #FECS where rord=3                    
select @fec4=rfec from #FECS where rord=4                    
select @fec5=rfec from #FECS where rord=5                    
select @fec6=rfec from #FECS where rord=6                    
              
           
declare @headers varchar(max)                          
select @headers  ='[                           
   { "label":"Descripción","key":"descripcion","cellStyle":{"text-align":"left","max-width":"180px","min-width":"180px","width":"180px"}},                          
   { "label":"Ahorros","subs":[ {"label": "'+format(CAST(@fec5 AS DATE),'dd-MMM')+'","key":"5-ahorros","cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"format":{"type":"integer"}} ,                     
   {"label": "'+format(CAST(@fec6 AS DATE),'dd-MMM')+'","key":"6-ahorros","cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"format":{"type":"integer"}},{"label": "Var mes","key":"var-ahorros","cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"format":{"type":"integer"}    
   }]},                    
   { "label":"PLAZO FIJO","subs":[ {"label": "'+format(CAST(@fec5 AS DATE),'dd-MMM')+'","key":"5-DPF","cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"format":{"type":"integer"} },                    
   {"label": "'+format(CAST(@fec6 AS DATE),'dd-MMM')+'","key":"6-DPF","cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"format":{"type":"integer"} },{"label": "Var mes","key":"var-DPF","cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"format":{"type":"integer"}    
   }]},       
   { "label":"CTS","subs":[ {"label": "'+format(CAST(@fec5 AS DATE),'dd-MMM')+'","key":"5-CTS","cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"format":{"type":"integer"}} ,                     
   {"label": "'+format(CAST(@fec6 AS DATE),'dd-MMM')+'","key":"6-CTS","cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"format":{"type":"integer"}},{"label": "Var mes","key":"var-CTS","cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"format":{"type":"integer"}    
   }]}     
   ] '                              
                     
                    
select @headers              
      
create table #Fec (RORD int, RFEC DATE)      
declare @fecs varchar(max)       
declare @dayAnt date=(select DATEADD(day, -1, @Fecha))       
;with cte_a as (      
SELECT case when rord=3 then 4 else rord end rord, rfec FROM storage.util.FVECFEC01(@Fecha,'cmg_3,cmg_5,cmg_6')        
union all      
SELECT 3,rfec FROM storage.util.FVECFEC01(@dayAnt,'cmg_6')        
)      
insert into #Fec  --select *f      
select * from cte_a order by 1 asc       
      
declare @feccons date      
set @feccons =(select rfec from #Fec where rord=4)      
      
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')        
from #Fec        
      
             
select distinct @tipcod HTIPCOD,case when @tipcod=7 then CAST(RCODFC AS varchar(250))                      
            when @tipcod=21 then CAST(RCODGRU AS varchar(250))                      
   when @tipcod=20 then CAST(RCODTER AS varchar(250))                      
   when @tipcod=19 then CAST(RCODCOR AS varchar(250))                      
   when @tipcod=18 then CAST(RCODUNI AS varchar(250))                      
   when @tipcod=17 then CAST(RCODUCO AS varchar(250))                      
  END HCODREL,                      
    case when @tipcod=7 then RDESFC                      
            when @tipcod=21 then RDESGRU                      
   when @tipcod=20 then RDESTER              
   when @tipcod=19 then RDESCOR                      
   when @tipcod=18 then RDESUNI                      
   when @tipcod=17 then RDESUCO                      
  END HCODRELDES,'1' nivel                      
into #Jerar                      
from storage.ref.WJERCOR03                       
where rfecpro=@feccons and rindfec='actual'                      
union all                      
                      
select  distinct CASE WHEN @tipcod=7 THEN 21                       
     WHEN @tipcod=21 THEN 20                      
     WHEN @tipcod=20 THEN 19                      
     WHEN @tipcod=19 THEN 18                      
     WHEN @tipcod=18 THEN 17                      
     WHEN @tipcod=17 THEN 2                      
   END HTIPCOD,                      
                      
   case when @tipcod=7 then CAST(RCODGRU AS varchar(250))                      
            when @tipcod=21 then CAST(RCODTER  AS varchar(250))                      
   when @tipcod=20 then CAST(RCODCOR  AS varchar(250))                      
   when @tipcod=19 then CAST(RCODUNI  AS varchar(250))                      
   when @tipcod=18 then CAST(RCODUCO  AS varchar(250))                      
   when @tipcod=17 then CAST(RCODSEC  AS varchar(250))                      
  END HTIPCOD,                      
    case when @tipcod=7 then  RDESGRU                      
            when @tipcod=21 then RDESTER                      
   when @tipcod=20 then RDESCOR                      
   when @tipcod=19 then RDESUNI                      
   when @tipcod=18 then RDESUCO                    
   when @tipcod=17 then RDESSEC                      
  END HTIPCOD,'2' nivel                      
                      
from storage.ref.WJERCOR03                       
where rfecpro=@feccons and rindfec='actual'             
      
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)        
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL        
        
insert into @tvars        
values ('sal_cap', null, 'CAP', null, null, null)       
        
insert into @tfil values ('todos', 'fec', @fecs)        
insert into @tconf values ('level_alias', 'style'),  ('fec_corr','true') ,('insert_to', '#ProdT')        
        
insert into @tfil        
exec [piv].[GPIVLEV01] @tipcod,@codrel,@jerar output        
        
  create table #ProdT    --select * from #ProdTip1                      
(                        
    fila int,                        
    cod_fc varchar(250)null,                        
 cod_ugru varchar(250)null,    
  cod_usec varchar(250)null,
    cod_ucoor  varchar(250)null,
    style int null,                        
    descripcion varchar(250)null,        
 CAP_1 float null       
 )      
        
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1            
        
      
       
select cod_fc,case when @tipcod=17 then isnull(cod_usec,@tipcod) else cod_ugru end cod_ugru,style,descripcion,CAP_1 ,   
   cast(iif(cod_ugru is null,@tipcod,iif(@tipcod=7,21,iif(@tipcod=17,2,@tipcod-1))) as varchar(250))_tipcod         
into #ProdT_        --select * from #ProdT_ 
from #ProdT    --select * from #ProdT    select * from #ProdT_
         
      
 select   cast(b.HTIPCOD as varchar(250)) HTIPCOD ,
  b.hcodrel ,a.*                       
into #ProdT__1        --select * from #ProdT__1           
from #ProdT_ a   --select * from #ProdT          
left join #Jerar b  --SELECT * FROM #ProdT__  SELECT * FROM #ProdTip1                      
on case when @tipcod=17 then a.cod_ugru else a.descripcion end =case when @tipcod=17 then b.hcodrel  else  b.HCODRELDES    end               
     
select  
case when @tipcod=17 and htipcod is null then cast(cod_ugru as varchar(250)) else HTIPCOD end HTIPCOD,
case when @tipcod=17 and htipcod is null  then @codrel else  hcodrel end hcodrel,cod_fc,cod_ugru,style,descripcion,CAP_1,_tipcod 
into #ProdT__  --select * from #ProdT__
from #ProdT__1



select a.*,HSBSDO1 ,B.RORD  ,b.PRODUCTO    
INTO #PP --select * from #PP      
from #ProdT__ a  ---select * from #ProdT__                
join (SELECT * FROM STORAGE.COM_ACT.WSALCAPCOMER01 WHERE PRODUCTO<>'TOTAL') b   --SELECT * FROM STORAGE.COM_ACT.WSALCAPCOMER01      
on cast(a.HTIPCOD as varchar(250))=cast(b.HTIPCOD as varchar(250))
and case when  a._tipcod=7 then '231'  else a.HCODREL end =b.HCODREL            
ORDER BY STYLE DESC,cod_ugru ASC      

 
    
--select * from #PP where rord in(5,6)    
    
SELECT     
      HTIPCOD ,    
     case when descripcion='ASESOR VIRTUAL' THEN 'ASESO' ELSE hcodrel END hcodrel,--hcodrel,    
    style,    
    descripcion,    
        
    -- ==========================================    
    -- BLOQUE AHORROS    
    -- ==========================================    
    SUM(CASE WHEN RORD = 6 AND PRODUCTO = 'AHORROS' THEN HSBSDO1 ELSE 0 END) AS [6-ahorros],    
    CASE 
        WHEN COUNT(CASE WHEN RORD = 5 AND PRODUCTO = 'AHORROS' THEN 1 END) > 0 
        THEN SUM(CASE WHEN RORD = 5 AND PRODUCTO = 'AHORROS' THEN HSBSDO1 ELSE 0 END)
        ELSE SUM(CASE WHEN RORD = 4 AND PRODUCTO = 'AHORROS' THEN HSBSDO1 ELSE 0 END)
    END AS [5-ahorros],
    (    
        SUM(CASE WHEN RORD = 6 AND PRODUCTO = 'AHORROS' THEN HSBSDO1 ELSE 0 END) -     
        CASE 
            WHEN COUNT(CASE WHEN RORD = 5 AND PRODUCTO = 'AHORROS' THEN 1 END) > 0 
            THEN SUM(CASE WHEN RORD = 5 AND PRODUCTO = 'AHORROS' THEN HSBSDO1 ELSE 0 END)
            ELSE SUM(CASE WHEN RORD = 4 AND PRODUCTO = 'AHORROS' THEN HSBSDO1 ELSE 0 END)
        END
    ) AS [var-ahorros],    
    
    -- ==========================================    
    -- BLOQUE PLAZO FIJO (DPF)    
    -- ==========================================    
    SUM(CASE WHEN RORD = 6 AND PRODUCTO = 'PLAZO FIJO' THEN HSBSDO1 ELSE 0 END) AS [6-DPF],    
    CASE 
        WHEN COUNT(CASE WHEN RORD = 5 AND PRODUCTO = 'PLAZO FIJO' THEN 1 END) > 0 
        THEN SUM(CASE WHEN RORD = 5 AND PRODUCTO = 'PLAZO FIJO' THEN HSBSDO1 ELSE 0 END)
        ELSE SUM(CASE WHEN RORD = 4 AND PRODUCTO = 'PLAZO FIJO' THEN HSBSDO1 ELSE 0 END)
    END AS [5-DPF],
    (    
        SUM(CASE WHEN RORD = 6 AND PRODUCTO = 'PLAZO FIJO' THEN HSBSDO1 ELSE 0 END) -     
        CASE 
            WHEN COUNT(CASE WHEN RORD = 5 AND PRODUCTO = 'PLAZO FIJO' THEN 1 END) > 0 
            THEN SUM(CASE WHEN RORD = 5 AND PRODUCTO = 'PLAZO FIJO' THEN HSBSDO1 ELSE 0 END)
            ELSE SUM(CASE WHEN RORD = 4 AND PRODUCTO = 'PLAZO FIJO' THEN HSBSDO1 ELSE 0 END)
        END
    ) AS [var-DPF],    
    
    -- ==========================================    
    -- BLOQUE CTS    
    -- ==========================================    
    SUM(CASE WHEN RORD = 6 AND PRODUCTO = 'CTS' THEN HSBSDO1 ELSE 0 END) AS [6-CTS],    
    CASE 
        WHEN COUNT(CASE WHEN RORD = 5 AND PRODUCTO = 'CTS' THEN 1 END) > 0 
        THEN SUM(CASE WHEN RORD = 5 AND PRODUCTO = 'CTS' THEN HSBSDO1 ELSE 0 END)
        ELSE SUM(CASE WHEN RORD = 4 AND PRODUCTO = 'CTS' THEN HSBSDO1 ELSE 0 END)
    END AS [5-CTS],
    (    
        SUM(CASE WHEN RORD = 6 AND PRODUCTO = 'CTS' THEN HSBSDO1 ELSE 0 END) -     
        CASE 
            WHEN COUNT(CASE WHEN RORD = 5 AND PRODUCTO = 'CTS' THEN 1 END) > 0 
            THEN SUM(CASE WHEN RORD = 5 AND PRODUCTO = 'CTS' THEN HSBSDO1 ELSE 0 END)
            ELSE SUM(CASE WHEN RORD = 4 AND PRODUCTO = 'CTS' THEN HSBSDO1 ELSE 0 END)
        END
    ) AS [var-CTS]    
into #HHH    
FROM #PP    
WHERE RORD IN (4,5, 6)    
GROUP BY     
    HTIPCOD,    
    hcodrel,    
    style,    
    descripcion    
ORDER BY     
   style desc    
      
SELECT HTIPCOD,hcodrel,style,descripcion,sum([6-ahorros]) [6-ahorros],sum([5-ahorros])[5-ahorros],sum([var-ahorros])[var-ahorros],
sum([6-DPF])[6-DPF],sum([5-DPF])[5-DPF],sum([var-DPF])[var-DPF],
sum([6-CTS])[6-CTS],sum([5-CTS])[5-CTS],sum([var-CTS])[var-CTS]
from #HHH
group by HTIPCOD,style,descripcion,hcodrel
order by style desc,descripcion desc

DECLARE @FCM DATE=(SELECT MAX(HFECPRO) FROM STORAGE.COM_ACT.WSALCAPCOMER01 WHERE PRODUCTO='TOTAL')      
      
select a.*,HSBSDO1 ,B.RORD,PRODUCTO      
INTO #PP1  --DROP TABLE #PP1      
from #ProdT__ a  ---select * from #ProdT__                
join (SELECT * FROM STORAGE.COM_ACT.WSALCAPCOMER01 WHERE PRODUCTO<>'TOTAL' AND HFECPRO=@FCM) b   --SELECT * FROM STORAGE.COM_ACT.WSALCAPCOMER01      
on  cast(a.HTIPCOD as varchar(250))=cast(b.HTIPCOD as varchar(250))
and  a.HCODREL   =b.HCODREL            
ORDER BY STYLE DESC,cod_ugru ASC      
      
SELECT HTIPCOD,HCODREL,descripcion,HSBSDO1,PRODUCTO FROM #PP1 WHERE STYLE=1      
       
       
      
END
