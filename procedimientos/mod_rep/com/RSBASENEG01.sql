-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-01-30 12:28:11.877000

--exec [com].[RSBASENEG01]
CREATE  PROCEDURE [com].[RSBASENEG01]    
@nom varchar(80) = ''
AS        
BEGIN          
 set nocount on;   
 
 select '' [json]
  
  declare @buscador varchar(300), @sql varchar(max) 
  if(@nom = '') begin
  set @buscador = '' end
  else begin
  set @buscador = ' where HCTACLI like ''' +@nom+ '%'' or HDESCLI like ''' +@nom+ '%''  '
  end



  set @sql = '  
				 ;WITH DatosCastigos as (  
				   select distinct HCTACLI, HDESCLI, HFECCAS FECHA, ''CASTIGOS'' TIPO
				 from storage.[com_act].HCCA001  
					'+@buscador+'  
				 )
				 select  * from DatosCastigos order by FECHA desc
  '  
  
  -- print @sql  

   
  exec (@sql)  
 
END
