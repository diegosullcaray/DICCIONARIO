-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:25.987000
--exec mod_rep.[com].[RSRDFCA050_4] 7,'231','20250414','TODOS'     
CREATE procedure [com].[RSRDFCA050_4]  --drop procedure [com].[RSRDFCA050_4]                      
@tip_cod nvarchar(50),@cod_rel varchar(50),@fec date,                
@prod varchar(250)                
as                
begin                
 SET NOCOUNT ON;          
 declare  @tipmet INT=1    
--declare  @tipmet INT=1,@tip_cod int=7,@cod_rel varchar(50) ='231',@prod varchar(250)='TODOS' --'Agua y Saneamiento' --'TODOS'                   
   declare @p_fecha date,@fec_i date,@flag bit,@hor varchar(2),@TIPMETA int,@indcan int=0                   
                        
 select @p_fecha=max(HFECPRO) from [storage].[com_act].[HCDA001]                        
 select @fec_i=max(SFECPRO) from [storage].[com_act].[SDAS010]                        
 select @flag=case when @fec_i>@p_fecha then 1 else 0 end                        
 select @p_fecha=case when @fec_i>@p_fecha then @fec_i else @p_fecha end                        
 select @hor=max(SHORPRO) from   [storage].[com_act].[SDAS010] where SFECPRO=@p_fecha                   
 set @TIPMETA=@tipmet                  
       
   /*    
 declare @defs as rep.TTHCOLDEF;                     
                  
insert into @defs                              
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH,THIDDEN)  values                              
 (1,1,1,'meta_Anual','Meta Anual',null,1,1,'number','.0-0',null,null),                              
 (2,1,2,'num_ope','Real',1,1,1,'number','.0-0',null,null),                              
 (2,1,2,'cumpl','% Cumpl.',1,1,1,'percent','.2-2',null,null),      
 (2,1,2,'met_requerido','% Requerido',1,1,1,'percent','.2-2',null,null)      
      
  select rep.FFTHCOLDEF(@defs) result;     */          
      
declare @headers varchar(max)                    
  select @headers  ='[                     
   { "label":"Meta Anual","key":"meta_Anual","format":{"type":"integer"}},               
   { "label":"Real","key":"num_ope","format":{"type":"integer"}},             
   { "label":"% Cumpl.","format":{"type":"percent"},"key":"cumpl","cellStyle":{"text-align":"center","min-width":"50px"}},                    
   { "label":"% Requerido","format":{"type":"percent"},"key":"met_requerido","cellStyle":{"text-align":"center","min-width":"50px"}}]'       
    
       
    
 select @headers                 
     
 declare @p_fecha1 date                                
                                  
 select @p_fecha1=MAX(SFECPRO) from storage.[com_act].[SDAF001] where SFECPRO<=@p_fecha                              
                            
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                            
                            
 insert into @tvars values                                 
 ('Num_Ope_DDiario_flujo',null,null,null,null,null),                            
 ('Monto_DDiario_flujo_flujo',null,null,null,null,null)                             
                                 
 insert into @tfil                  --select * from storage.com_act.RETP006  select * from storage.com_act.RETP010              
 values                                
 ('todos','fec','"'+cast(replace(@p_fecha1,'-','') as varchar(250))+'"')--,                                
                            
 insert into @tconf                                
 values                                
 ('level_alias','style'),                            
 ('insert_to','#SDAF001_Prev'),                            
 ('fec_corr','true')                            
                            
                            
 declare @jera varchar(100)                            
 insert into @tfil                                
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jera output                               
                            
 --select @jera = '"fec_dese"'+',"prod_mis_com"'+ ',' +@jera                     
 select @jera = '"fec_dese"'+ ',' +@jera                    
 create table #SDAF001_ (fila int null,fec varchar(50) null,cod varchar(50)null,cod_u varchar(250) null,style int null,descripcion varchar(250)null,                
 SMONDESMN_agua float null,num_ope_agua int null,                
 SMONDESMN_crededu float null,num_ope_crededu int null,                
 SMONDESMN_empmuj float null,num_ope_empmuj int null,                
 Monto_DDiario_flujo_flujo float null,                
 Num_Ope_DDiario_flujo  float null  ,              
 SMONDESMN_ProdVerde float null,num_ope_ProdVerde int null                
 )                     
 create table #SDAF001_Prev(            
 fila int null,cod_fec_dese varchar(250)null,cod_fc varchar(250)null,cod_ugru varchar(250)null,style int null,descripcion varchar(250)null,            
 [Agua y Saneamiento_Monto_DDiario_flujo_flujo] float null,[Agua y Saneamiento_Num_Ope_DDiario_flujo] float null,            
 [Crédito Educativo_Monto_DDiario_flujo_flujo] float null,[Crédito Educativo_Num_Ope_DDiario_flujo] float null,            
 [Emprendimiento Mujer_Monto_DDiario_flujo_flujo]float null,[Emprendimiento Mujer_Num_Ope_DDiario_flujo] float null,            
 [Monto_DDiario_flujo_flujo] float null,[Num_Ope_DDiario_flujo] float null,            
 [Producto Verde_Monto_DDiario_flujo_flujo] float null,[Producto Verde_Num_Ope_DDiario_flujo] float null            
 )            
               
 --insert into #SDAF001_  --select * from #SDAF001                
 --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jera,@columns='"vars"',@config=@tconf--,@show_query=1                                           
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jera,@columns='"prod_mis_com","vars"',@config=@tconf--,@show_query=1                                
       
         
insert into #SDAF001_            
select fila,cod_fec_dese,cod_fc,cod_ugru,style,descripcion,[Agua y Saneamiento_Monto_DDiario_flujo_flujo],[Agua y Saneamiento_Num_Ope_DDiario_flujo],            
[Crédito Educativo_Monto_DDiario_flujo_flujo],[Crédito Educativo_Num_Ope_DDiario_flujo],            
[Emprendimiento Mujer_Monto_DDiario_flujo_flujo],[Emprendimiento Mujer_Num_Ope_DDiario_flujo],            
[Monto_DDiario_flujo_flujo],[Num_Ope_DDiario_flujo],            
[Producto Verde_Monto_DDiario_flujo_flujo],[Producto Verde_Num_Ope_DDiario_flujo]            
from #SDAF001_Prev            
            
 delete from #SDAF001_ where style<>1                   
 create table #SDAF001 (fila int null,fec varchar(50) null,cod varchar(50)null,cod_u varchar(250) null,style int null,descripcion varchar(250)null,num_ope int null,SMONDESMN float null)                            
                
 if @prod='TODOS'  --                
 begin                
 insert into #SDAF001                 
  select fila,fec,cod,cod_u,style,descripcion,                 
 isnull(num_ope_agua,0) + isnull(num_ope_crededu,0) + isnull(num_ope_empmuj,0) + isnull(num_ope_ProdVerde,0) ,                
  isnull(SMONDESMN_agua,0) + isnull(SMONDESMN_crededu,0) + isnull(SMONDESMN_empmuj,0)   +  isnull(SMONDESMN_ProdVerde,0)              
  from #SDAF001_                 
                
 end                
