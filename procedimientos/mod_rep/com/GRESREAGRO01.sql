-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-10-29 12:34:00.583000
--exec [com].[GRESREAGRO01] 7,'231'    
CREATE procedure [com].[GRESREAGRO01]     
@tip_cod int,        
@cod_rel varchar(10)      
as    
 BEGIN    
  SET NOCOUNT ON;     
  declare @fecha date= '20220531'--(select MAX(hfecpro) from [storage].[com_act].WACLI001)       
  declare @fec varchar(8);      
  declare @defs as rep.TTHCOLDEF;      
  select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)      
      
  declare @fec_a varchar(8);    
  select top 1    
   @fec_a=RFECTXT    
  from storage.ref.RCALEN001    
  where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0    
  order by RFEC desc    
     
  SET LANGUAGE spanish;    
  insert into @defs      
  (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values      
  (1,1,2,1,'descripcion','Descripción','string',1)      
      
  insert into @defs     
  (TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS)  values    
  (2,1,'clien','Clientes',null,2),    
  (3,1,'cart','Cartera',null,2),    
  (4,1,'OPDES','Operaciones Desembolsadas',null,2),    
  (5,1,'mora','Mora >=1 día',null,2)    
    
  insert into @defs      
  (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS)  values      
  (6,2,2,'num_cli_stock_MA','Stock de Clientes al <br>'+format(cast(@fec_a as date),'dd-MMM'),'number','.0-0',null,null),      
  (7,3,2,'VAR_CLI','Variación Stock Clientes','number','.0-0',null,null),    
  (8,4,2,'sal_cap_ayer','Cartera','number','.0-0',null,null),    
  (9,5,2,'VAR_CARTERA','Variación Cartera','number','.0-0',null,null),    
  (10,6,2,'num_ope_sf2_ayer','N° Operaciones','number','.0-0',null,null),    
  (11,7,2,'mon_desem_sf2_ayer','Monto','number','.0-0',null,null),    
  (12,8,2,'saldo_mora_1_ayer','Saldo','number','.0-0',null,null),    
  (13,9,2,'ratio_mora_1_ayer','Ratio','percent','.2-2',null,null)    
    
  SET LANGUAGE english;      
  select rep.FFTHCOLDEF(@defs) result;      
    
    
  declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF      
    
  insert into @tvars values       
  ('num_cli_stock',null,null,null,null,null)    
    
  insert into @tvars values     
  ('mon_desem_sf2',null,null,null,null,null)    
      
  insert into @tvars values     
  ('num_ope_sf2',null,null,null,null,null)    
      
  insert into @tvars values     
  ('sal_cap',null,null,null,null,null)    
      
      
  insert into @tvars values     
  ('sal_mor_1',null,null,null,null,null)    
      
  insert into @tvars values     
  ('rat_mor_1',null,null,null,null,null)    
       
  insert into @tfil      
  values      
  ('todos','fec',''+@fec+''),    
  ('todos','prod_agro_total','1')    
      
    
  declare @jer varchar(100);    
  insert into @tfil    
  exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output    
       
  insert into @tconf      
  values      
  ('level_alias','style')     
    
  create table #CliAyer (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),num_cli_stock_ayer int,mon_desem_sf2_ayer float,num_ope_sf2_ayer float,sal_cap_ayer float,saldo_mora_1_ayer float,ratio_mora_1_ayer float)      
  insert into #CliAyer --drop table #CliAyer   select*from #CliAyer    
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1      
    
  delete from @tfil where   TKEYFIL='fec'    
  insert into @tfil  values ('todos','fec',''+@fec_a+'')    
    
  create table #CliMA (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),num_cli_stock_MA int,mon_desem_sf2_MA float,num_ope_sf2_MA float,sal_cap_MA float,saldo_mora_1_MA float,ratio_mora_1_MA float)        
  insert into #CliMA --drop table  #CliMA    
  Exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1      
    
    
select A.fila,a.cod_n1,a.cod_n2,a.style,a.descripcion,isnull(b.num_cli_stock_MA,0) num_cli_stock_MA,(isnull(A.num_cli_stock_ayer,0) - isnull(B.num_cli_stock_MA,0)) AS VAR_CLI,A.sal_cap_ayer,(isnull(A.sal_cap_ayer,0) - isnull(B.sal_cap_MA,0)) AS VAR_CARTERA,A.num_ope_sf2_ayer,A.mon_desem_sf2_ayer,a.saldo_mora_1_ayer,a.ratio_mora_1_ayer    
  from #CliAyer A    
  left join #CliMA B    
  on a.descripcion=b.descripcion    
 END
