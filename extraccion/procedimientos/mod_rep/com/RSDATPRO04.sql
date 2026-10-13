-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:32.453000
CREATE procedure [com].[RSDATPRO04]    
@tip_cod int,@cod_rel varchar(20), @fecha date       
as     
begin    
 set nocount on;    
 declare @defs as rep.TTHCOLDEF;    
 declare @w varchar(10)='15%';    
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
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TFORUNI,TSTDEWIDTH)  values    
 (2,2,1,'tapp_mes_sf2_2','Tapp Mes','percent','.2-2',null,@w),    
 (3,3,1,'var_tapp_mes','Var. Tapp Mes(b)','number','.0-0','pbs',@w),    
 (4,4,1,'tapp_stock_ss1_2','Tapp Stock','percent','.2-2',null,@w),    
 (5,5,1,'var_tapp_stock','Var. Tapp Stock(b)','number','.0-0','pbs',@w)    
    
 select rep.FFTHCOLDEF(@defs) result;    
    
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF      
      
  insert into @tvars values       
  ('tapp_mes_sf2',null,null,null,null,null),    
  ('tapp_stock_ss1',null,null,null,null,null)    
    
  insert into @tfil values      
  ('todos','fec','"'+concat_ws('","',@fec,@fec_a)+'"')    
    
  --declare @tip_cod int=7,@cod_rel varchar(100)='231'    
  declare @jer varchar(100);    
  insert into @tfil    
  exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output    
      
 select @jer='"prod_tipo","prod_com"'    
  insert into @tconf      
  values      
  ('level_alias','style')   ,
  ('insert_to','#report'),
('fec_corr','true')    
      
  --los valores rows y columnas van separados por comas y cada valor entre doble comilla      
  --'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion      
  create table #report (fila int,cod_prod_tipo varchar(100),cod_prod_com int,style int,descripcion varchar(100),    
  tapp_mes_sf2_1 float,tapp_mes_sf2_2 float,    
  tapp_stock_ss1_1 float,tapp_stock_ss1_2 float)    

  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1   

  /*  
  insert into #report      
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec"',@config=@tconf--,@show_query=1      
  */  
  ;with cte_report as (    
  select fila,style,descripcion,    
  tapp_mes_sf2_2,(tapp_mes_sf2_2-tapp_mes_sf2_1)*10000 var_tapp_mes,    
  case when (tapp_mes_sf2_2-tapp_mes_sf2_1)*10000<0 then -1 else null end style_var_tapp_mes,    
  tapp_stock_ss1_2,(tapp_stock_ss1_2-tapp_stock_ss1_1)*10000 var_tapp_stock,    
  case when (tapp_stock_ss1_2-tapp_stock_ss1_1)*10000<0 then -1 else null end style_var_tapp_stock    
  from #report    
  where descripcion is not null    
  )select * from cte_report    
    
end
