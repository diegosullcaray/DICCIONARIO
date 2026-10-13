-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-08-09 19:51:46.107000
--exec com.RGRAFGESTCOM05 7,'231','20260430'
CREATE procedure [com].[RGRAFGESTCOM05]
@tip_cod varchar(5),@cod_rel varchar(25),@fecha DATE  
as
begin
SET NOCOUNT ON;  
-- declare @tip_cod varchar(5)=21, @cod_rel varchar(25)='1', @Fecha DATE ='20260328'    
--drop table #Fechas  
  
set @tip_cod= case when @tip_cod='7' then '21' else @tip_cod end
set @cod_rel= case when @cod_rel='231' then '1' else @cod_rel end

;with cte_a as (  
select top 1 RFEC  
 from storage.ref.RCALEN001 where rfec <@Fecha and RCIEBT=1 order by 1 desc  
union all  
select max(rfec) rfec--,7   
from storage.ref.RCALEN001   
where rfec<=@Fecha and RDIAFER=0   
)   
select RFEC,ROW_NUMBER() over(order by RFEC asc) ord   
into #Fechas   --drop table #Fechas  select * from #Fechas
from cte_a  
  
declare @fec_ date
set @fec_= (select RFEC from #Fechas where ord=2)

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
where rfecpro=@fec_ and rindfec='actual'    and
case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                     
     when @tip_cod=20 then cast(RCODTER as nvarchar(10))                  
     when @tip_cod=19 then CAST(RCODCOR  as nvarchar(10))                        
      when @tip_cod=18 then CAST(RCODUNI as nvarchar(10)) 
	    when @tip_cod=17 then CAST(RCODUCO  AS VARCHAR(10))
	  else '1' end=IIF(@tip_cod=7,'1',@cod_rel)  
 

select a.rfec hfecpro,a.ord, b.htipcod,b.hcodrel,b.hnumcli  
into #wjas001   --select * from #wjas001
from #Fechas a  ---select * from #Fechas
inner join (select hfecpro,CASE WHEN a.htipcod=1 THEN 2 ELSE a.htipcod END htipcod,a.hcodrel,hnumcli 
			from storage.com_act.WJAS001 a
			inner join #jerar b   --select * from #jerar
			on CASE WHEN a.htipcod=1 THEN 2 ELSE a.htipcod END=b.htipcod and a.hcodrel=b.hcodrel
			) b  
on a.rfec=b.hfecpro  
    
alter table #wjas001 add ord2 int null   
update #wjas001 set ord2=ord-1   --select * from #wjas001  
    

;with cte_a_ as (  
select * from #wjas001
where ord=1
),
cte_bb as (
select * from #wjas001 where ord2=1
),
cte_a as (
select b.hfecpro,a.htipcod,a.hcodrel,isnull(b.hnumcli,0) - isnull(a.hnumcli,0) TmmHnumcli  
from  cte_a_ a  
inner join cte_bb b    --select * from #wjas001
ON a.htipcod = b.htipcod 
AND a.hcodrel = b.hcodrel
),  
cte_b as (  
select a.*, b.HVALVAR meta  
from cte_a a  
inner join [storage].[com].[VDMCOM01] b  
on eomonth(a.hfecpro)=b.hfecpro and a.htipcod=b.htipcod and a.hcodrel=b.hcodrel  
where b.hcodvar=10062   
)  
  
select * into #r from cte_b order by 1 asc   --select * from #r  
  
-- Declaramos variables para construir los arreglos del JSON  
DECLARE @categories NVARCHAR(MAX);  
DECLARE @dataVariacion NVARCHAR(MAX);  
DECLARE @dataMeta NVARCHAR(MAX);  

alter table #r
add descr nvarchar(max)

update a
set a.descr=b.HTIPDES
from #r a 
inner join #jerar b
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel
 
-- 1. Agrupamos las fechas (HFECPRO) formateadas  
-- Usamos FORMAT para que en el eje X se vea "30 ago 2025" directamente  
-- 1. Categorías (Ordenadas por descr)
--SELECT @categories = '[' + STRING_AGG('"' + CAST(descr AS VARCHAR(50)) + '"', ',') WITHIN GROUP (ORDER BY descr) + ']'  
SELECT @categories = '[' + STRING_AGG('"' + STRING_ESCAPE(RTRIM(LTRIM(CAST(descr AS NVARCHAR(MAX)))), 'json') + '"', ',') WITHIN GROUP (ORDER BY descr) + ']'
FROM (
    SELECT DISTINCT descr  
    FROM #r
) AS CategoriasUnicas;
  
-- 2. Valores de Variación (⚠️ CORREGIDO: Ahora ordenado por descr para que coincida)
SELECT @dataVariacion = '[' + STRING_AGG(CAST(TmmHnumcli AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY descr) + ']'  
FROM #r;  
  
-- 3. Valores de Meta (⚠️ CORREGIDO: Ahora ordenado por descr para que coincida)
SELECT @dataMeta = '[' + STRING_AGG(CAST(meta AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY descr) + ']'  
FROM #r;  

-- 4. Construimos el JSON final combinando las partes  
SELECT   
    JSON_QUERY(@categories) AS categories,  
    JSON_QUERY('[  
        {  
            "name": "Variación Clientes",  
            "data": ' + @dataVariacion + '  
        },  
        {  
            "name": "Meta Var Clientes",  
            "data": ' + @dataMeta + '  
        }  
    ]') AS series  
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;

end
