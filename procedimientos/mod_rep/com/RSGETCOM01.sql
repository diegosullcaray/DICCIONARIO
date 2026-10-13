-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-15 15:43:07.840000
--EXEC MOD_REP.com.RSGETCOM01 7,'231','20260523'          
CREATE PROCEDURE [com].[RSGETCOM01] --drop procedure com.RSGETCOM01_          
@tip_cod varchar(5), @cod_rel varchar(25), @Fecha DATE          
AS          
BEGIN          
SET NOCOUNT ON;            

set @tip_cod= case when @tip_cod='7' then '21' else @tip_cod end
set @cod_rel= case when @cod_rel='231' then '1' else @cod_rel end

          
-- declare @Fecha date='20260211', @tip_cod varchar(5)=21, @cod_rel varchar(25)='1'          
------------------------------------          
SELECT '' JSON          
          
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jer varchar(100)                                    
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL           
declare @fecs varchar(max)           
          
select *                                    
into #FECS                 
from storage.util.FVECFEC01(@fecha,'cmg_4,cmg_6')           
      
declare @fecCierreAnt date       
set @fecCierreAnt =(select rfec                                             
from storage.util.FVECFEC01(@fecha,'cmg_5')          
)      
          
declare @fec_ date ,@fec_ant date          
set @fec_ =(select rfec from #FECS where rord=2)          
set @fec_ant =(select rfec from #FECS where rord=1)          
          
           
/* % Días Habíl */          
 /*    
 select      RORD dia_habil,                      
             RFEC Fecha,DATENAME(weekday,RFEC) fecha_nombre                      
 INTO #FecHabil --drop table #FecHabil                      
 from        storage.util.FVECFEC01(eomonth(@fec_),'ini-hoy|hab') A                        
                      
 declare @CDiasHab int , @percent_habil float                    
 set @CDiasHab =(select count(*) from #FecHabil)            
             
  select @percent_habil=cast(dia_habil as float)/@CDiasHab from #FecHabil where fecha=@fec_          
  select @percent_habil=@percent_habil * 100    
  
  */

  declare @percent_habil float 
  ;with cte_a as (
  select 
  sum(case when RDIASEM=6 then 0.5 else 1 end) puntaje  
  from storage.ref.rcalen001 
  where rfec between DATEADD(month, DATEDIFF(month, 0, @fec_), 0) and  eomonth(@fec_) and rdiafer=0
  )
  ,
  cte_b as (
  select sum(case when RDIASEM=6 then 0.5 else 1 end) puntaje  
  from  storage.ref.rcalen001 
  where rfec between DATEADD(month, DATEDIFF(month, 0, @fec_), 0) and  @fec_ and rdiafer=0
  )  
  select   @percent_habil=cast(sum(a.puntaje) as float) / sum(b.puntaje) * 100
  from cte_b a
  inner join cte_a b
  on 1=1
          
--------------------------------------------------------------------------------          
                
select distinct @tip_cod HTIPCOD,case when @tip_cod=7 then CAST(RCODFC AS varchar(250))                
            when @tip_cod=21 then CAST(RCODGRU AS varchar(250))                
   when @tip_cod=20 then CAST(RCODTER AS varchar(250))                
   when @tip_cod=19 then CAST(RCODCOR AS varchar(250))                
   when @tip_cod=18 then CAST(RCODUNI AS varchar(250))                
   when @tip_cod=17 then CAST(RCODUCO AS varchar(250))                
  END HCODREL,                
    case when @tip_cod=7 then RDESFC                
            when @tip_cod=21 then RDESGRU                
   when @tip_cod=20 then RDESTER                
   when @tip_cod=19 then RDESCOR                
   when @tip_cod=18 then RDESUNI                
   when @tip_cod=17 then RDESUCO                
  END HCODRELDES,'1' nivel                
into #Jerar                
from storage.ref.WJERCOR03                 
where rfecpro=@fec_ and rindfec='actual'                
union all                
                
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
  END HTIPCOD,                
    case when @tip_cod=7 then  RDESGRU                
            when @tip_cod=21 then RDESTER                
   when @tip_cod=20 then RDESCOR                
   when @tip_cod=19 then RDESUNI                
   when @tip_cod=18 then RDESUCO              
   when @tip_cod=17 then RDESSEC                
  END HTIPCOD,'2' nivel                
                
from storage.ref.WJERCOR03                 
where rfecpro=@fec_ and rindfec='actual'                
           
/* META */          
;with cte_a as (          
select * from storage.[com].[VDMCOM01]           
where hfecpro=eomonth(@fec_) and hcodvar in('8080')          
),          
CTE_B AS (          
select a.hfecpro,a.hcodvar,a.htipcod,a.hcodrel,a.hvalvar          
from cte_a a          
inner join #Jerar b          
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel           
)          
select hfecpro,hcodvar,htipcod,hcodrel,hvalvar,(hvalvar * @percent_habil) / 100 avance_meta           
into #MetaProductividad  --select * from #MetaProductividad          
from cte_b     

/* META PRODUCTIVIDAD ASESOR */          
;with cte_a as (          
select * from storage.[com].[VDMCOM01]           
where hfecpro=eomonth(@fec_) and hcodvar in('5006')          
),          
CTE_B AS (          
select a.hfecpro,a.hcodvar,a.htipcod,a.hcodrel,a.hvalvar          
from cte_a a          
inner join #Jerar b          
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel           
)          
select hfecpro,hcodvar,htipcod,hcodrel,hvalvar,(hvalvar * @percent_habil) / 100 avance_meta           
into #MetaProductividadAsesor  --select * from #MetaProductividad          
from cte_b      

/* META CLIENTE CUMPLIMIENTO */          
;with cte_a as (          
select * from storage.[com].[VDMCOM01]           
where hfecpro=eomonth(@fec_) and hcodvar in('166')          
),          
CTE_B AS (          
select a.hfecpro,a.hcodvar,a.htipcod,a.hcodrel,a.hvalvar          
from cte_a a          
inner join #Jerar b          
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel           
)          
select hfecpro,hcodvar,htipcod,hcodrel,hvalvar,(hvalvar * @percent_habil) / 100 avance_meta           
into #MetaClientesnuevos  --select * from #MetaProductividad          
from cte_b    
           
/* META DINAMICA*/          
;with cte_a as (          
select * from storage.[com].[VDMCOM01]           
where hfecpro=eomonth(@fec_) and hcodvar in(134,133,10062,136,9000,8070,166)          
union all
select * from storage.[com].[VDMCOM01] 
where hfecpro=@fec_ and hcodvar in(10256)
--where hfecpro=@fec_ and hcodvar in(10256,10257)
union all
select @fec_ HFECPRO,HTIPMETA,HCODVAR,HTIPCOD,HCODREL,SUM(HVALVAR)HVALVAR 
from storage.[com].[VDMCOM01] 
where hfecpro between DATEADD(month, DATEDIFF(month, 0, @fec_), 0) and @fec_ and hcodvar=10255
GROUP BY HTIPMETA,HCODVAR,HTIPCOD,HCODREL
union all
select @fec_ HFECPRO,HTIPMETA,HCODVAR,HTIPCOD,HCODREL,SUM(HVALVAR)HVALVAR 
from storage.[com].[VDMCOM01] 
where hfecpro between DATEADD(month, DATEDIFF(month, 0, @fec_), 0) and @fec_ and hcodvar=10257
GROUP BY HTIPMETA,HCODVAR,HTIPCOD,HCODREL
),          
CTE_B AS (          
select a.hfecpro,a.hcodvar,a.htipcod,a.hcodrel,a.hvalvar          
from cte_a a          
inner join #Jerar b          
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel           
)           
SELECT htipcod, hcodrel, 
[134] AS hvalvar_134 , [133] hvalvar_133 , [10062] hvalvar_10062  ,    
[136] hvalvar_136  , [9000] hvalvar_9000  ,[8070] hvalvar_8070,
[166] hvalvar_166,[10256] hvalvar_10256, [10255] hvalvar_10255,
[10257] hvalvar_10257
INTO #Metas          
FROM (          
    SELECT htipcod, hcodrel, hcodvar, hvalvar          
    FROM CTE_B          
) SourceTable          
PIVOT (          
    SUM(hvalvar)          
    FOR hcodvar IN ([134],[133],[10062],[136],[9000],[8070],[166],[10256],[10255],[10257])          
) AS PivotTable;          
          
          
---------          
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                                    
from #FECS               
          
insert into @tvars                                    
values                                    
    ('num_ope_sf2', null, null, null, null, null)           
 ,('tick_prom_sf2', null, 'tick_prom', null, null, null)          
 ,('mon_desem_sf2', null, 'mont_dese', null, null, null)          
 --,('num_cli_stock', null, 'cli_stock', null, null, null)          
 ,('tapp_mes_sf2', null, 'tapp_mes', null, null, null)          
 ,('sal_vig',null,'sal_vig',   null, null, null)            
          
insert into @tfil values ('todos', 'fec', @fecs)                   
          
insert into @tconf                                    
values                                    
    ('level_alias', 'style') ,('insert_to','#ProdTip1') ,  ('fec_corr','true')            
          
insert into @tfil                                    
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jer output              
          
          
 create table #ProdTip1   --select * from #ProdTip1                
(                  
    fila int,                  
    cod_fc varchar(250)null,                  
 cod_ugru varchar(250)null,                
    style int null,                  
    descripcion varchar(250)null,                   
    num_ope_sf2_1 float null,                  
    num_ope_sf2_2 float null ,          
 tick_prom_1 float null,              
 tick_prom_2 float null,          
 mont_dese_1 float null,          
 mont_dese_2 float null,          
 --cli_stock_1 float null,          
 --cli_stock_2 float null,          
 tapp_mes_1 float null,          
 tapp_mes_2 float null,          
 sal_vig_1 float null,          
 sal_vig_2 float null          
)                      
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1                      
                
          
          
  select fila,cod_fc,cod_ugru,style,descripcion,isnull(num_ope_sf2_2,0) num_ope_sf ,isnull(num_ope_sf2_1,0) num_ope_sf_ante,                
 iif(cod_ugru is null,@tip_cod,iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1)))_tipcod  ,          
 tick_prom_2 , tick_prom_2 - tick_prom_1 TMM_TICK,          
 mont_dese_1,mont_dese_2 , mont_dese_2 - mont_dese_1 TMMDESEMB,          
 --cli_stock_1,cli_stock_2 , cli_stock_2 - cli_stock_1 TMMCLISTOCK,          
 tapp_mes_1,tapp_mes_2, (tapp_mes_2 - tapp_mes_1)*10000 TMMTAPP          
 ,sal_vig_1,sal_vig_2,sal_vig_2 - sal_vig_1 TMMSALVIG          
 into #ProdT       --select * from #ProdT          
 from #ProdTip1   --select * from #ProdTip1          
          
 select b.HTIPCOD,b.hcodrel,a.*                 
