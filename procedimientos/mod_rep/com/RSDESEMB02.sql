-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-08 18:11:13.570000
--exec mod_rep.com.RSDESEMB02 7,'231','20260907'     
--exec mod_rep.com.RSDESEMB 21,'1','20250812'  
CREATE PROCEDURE [com].[RSDESEMB02]        
@tip_cod int,@cod_rel varchar(20),@fec date           
AS              
BEGIN          
 SET NOCOUNT ON;            
 SET LANGUAGE SPANISH
 
;with cte_a as (  
select top 5 rfec  from storage.ref.RCALEN001 where rfec <= @fec   and RCIEBT=1  order by 1 desc
)   
select top 5 rfec,ROW_NUMBER() over(order by rfec asc) ord into #fec  from cte_a  --drop table #fec,#jerar  

declare @fecjer nvarchar(max)
set @fecjer =(select string_agg(format(rfec,'yyyyMMdd'),',') v from #fec )

declare @fec1 varchar(250), @fec2 varchar(250), @fec3 varchar(250), @fec4 varchar(250), @fec5 varchar(250)
set @fec1 =(select rfec from #fec where ord=1)
set @fec2 =(select rfec from #fec where ord=2)
set @fec3 =(select rfec from #fec where ord=3)
set @fec4 =(select rfec from #fec where ord=4)
set @fec5 =(select rfec from #fec where ord=5) 

select * into #jerar from storage.[ref].[FJERCOR02](@fecjer) --select * from 

declare @headers varchar(max)                    
select @headers  ='[                     
   { "label":"Rango Desembolso ","key":"RangoDesembolso","sticky": "true","cellStyle":{"text-align":"left","max-width":"190px","min-width":"190px","width":"190px"}},                    
   { "label":"Número de Operaciones","subs":[ {"label": "'+format(CAST(@fec1 AS DATE),'dd-MMM')+'","key":"1_Ope","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"style":{"min-width":"70px","width":"70px"}} ,               
   {"label": "'+format(CAST(@fec2 AS DATE),'dd-MMM')+'","key":"2_Ope","cellStyle":{"text-align":"right","max-width":"20px","min-width":"20px","width":"20px"},"style":{"min-width":"70px","width":"70px"}},{"label": "'+format(CAST(@fec3 AS DATE),'dd-MMM')+'","key":"3_Ope","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"}},{"label": "'+format(CAST(@fec4 AS DATE),'dd-MMM')+'","key":"4_Ope","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"}},{"label": "'+format(CAST(@fec5 AS DATE),'dd-MMM')+'","key":"5_Ope","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"}},{"label": "Var.ABS","key":"Ope_Var","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"}} ]},              
   { "label":"Monto Desembolsado","subs":[ {"label": "'+format(CAST(@fec1 AS DATE),'dd-MMM')+'","key":"1_MON","cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},              
   {"label": "'+format(CAST(@fec2 AS DATE),'dd-MMM')+'","key":"2_MON","cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},{"label": "'+format(CAST(@fec3 AS DATE),'dd-MMM')+'","key":"3_MON","cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},{"label": "'+format(CAST(@fec4 AS DATE),'dd-MMM')+'","key":"4_MON","cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},{"label": "'+format(CAST(@fec5 AS DATE),'dd-MMM')+'","key":"5_MON","cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},{"label": "Var.ABS","key":"Mon_Var","cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}}]},               
   { "label":"Tasa Activa Promedio %","subs":[ {"label": "'+format(CAST(@fec1 AS DATE),'dd-MMM')+'","key":"1_mes","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"} },              
   {"label": "'+format(CAST(@fec2 AS DATE),'dd-MMM')+'","key":"2_mes","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"}},{"label": "'+format(CAST(@fec3 AS DATE),'dd-MMM')+'","key":"3_mes","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"}},{"label": "'+format(CAST(@fec4 AS DATE),'dd-MMM')+'","key":"4_mes","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"}},{"label": "'+format(CAST(@fec5 AS DATE),'dd-MMM')+'","key":"5_mes","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"}},{"label": "Var.ABS","key":"mes_var","cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px"}}]}
   ] '                        
               
              
select @headers  
 

