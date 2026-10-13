-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-02-03 16:41:30.123000
--exec mod_rep.[com].[RSDATPRO01] 7,'231','20240916'             
CREATE procedure [com].[RSDATPRO01]            
@tip_cod int,@cod_rel varchar(20), @fecha date               
as             
begin            
 set nocount on;           
        
 --declare @tip_cod int=7,@cod_rel varchar(20)='231', @fecha date  ='20240916'            
        
 declare @defs as rep.TTHCOLDEF;            
 declare @w varchar(10)='12%';            
 declare @fec varchar(8);            
 declare @fec_a varchar(8);            
            
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)            
             
 select top 1              
  @fec_a=RFECTXT              
 from storage.ref.RCALEN001              
 where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0              
 order by RFEC desc            
        
 insert into @defs            
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values            
 (1,1,1,'descripcion','Descripción','string',1)            
 insert into @defs            
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,THIDDEN,TCOLS)  values            
 (2,2,1,'cli_stock','Stock de Clientes','number','.0-0',@w,null,null),            
 (3,3,1,'var_cli_stock','Var. Stock de Clientes(a)','number','.0-0',@w,null,null),            
 (4,4,1,'cli_nue','Clientes Nuevos','number','.0-0',@w,null,null),            
 (5,5,1,'var_cli_nue','Var. Clientes Nuevos(a)','number','.0-0',@w,null,null),            
 (6,6,1,'sal_cap','Cartera','number','.0-0',@w,null,null),            
 (7,7,1,'var_sal_cap','Var. Cartera(a)','number','.0-0',@w,null,null)            
            
 select rep.FFTHCOLDEF(@defs) result;        
         
            
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF              
      
  insert into @tvars values               
  ('sal_cap',null,null,null,null,null) ,       
  ('cli_nue_sf2',null,null,null,null,null),            
  --('cli_cre_stock',null,null,null,null,null)    ,        
  /*('cli_cre_stock_cartH',null,null,null,null,null) ,        
  ('cli_cre_stock_cartM',null,null,null,null,null)       
  */       
  ('num_cli_stock',null,null,null,null,null)      
 /*    
 ('cli_cre_stock_cartH',null,null,null,null,null) ,        
  ('cli_cre_stock_cartM',null,null,null,null,null)         
              
  */    
    
  insert into @tfil values              
  ('todos','fec','"'+concat_ws('","',@fec,@fec_a)+'"')            
            
  --declare @tip_cod int=7,@cod_rel varchar(100)='231'            
  declare @jer varchar(100);            
  insert into @tfil            
  exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output            
         
    select @jer='"prod_tipo","prod_com"'        
 --select @jer='"prod_mis_com"'            
        
      
  insert into @tconf              
  values              
  ('level_alias','style') ,           
  ('insert_to','#report1'),         
  ('fec_corr','true')          
    
    create table #report1 (fila int,cod_prod_tipo varchar(100),cod_prod_com int,style int,descripcion varchar(100),            
        
  cli_nue_sf2_1 int,cli_nue_sf2_2 int,            
  sal_cap_1 float,sal_cap_2 float    ,    
  num_cli_stock_1 int ,num_cli_stock_2 int    
  )     --drop table #report1  select top  5 * from #report1        
            
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1            
       
   select *      
  into #report        
  from #report1        
    
  ; with cte_report as (            
  select fila,style,descripcion            
  --,S.cli_stock,S.var_cli_stock            
  --,case when S.var_cli_stock<0 then -1 else null end style_var_cli_stock            
  ,num_cli_stock_2 cli_stock,isnull(num_cli_stock_2,0)-isnull(num_cli_stock_1,0) var_cli_stock            
  ,case when isnull(num_cli_stock_2,0)-isnull(num_cli_stock_1,0)<0 then -1 else null end style_var_cli_stock            
            
  ,sal_cap_2 sal_cap,isnull(sal_cap_2,0)-isnull(sal_cap_1,0) var_sal_cap            
  ,case when isnull(sal_cap_2,0)-isnull(sal_cap_1,0)<0 then -1 else null end style_var_sal_cap            
  ,cli_nue_sf2_2 cli_nue,isnull(cli_nue_sf2_2,0)-isnull(cli_nue_sf2_1,0) var_cli_nue            
  ,case when isnull(cli_nue_sf2_2,0)-isnull(cli_nue_sf2_1,0)<0 then -1 else null end style_var_cli_nue            
  from #report R            
  --left join #stock S on R.descripcion COLLATE SQL_Latin1_General_CP1_CI_AS=S.RDESCRIP COLLATE SQL_Latin1_General_CP1_CI_AS            
            
  ) select * into #cte_report1 from cte_report where descripcion is not null        
    
  set @jer='"prod_mis_com"'            
      
 delete from  @tconf where TKEYPROP='insert_to'      
       
 insert into @tconf              
  values                
  ('insert_to','#report2')       
    
  create table #report2 (fila int,cod_prod_tipo varchar(100),cod_prod_com int,style int,descripcion varchar(100),            
        
  cli_nue_sf2_1 int,cli_nue_sf2_2 int,            
  sal_cap_1 float,sal_cap_2 float    ,    
  num_cli_stock_1 int ,num_cli_stock_2 int    
  )     --drop table #report1  select top  5 * from #report1        
            
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1            
       
    
 set @jer='"prod_verde"'      
 delete from  @tconf where TKEYPROP='insert_to'      
  
 insert into @tconf              
  values                
  ('insert_to','#report3')       
    
  create table #report3 (fila int,cod_prod_verde varchar(100),cod_prod_com int,style int,descripcion varchar(100),            
        
  cli_nue_sf2_1 int,cli_nue_sf2_2 int,            
  sal_cap_1 float,sal_cap_2 float    ,    
  num_cli_stock_1 int ,num_cli_stock_2 int    
  )     --drop table #report1  select top  5 * from #report1        
            
  
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1          
  
  
      
    
select *        
  into #report_        
  from #report2      --select * from #report2 select * from #report3  
  
  
