-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-12-28 10:14:19.803000
--EXEC [mod_rep].[com].[GCMCNUE002] '7','231','20231227','0','1'
--EXEC [com].[GCMCNUE002] '7','231', '20231227', 1,2            
CREATE PROCEDURE [com].[GCMCNUE002](        
 @tip_cod varchar(5),@cod_rel varchar(25), @fec date,@prod varchar(50),@tipcuota int)            
AS              
BEGIN            
 SET NOCOUNT ON;         
 declare @fecs nvarchar(max)      
 set @fecs =(select replace(max(HFECPRO),'-','') from [storage].[com_act].[HCDA001] where HFECPRO<=@fec );             
--declare @fecs varchar(250)='20231227', @tip_cod int=7,@cod_rel varchar(250)='231'      
      
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)            
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL            
      
      
declare @defs as rep.TTHCOLDEF;       
insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TROWS,TCOLS)  values        
 (1,1,1,'descripcion','descripcion','string',1,3,null),   
 /*       
 (2,null,1,'NuevIng','Nuevo Ingreso',NULL,null,NULL,6),      
 (3,null,1,'Tot','Total',NULL,null,NULL,6),      
 (4,null,1,'Mant','Mantiene',NULL,null,NULL,6),      
    
  */  
  (2,null,1,'Mant','Mantiene',NULL,null,NULL,8),  
 (3,null,1,'NuevIng','Nuevo Ingreso',NULL,null,NULL,8),      
 (4,null,1,'Tot','Total',NULL,null,NULL,8)   ,  
       
  
 /*(5,null,2,'nro','N° Cero Cuotas','string',null,null,3),      
 (6,null,2,'sald','Saldo Cero Cuotas','string',null,null,3),    
     
 (7,null,2,'nro2','N° Cero Cuotas','string',null,null,3),      
 (8,null,2,'sald2','Saldo Cero Cuotas','string',null,null,3)  ,    
    
 (27,null,2,'nro3','N° Cero Cuotas','string',null,null,3),      
 (28,null,2,'sald3','Saldo Cero Cuotas','string',null,null,3)      
    */  
 (5,null,2,'nro1','N° Cero Cuotas','string',null,null,4),      
 (6,null,2,'sald1','Saldo Cero Cuotas','string',null,null,4),    
     
 (7,null,2,'nro2','N° Cero Cuotas','string',null,null,4),      
 (8,null,2,'sald2','Saldo Cero Cuotas','string',null,null,4)  ,    
    
 (28,null,2,'nro3','N° Cero Cuotas','string',null,null,4),      
 (29,null,2,'sald3','Saldo Cero Cuotas','string',null,null,4)   
  
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TROWS,TCOLS,TSTBACKGROUND)  values        
 (9,1,3,'ManRefiN','Refinanciado','number','.0-0',null,NULL,NULL),        
 (10,2,3,'ReproN','Repro','number','.0-0',null,NULL,NULL),      
 (11,3,3,'NReproN','No Repro','number','.0-0',null,NULL,NULL), 
 (12,4,3,'TotOpe_Man','Total Ope','number','.0-0',null,NULL,'green'),
 (13,5,3,'SManRefiN','Refinanciado','number','.0-0',null,NULL,NULL),      
 (14,6,3,'SReproN','Repro','number','.0-0',null,NULL,NULL),      
 (15,7,3,'SNReproN','No Repro','number','.0-0',null,NULL,NULL), 
 (16,7,3,'TotSal_Man','Total Saldo','number','.0-0',null,NULL,'green'),
      
 (17,8,3,'num_ccn_ref','Refinanciado','number','.0-0',null,NULL,NULL),        
 (18,9,3,'num_ccn_repro','Repro','number','.0-0',null,NULL,NULL),      
 (19,10,3,'num_ccn_norepro','No Repro','number','.0-0',null,NULL,NULL), 
 (20,10,3,'TotOpe_Nue','Total Ope','number','.0-0',null,NULL,'green'),
 (21,11,3,'sald_ccn_ref','Refinanciado','number','.0-0',null,NULL,NULL),      
 (22,12,3,'sald_ccn_repro','Repro','number','.0-0',null,NULL,NULL),      
 (23,13,3,'sald_ccn_norepro','No Repro','number','.0-0',null,NULL,NULL), 
 (24,13,3,'TotSal_Nue','Total Saldo','number','.0-0',null,NULL,'green'), 
      
 (25,14,3,'num_ccn_N_ref','Refinanciado','number','.0-0',null,NULL,NULL),        
 (26,15,3,'num_ccn_N_repro','Repro','number','.0-0',null,NULL,NULL),      
 (27,16,3,'num_ccn_N_norepro','No Repro','number','.0-0',null,NULL,NULL),  
 (28,16,3,'TotOpe','Total Ope','number','.0-0',null,NULL,'green'),
 (29,17,3,'sald_ccn_N_ref','Refinanciado','number','.0-0',null,NULL,NULL),      
 (30,18,3,'sald_ccn_N_repro','Repro','number','.0-0',null,NULL,NULL),      
 (31,19,3,'sald_ccn_N_norepro','No Repro','number','.0-0',null,NULL,NULL),
 (32,19,3,'TotSal','Total Saldo','number','.0-0',null,NULL,'green')
 /*(9,2,3,'num_ccn_ref','Refinanciado','number','.0-0',null,NULL),        
 (10,3,3,'num_ccn_repro','Repro','number','.0-0',null,NULL),      
 (11,4,3,'num_ccn_norepro','No Repro','number','.0-0',null,NULL),      
 (12,5,3,'sald_ccn_ref','Refinanciado','number','.0-0',null,NULL),      
 (13,6,3,'sald_ccn_repro','Repro','number','.0-0',null,NULL),      
 (14,7,3,'sald_ccn_norepro','No Repro','number','.0-0',null,NULL),      
      
 (15,8,3,'num_ccn_N_ref','Refinanciado','number','.0-0',null,NULL),        
 (16,9,3,'num_ccn_N_repro','Repro','number','.0-0',null,NULL),      
 (17,10,3,'num_ccn_N_norepro','No Repro','number','.0-0',null,NULL),      
 (18,11,3,'sald_ccn_N_ref','Refinanciado','number','.0-0',null,NULL),      
 (19,12,3,'sald_ccn_N_repro','Repro','number','.0-0',null,NULL),      
 (20,13,3,'sald_ccn_N_norepro','No Repro','number','.0-0',null,NULL),      
      
 (21,14,3,'ManRefiN','Refinanciado','number','.0-0',null,NULL),        
 (22,15,3,'ReproN','Repro','number','.0-0',null,NULL),      
 (23,16,3,'NReproN','No Repro','number','.0-0',null,NULL),      
 (24,17,3,'SManRefiN','Refinanciado','number','.0-0',null,NULL),      
 (25,18,3,'SReproN','Repro','number','.0-0',null,NULL),      
 (26,19,3,'SNReproN','No Repro','number','.0-0',null,NULL)      
 */  
          
 select rep.FFTHCOLDEF(@defs) result;       
        
