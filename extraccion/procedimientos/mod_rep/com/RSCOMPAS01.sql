-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:10.310000
--EXEC MOD_REP.[com].[RSCOMPAS01] 7,'231','20260528'          
CREATE PROCEDURE [com].[RSCOMPAS01] --drop procedure com.RSGETCOM01_          
@tipcod varchar(5), @codrel varchar(25), @Fecha DATE          
AS          
BEGIN          
SET NOCOUNT ON;     

select '' 

--DECLARE @tipcod INT=7,@codrel VARCHAR(250)='231',@Fecha DATE='20260527'
--DECLARE @tipcod INT=21,@codrel VARCHAR(250)='1',@Fecha DATE='20260527'
----------------------------------------------------------------
create table #Fec (RORD int, RFEC DATE)
declare @fecs varchar(max) 
declare @dayAnt date=(select DATEADD(day, -1, @Fecha)) 
;with cte_a as (
SELECT case when rord=3 then 4 else rord end rord, rfec FROM storage.util.FVECFEC01(@Fecha,'cmg_3,cmg_5,cmg_6')  
union all
SELECT 3,rfec FROM storage.util.FVECFEC01(@dayAnt,'cmg_6')  
)
insert into #Fec  --select *f
select * from cte_a order by 1 asc 

declare @feccons date
set @feccons =(select rfec from #Fec where rord=4)

select @fecs=string_agg(convert(varchar(10),RFEC,112),',')  
from #Fec  

       
select distinct @tipcod HTIPCOD,case when @tipcod=7 then CAST(RCODFC AS varchar(250))                
            when @tipcod=21 then CAST(RCODGRU AS varchar(250))                
   when @tipcod=20 then CAST(RCODTER AS varchar(250))                
   when @tipcod=19 then CAST(RCODCOR AS varchar(250))                
   when @tipcod=18 then CAST(RCODUNI AS varchar(250))                
   when @tipcod=17 then CAST(RCODUCO AS varchar(250))                
  END HCODREL,                
    case when @tipcod=7 then RDESFC                
            when @tipcod=21 then RDESGRU                
   when @tipcod=20 then RDESTER                
   when @tipcod=19 then RDESCOR                
   when @tipcod=18 then RDESUNI                
   when @tipcod=17 then RDESUCO                
  END HCODRELDES,'1' nivel                
into #Jerar                
from storage.ref.WJERCOR03                 
where rfecpro=@feccons and rindfec='actual'                
union all                
                
select  distinct CASE WHEN @tipcod=7 THEN 21                 
     WHEN @tipcod=21 THEN 20                
     WHEN @tipcod=20 THEN 19                
     WHEN @tipcod=19 THEN 18                
     WHEN @tipcod=18 THEN 17                
     WHEN @tipcod=17 THEN 2                
   END HTIPCOD,                
                
   case when @tipcod=7 then CAST(RCODGRU AS varchar(250))                
            when @tipcod=21 then CAST(RCODTER  AS varchar(250))                
   when @tipcod=20 then CAST(RCODCOR  AS varchar(250))                
   when @tipcod=19 then CAST(RCODUNI  AS varchar(250))                
   when @tipcod=18 then CAST(RCODUCO  AS varchar(250))                
   when @tipcod=17 then CAST(RCODSEC  AS varchar(250))                
  END HTIPCOD,                
    case when @tipcod=7 then  RDESGRU                
            when @tipcod=21 then RDESTER                
   when @tipcod=20 then RDESCOR                
   when @tipcod=19 then RDESUNI                
   when @tipcod=18 then RDESUCO              
   when @tipcod=17 then RDESSEC                
  END HTIPCOD,'2' nivel                
                
from storage.ref.WJERCOR03                 
where rfecpro=@feccons and rindfec='actual'       

declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)  
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL  
  
insert into @tvars  
values ('mon_desem_sf2', null, 'DESEM', null, null, null),   
        ('sal_cap', null, 'CAP', null, null, null) 
  
insert into @tfil values ('todos', 'fec', @fecs)  
insert into @tconf values ('level_alias', 'style'),  ('fec_corr','true') ,('insert_to', '#ProdT')  
  
insert into @tfil  
exec [piv].[GPIVLEV01] @tipcod,@codrel,@jerar output  
  
  create table #ProdT    --select * from #ProdTip1                
(                  
    fila int,                  
    cod_fc varchar(250)null,                  
 cod_ugru varchar(250)null,                
    style int null,                  
    descripcion varchar(250)null,  
	CAP_1 float null,
	CAP_2 float null,
	CAP_3 float null,
	CAP_4 float null,
	DESEM_1	float null,
	DESEM_2	float null,
	DESEM_3	float null,
	DESEM_4 float null
	)
	 
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1      
  

 
select cod_fc,cod_ugru,style,descripcion,CAP_4,CAP_4 - CAP_1 var_cap_anual,CAP_4 - CAP_2 var_cap_mes,CAP_4 - CAP_3 var_cap_dia,
		DESEM_4 des_dia, DESEM_2 des_mes ,
		 iif(cod_ugru is null,@tipcod,iif(@tipcod=7,21,iif(@tipcod=17,2,@tipcod-1)))_tipcod 
into #ProdT_
from #ProdT

 select HFECPRO,case when HTIPCOD=1 then 2 else HTIPCOD end HTIPCOD,HCODREL,HFECPRO descripcion,HNUMCLI  num_cli             
  into #wjas001                 
  from storage.com_act.WJAS001 where hfecpro=@feccons  

 select b.HTIPCOD,b.hcodrel,a.*                 
into #ProdT__                
from #ProdT_ a   --select * from #ProdT              
left join #Jerar b  --SELECT * FROM #ProdT__  SELECT * FROM #ProdTip1                
on a.descripcion=b.HCODRELDES            

select a.*,saldo_ahorro_hoy,Var_Ahorro_Anual,Var_Ahorro_Mes,Var_Ahorro_Dia,hsaldmedio,
Var_Saldo_Medio_Mes,fondeoestable,var_fondeoestable,HTIPNUMDOC,N_Enrolados_Activos,
N_Pago_Creditos_App,N_Operaciones_QR,N_Operaciones_Plin_Contacto,C.num_cli
from #ProdT__ a  ---select * from #ProdT__          
join  STORAGE.COM_ACT.WRCOMPASDIG01 b  
on a.HTIPCOD=b.HTIPCOD and case when  a._tipcod=7 then '231' else a.HCODREL end =b.HCODREL    
join  #wjas001 C
  on a.HTIPCOD=C.HTIPCOD and case when  a._tipcod=7 then '231' else a.HCODREL end =C.HCODREL  
ORDER BY STYLE DESC,cod_ugru ASC
END
