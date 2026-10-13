-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-08-09 19:51:02.453000
--exec  com.RGRAFGESTCOM03 7,'231','20260214'
CREATE procedure [com].[RGRAFGESTCOM03]
@tip_cod varchar(5),@cod_rel varchar(25),@fecha DATE
as
begin
SET NOCOUNT ON;
--declare @tip_cod varchar(5)=20, @cod_rel varchar(25)='1_9', @Fecha DATE ='20260214'  
--drop table #Fechas
set @tip_cod= case when @tip_cod='7' then '21' else @tip_cod end
set @cod_rel= case when @cod_rel='231' then '1' else @cod_rel end

;with cte_a as (
select top 6 RFEC
 from storage.ref.RCALEN001 where rfec <=@Fecha and RCIEBT=1 order by 1 desc
union all
select max(rfec) rfec--,7 
from storage.ref.RCALEN001 
where rfec<=@Fecha and RDIAFER=0 
) 
select RFEC,ROW_NUMBER() over(order by RFEC asc) ord 
into #Fechas
from cte_a

 

select a.rfec hfecpro,a.ord, b.htipcod,b.hcodrel,b.hnumcli
into #wjas001
from #Fechas a
inner join (select hfecpro,htipcod,hcodrel,hnumcli from storage.com_act.WJAS001 where htipcod=@tip_cod and hcodrel=@cod_rel) b
on a.rfec=b.hfecpro
  
alter table #wjas001 add ord2 int null 
update #wjas001 set ord2=ord-1 
 
;with cte_a as (
select b.hfecpro,a.htipcod,a.hcodrel,b.hnumcli - a.hnumcli TmmHnumcli
from  #wjas001 a
inner join #wjas001 b
on a.ord=b.ord2
),
cte_b as (
select a.*, b.HVALVAR meta  from cte_a a
inner join [storage].[com].[VDMCOM01] b
on eomonth(a.hfecpro)=b.hfecpro and a.htipcod=b.htipcod and a.hcodrel=b.hcodrel
where b.hcodvar=10062 
)

select * into #r from cte_b order by 1 asc

-- Declaramos variables para construir los arreglos del JSON
DECLARE @categories NVARCHAR(MAX);
DECLARE @dataVariacion NVARCHAR(MAX);
DECLARE @dataMeta NVARCHAR(MAX);

-- 1. Agrupamos las fechas (HFECPRO) formateadas
-- Usamos FORMAT para que en el eje X se vea "30 ago 2025" directamente
SELECT @categories = '[' + STRING_AGG('"' + FORMAT(hfecpro, 'dd MMM yyyy', 'es-ES') + '"', ',') WITHIN GROUP (ORDER BY hfecpro) + ']'
FROM #r;

-- 2. Agrupamos los valores de Variación (TmmHnumcli)
SELECT @dataVariacion = '[' + STRING_AGG(CAST(TmmHnumcli AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY hfecpro) + ']'
FROM #r;

-- 3. Agrupamos los valores de Meta
SELECT @dataMeta = '[' + STRING_AGG(CAST(meta AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY hfecpro) + ']'
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
 --drop table #Fechas,#wjas001
