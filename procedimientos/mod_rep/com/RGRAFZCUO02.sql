-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-14 17:22:54.290000
--exec [com].[RGRAFZCUO02] 7,'231','20260824'
CREATE procedure [com].[RGRAFZCUO02]
@tip_cod varchar(5),@cod_rel varchar(25),@fecha DATE  
as
begin
SET NOCOUNT ON;   
 --declare @tip_cod varchar(5)=7, @cod_rel varchar(25)='231', @Fecha DATE ='20260818'  
 IF OBJECT_ID('tempdb..#datos') IS NOT NULL DROP TABLE #datos
select   
    CASE cast(@tip_cod as varchar (5))  
        WHEN 7 THEN cast(RDESGRU as varchar (50))  
        WHEN 21 THEN cast(RDESTER as varchar (50))  
        WHEN 20 THEN cast(RDESCOR as varchar (50))  
        WHEN 19 THEN cast(RDESUNI as varchar (50))  
     WHEN 18 THEN cast(RDESUCO as varchar (50))
	 WHEN 17 THEN cast(haseoper as varchar (10))
    END   Descripcion
	,
	CASE cast(@tip_cod as varchar (5))  
        WHEN 7 THEN cast(21 as varchar (50))  
        WHEN 21 THEN cast(20 as varchar (50))  
        WHEN 20 THEN cast(19 as varchar (50))  
        WHEN 19 THEN cast(18 as varchar (50))  
		WHEN 18 THEN cast(17 as varchar (50)) 
    END HTIPCOD
	 ,CASE cast(@tip_cod as varchar (5))  
        WHEN 7 THEN cast(RCODGRU as varchar (50))  
        WHEN 21 THEN cast(RCODTER as varchar (50))  
        WHEN 20 THEN cast(RCODCOR as varchar (50))  
        WHEN 19 THEN cast(RCODUNI as varchar (50))  
		WHEN 18 THEN cast(RCODUCO as varchar (50)) 
    END  HCODREL  
	, cast( SUM (case when nuevo_ingreso = 'NO' then hsalcapmn end )/1000  AS numeric (17,0)) mantiene
	 , cast( SUM (case when nuevo_ingreso = 'SI' then hsalcapmn end ) /1000  AS numeric (17,0)) nuevo
	 into #datos
--nuevo_ingreso  
from storage.com_act.WZCUO001
 WHERE HFECPRO = @Fecha and CASE 
            WHEN @tip_cod = 21 THEN cast(RCODGRU as varchar)  
            WHEN @tip_cod = 20 THEN cast(RCODTER as varchar)  
            WHEN @tip_cod = 19 THEN cast(RCODCOR as varchar)  
            WHEN @tip_cod = 18 THEN cast(RCODUNI as varchar)  
            WHEN @tip_cod = 17 THEN cast(RCODUCO as varchar)  
            WHEN @tip_cod = 7  THEN cast(RCODFC as varchar) 
          END = @cod_rel  
group by CASE cast(@tip_cod as varchar (5))  
        WHEN 7 THEN cast(RDESGRU as varchar (50))  
        WHEN 21 THEN cast(RDESTER as varchar (50))  
        WHEN 20 THEN cast(RDESCOR as varchar (50))  
        WHEN 19 THEN cast(RDESUNI as varchar (50))  
     WHEN 18 THEN cast(RDESUCO as varchar (50))
	 WHEN 17 THEN cast(haseoper as varchar (10))
    END  , 
	CASE cast(@tip_cod as varchar (5))  
        WHEN 7 THEN cast(RCODGRU as varchar (50))  
        WHEN 21 THEN cast(RCODTER as varchar (50))  
        WHEN 20 THEN cast(RCODCOR as varchar (50))  
        WHEN 19 THEN cast(RCODUNI as varchar (50))  
		WHEN 18 THEN cast(RCODUCO as varchar (50)) 
    END   
  
 --select * from #datos

 --select  RCODGRU,nuevo_ingreso, SUM(hsalcapmn) from storage.com_act.Rpte_PEDC029_cerocuotas where hfecpro = '20260818'
 --group by RCODGRU,nuevo_ingreso
 -- select  SUM(hsalcapmn) from storage.com_act.Rpte_PEDC029_cerocuotas where hfecpro = '20260818'
 --select * from storage.com_act.Rpte_PEDC029_cerocuotas where hfecpro = '20260818'
 --order by RCODGRU 

-- Construcción del JSON Mirror para Ingresos y Salidas
DECLARE @categories NVARCHAR(MAX);
DECLARE @dataNuevos NVARCHAR(MAX), @dataIngr NVARCHAR(MAX); 

-- 1. Categorías (Fechas) 
SELECT @categories = '[' + STRING_AGG('"' + Descripcion + '"', ',') WITHIN GROUP (ORDER BY Descripcion) + ']' FROM #datos;

-- 2. Series Positivas (Ingresos)
SELECT @dataNuevos = '[' + STRING_AGG(CAST(mantiene AS VARCHAR), ',') WITHIN GROUP (ORDER BY descripcion) + ']' FROM #datos;
SELECT @dataIngr = '[' + STRING_AGG(CAST(nuevo AS VARCHAR), ',') WITHIN GROUP (ORDER BY descripcion) + ']' FROM #datos; 
SELECT 
    JSON_QUERY(@categories) AS categories,
    JSON_QUERY('[
        {"type":"column","name":"MANTIENE","color":"#64B5F6","HTIPCO":"21","HCODREL":"1","data":'+@dataNuevos+'},
        {"type":"column","name":"NUEVO","color":"#C5CAE9","HTIPCO":"21","HCODREL":"1","data":'+@dataIngr+'}  
    ]') AS series
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;

end


--drop table #Fechas
