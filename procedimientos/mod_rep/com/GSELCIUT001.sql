-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.377000
  
--exec [com].[GSELCIUT001]  
CREATE PROCEDURE [com].[GSELCIUT001]  
AS  
BEGIN  
 SET NOCOUNT ON;  
  
  SET NOCOUNT ON;    
  
  --exec [rep].[FSHEACOLS01] 'SEL_EFEC_01';  
  exec [rep].[FTHEACOLS01] 'SEL_EFEC_01';  
  ;with cte_f as(    
  select  CONCAT(RCODCIIU,'00') [id],RDESCIIU [desc]  
  from storage.[ref].[REGCIIU003] 
  )  
  select id,[desc]  
  from cte_f    
 
END
