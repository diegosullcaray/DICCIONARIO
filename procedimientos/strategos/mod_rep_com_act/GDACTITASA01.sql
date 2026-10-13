-- Extraído de mish/strategos el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:42:07.523000
CREATE PROCEDURE [mod_rep_com_act].[GDACTITASA01]
@tipcod int,@codrel varchar(20)       
AS      
BEGIN      
 SET NOCOUNT ON;      
      
 declare @fec date      
      
 select @fec=max(HFECPRO) from [storage].[com_act].HCDA001   
 exec    storage.[com_act].[RSRDFCA014] @tipcod,@codrel,@fec     
 /*
 if(@tipcod=4)      
 begin      
  exec storage.[com_act].RSRDMA014 @codrel,@fec      
 end      
 if(@tipcod=5)      
 begin      
  exec storage.[com_act].RSRDRA014 @codrel,@fec      
 end      
 if(@tipcod=6)      
 begin      
  exec storage.[com_act].RSRDTA014 @codrel,@fec      
 end      
 if(@tipcod=7)      
 begin      
  exec storage.[com_act].RSRDFCA014 @fec      
 end      
 if(@tipcod=8)      
 begin      
  exec storage.[com_act].RSRDCA014 @codrel,@fec      
 end     
 */ 
END
