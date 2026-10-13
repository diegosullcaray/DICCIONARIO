-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:11.900000
--exec mod_rep.com.RSDEPGSOLID01 7,'231','20260404'   
CREATE PROCEDURE [com].[RSDEPGSOLID01]        
@tip_cod int,@cod_rel varchar(20),@fec date           
AS              
BEGIN          
 SET NOCOUNT ON;

 set @tip_cod=case when @tip_cod in(7,21,20) then '20' else @tip_cod end
 set @cod_rel =case when @cod_rel in('231','2','2_12') THEN '2_12' ELSE @cod_rel END
--declare @codrel varchar(25)='2_12', @Fecha date='20260305', @tipcod varchar(5)='20'          
declare @fecs varchar(max)          
          
select *          
into #FECS     --drop table #FECS     
from storage.util.FVECFEC01(@fec,'cmg_6')          
          
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')          
from #FECS          

declare @headers varchar(max)                    
select @headers  ='[                     
   { "label":"Descripción","key":"descripcion","sticky": "true","cellStyle":{"text-align":"left","max-width":"190px","min-width":"190px","width":"190px","cursor":"pointer","text-decoration": "underline"}},                    
   { "label":"Indicadores de Cartera",
   "subs":[ {"label": "Saldo Vigente","key":"sal_vig_bs","format": {"type":"integer"}} ,               
            {"label": "Mto. Desembolsado","key":"mod_desem_bs","format": {"type":"integer"}},
			{"label": "Ticket Promedio","key":"tick_prom_bs","format": {"type":"integer"}},
			{"label": "N° Clientes","key":"cont_cli_gr_bs","format": {"type":"integer"}},
			{"label": "TAPP Mes","key":"tapp_mes_bs","format": {"type":"decimal"}},
			{"label": "N° Grupo","key":"cont_gr_bs","format": {"type":"integer"}} ]},
			
   { "label":"Variables de Renovación",
   "subs":[ {"label": "Grupos Base Inicial","key":"bs_base_grup","cellStyle":{"text-align":"right"}},              
		    {"label": "Renovados","key":"bs_renovar_grup","cellStyle":{"text-align":"right"}},
			{"label": "Por Renovar","key":"bs_porrenovar_grup","cellStyle":{"text-align":"right"}},
			{"label": "Vencidos","key":"bs_venci_grup","cellStyle":{"text-align":"right"}},
			{"label": "Vencen Hoy","key":"bs_venci_hoy_grup","cellStyle":{"text-align":"right"}}]}, 

    { "label":"Indicadores de Efectividad y Pago",
   "subs":[ {"label": "Pago Puntual","key":"efec_sal_pag_bs_m0","format": {"type":"percent"},"cellStyle":{"text-align":"right"}},              
		    {"label": "Efect. -30 a 0","key":"efec_bs_m30_0","format": {"type":"percent"},"cellStyle":{"text-align":"right"}},
			{"label": "Efect. 1 a 30","key":"efec_bs_1_30","format": {"type":"percent"},"cellStyle":{"text-align":"right"}}]} 
			] '                        
               
              
select @headers  
          
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)          
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL          
          
insert into @tvars          
values ('sal_vig_bs', null, null, null, null, null),          
        ('mod_desem_bs', null, null, null, null, null),          
        ('tick_prom_bs', null, null, null, null, null),          
        ('tapp_mes_bs', null, null, null, null, null),          
        ('cont_gr_bs', null, null, null, null, null),          
        ('cont_cli_gr_bs', null, null, null, null, null),
		('conteo_ant_cli_nuev', null, null, null, null, null),
		('conteo_ant_cli_recurr', null, null, null, null, null),
		('conteo_ant_cli_repre', null, null, null, null, null),
		('bs_base_grup', null, null, null, null, null) ,
		('bs_venci_grup', null, null, null, null, null) ,
		('bs_venci_hoy_grup', null, null, null, null, null) ,
		('bs_porrenovar_grup', null, null, null, null, null) ,
		('bs_renovar_grup', null, null, null, null, null) 
		--,
		--('efec_bs_1_30', null, null, null, null, null),
		--('efec_bs_m30_0', null, null, null, null, null),		
		--('efec_sal_pag_bs_m0', null, null, null, null, null)
          
insert into @tfil values ('todos', 'fec', @fecs)          
insert into @tconf values ('level_alias', 'style'),('insert_to', '#DESS')          
          
insert into @tfil          
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output          

create table #DESS --select * from #DES
(
fila int null,cod_fc varchar(250) null,cod_ugru varchar(250)null,cod_uter varchar(250),
cod_fec varchar(50)null, style int null,
descripcion varchar(250) null,
sal_vig_bs float null,
mod_desem_bs float null,
tick_prom_bs float null,
tapp_mes_bs float null,
cont_gr_bs int null,
cont_cli_gr_bs int null,
conteo_ant_cli_nuev int null,
conteo_ant_cli_recurr int null,
conteo_ant_cli_repre int null,
bs_base_grup int null,
bs_venci_grup int null,
bs_venci_hoy_grup int null,
bs_porrenovar_grup int null,
bs_renovar_grup int null

--,efec_bs_1_30 float null,
--efec_bs_m30_0 float null,
--efec_sal_pag_bs_m0 float null

)
          
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf--,@show_query=1          
 
