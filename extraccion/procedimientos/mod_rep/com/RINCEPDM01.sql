-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:01.823000
--EXEC mod_rep.[com].[RINCEPDM01] 7,'231','20230124'
CREATE PROCEDURE [com].[RINCEPDM01]
@tip_cod int,@cod_rel varchar(20), @fecha date
AS
BEGIN
 set nocount on;
 declare @defs as rep.TTHCOLDEF;  

 select *   into #FECS  --drop table #FECS  select * from  #FECS                                 
from storage.util.FVECFEC01(@fecha,'cie_ant,hoy')   

 declare @fecacumu varchar(max)
select @fecacumu=string_agg(format(RFEC,'yyyyMMdd'),',') 
from #FECS 

 SET LANGUAGE spanish; 
 insert into @defs
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values          
 (1,1,1,'descripcion','Descripción','string',null,null,null,null),        
 (2,2,1,'Num_Grupos_1','Grupos al cierre Mes Ant.','number','.0-0',null,null,null),            
 (3,3,1,'Num_Grupos_F_1','Grupos al cierre Filtro Mes Ant.','number','.0-0',null,null,null),        
 (4,4,1,'Num_Grupos_2','Grupos al cierre','number','.0-0',null,null,null),              
 (5,5,1,'Num_Grupos_F_2','Grupos al cierre Filtro','number','.0-0',null,'#A72C12',null),        
 (6,6,1,'tot_desemb_pdm_2','# Grupos Desem. Mes','number','.0-0',null,'#A72C12',null),        
 (7,7,1,'Monto_Des_grup_2','Monto Desem. Mes','number','.1-1',null,'#A72C12',null)
  

 --select * from @defs
 select rep.FFTHCOLDEF(@defs) result;

 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF

 insert into @tvars values
 ('Num_Grupos',null,null,null,null,null),
 ('Num_Grupos_F',null,null,null,null,null),
 ('tot_desemb_pdm',null,null,null,null,null),
 ('Monto_Des_grup',null,null,null,null,null) 

 insert into @tfil
 values
 ('todos','fec',@fecacumu)--,

 --declare @tip_cod int=15,@cod_rel varchar(100)='2'
 declare @jer varchar(100);
 insert into @tfil
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output

 insert into @tconf
 values
 ('level_alias','style'),
 ('fec_corr','true')
  
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1

end
