-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-08-22 18:21:55.700000
--exec [com].[RSRDFCA022] 7,'231','20210922'    
CREATE PROCEDURE [com].[RSRDFCA022]        
@tipcod int,@codrel varchar(20)--,@fec date          
AS            
BEGIN            
 SET NOCOUNT ON;       
    
  declare @fec date              
              
 select @fec=max(SFECPRO) from storage.[com_act].SDAF001      
--declare @tipcod int=7,@codrel varchar(20)='231',@fec date ='20210922'         
select ROW_NUMBER() OVER(ORDER BY RFEC ASC) AS Row#,RFEC into #FecMensual --drop table  #FecMensual    
FROM  [storage].[ref].[RCALEN001]        
WHERE MONTH(RFEC)=MONTH(@FEC) and YEAR(RFEC)=YEAR(@FEC)     
    
exec  strategos.[mod_rep_com_act].[CABDESEDIAR01] @tipcod,@codrel      
    
declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF    
    
    
 insert into @tvars values         
 ('num_ope_ce02',null,null,null,null,null)       
         
 insert into @tfil        
 values        
 ('todos','fec','"'+cast(@fec as varchar(250))+'"')--,        
    
 insert into @tconf        
  values        
  ('level_alias','style'),    
  --('insert_to','#report'),    
  ('fec_corr','true')    
    
    
 declare @jer varchar(100)    
 insert into @tfil        
 exec piv.GPIVLEV01 @tipcod,@codrel,@jer output       
    
 select @jer = '"fec_dese_h"'+ ',' +@jer     
     
 create table #T(fila int,cod_fc varchar(250)null,cod_cter varchar(250)null,cod_fec varchar(250),style int null, descripcion varchar(250)null,Ope int null)    
 insert into #T --drop table #T    
     
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1        
       
select a.Row# as ID,a.RFEC,isnull(b.cod_cter,'') cod_cter,    
 isnull(b.cod_fec,'') cod_fec,isnull(b.style,'')style,isnull(b.descripcion,'') descripcion,isnull(b.Ope,0) Ope    
 into #Tabla --drop table #Tabla    
 from #FecMensual a    
 left join (select * from #T where style in(1,0))b    
 on a.RFEC=b.cod_fc    
    
    
 DECLARE @Query nvarchar(max);    
    
--Primero ponemos las columnas sobre las cuales agruparemos    
SET @Query = N'SELECT style,descripcion' + NCHAR(10)     
--Después colocamos las columnas que vamos a transponer    
+ ( SELECT REPLACE( N',MAX( CASE WHEN id = <<id>> THEN Ope END) AS Ope<<id>>,    
 MAX( CASE WHEN id = <<id>> THEN ''NULL'' ELSE ''#ec9f9f'' END) AS background_<<id>>', N'<<id>>', id)+ NCHAR(10)    
    FROM #Tabla    
    --Eliminamos duplicados usando GROUP BY    
    GROUP BY id    
    --Definimos el orden de las columnas    
    ORDER BY id    
    --Usamos esta instrucción para concatenar los valores    
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')    
--Ponemos el resto de la consulta    
+ N'FROM #Tabla    
where descripcion<>''''    
GROUP BY descripcion,style    
order by style desc    
;'    
    
--Esto es para fines de debugging    
--PRINT @Query    
    
--Ejecutamos el código dinámico    
    
EXEC sp_Executesql @Query;    
end