into #ProdT__                
from #ProdT a   --select * from #ProdT              
left join #Jerar b  --SELECT * FROM #ProdT__  SELECT * FROM #ProdTip1                
on a.descripcion=b.HCODRELDES                
                
          
  select HFECPRO,case when HTIPCOD=1 then 2 else HTIPCOD end HTIPCOD,HCODREL,HFECPRO descripcion,cast(HNUMSECIMES as float) IND,                  
     cast(HNUMSECGMES as float) PDM,HVSALVIGMN  ,HNUMCLIN ,HNUMCLI               
  into #wjas001                 
  from storage.com_act.WJAS001 where hfecpro=@fec_           
          
  select HFECPRO,case when HTIPCOD=1 then 2 else HTIPCOD end HTIPCOD,HCODREL,HFECPRO descripcion,cast(HNUMSECIMES as float) IND,                  
     cast(HNUMSECGMES as float) PDM,HVSALVIGMN    ,HNUMCLIN     ,HNUMCLI         
  into #wjas001_Ant                 
  from storage.com_act.WJAS001 where hfecpro=@fec_ant           
       
update a      
set a.HNUMCLI=b.HNUMCLI      
from #wjas001_Ant a       
inner join (select htipcod,hcodrel,HNUMCLI from storage.com_act.WJAS001 where hfecpro=@fecCierreAnt )b --piero      
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel      
           
