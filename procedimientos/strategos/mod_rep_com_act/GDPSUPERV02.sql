-- Extraído de mish/strategos el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-15 18:50:02.827000


 --exec [mod_rep_com_act].[GDP_SUPERV02] 7,'231'  
CREATE PROCEDURE [mod_rep_com_act].[GDPSUPERV02]  
@tipcod int,@codrel varchar(20)    
AS    
BEGIN    
 SET NOCOUNT ON;    
    
 declare @fec varchar(50)    
    
 select @fec=max(HFECPRO) from [storage].[com_act].[HCDA001]     
 select @fec =(select cast(@fec as varchar(250)))  
 select @fec =(select replace(@fec,'-',''))  
 exec storage.[com_act].RSRDFCA003 @tipcod,@codrel,@fec   
END
