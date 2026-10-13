-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:32.413000
--EXEC [com].[RSDATPRO03]     7,'231','20201105'
CREATE procedure [com].[RSDATPRO03]    
@tip_cod int,@cod_rel varchar(20), @fecha date       
as     
begin    
 set nocount on;    
 declare @defs as rep.TTHCOLDEF;    
 declare @w varchar(10)='90px';    
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
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values    
 (2,2,1,'ope_desem','Operaciones Desembolsadas','number','.0-0',@w),    
 (3,3,1,'var_ope_desem','Var. Operaciones Desembolsadas(a)','number','.0-0',@w),    
 (4,4,1,'ope_ini_mov','Operaciones Iniciadas en el Móvil','number','.0-0',@w),    
 (5,5,1,'rat_ope_ini_mov','Operaciones Iniciadas en el Móvil (%)','percent','.2-2',@w),    
 (6,6,1,'mon_des','Monto Desembolsado','number','.0-0',@w),    
 (7,7,1,'var_mon_des','Var. Monto Desembolsado(a)','number','.0-0',@w),    
 (8,8,1,'des_ini_mov','Desembolsos Iniciados en el Móvil','number','.0-0',@w),    
 (9,9,1,'rat_des_ini_mov','Desembolsos Iniciados en el Móvil (%)','percent','.2-2',@w),    
 (10,10,1,'tick_prom','Ticket Promedio','number','.0-0',@w),    
 (11,11,1,'var_tick_prom','Var. Ticket Promedio(a)','number','.0-0',@w)    
    
 select rep.FFTHCOLDEF(@defs) result;    
    
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF      
      
  insert into @tvars values       
  ('num_ope_sf2',null,null,null,null,null),    
  ('num_ope_sf15',null,null,null,null,null),    
  ('mon_desem_sf2',null,null,null,null,null),    
  ('mon_desem_sf15',null,null,null,null,null),    
  ('tick_prom_sf2',null,null,null,null,null)    
      
  insert into @tfil values      
  ('todos','fec','"'+concat_ws('","',@fec,@fec_a)+'"')    
    
  --declare @tip_cod int=7,@cod_rel varchar(100)='231'    
  declare @jer varchar(100);    
  insert into @tfil    
  exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output    
      
 select @jer='"prod_tipo","prod_com"'    
  insert into @tconf      
  values      
  ('level_alias','style') ,
  ('insert_to','#report'),
('fec_corr','true')    
      
  --los valores rows y columnas van separados por comas y cada valor entre doble comilla      
  --'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion      
  create table #report (fila int,cod_prod_tipo varchar(100),cod_prod_com int,style int,descripcion varchar(100),    
  mon_desem_sf15_1 float,mon_desem_sf15_2 float,    
  mon_desem_sf2_1 float,mon_desem_sf2_2 float,    
  num_ope_sf15_1 int,num_ope_sf15_2 int,    
  num_ope_sf2_1 int,num_ope_sf2_2 int,    
  tick_prom_sf2_1 float,tick_prom_sf2_2 float)    --DROP TABLE #report

   exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1   
    
    
  /*insert into #report      
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec"',@config=@tconf--,@show_query=1      
  */  
  ;with cte_report as (    
  select fila,style,descripcion,    
  num_ope_sf2_2 ope_desem,isnull(num_ope_sf2_2,0)-isnull(num_ope_sf2_1,0) var_ope_desem,    
  case when isnull(num_ope_sf2_2,0)-isnull(num_ope_sf2_1,0)<0 then -1 else null end style_var_ope_desem,    
  num_ope_sf15_2 ope_ini_mov,ISNULL(num_ope_sf15_2*1.00/num_ope_sf2_2*1.00,0) rat_ope_ini_mov,    
  mon_desem_sf2_2 mon_des,isnull(mon_desem_sf2_2,0)-isnull(mon_desem_sf2_1,0) var_mon_des,    
  case when isnull(mon_desem_sf2_2,0)-isnull(mon_desem_sf2_1,0)<0 then -1 else null end style_var_mon_des,    
  mon_desem_sf15_2 des_ini_mov,ISNULL(mon_desem_sf15_2*1.00/mon_desem_sf2_2*1.00,0) rat_des_ini_mov,    
  tick_prom_sf2_2 tick_prom,isnull(tick_prom_sf2_2,0)-isnull(tick_prom_sf2_1,0) var_tick_prom,    
  case when isnull(tick_prom_sf2_2,0)-isnull(tick_prom_sf2_1,0)<0 then -1 else null end style_var_tick_prom    
  from #report    
  where descripcion is not null    
  )select * from cte_report    
    
end