select a.htipcod,a.hcodrel,            
a.descripcion,a.style,                
  case when (isnull(b.IND,0)*1.0)=0 then 0 else isnull(a.num_ope_sf,0)/(isnull(b.IND,0)*1.0) end  prod_ind   ,          
  tick_prom_2,TMM_TICK ,          
  mont_dese_2,TMMDESEMB,          
 -- cli_stock_2, TMMCLISTOCK,          
  tapp_mes_2,TMMTAPP          
  ,b.HVSALVIGMN,          
  sal_vig_2,TMMSALVIG,          
  b.HNUMCLIN          
  ,b.HNUMCLI        
 into #TB  --drop table #TB   SELECT * FROM #TB       drop table #TB          
 from #ProdT__ a  ---select * from #ProdT__          
   join  #wjas001 b                 
   on a.HTIPCOD=b.HTIPCOD and case when  a._tipcod=7 then '231' else a.HCODREL end =b.HCODREL                
          
              
          
select a.htipcod,a.hcodrel,            
a.descripcion,a.style,                
  case when (isnull(b.IND,0)*1.0)=0 then 0 else isnull(a.num_ope_sf_ante,0)/(isnull(b.IND,0)*1.0) end  prod_ind_ant ,          
  null tick_prom_2,null TMM_TICK          
  ,null mont_dese_2,null TMMDESEMB,          
  --null cli_stock_2, null TMMCLISTOCK,          
  null tapp_mes_2,null TMMTAPP,          
  null HVSALVIGMN          
  ,NULL sal_vig_2, NULL TMMSALVIG,          
  HNUMCLIN HNUMCLIN_ant          
  ,HNUMCLI HNUMCLI_ant        
 into #TB_Ant  --drop table #TB   SELECT * FROM #TB_Ant       drop table #TB          
 from #ProdT__ a  ---select HNUMCLI,* from #ProdT__          
   join  #wjas001_Ant b  --select HNUMCLI,* from #wjas001_Ant               
   on a.HTIPCOD=b.HTIPCOD and case when  a._tipcod=7 then '231' else a.HCODREL end =b.HCODREL            
          

