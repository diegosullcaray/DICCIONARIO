-- Extraído de mish/strategos el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:42:07.960000
--exec [mod_rep_com_act].[GDPORTAGRO01] 7,231
CREATE PROCEDURE [mod_rep_com_act].[GDPORTAGRO01]      
@tipcod int,@codrel varchar(20)
AS  
BEGIN  
 SET NOCOUNT ON;  
  
 declare @fec date  
  
 select @fec=max(HFECPRO) from [storage].[com_act].[HCDA001]   
   exec storage.[com_act].RSRDFCA021 @tipcod,@codrel,@fec  
  /*
 if(@tipcod=2)  
 begin  
  exec storage.[com_act].RSRDAA021 @codrel,@fec  
 end  
 if(@tipcod=1)  
 begin  
  exec storage.[com_act].RSRDBA021 @codrel,@fec  
 end  
 if(@tipcod=4)  
 begin  
  exec storage.[com_act].RSRDMA021 @codrel,@fec  
 end  
 if(@tipcod=5)  
 begin  
  exec storage.[com_act].RSRDRA021 @codrel,@fec  
 end  
 if(@tipcod=6)  
 begin  
  exec storage.[com_act].RSRDTA021 @codrel,@fec  
 end  
 if(@tipcod=7)  
 begin  
  exec storage.[com_act].RSRDFCA021 @tipcod,@codrel,@fec  
 end 
 if(@tipcod=8)  
 begin  
  exec storage.[com_act].RSRDCA021 @codrel,@fec  
 end    */
END
