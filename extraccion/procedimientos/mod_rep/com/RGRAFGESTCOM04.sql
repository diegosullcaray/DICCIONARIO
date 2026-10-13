-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-08-09 19:51:24.767000
CREATE procedure [com].[RGRAFGESTCOM04]
@tip_cod varchar(5),@cod_rel varchar(25),@fecha DATE  
as
begin
SET NOCOUNT ON;  
 --declare @tip_cod varchar(5)=7, @cod_rel varchar(25)='231', @Fecha DATE ='20260216'  
 set @tip_cod= case when @tip_cod='7' then '21' else @tip_cod end
set @cod_rel= case when @cod_rel='231' then '1' else @cod_rel end

 ;with cte_a as (
select top 6 RFEC
 from storage.ref.RCALEN001 where rfec <@Fecha and RCIEBT=1 order by 1 desc
union all
select max(rfec) rfec 
from storage.ref.RCALEN001 
where rfec<=@Fecha and RDIAFER=0 
) 
select RFEC,ROW_NUMBER() over(order by RFEC asc) ord 
into #Fechas
from cte_a
           
select DISTINCT hfecpro,htipcod,hcodrel,HNUMCLIN hnumclinuevo 
into #R1
from storage.com_act.wjas001 where hfecpro in(select rfec from #fechas where ord between 2 and 7)
and htipcod=@tip_cod and hcodrel=@cod_rel order by 1 asc
----------------
select * into #R2 from STORAGE.COM_ACT.WTIPCLI001 where hfecpro in(select rfec from #fechas)
 and htipcod=@tip_cod and hcodrel=@cod_rel

 --select max(hfecpro) from STORAGE.COM_ACT.WTIPCLI001 where hfecpro='20260331'
  

SELECT A.*,B.HNUMCLIINGR,B.HNUMCLIVENC,B.HNUMCLIPROG,B.HNUMCLIANTI ,  HNUMCLIINGR - hnumclinuevo Recuperado
INTO #Resultado  --select * from #Resultado  drop table #Resultado
FROM #R1 A  --select * from #Resultado
LEFT JOIN #R2 B
ON A.HFECPRO=B.HFECPRO AND A.HTIPCOD=B.HTIPCOD AND A.HCODREL=B.HCODREL

-- Construcción del JSON Mirror para Ingresos y Salidas
DECLARE @categories NVARCHAR(MAX);
DECLARE @dataNuevos NVARCHAR(MAX), @dataIngr NVARCHAR(MAX);
DECLARE @dataVenc NVARCHAR(MAX), @dataProg NVARCHAR(MAX), @dataAnti NVARCHAR(MAX),@dataRecu NVARCHAR(MAX)


-- 1. Categorías (Fechas)
SELECT @categories = '[' + STRING_AGG('"' + FORMAT(hfecpro, 'dd MMM yyyy', 'es-ES') + '"', ',') WITHIN GROUP (ORDER BY hfecpro) + ']' FROM #Resultado;

-- 2. Series Positivas (Ingresos)
SELECT @dataNuevos = '[' + STRING_AGG(CAST(hnumclinuevo AS VARCHAR), ',') WITHIN GROUP (ORDER BY hfecpro) + ']' FROM #Resultado;
SELECT @dataIngr = '[' + STRING_AGG(CAST(HNUMCLIINGR AS VARCHAR), ',') WITHIN GROUP (ORDER BY hfecpro) + ']' FROM #Resultado;
SELECT @dataRecu = '[' + STRING_AGG(CAST(Recuperado AS VARCHAR), ',') WITHIN GROUP (ORDER BY hfecpro) + ']' FROM #Resultado;
-- 3. Series Negativas (Salidas - Multiplicadas por -1)
SELECT @dataVenc = '[' + STRING_AGG(CAST(HNUMCLIVENC * -1 AS VARCHAR), ',') WITHIN GROUP (ORDER BY hfecpro) + ']' FROM #Resultado;
SELECT @dataProg = '[' + STRING_AGG(CAST(HNUMCLIPROG * -1 AS VARCHAR), ',') WITHIN GROUP (ORDER BY hfecpro) + ']' FROM #Resultado;
SELECT @dataAnti = '[' + STRING_AGG(CAST(HNUMCLIANTI * -1 AS VARCHAR), ',') WITHIN GROUP (ORDER BY hfecpro) + ']' FROM #Resultado;

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

end


--drop table #Fechas
