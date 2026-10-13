-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-06-17 15:43:22.597000
--EXEC MOD_REP.[com].[RSSEGPAS03] 7,'231','20240615'
CREATE  PROCEDURE [com].[RSSEGPAS03]    
@tip_cod int,@cod_rel varchar(20),@fec date='20240610'
AS    
BEGIN 
set nocount on;  
--declare @fec varchar(50)='20240610',@tip_cod int =18,@cod_rel varchar(250)='1'    
----------------------------------------------------------------------------------------------------------
 
declare @TotalDH int,@ADH int,@fecMin date,@fecMax date,@Avance_Esperado float 
select @fecMin =(select MIN(RFEC) from  storage.util.FVECFEC01(eomonth(@fec),'ini-hoy|hab') A)
select @fecMax =(select MAX(RFEC) from  storage.util.FVECFEC01(eomonth(@fec),'ini-hoy|hab') A)
  
select @TotalDH=(count (*)) from storage.ref.RCALEN001  where RFEC between @fecMin and @fecMax  and RDIAFER=0 and  RDIASEM<>6
 
set @ADH =(select MAX(RORD) from storage.util.FVECFEC01((@fec),'ini-hoy|hab') A    )
set @Avance_Esperado =  (select cast(@ADH as float) / (@TotalDH))
------------              
declare @fecs varchar(max),@fec1 date,@fec2 date,@fec3 date    
select* into #FECS from storage.util.FVECFEC01(@fec,'cmg_4,cmg_5,cmg_6') --


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
 ,('fec_corr','true') ,('insert_to', '#T')                         
                  
  
 select @jer='"Prod_Seg"'   --,"prod_com"    
 
 create table #T (
 fila int null,cod_Prod_Seg varchar(250)null,style  varchar(250)null,descripcion  varchar(250)null,num_pol_pasiv_1 float null,num_pol_pasiv_2 float null,num_pol_pasiv_3  float null
 )
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1           
 ----- META -----------
 declare @fecMetaPasivo date ,@MetMA float, @MetOnco float
 set @fecMetaPasivo =(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR=10033)

declare @TM as table (Tip_cod int, tip_cod2 int)
insert into @TM values(7,18),(18,17),(17,4),(4,16)

set @MetMA =(select isnull(HVALVAR,0) from storage.com.VDMCOM01 where HFECPRO=@fecMetaPasivo and HTIPCOD=@tip_cod and HCODREL=@cod_rel and  HCODVAR =10033)
set @MetOnco =(select isnull(HVALVAR,0) from storage.com.VDMCOM01 where HFECPRO=@fecMetaPasivo and HTIPCOD=@tip_cod and HCODREL=@cod_rel and  HCODVAR =10034)
 


 ----------------------

 declare @head varchar(max)
 set @head = '[{"label":"Descripción","key":"descripcion","cellStyle":{"min-width":"250px"},"sticky":true},{"label":"Detalle","subs":[{"label":'+'"'+cast(@fec1 as varchar)+'"'+',"key":"num_pol_pasiv_1","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":'+'"'+cast(@fec2 as varchar)+'"'+',"key":"num_pol_pasiv_2","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":'+'"'+cast(@fec3 as varchar)+'"'+',"key":"num_pol_pasiv_3","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Meta","key":"meta","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"TMM","key":"TMM","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Var.Meta","key":"var_meta","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Avance Esperado","key":"Avance_Esperado","format":{"type":"percent"},"cellStyle":{"text-align":"right"}},{"label":"Var. Avance Esperado","key":"vari_ava_espe","format":{"type":"integer"},"cellStyle":{"text-align":"right"}},{"label":"Total de Ingreso","key":"Total_Ing","format":{"type":"integer"},"cellStyle":{"text-align":"right"}}]}]'

select @head
-----------------------------------

 ;with cte_a as (
 select * from #T 
 where cod_Prod_Seg in(615,616,617,618,619)
 )
 select a.*,num_pol_pasiv_3 - num_pol_pasiv_2 TMM, 
 case 
	when cod_Prod_Seg in(615,616,617) then num_pol_pasiv_3 - isnull(@MetOnco,0) 
	when cod_Prod_Seg in(618,619) then num_pol_pasiv_3 - isnull(@MetMA,0)
 end var_meta,
 @Avance_Esperado Avance_Esperado, 
 case when cod_Prod_Seg in(615,616,617) then (num_pol_pasiv_3) - (isnull(@MetOnco,0) * @Avance_Esperado) 
	  when cod_Prod_Seg in(618,619) then (num_pol_pasiv_3) - (isnull(@MetMA,0) * @Avance_Esperado)
 end vari_ava_espe,
 num_pol_pasiv_3 * HCOMIFC Total_Ing,
 case 
	when cod_Prod_Seg in(615,616,617) then ISNULL(@MetOnco,0)
	when cod_Prod_Seg in(618,619) then isnull(@MetMA,0)
 end meta
 from cte_a  a
 left join storage.[com_seg].[RETC001] b
 on a.cod_Prod_Seg=b.HCODSEG
   
--drop table #FECS,#T
     
END