;with cte_a as (          
select a.*,b.prod_ind_ant ,b.HNUMCLIN_ant  ,b.HNUMCLI_ant        
from  #TB a  --select * from #TB          
full join #TB_Ant b --select * from #TB_Ant          
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel          
) ,          
cte_b as (          
select a.htipcod,a.hcodrel,a.descripcion,a.style,a.prod_ind,
case when isnull(b.avance_meta,d.avance_meta)=0 then 0 else a.prod_ind / isnull(b.avance_meta,d.avance_meta) end  Percent_Cumpl ,          -- 
a.prod_ind_ant , a.prod_ind - a.prod_ind_ant TMMPROD ,          
case when b.hvalvar=0 then  0 else a.prod_ind/b.hvalvar end  percent_avance_hoy ,    --      
a.tick_prom_2,a.TMM_TICK ,          
a.mont_dese_2,TMMDESEMB,          
--a.cli_stock_2, a.TMMCLISTOCK,          
a.tapp_mes_2,a.TMMTAPP          
,a.HVSALVIGMN          
,a.sal_vig_2,a.TMMSALVIG,          
a.HNUMCLIN,          
A.HNUMCLIN - A.HNUMCLIN_ant TMMCLINUEV          
,a.HNUMCLI cli_stock_2        
,a.HNUMCLI - a.HNUMCLI_ant TMMCLISTOCK        ,
case when c.avance_meta=0 then 0 else a.HNUMCLIN / c.avance_meta end Percent_Cumpl_clinuevo,
case when c.hvalvar=0 then 0 else a.HNUMCLIN / c.hvalvar end percent_avance_hoy_cli_nevo
from cte_a a          
left join #MetaProductividad b            
--inner join #MetaProductividad b  --select * from #MetaProductividad          
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel       
left join #MetaClientesnuevos c
on a.HTIPCOD=c.HTIPCOD and a.HCODREL=c.hcodrel
left join (select * from  #MetaProductividadAsesor where htipcod=2) d
on a.HTIPCOD=d.HTIPCOD and a.HCODREL=d.HCODREL
),          
cte_c as (          
select a.*,case when b.hvalvar_134=0 then  0 else a.tick_prom_2 / b.hvalvar_134 end  percent_avance_ticket ,          
case when b.hvalvar_133=0 then 0 else a.mont_dese_2 / b.hvalvar_133 end  percent_avance_montode          
,case when b.hvalvar_10062=0 then 0 else a.TMMCLISTOCK / b.hvalvar_10062 end  percent_avance_cli_stock      
,b.hvalvar_136  ,b.hvalvar_9000 ,b.hvalvar_8070,b.hvalvar_134,b.hvalvar_133,b.hvalvar_10062 , b.hvalvar_166,
case when b.hvalvar_166=0 then 0 else a.HNUMCLIN / b.hvalvar_166  end percent_avance_cli_nuevos,
b.hvalvar_10256,a.HVSALVIGMN - b.hvalvar_10256 distdiariacartvig , --
b.hvalvar_10255, case when b.hvalvar_10255=0 then 0 else a.mont_dese_2 / b.hvalvar_10255 end percentcumpldesembolsometadi,
b.hvalvar_10257 , a.TMMCLISTOCK - b.hvalvar_10257 var_distancia_metadi
from cte_b a          
left join #Metas b          
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel          
),    
CTE_D AS (    
SELECT A.*,B.HSALVIGEN,B.HSALNOVIG,isnull(B.HRODAM,0)HRODAM ,b.TMMSALVIGE,b.TMMHSALNOVIG,b.TMMRODAMIENTO   
FROM CTE_C  A    
LEFT JOIN storage.COM_ACT.WRODASAL001 B    
ON A.HTIPCOD=case when b.HTIPCOD=1 then 2 else B.HTIPCOD end AND A.HCODREL=B.HCODREL    
)    
select * into #Temp_1 from CTE_D order by style desc          

if @tip_cod=17
begin
select 
htipcod,
descripcion,style,sum(prod_ind)prod_ind,sum(Percent_Cumpl)Percent_Cumpl,
sum(prod_ind_ant) prod_ind_ant,sum(TMMPROD)TMMPROD,sum(percent_avance_hoy)percent_avance_hoy,
sum(tick_prom_2)tick_prom_2 , sum(TMM_TICK)TMM_TICK, sum(mont_dese_2)mont_dese_2,sum(TMMDESEMB)TMMDESEMB,
sum(tapp_mes_2)tapp_mes_2,sum(TMMTAPP)*10000 TMMTAPP,sum(HVSALVIGMN)HVSALVIGMN,sum(sal_vig_2)sal_vig_2,sum(TMMSALVIG)TMMSALVIG,
sum(HNUMCLIN)HNUMCLIN,sum(TMMCLINUEV)TMMCLINUEV,sum(cli_stock_2)cli_stock_2,sum(TMMCLISTOCK)TMMCLISTOCK,
sum(percent_avance_ticket)percent_avance_ticket,sum(percent_avance_montode)percent_avance_montode,
sum(percent_avance_cli_stock)percent_avance_cli_stock,
sum(hvalvar_136)hvalvar_136,sum(hvalvar_9000)hvalvar_9000,sum(hvalvar_8070) hvalvar_8070,suM(hvalvar_134)hvalvar_134,suM(hvalvar_133)hvalvar_133,
suM(hvalvar_10062)hvalvar_10062,sum(hvalvar_166)hvalvar_166,
sum(percent_avance_cli_nuevos) percent_avance_cli_nuevos, sum(Percent_Cumpl_clinuevo) Percent_Cumpl_clinuevo,

sum(HSALVIGEN)HSALVIGEN,sum(HSALNOVIG)HSALNOVIG,sum(isnull(HRODAM,0))HRODAM,sum(TMMSALVIGE)TMMSALVIGE,sum(TMMHSALNOVIG)TMMHSALNOVIG,sum(TMMRODAMIENTO)TMMRODAMIENTO
, sum(isnull(mont_dese_2,0)) - sum(isnull(HVSALVIGMN,0))  - sum(isnull(HRODAM,0)) Canc_vigente,
sum(hvalvar_10256) hvalvar_10256,sum(distdiariacartvig) distdiariacartvig,
sum(hvalvar_10255) hvalvar_10255 , sum(percentcumpldesembolsometadi) percentcumpldesembolsometadi,
sum(hvalvar_10257) hvalvar_10257,sum(TMMCLISTOCK) - sum(hvalvar_10257) var_distancia_metadi,
CASE 
        WHEN sum(Percent_Cumpl) >= 1.0 THEN 'green'
        WHEN sum(Percent_Cumpl) >= 0.8 THEN 'yellow'
        ELSE 'red'
    END AS Color_Cumplimiento,
case 
when sum(Percent_Cumpl_clinuevo) >=1.0 then 'green'
when sum(Percent_Cumpl_clinuevo) >=0.8 then 'yellow'
else 'red'
end as color_cumplimiento_clinuevo
into #PreAsesor
from #Temp_1 
group by htipcod,
descripcion,style
order by style desc  ,descripcion ASC         


declare @metavarvigenteCoordinacion float ,@metadiariasalvigente float 
declare @metadesemcoordinacion float,@metadesemdiario float
set @metavarvigenteCoordinacion =(select hvalvar_9000 from #PreAsesor where style=1)
set @metadiariasalvigente =(select hvalvar_10256 from #PreAsesor where style=1)
set @metadesemcoordinacion =(select hvalvar_133  from #PreAsesor where style=1)
set @metadesemdiario =(select hvalvar_10255 from #PreAsesor where style=1)


update a
set a.hvalvar_10256= (case when @metavarvigenteCoordinacion=0 then  0 else hvalvar_9000 / @metavarvigenteCoordinacion end) * isnull(@metadiariasalvigente,0)
,a.hvalvar_10255 =(case when @metadesemcoordinacion=0 then 0 else hvalvar_133/ @metadesemcoordinacion end) *  @metadesemdiario
from #PreAsesor a   --select * from #PreAsesor
where htipcod=2

update a ---piero
 set a.distdiariacartvig= a.HVSALVIGMN - a.hvalvar_10256, 
 percentcumpldesembolsometadi= case when hvalvar_10255=0 then 0 else mont_dese_2 / hvalvar_10255 end 
from #PreAsesor a
where htipcod=2

select * from #PreAsesor order by style desc  ,descripcion ASC 
           

end
else
begin
select *,(isnull(mont_dese_2,0) - isnull(HVSALVIGMN,0) - isnull(HRODAM,0))  Canc_vigente ,
CASE 
        WHEN Percent_Cumpl >= 1.0 THEN 'green'
        WHEN Percent_Cumpl >= 0.8 THEN 'yellow'
        ELSE 'red'
    END AS Color_Cumplimiento,
CASE 
        WHEN Percent_Cumpl_clinuevo >= 1.0 THEN 'green'
        WHEN Percent_Cumpl_clinuevo >= 0.8 THEN 'yellow'
        ELSE 'red'
    END AS Color_Cumplimiento

from #Temp_1 
order by style desc  ,HCODREL ASC   
end

END
