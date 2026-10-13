-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-04-13 08:30:43.960000
--exec [com].[RENRDESEM01] 7,'231','20220322'      
CREATE procedure [com].[RENRDESEM01]       
@tip_cod int,@cod_rel varchar(20), @fecha date        
AS       
begin      
 set nocount on;        
 declare @defs as rep.TTHCOLDEF; declare @fec varchar(8);      
 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)      
      
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS)  values        
 (1,1,1,'descripcion','Descripción','string',1,2)        
 insert into @defs         
    (TORDER,TLEV,TKEY,TDESC,THIDDEN,TCOLS)  values        
    (2,1,'tcartera','Total Cartera',null,3),        
    (3,1,'tdesem','Desembolso',null,3)       
      
 insert into @defs        
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND)  values        
    (4,2,2,'num_cli_enro_vr2','Nro Clientes ','number','.0-0',null,null),        
    (5,3,2,'cli_inst_enro_vr2','Instalados','number','.0-0',null,null),        
    (6,4,2,'ratio_t1','% Instalados','percent','.2-2',null,'#870800'),        
    (7,5,2,'cli_dese_enro_vr2','Nro Clientes Desembolsos','number','.0-0',null,null),        
    (8,6,2,'cli_des_insta_enro_vr2','Instalados Desembolsos','number','.0-0',null,null),        
    (9,7,2,'ratio_t2','% Instalados Desembolsos','percent','.2-2',null,'#870800')      
      
  select rep.FFTHCOLDEF(@defs) result;       
      
  declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF          
          
      
  insert into @tvars values           
  ('num_cli_stock',null,'num_cli_enro_vr2',null,null,null),        
  ('cart_inst_enr',null,'cli_inst_enro_vr2',null,null,null),       
  ('ratio_t1','CASE WHEN num_cli_enro_vr2=0 THEN 0 ELSE cast(cli_inst_enro_vr2/num_cli_enro_vr2 as numeric(17,6)) END','ratio_t1','cal','dp',null),       
  ('num_ope_sf2',null,'cli_dese_enro_vr2',null,null,null) ,      
  ('cli_inst_enro_vr2',null,'cli_des_insta_enro_vr2',null,null,null),      
  ('ratio_t2','CASE WHEN cli_dese_enro_vr2=0 THEN 0 ELSE cast(cli_des_insta_enro_vr2/cli_dese_enro_vr2 as numeric(17,6)) END ','ratio_t2','cal','dp',null)      
        
  insert into @tfil values          
  ('todos','fec','"'+@fec+'"')        
        
  declare @jer varchar(100);        
  insert into @tfil        
  exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output        
          
  insert into @tconf          
  values          
  ('level_alias','style')      
       
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1          
    
end
