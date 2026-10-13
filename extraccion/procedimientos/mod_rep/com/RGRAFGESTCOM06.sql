-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-08-09 19:52:08.773000
--EXEC  [com].[RGRAFGESTCOM06]   17,'1367','20260330'
CREATE procedure [com].[RGRAFGESTCOM06]  
@tip_cod varchar(5),@cod_rel varchar(25),@fecha DATE   
as  
begin  
SET NOCOUNT ON;    
 --declare @tip_cod varchar(5)=7, @cod_rel varchar(25)='231', @Fecha DATE ='20260216'    
set @tip_cod= case when @tip_cod='7' then '21' else @tip_cod end
set @cod_rel= case when @cod_rel='231' then '1' else @cod_rel end

 ;with cte_a as (  
--select top 6 RFEC  
-- from storage.ref.RCALEN001 where rfec <=@Fecha and RCIEBT=1 order by 1 desc  
--union all  
select max(rfec) rfec   
from storage.ref.RCALEN001   
where rfec<=@Fecha and RDIAFER=0   
)   
select RFEC,ROW_NUMBER() over(order by RFEC asc) ord   
into #Fechas  
from cte_a  


declare @fec_ date
set @fec_= (select RFEC from #Fechas where ord=1)

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
into #jerar              
from storage.ref.WJERCOR03                 
where rfecpro=@fec_ and rindfec='actual' and
case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                     
     when @tip_cod=20 then cast(RCODTER as nvarchar(10))                  
     when @tip_cod=19 then CAST(RCODCOR  as nvarchar(10))                        
      when @tip_cod=18 then CAST(RCODUNI as nvarchar(10)) 
	    when @tip_cod=17 then CAST(RCODUCO  AS VARCHAR(10))
	  else '1' end=IIF(@tip_cod=7,'1',@cod_rel)   

/*             
select DISTINCT hfecpro,htipcod,hcodrel,HNUMCLIN hnumclinuevo   
into #R1  
from storage.com_act.wjas001 
where hfecpro in(select rfec from #fechas where ord between 2 and 7)  
and htipcod=@tip_cod and hcodrel=@cod_rel order by 1 asc  
*/
select DISTINCT hfecpro,htipcod,hcodrel,HNUMCLIN hnumclinuevo   
into #R1  
from #Fechas a 
inner join (select hfecpro,CASE WHEN  b.htipcod=1 THEN 2 ELSE  b.htipcod END htipcod,a.hcodrel,HNUMCLIN
			from storage.com_act.wjas001  a 
		    inner join  #jerar b   --select * from #jerar
			on CASE WHEN a.htipcod=1 THEN 2 ELSE a.htipcod END =b.htipcod and a.hcodrel=b.hcodrel
			)b 
on a.rfec=b.hfecpro 
----------------  
/*
select * into #R2 
from STORAGE.COM_ACT.WTIPCLI001 a where hfecpro in(select rfec from #fechas)  
 and htipcod=@tip_cod and hcodrel=@cod_rel  
 */

select * into #R2  from #fechas a 
inner join (select HFECPRO,CASE WHEN a.htipcod=1 THEN 2 ELSE a.htipcod END  HTIPCOD,A.HCODREL,HNUMCLIINGR,HNUMCLIVENC,HNUMCLIPROG,HNUMCLIANTI  from  STORAGE.COM_ACT.WTIPCLI001 a
		    inner join #jerar b   --select * from #jerar
			on CASE WHEN a.htipcod=1 THEN 2 ELSE a.htipcod END =b.htipcod and a.hcodrel=b.hcodrel
			)b
on a.rfec=b.hfecpro
     
  
SELECT A.*,B.HNUMCLIINGR,B.HNUMCLIVENC,B.HNUMCLIPROG,B.HNUMCLIANTI ,  HNUMCLIINGR - hnumclinuevo Recuperado  
INTO #Resultado  --select * from #Resultado  drop table #Resultado  
FROM #R1 A  --select * from #Resultado  
LEFT JOIN #R2 B  
ON A.HFECPRO=B.HFECPRO AND A.HTIPCOD=B.HTIPCOD AND A.HCODREL=B.HCODREL  
 
alter table #Resultado
add descr nvarchar(max)

update a
set a.descr=b.HTIPDES
from #Resultado a 
inner join #jerar b
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel

  
-- Construcción del JSON Mirror para Ingresos y Salidas  
DECLARE @categories NVARCHAR(MAX);  
DECLARE @dataNuevos NVARCHAR(MAX), @dataIngr NVARCHAR(MAX);  
DECLARE @dataVenc NVARCHAR(MAX), @dataProg NVARCHAR(MAX), @dataAnti NVARCHAR(MAX),@dataRecu NVARCHAR(MAX)  
  
  
-- 1. Categorías (Fechas)  
SELECT @categories = '[' + STRING_AGG('"' + CAST(descr AS VARCHAR(50)) + '"', ',') WITHIN GROUP (ORDER BY descr) + ']' FROM #Resultado;  
  
-- 2. Series Positivas (Ingresos)  
SELECT @dataNuevos = '[' + STRING_AGG(CAST(hnumclinuevo AS VARCHAR), ',') WITHIN GROUP (ORDER BY descr) + ']' FROM #Resultado;  
SELECT @dataIngr = '[' + STRING_AGG(CAST(HNUMCLIINGR AS VARCHAR), ',') WITHIN GROUP (ORDER BY descr) + ']' FROM #Resultado;  
SELECT @dataRecu = '[' + STRING_AGG(CAST(Recuperado AS VARCHAR), ',') WITHIN GROUP (ORDER BY descr) + ']' FROM #Resultado;  
-- 3. Series Negativas (Salidas - Multiplicadas por -1)  
SELECT @dataVenc = '[' + STRING_AGG(CAST(HNUMCLIVENC * -1 AS VARCHAR), ',') WITHIN GROUP (ORDER BY descr) + ']' FROM #Resultado;  
SELECT @dataProg = '[' + STRING_AGG(CAST(HNUMCLIPROG * -1 AS VARCHAR), ',') WITHIN GROUP (ORDER BY descr) + ']' FROM #Resultado;  
SELECT @dataAnti = '[' + STRING_AGG(CAST(HNUMCLIANTI * -1 AS VARCHAR), ',') WITHIN GROUP (ORDER BY descr) + ']' FROM #Resultado;  
  
SELECT   
    JSON_QUERY(@categories) AS categories,  
    JSON_QUERY('[  
        {"type":"column","name":"NUEVOS","color":"#64B5F6","data":'+@dataNuevos+'},  
        {"type":"column","name":"RECUPERADOS","color":"#C5CAE9","data":'+@dataRecu+'},  
        {"type":"column","name":"Salida Anticipada","color":"#002060","data":'+@dataAnti+'},  
        {"type":"column","name":"Salida programada","color":"#BDE4E4","data":'+@dataProg+'},  
        {"type":"column","name":"Salida Vencido","color":"#D8D4BC","data":'+@dataVenc+'}  
    ]') AS series  
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;  
   
  
--drop table #Fechas  
end