SELECT A.hfecpro,
CASE  WHEN b.rcodgru =2 and @tip_cod <>7 THEN A.idrango2 ELSE A.idrango END idrango,
CASE  WHEN b.rcodgru =2 and @tip_cod <>7   THEN A.RangoDesembolso2  ELSE A.RangoDesembolso END RangoDesembolso,
CASE  WHEN b.rcodgru =2 and @tip_cod <>7 THEN '2' ELSE '1' END TIPO, 
A.HCODOPE,A.haseoper,A.HMONDESMN,A.HNUMTAS
INTO #Base__ FROM storage.[com_act].VCAH005 a  
LEFT JOIN (
    SELECT DISTINCT rfecpro, rcodsec, rcodgru  
    FROM #jerar
    WHERE   CASE 
        WHEN @tip_cod = '7' THEN CAST('1' AS VARCHAR(10))              
        WHEN @tip_cod = '20' THEN CAST(RCODTER AS VARCHAR(10))              
        WHEN @tip_cod = '19' THEN CAST(RCODCOR AS VARCHAR(10))              
        WHEN @tip_cod = '21' THEN CAST(RCODGRU AS VARCHAR(10))              
        WHEN @tip_cod = '18' THEN CAST(RCODUNI AS VARCHAR(10))        
        WHEN @tip_cod = '17' THEN CAST(RCODUCO AS VARCHAR(10)) 
    END = CASE 
        WHEN @tip_cod = '7' THEN '1' 
        ELSE @cod_rel 
    END 
) b ON a.haseoper = b.rcodsec AND a.HFECPRO = b.RFECPRO
 WHERE @tip_cod = '7'  OR (@tip_cod <> '7' AND b.rcodsec IS NOT NULL )




SELECT A.*,B.ord INTO #Base_
FROM #Base__ A
INNER JOIN  #fec B
ON A.HFECPRO=B.RFEC

select hfecpro,ord,IDRango,RangoDesembolso,
count(distinct hcodope) HCODOPE,sum(HMONDESMN) HMONDESMN,
sum(HMONDESMN*HNUMTAS/100.0)/SUM(HMONDESMN) STAPPMES
into #PreResult
from #Base_
group by hfecpro,ord,IDRango,RangoDesembolso
  

----//----
-- Crear índice para optimizar la consulta
CREATE NONCLUSTERED INDEX IX_PreResult_Temp 
ON #PreResult (RangoDesembolso, ord) 
INCLUDE (IDRango, HCODOPE, HMONDESMN, STAPPMES);

 declare @TIPO as int, @RANGOM_Tex as varchar(5), @RANGOM_Num as int
	select top 1 @TIPO= TIPO from #Base__
	SELECT 
    @RANGOM_Tex = CASE WHEN @TIPO = 1 THEN '50M'   ELSE '3M'   END,
    @RANGOM_Num = CASE WHEN @TIPO = 1 THEN 50000   ELSE 3000   END;

-- Consulta principal con los tres tipos de datos
SELECT 
    0 AS style,
    IDRango,
    RangoDesembolso, 
    SUM(CASE WHEN ord = 1 THEN HCODOPE ELSE 0 END) AS [1_Ope],
    SUM(CASE WHEN ord = 2 THEN HCODOPE ELSE 0 END) AS [2_Ope],
    SUM(CASE WHEN ord = 3 THEN HCODOPE ELSE 0 END) AS [3_Ope],
    SUM(CASE WHEN ord = 4 THEN HCODOPE ELSE 0 END) AS [4_Ope],
    SUM(CASE WHEN ord = 5 THEN HCODOPE ELSE 0 END) AS [5_Ope], 
	SUM(CASE WHEN ord = 5 THEN HCODOPE ELSE 0 END) - SUM(CASE WHEN ord = 4 THEN HCODOPE ELSE 0 END) [Ope_Var],
    SUM(CASE WHEN ord = 1 THEN HMONDESMN ELSE 0 END) AS [1_MON],
    SUM(CASE WHEN ord = 2 THEN HMONDESMN ELSE 0 END) AS [2_MON],
    SUM(CASE WHEN ord = 3 THEN HMONDESMN ELSE 0 END) AS [3_MON],
    SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END) AS [4_MON],
    SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END) AS [5_MON], 
	SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END) - SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END) [Mon_Var],
    (SUM(CASE WHEN ord = 1 THEN STAPPMES ELSE 0 END)) AS [1_mes],   
    (SUM(CASE WHEN ord = 2 THEN STAPPMES ELSE 0 END)) AS [2_mes],
    (SUM(CASE WHEN ord = 3 THEN STAPPMES ELSE 0 END)) AS [3_mes],
    (SUM(CASE WHEN ord = 4 THEN STAPPMES ELSE 0 END)) AS [4_mes],
    (SUM(CASE WHEN ord = 5 THEN STAPPMES ELSE 0 END)) AS [5_mes],
	(SUM(CASE WHEN ord = 5 THEN STAPPMES ELSE 0 END) - SUM(CASE WHEN ord = 4 THEN STAPPMES ELSE 0 END))    mes_var