else                
begin                
insert into #SDAF001                 
select fila,fec,cod,cod_u,style,descripcion,                 
  case when @prod='Agua y Saneamiento' then  num_ope_agua                
    when @prod='Crédito Educativo' then num_ope_crededu                 
    when @prod='Emprendimiento Mujer' then num_ope_empmuj               
 when @prod='Producto verde' then num_ope_ProdVerde              
 end,              
               
  case when @prod='Agua y Saneamiento' then SMONDESMN_agua                 
       when @prod='Crédito Educativo' then SMONDESMN_crededu                  
    when @prod='Emprendimiento Mujer' then SMONDESMN_empmuj              
 when @prod='Producto verde' then SMONDESMN_ProdVerde              
 end                
  from #SDAF001_                 
                
end                
      
declare @prodd varchar(max),@sql nvarchar(max)    ,@prodd2 varchar(max)          
select  @prodd= case when  @prod='TODOS' then '10232,10233,10234,10235'                 
             when  @prod='Agua y Saneamiento' then '10232'                
       when  @prod='Crédito Educativo' then '10233'                
       when  @prod='Emprendimiento Mujer' then '10234'              
    when  @prod='Producto verde' then '10235' end                
      
select  @prodd2= case when  @prod='TODOS' then '10250'                 
             when  @prod='Agua y Saneamiento' then '10247'                
       when  @prod='Crédito Educativo' then '10246'                
       when  @prod='Emprendimiento Mujer' then '10248'              
    when  @prod='Producto verde' then '10249' end           
        
                 
set @sql='                              
 select eomonth('''+cast(@p_fecha as varchar(250))+''') RNUM,max(a.htipcod)htipcod, ''meta_ope_acum''  DESVAL, sum(isnull(A.HVALVAR,0)) VAL                       
     into  ##cteDatMetas  ------drop table ##cteDatMetas                
  from  storage.[com].[metas_saldos_anual]  A                     
  where A.HCODVAR in('+cast(@prodd as varchar(250))+')                             
  and  A.HTIPMETA = '+cast(@TIPMETA as varchar(250))+'                               
  and a.htipcod='+cast(@tip_cod as varchar(250))+'                            
  and a.HCODREL ='''+cast(@cod_rel as varchar(250))+'''                            
   and A.HFECPRO = DATEFROMPARTS(YEAR(GETDATE()), 12, 31)                         
                 
                
'                
exec (@sql)                
      
set @sql='                              
 select eomonth('''+cast(@p_fecha as varchar(250))+''') RNUM,max(a.htipcod)htipcod, ''meta_ope_acum''  DESVAL, sum(isnull(A.HVALVAR,0)) VAL                       
     into  ##cteDatMetasRequerido  ------drop table ##cteDatMetas                
  from  [storage].[com].[VDMCOM01]  A                     
  where A.HCODVAR in('+cast(@prodd2 as varchar(250))+')                             
  and  A.HTIPMETA = '+cast(@TIPMETA as varchar(250))+'                               
  and a.htipcod='+cast(@tip_cod as varchar(250))+'                            
  and a.HCODREL ='''+cast(@cod_rel as varchar(250))+'''                            
   and A.HFECPRO = eomonth('''+cast(@p_fecha as varchar(250))+''')       
'                
exec (@sql)             
                 
select * into #cteDatMetas from ##cteDatMetas  --drop table ##cteDatMetas                
drop table ##cteDatMetas              
      
select * into #cteDatMetasRequerido from ##cteDatMetasRequerido  --drop table ##cteDatMetas                
drop table ##cteDatMetasRequerido       
       
      
         
;with cte_a as (      
select @tip_cod cod,style,descripcion,sum(num_ope) num_ope from #SDAF001 group by cod,style,descripcion      
)      
select a.cod,a.descripcion,b.val meta_Anual,a.num_ope,case when b.val=0 then 0 else cast(a.num_ope as float) / b.val end cumpl,      
c.val met_requerido      
from cte_a a      
left join #cteDatMetas b      
on a.cod=b.htipcod       
left join #cteDatMetasRequerido c      
on a.cod=c.htipcod      
           
end
