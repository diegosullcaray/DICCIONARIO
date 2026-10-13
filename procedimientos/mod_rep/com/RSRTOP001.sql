-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:33.200000
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [com].[RSRTOP001]    
@tip_cod nvarchar(10),@level nvarchar(10)     
AS    
BEGIN    
 -- SET NOCOUNT ON added to prevent extra result sets from    
 SET NOCOUNT ON;    
 
 if @tip_cod=7
  begin
   exec mod_rep.com.RSRTOPT001 @tip_cod,@level
  end
 if @tip_cod=14
  begin
   exec mod_rep.com.RSRTOPT002 @tip_cod,@level
  end
 if @tip_cod=11
  begin
   exec mod_rep.com.RSRTOPT003 @tip_cod,@level
  end

    
END