INTO #r  --select * from #r  drop table #R
FROM #PreResult
WHERE RangoDesembolso IS NOT NULL AND ord IS NOT NULL
GROUP BY IDRango, RangoDesembolso

UNION ALL
 

-- Fila de totales
SELECT 
    1 AS style,
    10 AS IDRango,
    'Total' AS RangoDesembolso, 
    count( distinct CASE WHEN ord = 1 THEN HCODOPE ELSE null END) AS [1_ope],
    count(distinct CASE WHEN ord = 2 THEN HCODOPE ELSE null END) AS [2_ope],
    count(distinct CASE WHEN ord = 3 THEN HCODOPE ELSE null END) AS [3_ope],
    count(distinct CASE WHEN ord = 4 THEN HCODOPE ELSE null END) AS [4_ope],
    count(distinct CASE WHEN ord = 5 THEN HCODOPE ELSE null END) AS [5_ope], 
	count(distinct CASE WHEN ord = 5 THEN HCODOPE ELSE null END) - count(distinct CASE WHEN ord = 4 THEN HCODOPE ELSE null END),
    SUM(CASE WHEN ord = 1 THEN HMONDESMN ELSE 0 END) AS [1_mon],
    SUM(CASE WHEN ord = 2 THEN HMONDESMN ELSE 0 END) AS [2_mon],
    SUM(CASE WHEN ord = 3 THEN HMONDESMN ELSE 0 END) AS [3_mon],
    SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END) AS [4_mon],
    SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END) AS [5_mon], 
	SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END) - SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END),
	ISNULL(SUM(CASE WHEN ord = 1 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 1 THEN HMONDESMN ELSE 0 END)  , 0)  , 0)/ 100 AS [1_MES],
ISNULL(SUM(CASE WHEN ord = 2 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 2 THEN HMONDESMN ELSE 0 END) , 0) , 0)/ 100 AS [2_MES],
ISNULL(SUM(CASE WHEN ord = 3 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 3 THEN HMONDESMN ELSE 0 END) , 0) , 0)/ 100 AS [3_MES],
ISNULL(SUM(CASE WHEN ord = 4 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END) , 0) , 0)/ 100 AS [4_MES],
ISNULL(SUM(CASE WHEN ord = 5 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END)  , 0) , 0) / 100AS [5_MES],

-- Para el ROUND final
ISNULL(ROUND((
    ISNULL(SUM(CASE WHEN ord = 5 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END), 0), 0) -  
    ISNULL(SUM(CASE WHEN ord = 4 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END), 0), 0)
) , 2), 0)/ 100
FROM #Base_     

 
union all
-- Fila de totales
SELECT 
    1 AS style,
    11 AS IDRango,
    'Desembolsos >=PEN '+@RANGOM_Tex AS RangoDesembolso, 
    count( distinct CASE WHEN ord = 1 THEN HCODOPE ELSE null END) AS [1_ope],
    count(distinct CASE WHEN ord = 2 THEN HCODOPE ELSE null END) AS [2_ope],
    count(distinct CASE WHEN ord = 3 THEN HCODOPE ELSE null END) AS [3_ope],
    count(distinct CASE WHEN ord = 4 THEN HCODOPE ELSE null END) AS [4_ope],
    count(distinct CASE WHEN ord = 5 THEN HCODOPE ELSE null END) AS [5_ope], 
	count(distinct CASE WHEN ord = 5 THEN HCODOPE ELSE null END) - count(distinct CASE WHEN ord = 4 THEN HCODOPE ELSE null END),
    SUM(CASE WHEN ord = 1 THEN HMONDESMN ELSE 0 END) AS [1_mon],
    SUM(CASE WHEN ord = 2 THEN HMONDESMN ELSE 0 END) AS [2_mon],
    SUM(CASE WHEN ord = 3 THEN HMONDESMN ELSE 0 END) AS [3_mon],
    SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END) AS [4_mon],
    SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END) AS [5_mon], 
	SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END) - SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END),
	SUM(CASE WHEN ord = 1 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 1 THEN HMONDESMN ELSE 0 END) , 0) / 100  [1_MES],
