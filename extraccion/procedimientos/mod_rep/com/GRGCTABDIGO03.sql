-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:21:48.313000
--exec [com].[GRGCTABDIGO02] 7,'231','20230331'                                                                
CREATE PROCEDURE [com].[GRGCTABDIGO03]                                                                                    
 @tip_cod int,                                                                                        
 @cod_rel varchar(20),                                                                                    
 @fec date                                                                                   
 as                                                                                    
begin                                                                                    
  SET NOCOUNT ON;  
  
--set @fec='20230410'  
--declare @fec varchar(50)='20230331',@tip_cod int =7,@cod_rel varchar(250)='231',@prod varchar(50)='TODOS'   
declare @prod varchar(50)='TODOS'      ,@fec1 varchar(250)            
  ------------                
  set @fec1=(select max(RFEC) from [storage].[ref].[RCALEN001] where rfec<=@fec and RDIAFER=0)        
  ------------                  
   
 declare @defs as rep.TTHCOLDEF                                                                          
 insert into @defs                                                                            
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,TROWS,TCOLS)  values                                                                           
 (1,1,1,'descripcion','Descripción','string',null,'20px',2,null),                                                                            
 (2,2,1,'CLI_NET_1','Clientes Totales','number',null,null,2,null),                   
 (3,null,1,'2','Enrolamiento','number',null,null,1,4),                         
 (4,null,1,'3','Usabilidad','number',null,null,1,4),                         
 (5,null,1,'4','Huella Digital','number',null,null,1,3),                                  
                               
 (6,2,2,'CLI_ENBO_1','# Enrolados','number',null,null,1,1),     
 (7,3,2,'PERCENT_ENRO','% Enrolados','number',null,null,1,1),    
 (8,4,2,'4_','Meta de Enrolamiento %','number',null,null,1,1),    
 (9,5,2,'4__','Avance de Enrolamiento','number',null,null,1,1),         
   
 (10,6,2,'CLI_USAB_1','# Usabilidad','number',null,null,1,1),     
 (11,7,2,'PERCENT_USA','% Usabilidad','number',null,null,1,1),    
 (12,8,2,'4____','Meta de Usabilidad %','number',null,null,1,1),    
 (13,9,2,'4______','Avance de Usabilidad','number',null,null,1,1),       
   
 (14,10,2,'CLI_HDV_1','Registro por huella de voz','number',null,null,1,1),     
 (15,11,2,'45','Meta de registros por huella de voz','number',null,null,1,1),    
 (16,12,2,'445','Avance de huella de voz','number',null,null,1,1)                                    
   
select rep.FFTHCOLDEF(@defs) result;  
                      
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                            
            --exec STORAGE.[com_pas].[PSLSDPS010] '20230218'                
 insert into @tvars values                             
 ('CLI_NET_COM',null,null,null,null,null),                
 ('CLI_ENBO_COM',null,null,null,null,null),  
 ('CLI_USAB_COM',null,null,null,null,null), ---       
 ('CLI_HDV_COM',null,null,null,null,null)                      
                             
 insert into @tfil                            
 values                            
 ('todos','fec','"'+cast(@fec1 as varchar(50))+'"')                
                
 if @prod<>'TODOS'                
 begin                
 insert into @tfil                  
 values('TODOS','prod_capt','"'+@prod+'"')         
 end                          
                            
 --declare @tip_cod int=15,@cod_rel varchar(100)='2'                            
 declare @jer varchar(100);                          
 insert into @tfil                    
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output                            
                            
 insert into @tconf                            
 values                            
 ('level_alias','style'),                
 ('fec_corr','true'),('insert_to', '#RESULTPIV')                              
  
 create table #RESULTPIV       --select * from #RESULTPIV      drop table #RESULTPIV             
 (                
 fila int null,cod_fc varchar(250)null, cod_cter_capt_m  varchar(250)null,cod_ccor_capt_m varchar(250)null, style int null,                
 descripcion varchar(250)null,    
 CLI_ENBO_COM_1 int null,  
 CLI_HDV_COM_1  int null,  
 CLI_NET_COM_1 int null,  
 CLI_USAB_COM_1 INT NULL  
 )         
                      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1                            
   
 select style,descripcion,format(CLI_NET_COM_1,'N0','en-US')CLI_NET_1,  
 format(CLI_ENBO_COM_1,'N0','en-US') CLI_ENBO_1,format((CAST(CLI_ENBO_COM_1 AS FLOAT)/CLI_NET_COM_1),'P') PERCENT_ENRO,  
 format(CLI_USAB_COM_1,'N0','en-US')CLI_USAB_1,format((CAST(CLI_USAB_COM_1 AS FLOAT)/CLI_ENBO_COM_1 ),'P') PERCENT_USA,  
 format(CLI_HDV_COM_1,'N0','en-US') CLI_HDV_1   
 from #RESULTPIV               
 --format(b.[1],'P')   
 end  
   
 --DROP TABLE #RESULTPIV