delete from @tvars where TKEYVAR in(
'sal_vig_bs','mod_desem_bs','tick_prom_bs','tapp_mes_bs','cont_gr_bs','cont_cli_gr_bs','conteo_ant_cli_nuev','conteo_ant_cli_recurr','conteo_ant_cli_repre',
'bs_base_grup','bs_venci_grup','bs_venci_hoy_grup','bs_porrenovar_grup','bs_renovar_grup')

delete from @tconf where TKEYPROP='insert_to'
 
insert into @tvars   values
('efec_m30_0', null, 'efec_bs_1_30', null, null, null),--Efectividad -30-0d        efec_m30_0  
('efec_sal_pag_m0', null, 'efec_bs_m30_0', null, null, null),  
('efec_1_30', null, 'efec_sal_pag_bs_m0', null, null, null) 

insert into @tconf values ('insert_to', '#DES_')      

create table #DES_ --select * from #DES
(
fila int null,cod_fc varchar(250) null,cod_ugru varchar(250)null,cod_uter varchar(250),
cod_fec varchar(50)null, style int null,
descripcion varchar(250) null,
efec_bs_1_30_GRUPAL_24 float null,
efec_bs_m30_0_GRUPAL_24 FLOAT NULL,
efec_sal_pag_bs_m0_24 float null
)
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars","prod_tipo","prod_com"',@config=@tconf--,@show_query=1 

select a.*,b.efec_bs_1_30_GRUPAL_24 efec_bs_1_30 ,b.efec_bs_m30_0_GRUPAL_24 efec_bs_m30_0,b.efec_sal_pag_bs_m0_24 efec_sal_pag_bs_m0
INTO #DES
from #DESS a
left join  #DES_ b
on a.cod_fc=b.cod_fc and a.cod_ugru=b.cod_ugru and a.cod_uter=b.cod_uter and a.cod_fec=b.cod_fec and a.style=b.style and a.descripcion=b.descripcion


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
where rfecpro in(select rfec from #FECS) and rindfec='actual'                  
union all                  
                  
select  distinct CASE WHEN @tip_cod=7 THEN 21                   
     WHEN @tip_cod=21 THEN 20                  
     WHEN @tip_cod=20 THEN 19                  
     WHEN @tip_cod=19 THEN 18                  
     WHEN @tip_cod=18 THEN 17                  
     WHEN @tip_cod=17 THEN 1                  
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
where rfecpro in(select rfec from #FECS) and rindfec='actual'        
 
;with cte_a as (
select *, 
--CAST(bs_renovar_grup * 100.0 / (bs_renovar_grup + bs_porrenovar_grup + bs_venci_grup + bs_venci_hoy_grup) AS DECIMAL(5,2)) AS Porcentaje_Renovados,
--    CAST(bs_porrenovar_grup * 100.0 / (bs_renovar_grup + bs_porrenovar_grup + bs_venci_grup + bs_venci_hoy_grup) AS DECIMAL(5,2)) AS Porcentaje_PorRenovar,
--    CAST(bs_venci_grup * 100.0 / (bs_renovar_grup + bs_porrenovar_grup + bs_venci_grup + bs_venci_hoy_grup) AS DECIMAL(5,2)) AS Porcentaje_Vencidos,
--    CAST(bs_venci_hoy_grup * 100.0 / (bs_renovar_grup + bs_porrenovar_grup + bs_venci_grup + bs_venci_hoy_grup) AS DECIMAL(5,2)) AS Porcentaje_VencenHoy
ISNULL(CAST(bs_renovar_grup * 100.0 / NULLIF((ISNULL(bs_renovar_grup,0) + ISNULL(bs_porrenovar_grup,0) + ISNULL(bs_venci_grup,0) + ISNULL(bs_venci_hoy_grup,0)), 0) AS DECIMAL(5,2)), 0.00) AS Porcentaje_Renovados,
    ISNULL(CAST(bs_porrenovar_grup * 100.0 / NULLIF((ISNULL(bs_renovar_grup,0) + ISNULL(bs_porrenovar_grup,0) + ISNULL(bs_venci_grup,0) + ISNULL(bs_venci_hoy_grup,0)), 0) AS DECIMAL(5,2)), 0.00) AS Porcentaje_PorRenovar,
    ISNULL(CAST(bs_venci_grup * 100.0 / NULLIF((ISNULL(bs_renovar_grup,0) + ISNULL(bs_porrenovar_grup,0) + ISNULL(bs_venci_grup,0) + ISNULL(bs_venci_hoy_grup,0)), 0) AS DECIMAL(5,2)), 0.00) AS Porcentaje_Vencidos,
    ISNULL(CAST(bs_venci_hoy_grup * 100.0 / NULLIF((ISNULL(bs_renovar_grup,0) + ISNULL(bs_porrenovar_grup,0) + ISNULL(bs_venci_grup,0) + ISNULL(bs_venci_hoy_grup,0)), 0) AS DECIMAL(5,2)), 0.00) AS Porcentaje_VencenHoy
,iif(cod_ugru is null,@tip_cod,iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1)))_tipcod  
from #DES
)
select  b.HTIPCOD htipcod,b.hcodrel,a.*   
from cte_a a
left join #Jerar b  --SELECT * FROM #ProdT__  SELECT * FROM #ProdTip1                  
on a.descripcion=b.HCODRELDES      
 

END
