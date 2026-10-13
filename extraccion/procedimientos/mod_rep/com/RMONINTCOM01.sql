-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:02.833000
--EXEC MOD_REP.com.RMONINTCOM01 7,'231','20260514'          
CREATE PROCEDURE [com].[RMONINTCOM01] --drop procedure com.RSGETCOM01_          
@tip_cod varchar(5), @cod_rel varchar(25), @Fecha DATE          
AS          
BEGIN          
SET NOCOUNT ON;   
--declare @cod_rel varchar(25)='1', @Fecha date='20260513', @tip_cod varchar(5)='21'     
---------------------------------------------
declare @fecs varchar(max) 
--drop table #FECS

select *                        
into #FECS                        
from storage.util.FVECFEC01(@fecha,'cmg_4,cmg_5,cmg_6')  

select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                        
from #FECS     


declare @fec_ date ,@fec_ant date,@fec_intr date          
set @fec_ =(select rfec from #FECS where rord=3)          
set @fec_ant =(select rfec from #FECS where rord=2)      
set @fec_intr =(select rfec from #FECS where rord=1)  

declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)                        
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL  
           
insert into @tvars                        
values ('mon_desem_sf2', null, 'mon_desem', null, null, null),       
('sal_vig',null,'sal_vig',   null, null, null),
('num_ope_sf2', null, 'num_ope', null, null, null),
('tick_prom_sf2', null, 'tick_prom', null, null, null),
('tapp_mes_sf2', null, 'tapp_mes', null, null, null),                        
('tapp_stock_ss1', null, 'tapp_stock', null, null, null)

insert into @tfil values ('todos', 'fec', @fecs)                        
insert into @tconf values ('level_alias', 'style'),('fec_corr','true') ,('insert_to', '#DES_')   

insert into @tfil                        
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output 

create table #DES_   --select * from #ProdTip1                
(                  
fila int,                  
cod_fc varchar(250)null,                  
cod_ugru varchar(250)null,                
style int null,      
descripcion varchar(250)null,
mon_desem_1 FLOAT null,mon_desem_2 FLOAT null,mon_desem_3 FLOAT null,
num_ope_1 FLOAT null,num_ope_2 FLOAT null,num_ope_3 FLOAT null,
sal_vig_1 FLOAT null,sal_vig_2 FLOAT null,sal_vig_3 FLOAT null,
tapp_mes_1 FLOAT null,tapp_mes_2 FLOAT null,tapp_mes_3 FLOAT null,
tapp_stock_1 FLOAT null,tapp_stock_2 FLOAT null,tapp_stock_3 FLOAT null,
tick_prom_1 FLOAT null,tick_prom_2 FLOAT null,tick_prom_3 FLOAT null,
HNUMCL3 int null, HNUMCLI2 INT
)
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1       


---
          
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
---


select b.HTIPCOD,b.hcodrel,fila,cod_fc,cod_ugru,style,descripcion,
sal_vig_3,sal_vig_3- sal_vig_2 varmessaldo, sal_vig_3 - sal_vig_1 varintramessaldo,cast(0 as float) metas,cast('85%' as VARCHAR(250)) cumplmetasaldo,
mon_desem_3,mon_desem_3-mon_desem_2 varmesmonto,
num_ope_3,num_ope_3 - num_ope_2 varmesProd,
tick_prom_3, tick_prom_3 - tick_prom_1 varmestick,
tapp_mes_3,(tapp_mes_3 * 100) - (tapp_mes_2*100)  varmestappmes,
--tapp_stock_2 *100 tapp_stock_2,
tapp_stock_3 ,((tapp_stock_3* 100) - (tapp_stock_2 *100))*100 varmestappstock,
1515 cliente3,0 cliente2,0 cliente1,0 cliente, 12 varmescliente,11 varintramescliente
into #F
from #DES_ a
left join #Jerar b  --SELECT * FROM #ProdT__  SELECT * FROM #ProdTip1                
on a.descripcion=b.HCODRELDES    

;with cte_a as (
select * from storage.[com].[VDMCOM01]           
where hfecpro=eomonth(@fec_) and hcodvar in(199)
),
CTE_B AS (          
select a.hfecpro,a.hcodvar,a.htipcod,a.hcodrel,a.hvalvar          
from cte_a a          
inner join #Jerar b          
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel           
)  
SELECT htipcod, hcodrel, 
[199] AS hvalvar_199 
INTO #Metas          
FROM (          
    SELECT htipcod, hcodrel, hcodvar, hvalvar          
    FROM CTE_B          
) SourceTable          
PIVOT (          
    SUM(hvalvar)          
    FOR hcodvar IN ([199])          
) AS PivotTable;     

 
update a      
set a.cliente3=b.HNUMCLI      
from #F a       
inner join (select htipcod,hcodrel,HNUMCLI from storage.com_act.WJAS001 where hfecpro=@fec_ )b --piero      
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel  

update a      
set a.cliente2=b.HNUMCLI      
from #F a       
inner join (select htipcod,hcodrel,HNUMCLI from storage.com_act.WJAS001 where hfecpro=@fec_ant )b --piero      
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel  

update a      
set a.cliente1=b.HNUMCLI      
from #F a       
inner join (select htipcod,hcodrel,HNUMCLI from storage.com_act.WJAS001 where hfecpro=@fec_intr )b --piero      
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel  

update #F set cliente=cliente3  
update #F set varmescliente= cliente3 - cliente2
update #F set varintramescliente= cliente3 - cliente1
 
--select a.*,b.hvalvar_199
--from #F a
--left join #Metas b          
--on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel  

update a
set a.metas=b.hvalvar_199 --drop table #F
from #F a 
inner join (select htipcod,hcodrel,hvalvar_199 from #Metas)b
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel  

update #f set cumplmetasaldo= case when metas=0 then '0%' ELSE CAST(CAST((sal_vig_3 / metas) * 100 AS DECIMAL(10, 2)) AS VARCHAR(50)) + '%' end

--select * from #F

--select 
--fila,cod_fc,cod_ugru,style,descripcion,
--sal_vig_3,varmessaldo,varintramessaldo,cumplmetasaldo,
--mon_desem_3,varmesmonto,
--num_ope_3,varmesProd,
--tick_prom_3,varmestick,
--tapp_mes_3,varmestappmes,
--tapp_stock_3,varmestappstock,
--cliente,varmescliente,varintramescliente 
--from #F
 -- 1. EL 'WITH' VA PRIMERO, FUERA DE CUALQUIER PARÉNTESIS
;WITH DatosFormateados AS (
    SELECT 
        style,
        descripcion AS titulo,
        -- AGREGAMOS LAS LLAVES AQUÍ
        htipcod AS tip_cod,
        hcodrel AS cod_rel,
        
        CASE 
            WHEN cod_ugru IS NULL THEN 'fc'
            WHEN cod_ugru = 1 THEN 'ind'
            WHEN cod_ugru = 2 THEN 'grp'
            ELSE 'met' 
        END AS estilo,

        -- [Omitido por brevedad: Los mismos formatos de S/, pbs y variaciones que ya tienes]
        'S/ ' + ISNULL(FORMAT(sal_vig_3 / 1000.0, 'N0'), '0') AS val_sal,
        ISNULL(CAST(cumplmetasaldo AS VARCHAR(20)), '0%') AS meta_sal,
        CASE WHEN varmessaldo >= 0 THEN 'true' ELSE 'false' END AS pos_sal_mes,
        CASE WHEN varmessaldo >= 0 THEN '+' ELSE '' END + ISNULL(FORMAT(varmessaldo / 1000.0, 'N0'), '0') AS tend_sal_mes,
        CASE WHEN varintramessaldo >= 0 THEN 'true' ELSE 'false' END AS pos_sal_intra,
        CASE WHEN varintramessaldo >= 0 THEN '+' ELSE '' END + ISNULL(FORMAT(varintramessaldo / 1000.0, 'N0'), '0') AS tend_sal_intra,
        'S/ ' + ISNULL(FORMAT(mon_desem_3 / 1000.0, 'N0'), '0') AS val_dese,
        CASE WHEN varmesmonto >= 0 THEN 'true' ELSE 'false' END AS pos_dese,
        CASE WHEN varmesmonto >= 0 THEN '+' ELSE '' END + ISNULL(FORMAT(varmesmonto / 1000.0, 'N0'), '0') AS tend_dese,
        ISNULL(FORMAT(num_ope_3, 'N0'), '0') AS val_prod, 
        CASE WHEN varmesProd >= 0 THEN 'true' ELSE 'false' END AS pos_prod,
        CASE WHEN varmesProd >= 0 THEN '+' ELSE '' END + ISNULL(FORMAT(varmesProd, 'N0'), '0') AS tend_prod,
        'S/ ' + ISNULL(FORMAT(tick_prom_3, 'N0'), '0') AS val_tick,
        CASE WHEN varmestick >= 0 THEN 'true' ELSE 'false' END AS pos_tick,
        CASE WHEN varmestick >= 0 THEN '+' ELSE '' END + ISNULL(FORMAT(varmestick, 'N0'), '0') AS tend_tick,
        ISNULL(FORMAT(cliente, 'N0'), '0') AS val_cli, 
        CASE WHEN varmescliente >= 0 THEN 'true' ELSE 'false' END AS pos_cli_mes,
        CASE WHEN varmescliente >= 0 THEN '+' ELSE '' END + ISNULL(FORMAT(varmescliente, 'N0'), '0') AS tend_cli_mes,
        CASE WHEN varintramescliente >= 0 THEN 'true' ELSE 'false' END AS pos_cli_intra,
        CASE WHEN varintramescliente >= 0 THEN '+' ELSE '' END + ISNULL(FORMAT(varintramescliente, 'N0'), '0') AS tend_cli_intra,
        ISNULL(FORMAT(tapp_mes_3 * 100, 'N2'), '0.00') AS tapp_mes_val,
        CASE WHEN varmestappmes >= 0 THEN 'true' ELSE 'false' END AS tapp_mes_pos,
        CASE WHEN varmestappmes >= 0 THEN '+' ELSE '' END + ISNULL(FORMAT(varmestappmes, 'N0'), '0') + ' pbs' AS tapp_mes_tend,
        ISNULL(FORMAT(tapp_stock_3 * 100, 'N2'), '0.00') AS tapp_stock_val, 
        CASE WHEN varmestappstock >= 0 THEN 'true' ELSE 'false' END AS tapp_stock_pos,
        CASE WHEN varmestappstock >= 0 THEN '+' ELSE '' END + ISNULL(FORMAT(varmestappstock, 'N0'), '0') + ' pbs' AS tapp_stock_tend
        
    FROM #F
)

-- 2. ENVOLTORIO
SELECT CAST((
    SELECT 
	style,
        titulo,
        estilo,
        -- INCLUIMOS LAS LLAVES EN EL JSON RESULTANTE
        tip_cod,
        cod_rel,
        
        JSON_QUERY(
            CAST(
                '[' +
                    -- [Tus 6 tarjetas configuradas exactamente como las tienes]
                    '{"tipo":"estandar","label":"SALDO VIGENTE","valor":"'+val_sal+'","tendencias":[{"valor":"'+tend_sal_mes+'","subLabel":"mes ant.","esPositivo":'+pos_sal_mes+'},{"valor":"'+tend_sal_intra+'","subLabel":"intrames","esPositivo":'+pos_sal_intra+'}],"meta":{"label":"CUMPLIMIENTO DE META","porcentaje":"'+meta_sal+'"}},' +
                    '{"tipo":"estandar","label":"DESEMBOLSO","valor":"'+val_dese+'","tendencias":[{"valor":"'+tend_dese+'","subLabel":"vs mes anterior","esPositivo":'+pos_dese+'}]},' +
                    '{"tipo":"estandar","label":"PRODUCTIVIDAD","valor":"'+val_prod+'","tendencias":[{"valor":"'+tend_prod+'","subLabel":"vs mes anterior","esPositivo":'+pos_prod+'}]},' +
                    '{"tipo":"estandar","label":"TICKET","valor":"'+val_tick+'","tendencias":[{"valor":"'+tend_tick+'","subLabel":"vs mes anterior","esPositivo":'+pos_tick+'}]},' +
                    '{"tipo":"estandar","label":"CLIENTE","valor":"'+val_cli+'","tendencias":[{"valor":"'+tend_cli_mes+'","subLabel":"mes ant.","esPositivo":'+pos_cli_mes+'},{"valor":"'+tend_cli_intra+'","subLabel":"intrames","esPositivo":'+pos_cli_intra+'}]},' +
                    '{"tipo":"tapp","label":"TAPP","items":[{"label":"Mes","valor":"'+tapp_mes_val+'","tendencia":"'+tapp_mes_tend+'","esPositivo":'+tapp_mes_pos+'},{"label":"Stock","valor":"'+tapp_stock_val+'","tendencia":"'+tapp_stock_tend+'","esPositivo":'+tapp_stock_pos+'}]}' +
                ']' 
            AS NVARCHAR(MAX))
        ) AS tarjetas
        
    FROM DatosFormateados
    ORDER BY style DESC--, titulo ASC
    FOR JSON PATH
) AS NVARCHAR(MAX)) AS headers;
SELECT 'HOLA' A
end