insert into @tvars            
values 
  ('ManRefiN','cast(isnull(num_ccn_N_ref,0) - isnull(num_ccn_ref,0) as numeric(17,6))','ManRefiN','cal','dp',null),        
  ('ReproN','cast(isnull(num_ccn_N_repro,0) - isnull(num_ccn_repro,0) as numeric(17,6))','ReproN','cal','dp',null),      
  ('NReproN','cast(isnull(num_ccn_N_norepro,0) - isnull(num_ccn_norepro,0) as numeric(17,6))','NReproN','cal','dp',null),      
  ('TotOpe_Man', 'cast(isnull(num_ccn_N_ref,0) - isnull(num_ccn_ref,0) as numeric(17,6))+
  cast(isnull(num_ccn_N_repro,0) - isnull(num_ccn_repro,0) as numeric(17,6))+
  cast(isnull(num_ccn_N_norepro,0) - isnull(num_ccn_norepro,0) as numeric(17,6))', 'TotOpe_Man', 'cal','dp', null),   

  ('SManRefiN','cast(isnull(sald_ccn_N_ref,0) - isnull(sald_ccn_ref,0) as numeric(17,6))','SManRefiN','cal','dp',null),
  ('SReproN','cast(isnull(sald_ccn_N_repro,0) - isnull(sald_ccn_repro,0) as numeric(17,6))','SReproN','cal','dp',null),      
  ('SNReproN','cast(isnull(sald_ccn_N_norepro,0) - isnull(sald_ccn_norepro,0) as numeric(17,6))','SNReproN','cal','dp',null),        
  ('TotSal_Man', 'cast(isnull(sald_ccn_N_ref,0) - isnull(sald_ccn_ref,0) as numeric(17,6))+
  cast(isnull(sald_ccn_N_repro,0) - isnull(sald_ccn_repro,0) as numeric(17,6))+
  cast(isnull(sald_ccn_N_norepro,0) - isnull(sald_ccn_norepro,0) as numeric(17,6))', 'TotSal_Man', 'cal','dp', null),   



  ('num_ccn_ref', null, null, null, null, null),--Cero cuotas nuevas saldo        
  ('num_ccn_repro', null, null, null, null, null),       
  ('num_ccn_norepro', null, null, null, null, null),  
  ('TotOpe_Nue', 'cast(ISNULL(num_ccn_ref,0)+ISNULL(num_ccn_repro,0)+ISNULL(num_ccn_norepro,0) as numeric(17,6))', 'TotOpe_Nue', 'cal','dp', null),
  --EXEC [mod_rep].[com].[GCMCNUE002] '7','231','20231227','0','1'

  ('sald_ccn_ref', null, null, null, null, null),      
  ('sald_ccn_repro', null, null, null, null, null),      
  ('sald_ccn_norepro', null, null, null, null, null),
  ('TotSal_Nue', 'cast(ISNULL(sald_ccn_ref,0)+ISNULL(sald_ccn_repro,0)+ISNULL(sald_ccn_norepro,0) as numeric(17,6))', 'TotSal_Nue', 'cal','dp', null),
  
  ('num_ccn_N_ref', null, null, null, null, null),--Cero cuotas nuevas saldo        
  ('num_ccn_N_repro', null, null, null, null, null),       
  ('num_ccn_N_norepro', null, null, null, null, null),
  ('TotOpe', 'cast(ISNULL(num_ccn_N_ref,0)+ISNULL(num_ccn_N_repro,0)+ISNULL(num_ccn_N_norepro,0) as numeric(17,6))', 'TotOpe', 'cal','dp', null),
  
  ('sald_ccn_N_ref', null, null, null, null, null),      
  ('sald_ccn_N_repro', null, null, null, null, null),      
  ('sald_ccn_N_norepro', null, null, null, null, null),     
  ('TotSal', 'cast(ISNULL(sald_ccn_N_ref,0)+ISNULL(sald_ccn_N_repro,0)+ISNULL(sald_ccn_N_norepro,0) as numeric(17,6))', 'TotSal', 'cal','dp', null) 
  
 
  
insert into @tfil values ('todos', 'fec', ''+@fecs+'')           
insert into @tconf values ('level_alias', 'style')--,('insert_to', '#RESULTPIV')    --drop table #RESULTPIV drop table #FECS        
      
        
      
insert into @tfil            
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output         
        
    select @jerar=@jerar+',"prod_com"'       
      
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf  -- ,@show_query=1          
      
END
