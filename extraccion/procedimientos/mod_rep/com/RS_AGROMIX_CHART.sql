-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:38.083000
--exec com.RS_AGROMIX_CHART  7,'231','20250930'
CREATE procedure [com].[RS_AGROMIX_CHART] 
@tip_cod int,
@cod_rel varchar(250),
@fec date
as
begin
 SET NOCOUNT ON; 
  
select distinct rfecpro, isnull(rcodsec,'0') rcodsec 
into #Asesor
from storage.ref.fjercor02(@fec)
where case when @tip_cod=7 then cast('1' as varchar)
           when @tip_cod=21 then cast(rcodgru as varchar)
           when @tip_cod=20 then cast(rcodter as varchar)
           when @tip_cod=19 then cast(rcodcor as varchar)
           when @tip_cod=18 then cast(rcoduni as varchar)
           when @tip_cod=17 then cast(RCODUCO as varchar) 
		   when @tip_cod=2 then cast(RCODSEC as varchar) end  = case when @tip_cod=7 then '1' else @cod_rel end;

;with cte_a as (
select * from storage.com_act.WCMAG001 where hfecpro=@fec
)
select 
    a.HFECPRO, a.HCAPMON, a.HVENMON, a.HCTACLI, a.HDESCUL,A.HCODOPE,a.HEXTENS,
    case when a.HASEOPER in('','--') then '0' else a.HASEOPER end as HASEOPER,
    b.rcodsec,a.HLATITU,a.HLONGIT ,a.HDESCLI ,a.HETPROD
into #HBase
from cte_a a
left join #Asesor b on a.hfecpro = b.rfecpro 
    and case when a.HASEOPER in('','--') then '0' else a.HASEOPER end = b.rcodsec
where @tip_cod = 7 OR b.rfecpro IS NOT NULL;
 
;with SumasPorProducto as (
    select 
        HDESCUL, 
        SUM(HVENMON) as TotalVencido
    from #HBase
    group by HDESCUL
)
select 
    HDESCUL,
    ROW_NUMBER() OVER(ORDER BY TotalVencido DESC) as Ranking
into #RankingProductos
from SumasPorProducto;
 
select 
    h.*,  
    CASE 
        WHEN r.Ranking <= 12 THEN h.HDESCUL 
        ELSE 'Otros' 
    END as HDESCUL_Agrupado,
    CASE 
        WHEN r.Ranking <= 12 THEN 'Individual' 
        ELSE 'Agrupado' 
    END as TipoFila
into #HBaseConGrupo
from #HBase h
join #RankingProductos r on h.HDESCUL = r.HDESCUL;
 

;with ConsultaResumen as (
    select 
        a.HDESCUL_Agrupado as HDESCUL,
        SUM(a.HVENMON) as HVENMON, 
        SUM(SUM(a.HVENMON)) OVER() as GranTotalHVENMON
    from #HBaseConGrupo a
    group by a.HDESCUL_Agrupado, a.TipoFila
), 
ResultadosFinales as (
    select
        HDESCUL,
        HVENMON,
        case 
            when GranTotalHVENMON = 0 then 0 
            else HVENMON / GranTotalHVENMON * 100
        end as pctResTVen, 
        CASE WHEN HDESCUL = 'Otros' THEN 1 ELSE 0 END as Ordenador
    from ConsultaResumen
) 
select 
    JSON_QUERY(
        '[' + STRING_AGG(CONVERT(NVARCHAR(MAX), '"' + STRING_ESCAPE(HDESCUL, 'json') + '"'), ',') WITHIN GROUP (ORDER BY Ordenador ASC, HVENMON DESC) + ']'
    ) as categories,

    -- 2. Creamos el array de 'series' que contiene dos objetos (Saldo Vencido y % Respecto al Total)
    JSON_QUERY(
        '[{
            "name": "Saldo Vencido",
            "data": [' + STRING_AGG(CONVERT(NVARCHAR(MAX), HVENMON), ',') WITHIN GROUP (ORDER BY Ordenador ASC, HVENMON DESC) + ']
        },{
            "name": "%Respecto al Total",
            "data": [' + STRING_AGG(CONVERT(NVARCHAR(MAX), pctResTVen), ',') WITHIN GROUP (ORDER BY Ordenador ASC, HVENMON DESC) + ']
        }]'
    ) as series
from ResultadosFinales 
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
 
 
select 
    HDESCUL,HDESCUL_Agrupado ,
    HCAPMON as HCAPMON,
    HVENMON as HVENMON,
    HCTACLI as HCTACLI,
	case when HCAPMON=0 then 0 else cast(HVENMON as float)/ HCAPMON * 100 end percenSV,
	HEXTENS,
	HLATITU,HLONGIT ,
	HDESCLI,HETPROD
from #HBaseConGrupo  
order by HVENMON DESC;
 
end
