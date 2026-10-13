-- Extraído de mish/strategos el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-15 18:49:33.887000


 --exec [mod_rep_com_act].[GDP_SUPERV01] 7,'231'  
CREATE PROCEDURE [mod_rep_com_act].[GDPSUPERV01]  
@tipcod int,@codrel varchar(20)    
AS    
BEGIN    
 SET NOCOUNT ON;    
    
 declare @fec varchar(50)    
    
 select @fec=max(HFECPRO) from [storage].[com_act].[HCDA001]     
 select @fec =(select cast(@fec as varchar(250)))  
 select @fec =(select replace(@fec,'-',''))  
 exec storage.[com_act].RSRDFCA002 @tipcod,@codrel,@fec   
   
 /*if(@tipcod=2)    
 begin    
  exec storage.[com_act].RSRDAA002 @codrel,@fec    
 end    
 if(@tipcod=1)    
 begin    
  exec storage.[com_act].RSRDBA002 @codrel,@fec    
 end    
 if(@tipcod=4)    
 begin    
  exec storage.[com_act].RSRDMA002 @codrel,@fec  --  
 end    
 if(@tipcod=5)    
 begin    
  exec storage.[com_act].RSRDRA002 @codrel,@fec  --  
 end    
 if(@tipcod=6)    
 begin    
  exec storage.[com_act].RSRDTA002 @codrel,@fec  --  
 end    
 if(@tipcod=7)    
 begin    
  exec storage.[com_act].RSRDFCA002 @fec  --  
 end   
 if(@tipcod=8)    
 begin    
  exec storage.[com_act].RSRDCA002 @codrel,@fec  --  
 end    */  
END
