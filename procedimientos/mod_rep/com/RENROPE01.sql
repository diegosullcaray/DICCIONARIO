-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.873000
--exec [com].[RENROPE01] 7,'231','20210408'    
CREATE procedure [com].[RENROPE01]     
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
    (2,1,'tdese','Desembolsos',null,3),      
    (3,1,'tapert','Apertura',null,3)     
    
 insert into @defs      
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TCOLS,TSTBACKGROUND)  values      
    (4,2,2,'num_cli_opedes_enro','Nro Clientes ','number','.0-0',null,1,null),      
    (5,3,2,'cli_inst_opedes_enro','Instalados','number','.0-0',null,1,null),      
    (6,4,2,'ratio_t1','% Instalados','percent','.0-0',null,1,'#870800'),      
    (7,5,2,'num_cli_opepas_enro','Nro Clientes','number','.0-0',null,1,null),      
    (8,6,2,'cli_inst_opepas_enro','Instalados','number','.0-0',null,1,null),      
    (9,7,2,'ratio_t2','% Instalados','percent','.0-0',null,1,'#870800')    
    
  select rep.FFTHCOLDEF(@defs) result;     
    
  declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF        
        
  insert into @tvars values         
  ('num_cli_opedes_enro',null,'num_cli_opedes_enro',null,null,null),      
  ('cli_inst_opedes_enro',null,null,null,null,null),     
  ('ratio_t1','cast(cli_inst_opedes_enro/num_cli_opedes_enro as numeric(17,6))','ratio_t1','cal','dp',null),     
  ('num_cli_opepas_enro',null,null,null,null,null) ,    
  ('cli_inst_opepas_enro',null,null,null,null,null),    
  ('ratio_t2','cast(cli_inst_opepas_enro/num_cli_opepas_enro as numeric(17,6))','ratio_t2','cal','dp',null)    
      
  insert into @tfil values        
  ('todos','fec','"'+@fec+'"')      
      
  declare @jer varchar(100);      
  insert into @tfil      
  exec piv.GPIVLEV03 @tip_cod,@cod_rel,@jer output      
        
  insert into @tconf        
  values        
  ('level_alias','style')    
     
  CREATE TABLE #Result (fila int null,cod_fec varchar(max) null,cod_cter_capt varchar(max) null,style int null,descripcion varchar(max) null,num_cli_opedes_enro float null,cli_inst_opedes_enro float null,ratio_t1 float null,num_cli_opepas_enro float null,
 cli_inst_opepas_enro float null, ratio_t2 float null)  
  insert into #Result  
  exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1       
  
  select style,case when descripcion=cast(@fecha as varchar(250)) then 'FINANCIERA CONFIANZA' ELSE descripcion end  as descripcion,  
  num_cli_opedes_enro,cli_inst_opedes_enro,ratio_t1,
  num_cli_opepas_enro,cli_inst_opepas_enro,ratio_t2  
  from #Result     
end
