-- Extraído de mish/strategos el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:42:07.663000

create PROCEDURE [mod_rep_com_act].[GDCCAP_BP01]
@tipcod int,@codrel varchar(20),@cod_rel_2 varchar(20) =null 
AS    
BEGIN    
 SET NOCOUNT ON;    
    
 declare @fec varchar(50)        
    
 select @fec=max(HFECPRO) from [storage].[com_pas].[HCDP001]    
 select @fec =(select cast(@fec as varchar(250)))
 select @fec =(select replace(@fec,'-','')) 
    
 --1 Codigo BT  
 --2 DNI  
 --3 Codigo Agencia  
 --4 Codigo Matriz  
 --5 Codigo Region  
 --6 Codigo Territorio  
 --7 FC   
  declare @zcod varchar(250)  

exec mod_rep.[com].[RSRDFCP004] @tipcod,@codrel,@fec

  /*
 if(@tipcod=4)    
 begin    
 --select @zcod=storage.util.FUTPART(@codrel,'-',4),@codrel=storage.util.FUTPART(@codrel,'-',1)  
  exec storage.[com_pas].RSRDMP004 @cod_rel_2,@codrel,@fec    
 end   
 if(@tipcod=5)    
 begin    
 --select @zcod=storage.util.FUTPART(@codrel,'-',3),@codrel=storage.util.FUTPART(@codrel,'-',1)  
 exec storage.[com_pas].RSRDRP004 @cod_rel_2,@codrel,@fec    
 end   
 if(@tipcod=6)    
 begin    
 --select @zcod=storage.util.FUTPART(@codrel,'-',2),@codrel=storage.util.FUTPART(@codrel,'-',1)  
 exec storage.[com_pas].RSRDTP004 @cod_rel_2,@codrel,@fec    
 end   
 if(@tipcod=9)    
 begin    
  exec storage.[com_pas].RSRDBPP004 @codrel,@fec    
 end   
 if(@tipcod=7)    
 begin    
 exec storage.[com_pas].RSRDFCP004 @fec    
   
 end   
    */
END
