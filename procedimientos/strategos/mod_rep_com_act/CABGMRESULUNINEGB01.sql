-- Extraído de mish/strategos el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-07-25 18:21:34.257000
--exec [mod_rep_com_act].[CABGMRESULUNINEGB01] 7,'231','20201130','Red'    
CREATE PROCEDURE [mod_rep_com_act].[CABGMRESULUNINEGB01]                
@tipcod int,@codrel varchar(20),@fec date ,@canal varchar(250)       
AS                
BEGIN          
      
 if(@tipcod between 4 and 6)         
 BEGIN      
   exec storage.[com].[CABRSRMFCN001] @codrel, @fec, @tipcod         
   exec strategos.[mod_rep_com_act].[GMRESULUNINEGB01]  @tipcod, @codrel, @fec,@canal       
 END           
ELSE      
BEGIN      
  exec storage.[com].[CABRSRMFCN001] 231, @fec, @tipcod          
  exec strategos.[mod_rep_com_act].[GMRESULUNINEGB01]  @tipcod, @codrel, @fec,@canal       
END            
END
