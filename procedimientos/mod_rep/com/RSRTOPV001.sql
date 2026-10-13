-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-12-29 08:42:50.827000

CREATE PROCEDURE [com].[RSRTOPV001]            
@tip_cod nvarchar(10),@tip_cod2 nvarchar(10),@level nvarchar(10),@cod_rel varchar(50)             
AS            
BEGIN            
 -- SET NOCOUNT ON added to prevent extra result sets from            
 SET NOCOUNT ON;            
         
 if @tip_cod2=7        
  begin        
   exec mod_rep.com.RSRTOPTV001 @tip_cod,@tip_cod2,@level,@cod_rel       
  end        
 if @tip_cod2=20        
  begin        
   --exec mod_rep.com.RSRTOPT002 @tip_cod,@level        
   EXEC MOD_REP.[com].[RSRTOPTV002] @tip_cod,@tip_cod2,@level,@cod_rel       
  end        
 if @tip_cod2=18        
  begin        
   exec mod_rep.com.RSRTOPTV003  @tip_cod,@tip_cod2,@level,@cod_rel       
  end        
        
            
END
