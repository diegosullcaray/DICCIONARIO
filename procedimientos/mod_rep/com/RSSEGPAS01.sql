-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-06-17 12:05:49.783000
--exec mod_rep.[com].[RSSEGPAS01] 7,'231','20240615'
CREATE  PROCEDURE [com].[RSSEGPAS01]    
@tip_cod int,@cod_rel varchar(20),@fec date='20240610'
AS    
BEGIN 
set nocount on;  
--declare @fec varchar(50)='20240610',@tip_cod int =7,@cod_rel varchar(250)='231'    
----------------------------------------------------------------------------------------------------------        
declare @fecs varchar(max),@head varchar(max),@fec1 date,@fec2 date,@fec3 date
select* into #FECS from storage.util.FVECFEC01(@fec,'cmg_4,cmg_5,cmg_6') -- select * from #FECS
 
set @fec1 =(select rfec from #FECS where RORD=1)
set @fec2 =(select rfec from #FECS where RORD=2)
set @fec3 =(select rfec from #FECS where RORD=3)

select @fecs=string_agg(convert(varchar(10),RFEC,112),',')            
from #FECS            
                  
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                        
            --exec STORAGE.[com_pas].[PSLSDPS010] '20230218'            
 insert into @tvars values                         
 ('num_pol_pasiv',null,null,null,null,null)                        
                         
 insert into @tfil                        
 values                        
 ('todos','fec',@fecs)            
                 
 --declare @tip_cod int=15,@cod_rel varchar(100)='2'                        
 declare @jer varchar(100);                      
 insert into @tfil                
 exec piv.GPIVLEV09 @tip_cod,@cod_rel,@jer output                        
                        
 insert into @tconf                        
 values                        
 ('level_alias','style')
 ,('fec_corr','true') ,('insert_to', '#T_')                         
                  
  
 --select @jer=@jer+',"Prod_Seg"'   --,"prod_com"    
 
 create table #T_ (
 fila int null,cod_fc varchar(250)null,cod_cter_seg_m varchar(250)null
 ,style  varchar(250)null,descripcion  varchar(250)null,
 [615_num_pol_pasiv_1] float null,[615_num_pol_pasiv_2] float null, [615_num_pol_pasiv_3] float null,
 [616_num_pol_pasiv_1] float null,[616_num_pol_pasiv_2] float null, [616_num_pol_pasiv_3] float null,
 [617_num_pol_pasiv_1] float null,[617_num_pol_pasiv_2] float null, [617_num_pol_pasiv_3] float null,
 [618_num_pol_pasiv_1] float null,[618_num_pol_pasiv_2] float null, [618_num_pol_pasiv_3] float null,
 [619_num_pol_pasiv_1] float null,[619_num_pol_pasiv_2] float null,[619_num_pol_pasiv_3] float null,
 [num_pol_pasiv_2] float null,[num_pol_pasiv_3] float null 
 )
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"Prod_Seg","vars","fec_corr"',@config=@tconf--,@show_query=1           

----------------------------------------------------------------------
declare @TotalDH int,@ADH int,@fecMin date,@fecMax date,@Avance_Esperado float 
select @fecMin =(select MIN(RFEC) from  storage.util.FVECFEC01(eomonth(@fec),'ini-hoy|hab') A)
select @fecMax =(select MAX(RFEC) from  storage.util.FVECFEC01(eomonth(@fec),'ini-hoy|hab') A)
  
select @TotalDH=(count (*)) from storage.ref.RCALEN001  where RFEC between @fecMin and @fecMax  and RDIAFER=0 and  RDIASEM<>6
 
set @ADH =(select MAX(RORD) from storage.util.FVECFEC01((@fec),'ini-hoy|hab') A    )
set @Avance_Esperado =  (select cast(@ADH as float) / (@TotalDH))
--------------------------------------------------------------------------------
set @head = '[{"label":"Descripción","key":"descripcion","cellStyle":{"min-width":"250px"},"sticky":true},{"label":"Oncologico Mensual","subs":[{"label":'+'"'+cast(@fec1 as varchar)+'"'+',"key":"615_num_pol_pasiv_1","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":'+'"'+cast(@fec2 as varchar)+'"'+',"key":"615_num_pol_pasiv_2","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":'+'"'+cast(@fec3 as varchar)+'"'+',"key":"615_num_pol_pasiv_3","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Meta","key":"meta_615","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"TMM","key":"TMM_615","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Var.Meta","key":"var_meta_615","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Avance Esperado","key":"AV_ESP_615","format":{"type":"percent"},"cellStyle":{"text-align":"right"}},{"label":"Var. Avance Esperado","key":"vari_ava_espe_615","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}]},{"label":"Oncologico Anual","subs":[{"label":'+'"'+cast(@fec1 as varchar)+'"'+',"key":"616_num_pol_pasiv_1","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":'+'"'+cast(@fec2 as varchar)+'"'+',"key":"616_num_pol_pasiv_2","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":'+'"'+cast(@fec3 as varchar)+'"'+',"key":"616_num_pol_pasiv_3","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Meta","key":"meta_616","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"TMM","key":"TMM_616","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Var.Meta","key":"var_meta_616","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Avance Esperado","key":"AV_ESP_616","format":{"type":"percent"},"cellStyle":{"text-align":"right"}},{"label":"Var. Avance Esperado","key":"vari_ava_espe_616","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}]}]'

select @head


declare @fecMeta date
set @fecMeta =(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR=10116)


------META---------------------
declare @TM as table (Tip_cod int, tip_cod2 int)
insert into @TM values(7,18),(18,17),(17,4),(4,16)
 
;with cte_niv1_ as (
select HFECPRO,HTIPCOD,HCODREL,HCODVAR,HVALVAR 
from storage.com.VDMCOM01 
where HFECPRO=@fecMeta and HTIPCOD=@tip_cod and HCODREL=@cod_rel and  HCODVAR=10116
),
cte_niv1 as (
select a.*,b.RDES
from cte_niv1_ a 
left join (
             select distinct
			  case when @tip_cod=7 then RCODFC
				   when @tip_cod=18 then RCODTER	
				   when @tip_cod=17 then RCODMAC
				   when @tip_cod=4 then RCODMAT
				   when @tip_cod=16 then RCODAGE
			  end RCOD,
			  case when @tip_cod=7 then RDESFC
				   when @tip_cod=18 then RDESTER	
				   when @tip_cod=17 then RDESMAC
				   when @tip_cod=4 then RDESMAT
				   when @tip_cod=16 then RDESAGE
			  end RDES
			 from storage.ref.VJERCOR04 
		   )b
on a.HCODREL=b.RCOD

),
cte_niv2_ as (
select HFECPRO,HTIPCOD,HCODREL,HCODVAR,HVALVAR
from storage.com.VDMCOM01 
where  HFECPRO=@fecMeta and HTIPCOD in(select tip_cod2 from @TM where Tip_cod=@tip_cod)
and  HCODVAR=10116
),
cte_niv2 as (
select a.*,b.RDES 
from cte_niv2_ a
left join (
             select distinct
			  case when @tip_cod=7 then RCODTER
				   when @tip_cod=18 then RCODMAC	
				   when @tip_cod=17 then RCODMAT
				   when @tip_cod=4 then RCODAGE
			  end RCOD,
			  case when @tip_cod=7 then rdester
				   when @tip_cod=18 then RDESMAC	
				   when @tip_cod=17 then RDESMAT
				   when @tip_cod=4 then RDESAGE
			  end RDES
			 from storage.ref.VJERCOR04 
		   )b
on a.HCODREL=b.RCOD
),
CTE_U  as (
select * from cte_niv1 
union all
select * from cte_niv2
)
select * INTO #M from CTE_U


select 
fila,cod_fc,cod_cter_seg_m,style,descripcion,
[615_num_pol_pasiv_1] ,[615_num_pol_pasiv_2] , [615_num_pol_pasiv_3] ,[615_num_pol_pasiv_3] - [615_num_pol_pasiv_2] TMM_615,b.HVALVAR meta_615, @Avance_Esperado AV_ESP_615,
[615_num_pol_pasiv_3] - b.HVALVAR var_meta_615,[615_num_pol_pasiv_3] -  (b.HVALVAR * @Avance_Esperado ) vari_ava_espe_615,


[616_num_pol_pasiv_1] ,[616_num_pol_pasiv_2] , [616_num_pol_pasiv_3] ,[616_num_pol_pasiv_3] - [616_num_pol_pasiv_2] TMM_616,b.HVALVAR meta_616, @Avance_Esperado AV_ESP_616,
[616_num_pol_pasiv_3] - b.HVALVAR var_meta_616 , [616_num_pol_pasiv_3] -  (b.HVALVAR * @Avance_Esperado ) vari_ava_espe_616

from #T_ a
left join #M b
on a.descripcion=b.RDES
--drop table #FECS,#T_ 
END
