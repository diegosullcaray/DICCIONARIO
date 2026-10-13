-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-08-09 19:52:36.597000
--exec [com].[RGRAFGESTCOM07] 7,'231','20260425'  
CREATE PROCEDURE [com].[RGRAFGESTCOM07]    
@tip_cod int,@cod_rel varchar(20),@Fecha varchar(10)   
as  
begin  
 SET NOCOUNT ON; 
--declare @tip_cod varchar(5)=7,@cod_rel varchar(25)='231',@fecha DATE='20260425'
----
set @tip_cod= case when @tip_cod='7' then '21' else @tip_cod end
set @cod_rel= case when @cod_rel='231' then '1' else @cod_rel end

;with cte_a as (
select top 12 RFEC
 from storage.ref.RCALEN001 where rfec <@Fecha and RCIEBT=1 order by 1 desc
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
 
 
select b.hfecpro,a.htipcod,a.hcodrel,b.hnumcli - a.hnumcli TmmHnumcli , b.hnumcli cliStock
into #Variacion
from  #wjas001 a
inner join #wjas001 b
on a.ord=b.ord2
 

-- Declaramos variables para construir las partes del JSON
DECLARE @categories NVARCHAR(MAX);
DECLARE @dataCliStock NVARCHAR(MAX);
DECLARE @dataVariacionCliStock NVARCHAR(MAX);

SELECT @categories = '[' + STRING_AGG('"' + CAST(hfecpro AS VARCHAR(20)) + '"', ',') WITHIN GROUP (ORDER BY hfecpro) + ']'
FROM #Variacion;

SELECT @dataCliStock = '[' + STRING_AGG(CAST(cliStock  AS VARCHAR(50)), ',') WITHIN GROUP (ORDER BY hfecpro) + ']'
FROM #Variacion;

SELECT @dataVariacionCliStock = '[' + STRING_AGG(ISNULL(CAST(TmmHnumcli  AS VARCHAR(50)), 'null'), ',') WITHIN GROUP (ORDER BY hfecpro) + ']'
FROM #Variacion;

-- 4. Construimos el objeto final
SELECT 
    JSON_QUERY(@categories) AS categories,
    JSON_QUERY('[
        {"name": "Clientes Stock", "data": ' + @dataCliStock + '},
        {"name": "VARIACIÓN Clientes Stock", "data": ' + @dataVariacionCliStock + '}
    ]') AS series
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
  
END