select *        
  into #report__        
  from #report3     
    
   ; with cte_report as (            
  select fila,style,descripcion            
  --,S.cli_stock,S.var_cli_stock            
  --,case when S.var_cli_stock<0 then -1 else null end style_var_cli_stock            
  ,num_cli_stock_2 cli_stock,isnull(num_cli_stock_2 ,0)-isnull(num_cli_stock_1,0) var_cli_stock            
  ,case when isnull(num_cli_stock_2,0)-isnull(num_cli_stock_1,0)<0 then -1 else null end style_var_cli_stock            
            
  ,sal_cap_2 sal_cap,isnull(sal_cap_2,0)-isnull(sal_cap_1,0) var_sal_cap            
  ,case when isnull(sal_cap_2,0)-isnull(sal_cap_1,0)<0 then -1 else null end style_var_sal_cap            
  ,cli_nue_sf2_2 cli_nue,isnull(cli_nue_sf2_2,0)-isnull(cli_nue_sf2_1,0) var_cli_nue            
  ,case when isnull(cli_nue_sf2_2,0)-isnull(cli_nue_sf2_1,0)<0 then -1 else null end style_var_cli_nue            
  from #report_ R            
  --left join #stock S on R.descripcion COLLATE SQL_Latin1_General_CP1_CI_AS=S.RDESCRIP COLLATE SQL_Latin1_General_CP1_CI_AS            
            
  ) select * into #cte_report2 from cte_report where descripcion is not null        
    
  
   ; with cte_report as (            
  select fila,style,descripcion            
  --,S.cli_stock,S.var_cli_stock            
  --,case when S.var_cli_stock<0 then -1 else null end style_var_cli_stock            
  ,num_cli_stock_2 cli_stock,isnull(num_cli_stock_2 ,0)-isnull(num_cli_stock_1,0) var_cli_stock            
  ,case when isnull(num_cli_stock_2,0)-isnull(num_cli_stock_1,0)<0 then -1 else null end style_var_cli_stock            
            
  ,sal_cap_2 sal_cap,isnull(sal_cap_2,0)-isnull(sal_cap_1,0) var_sal_cap            
  ,case when isnull(sal_cap_2,0)-isnull(sal_cap_1,0)<0 then -1 else null end style_var_sal_cap            
  ,cli_nue_sf2_2 cli_nue,isnull(cli_nue_sf2_2,0)-isnull(cli_nue_sf2_1,0) var_cli_nue            
  ,case when isnull(cli_nue_sf2_2,0)-isnull(cli_nue_sf2_1,0)<0 then -1 else null end style_var_cli_nue            
  from #report__ R            
  --left join #stock S on R.descripcion COLLATE SQL_Latin1_General_CP1_CI_AS=S.RDESCRIP COLLATE SQL_Latin1_General_CP1_CI_AS            
            
  ) select * into #cte_report3 from cte_report where descripcion is not null        
  
   
   update #cte_report1 set fila=9 where descripcion='CONSTRUYENDO CONFIANZA'     
      
  update #cte_report1 set fila=11 where descripcion='CREDITO EDUCATIVO'      
  update #cte_report1 set fila=12 where descripcion='EMPRENDIENDO CONFIANZA'      
  update #cte_report1 set fila=16 where descripcion='INICIANDO CONFIANZA PYME'      
      
        
  update #cte_report1 set fila=17 where descripcion='CONSUMO'      
  update #cte_report1 set fila=18 where descripcion='GARANTIA LIQUIDA'      
  update #cte_report1 set fila=19 where descripcion='TRABAJADORES FC'      
  update #cte_report1 set fila=20 where descripcion='HIPOTECARIO'      
  update #cte_report1 set fila=21 where descripcion='INICIANDO CONFIANZA'      
  update #cte_report1 set fila=22 where descripcion='CREDITOS FAE'      
  update #cte_report1 set fila=23 where descripcion='CREDITOS REACTIVA'      
  update #cte_report1 set fila=24 where descripcion='INICIANDO OFICIOS'      
  update #cte_report1 set fila=25 where descripcion='NEGOCIOS FAE MUJER'      
  update #cte_report1 set fila=26 where descripcion='IMPULSA MYPERU'       
      
      
    update #cte_report2 set fila=10 where descripcion='Agua y Saneamiento'       
    update #cte_report2 set fila=13 where descripcion='Emprendimiento Mujer'       
      
   

update #cte_report3 set fila=6 where descripcion='Agropecuario Verde'             
    update #cte_report3 set fila=14 where descripcion='Emprendimiento Verde' 
       
    update #cte_report2 set descripcion='AGUA Y SANEAMIENTO' where descripcion='Agua y Saneamiento'       
    update #cte_report2 set descripcion='EMPRENDIMIENTO MUJER' where descripcion='Emprendimiento Mujer'     
   
   
    update #cte_report3 set descripcion='AGROPECUARIO VERDE' where descripcion='Agropecuario Verde'  
    update #cte_report3 set descripcion='EMPRENDIMIENTO VERDE' where descripcion='Emprendimiento Verde'   
 ;with cte_a as (      
  select * from #cte_report1 union all      
  select * from #cte_report2 WHERE fila IN(10,13)     
  union all  
  select * from  #cte_report3  
  )      
  select * from cte_a order by fila asc        
      
end
