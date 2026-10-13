-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-02-27 18:51:48.220000
--exec [com].[RSRDFCA029]  7,'231'
CREATE procedure [com].[RSRDFCA029]  
@tip_cod int,@cod_rel varchar(50)
 /*(@cod_rel varchar(50),@p_fecha date, @tip_cod int, @TIPMETA int = 1, @jer smallint = 1)    
  */
 AS    
BEGIN    
 SET NOCOUNT ON;    

 declare @p_fecha date
 select @p_fecha=max(HFECPRO) from [storage].[com_act].[HCDA001]       
 
  declare @defs as rep.TTHCOLDEF;   

insert into @defs            
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH,THIDDEN)  values            
 (1,1,1,'variable','Descripción',null,2,1,'string',null,null,null),            
 (2,1,null,'Monto_Desembolsado','Monto Desembolsado',2,null,null,null,null,null,null),            
 (3,1,null,'Operaciones_Desembolsadas','Operaciones Desembolsadas',2,null,null,null,null,null,null),  
 
            
 (7,2,2,'des_diario','Diario',null,null,null,'number','.0-0',null,null),            
 (8,2,3,'des_mensual','Mensual',null,null,null,'number','.0-0',null,null),   
 (9,2,4,'ope_diario','Diario',null,null,null,'number','.0-0',null,null),   
 (10,2,5,'ope_mensual','Mensual',null,null,null,'number','.0-0',null,null)        
            
  select rep.FFTHCOLDEF(@defs) result;   
   
 /*  
declare    
 @cod_rel varchar(50)='1',@p_fecha date='20220609', @tip_cod int=21, @TIPMETA int = 1, @jer smallint = 2    
 */  
 ---  
 declare @fecs nvarchar(max)  
 select  RFEC SFECPRO    
 into  #FECHASDES    
 from  storage.[ref].[RCALEN001]     
 where  RFEC between EOMONTH(@p_fecha,-12) and eomonth(@p_fecha,-1) and RCIEBT=1    
 order by 1    
    
select @fecs=string_agg(convert(varchar(10),SFECPRO,112),',')  
from #FECHASDES  
  
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF  
  
 insert into @tvars values       
 ('Num_Ope_DDiario_flujo',null,null,null,null,null),  
 ('Monto_DDiario_flujo_flujo',null,null,null,null,null)   
       
 insert into @tfil      
 values      
 ('todos','fec',@fecs)--,      
  
 insert into @tconf      
 values      
 ('level_alias','style'),  
 --('insert_to','#report'),  
 ('fec_corr','true')  
  
  
 declare @jera varchar(100)  
 insert into @tfil      
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jera output     
  
 select @jera = '"fec_dese"'+ ',' +@jera   
     
 create table #SDAF001 (fila int null,fec varchar(50) null,cod varchar(50)null,cod_u varchar(250) null,style int null,descripcion varchar(250)null,num_ope int null,SMONDESMN float null)  
   
 insert into #SDAF001 --drop table #SDAF001  
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jera,@columns='"vars"',@config=@tconf--,@show_query=1      
      
 delete from #SDAF001 where style<>1  
  
;with cte_desem_ini_mes as (  
select eomonth(fec) SFECPRO,  
    sum(SMONDESMN) SMONDESMN,sum(num_ope) SNUMOPE     
from  #SDAF001    
group by eomonth(fec)   
),  
cte_desem_mensual    
as    
(    
select  cast(round(AVG(SMONDESMN),0) as float) AVGSMONDESMN,cast(round(AVG(SNUMOPE),0) as float)AVGSNUMOPE,cast(round(MIN(SMONDESMN),0) as float) MINSMONDESMN    
   ,cast(MIN(SNUMOPE) as float) MINSNUMOPE,cast(round(MAX(SMONDESMN),0)as float) MAXSMONDESMN,cast(MAX(SNUMOPE) as float) MAXSNUMOPE    
from  cte_desem_ini_mes    
),cte_desem_ini_diario    
as(    
select  A.fec,sum(SMONDESMN) SMONDESMN,sum(num_ope) SNUMOPE    
from  #SDAF001 A   --select * from #SDAF001  
group by A.fec    
),    
cte_desem_diario    
as(    
select cast(round(AVG(SMONDESMN),0) as float) AVGSMONDESMN,  
    cast(round(AVG(SNUMOPE),0) as float)AVGSNUMOPE,  
    cast(round(MIN(SMONDESMN),0) as float) MINSMONDESMN,  
    cast(MIN(SNUMOPE) as float) MINSNUMOPE,  
    cast(round(MAX(SMONDESMN),0) as float) MAXSMONDESMN,  
    cast(MAX(SNUMOPE) as float) MAXSNUMOPE    
from  cte_desem_ini_diario    
)  ,    
cte_desem_diario_final    
as    
(    
select  variables,valores    
from  cte_desem_diario    
unpivot (valores for variables in (AVGSMONDESMN,AVGSNUMOPE,MINSMONDESMN,MINSNUMOPE,MAXSMONDESMN,MAXSNUMOPE)) upvt    
)    
,    
cte_desem_mensual_final    
as    
(    
select  variables,valores    
from  cte_desem_mensual    
unpivot (valores for variables in (AVGSMONDESMN,AVGSNUMOPE,MINSMONDESMN,MINSNUMOPE,MAXSMONDESMN,MAXSNUMOPE)) upvt    
)    
,    
cte_orden_monto    
as(    
select 'AVGSMONDESMN' variables,1 orden    
UNION    
select 'MINSMONDESMN' ,2     
UNION    
select 'MAXSMONDESMN' ,3    
),    
cte_orden_ope    
as(    
select 'AVGSNUMOPE' variables,1 orden    
UNION    
select 'MINSNUMOPE' ,2     
UNION    
select 'MAXSNUMOPE' ,3    
)    
select  case when A.variables='AVGSMONDESMN' then 'Promedio últimos 12 meses'    
    when A.variables='MINSMONDESMN' then 'Mínimo últimos 12 meses'     
    when A.variables='MAXSMONDESMN' then 'Máximo últimos 12 meses' end variable    
   ,B.valores des_diario,C.valores des_mensual,E.valores ope_diario,F.valores ope_mensual    
from  cte_orden_monto A    
left join cte_desem_diario_final B    
on   A.variables=B.variables    
left join cte_desem_mensual_final C    
on   A.variables=C.variables    
left join cte_orden_ope D    
on   A.orden=D.orden    
left join cte_desem_diario_final E    
on   D.variables=E.variables    
left join cte_desem_mensual_final F    
on   D.variables=F.variables    
order by A.orden    
     
end
