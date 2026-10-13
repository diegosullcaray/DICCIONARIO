-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:39.537000
--exec com.RS_AGROMIX_CHART3  7,'231','20250930'
CREATE procedure [com].[RS_AGROMIX_CHART3] 
@tip_cod int,
@cod_rel varchar(250),
@fec date
as
begin
 SET NOCOUNT ON; 

-- ====================================================================
-- PASO 1: CREAR LA TABLA #HBase (Tu código original, sin cambios)
-- ====================================================================
--declare @tip_cod int=7, @cod_rel varchar(250)='231',@fec date='20250930'

select distinct rfecpro, isnull(rcodsec,'0') rcodsec 
into #Asesor
from storage.ref.fjercor02(@fec)
where case when @tip_cod=7 then cast('1' as varchar)
           when @tip_cod=21 then cast(rcodgru as varchar)
           when @tip_cod=20 then cast(rcodter as varchar)
           when @tip_cod=19 then cast(rcodcor as varchar)
           when @tip_cod=18 then cast(rcoduni as varchar)
           when @tip_cod=17 then cast(RCODUCO as varchar) 
		    when @tip_cod=2 then cast(RCODSEC as varchar) end = case when @tip_cod=7 then '1' else @cod_rel end;

		   
;with cte_a as (
select * from storage.com_act.WCMAG001 where hfecpro=@fec
)

select 
    a.HFECPRO, a.HCAPMON, a.HVENMON, a.HCTACLI, a.HDESCUL,A.HCODOPE,a.HEXTENS,
    case when a.HASEOPER in('','--') then '0' else a.HASEOPER end as HASEOPER,
    b.rcodsec,a.HLATITU,a.HLONGIT ,a.HDESCLI,a.HETPROD
into #HBase
from cte_a a
left join #Asesor b on a.hfecpro = b.rfecpro 
    and case when a.HASEOPER in('','--') then '0' else a.HASEOPER end = b.rcodsec
where @tip_cod = 7 OR b.rfecpro IS NOT NULL;


-- ====================================================================
-- PASO 2: IDENTIFICAR EL TOP 12 Y CREAR LA TABLA FINAL CON LA COLUMNA DE AGRUPACIÓN
-- ====================================================================

-- Primero, creamos una tabla temporal para saber el ranking de cada producto
;with SumasPorProducto as (
    select 
        HDESCUL, 
        COUNT(DISTINCT HCTACLI) as TotalClientes
    from #HBase
    group by HDESCUL
)
select 
    HDESCUL,
    ROW_NUMBER() OVER(ORDER BY TotalClientes DESC) as Ranking
into #RankingProductos
from SumasPorProducto;

-- Ahora, creamos la tabla #HBaseConGrupo, que es #HBase + la lógica de agrupación
select 
    h.*, -- Todas las columnas originales de #HBase
    -- Añadimos las dos columnas clave para agrupar y filtrar
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


-- ====================================================================
-- PASO 3: REALIZAR LAS CONSULTAS FINALES (AHORA MUCHO MÁS SENCILLAS)
-- ====================================================================

;with ConsultaResumen as (
    select 
        a.HDESCUL_Agrupado as HDESCUL,
        count(distinct HCTACLI) as HCTACLI  
    from #HBaseConGrupo a
    group by a.HDESCUL_Agrupado, a.TipoFila
),
-- Ahora, calculamos los porcentajes finales y asignamos un orden
ResultadosFinales as (
    select
        HDESCUL,
        HCTACLI,  
        -- Creamos una columna para ordenar y asegurar que 'Otros' vaya al final
        CASE WHEN HDESCUL = 'Otros' THEN 1 ELSE 0 END as Ordenador
    from ConsultaResumen
)
-- Finalmente, construimos el objeto JSON
select
    -- 1. Creamos el array de 'categories' usando los nombres de los productos
    JSON_QUERY(
        '[' + STRING_AGG(CONVERT(NVARCHAR(MAX), '"' + STRING_ESCAPE(HDESCUL, 'json') + '"'), ',') WITHIN GROUP (ORDER BY Ordenador ASC, HCTACLI DESC) + ']'
    ) as categories,

    -- 2. Creamos el array de 'series' que contiene dos objetos (Saldo Vencido y % Respecto al Total)
    JSON_QUERY(
        '[{
            "name": "Cliente",
            "data": [' + STRING_AGG(CONVERT(NVARCHAR(MAX), HCTACLI), ',') WITHIN GROUP (ORDER BY Ordenador ASC, HCTACLI DESC) + ']
        }]'
    ) as series
from ResultadosFinales
-- FOR JSON PATH: Construye objetos JSON anidados.
-- WITHOUT_ARRAY_WRAPPER: Devuelve un único objeto JSON en lugar de un array con un objeto.
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;

/*
-- Consulta 1: El Resumen Agrupado (Top 12 + 'Otros')
-- Esta es la consulta que mostrarías en tu dashboard principal.
;with cte_Totales as (
    select
        -- Calculamos los totales del conjunto de datos una sola vez
        SUM(HCAPMON) as GranTotalHCAPMON,
        SUM(HVENMON) as GranTotalHVENMON
    from #HBaseConGrupo
)
select 
    MAX(a.HFECPRO) as HFECPRO,
    a.HDESCUL_Agrupado as HDESCUL, -- Usamos la nueva columna para agrupar
    a.TipoFila,
    --SUM(a.HCAPMON) as HCAPMON,
    SUM(a.HVENMON) as HVENMON,
    --COUNT(DISTINCT a.HCTACLI) as HCTACLI,
    -- Cálculos de porcentajes
    --case when SUM(a.HCAPMON) = 0 then 0 else SUM(a.HVENMON) / SUM(a.HCAPMON) end as pctVencido,
    --case when b.GranTotalHCAPMON = 0 then 0 else SUM(a.HCAPMON) / b.GranTotalHCAPMON end as pctParticipacion,
    case when b.GranTotalHVENMON = 0 then 0 else SUM(a.HVENMON) / b.GranTotalHVENMON end as pctResTVen
from #HBaseConGrupo a, cte_Totales b -- Cross join para tener los totales en cada fila
group by a.HDESCUL_Agrupado, a.TipoFila, b.GranTotalHCAPMON, b.GranTotalHVENMON
order by 
    CASE WHEN a.HDESCUL_Agrupado = 'Otros' THEN 1 ELSE 0 END, -- 'Otros' siempre al final
    SUM(HVENMON) DESC;

*/

-- Consulta 2: El Detalle de "Otros" (Para cuando el usuario haga clic)
 
select 
    HDESCUL,HDESCUL_Agrupado ,
    HCAPMON as HCAPMON,
    HVENMON as HVENMON,
    HCTACLI as HCTACLI,
	case when HCAPMON=0 then 0 else cast(HVENMON as float)/ HCAPMON * 100 end percenSV,
	HEXTENS,
	HLATITU,HLONGIT ,HDESCLI,HETPROD
from #HBaseConGrupo  --select * from #HBaseConGrupo
--where TipoFila in('Agrupado' -- Simplemente filtras por la columna que creamos
order by HVENMON DESC;
 
end