SUM(CASE WHEN ord = 2 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 2 THEN HMONDESMN ELSE 0 END) , 0) / 100 [2_MES],
SUM(CASE WHEN ord = 3 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 3 THEN HMONDESMN ELSE 0 END) , 0) / 100 [3_MES],
SUM(CASE WHEN ord = 4 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END) , 0) / 100 [4_MES],
SUM(CASE WHEN ord = 5 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END) , 0) / 100 [5_MES],
ROUND((SUM(CASE WHEN ord = 5 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 5 THEN HMONDESMN ELSE 0 END) , 0) - 
SUM(CASE WHEN ord = 4 THEN HMONDESMN * HNUMTAS ELSE 0 END) / NULLIF(SUM(CASE WHEN ord = 4 THEN HMONDESMN ELSE 0 END) , 0)), 2) / 100
FROM #Base_    
where HMONDESMN >= @RANGOM_Num 
ORDER BY style, IDRango;

 select style,IDRango,RangoDesembolso,
 FORMAT([1_Ope], '#,##0', 'en-US') [1_Ope],
FORMAT([2_Ope], '#,##0', 'en-US') [2_Ope],
FORMAT([3_Ope], '#,##0', 'en-US') [3_Ope],
FORMAT([4_Ope], '#,##0', 'en-US') [4_Ope],
FORMAT([5_Ope], '#,##0', 'en-US') [5_Ope],
FORMAT([Ope_Var], '#,##0', 'en-US') [Ope_Var],
FORMAT([1_MON], '#,##0', 'en-US') [1_MON],
FORMAT([2_MON], '#,##0', 'en-US') [2_MON],
FORMAT([3_MON], '#,##0', 'en-US') [3_MON],
FORMAT([4_MON], '#,##0', 'en-US') [4_MON],
FORMAT([5_MON], '#,##0', 'en-US') [5_MON],
FORMAT([Mon_Var], '#,##0', 'en-US') [Mon_Var],
FORMAT([1_mes], '#,##0.00%', 'en-US') [1_mes],
FORMAT([2_mes], '#,##0.00%', 'en-US') [2_mes],
FORMAT([3_mes], '#,##0.00%', 'en-US') [3_mes],
FORMAT([4_mes], '#,##0.00%', 'en-US') [4_mes],
FORMAT([5_mes], '#,##0.00%', 'en-US') [5_mes],
FORMAT([mes_var], '#,##0.00%', 'en-US') [mes_var]
 from #r  
 union all 
 SELECT 
    1 AS style, -- Nuevo style para identificar la fila de porcentajes
    12 AS IDRango,
    '%Desembolsos>= PEN '+@RANGOM_Tex AS RangoDesembolso,
    CAST(CAST(ROUND((r11.[1_Ope] * 100.0 / NULLIF(r10.[1_Ope], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [1_Ope],
CAST(CAST(ROUND((r11.[2_Ope] * 100.0 / NULLIF(r10.[2_Ope], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [2_Ope],
CAST(CAST(ROUND((r11.[3_Ope] * 100.0 / NULLIF(r10.[3_Ope], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [3_Ope],
CAST(CAST(ROUND((r11.[4_Ope] * 100.0 / NULLIF(r10.[4_Ope], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [4_Ope],
CAST(CAST(ROUND((r11.[5_Ope] * 100.0 / NULLIF(r10.[5_Ope], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [5_Ope],
NULL AS [Columna6],
CAST(CAST(ROUND((r11.[1_mon] * 100.0 / NULLIF(r10.[1_mon], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [1_MON],
CAST(CAST(ROUND((r11.[2_mon] * 100.0 / NULLIF(r10.[2_mon], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [2_MON],
CAST(CAST(ROUND((r11.[3_mon] * 100.0 / NULLIF(r10.[3_mon], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [3_MON],
CAST(CAST(ROUND((r11.[4_mon] * 100.0 / NULLIF(r10.[4_mon], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [4_MON],
CAST(CAST(ROUND((r11.[5_mon] * 100.0 / NULLIF(r10.[5_mon], 0)), 0) AS INT) AS VARCHAR(20)) + '%' AS [5_MON],
null,null,null,null,null,null,null

FROM 
    (SELECT [1_Ope], [2_Ope], [3_Ope], [4_Ope], [5_Ope] ,[1_MON],[2_MON],[3_MON],[4_MON],[5_MON] 

	
	FROM #r WHERE IDRango = 10) r10
CROSS JOIN 
    (SELECT [1_Ope], [2_Ope], [3_Ope], [4_Ope], [5_Ope] ,[1_MON],[2_MON],[3_MON],[4_MON],[5_MON]
	
	FROM #r WHERE IDRango = 11) r11
      
END
