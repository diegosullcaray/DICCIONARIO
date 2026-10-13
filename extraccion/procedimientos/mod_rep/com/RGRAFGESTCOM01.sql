-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-08-09 19:50:11.820000
--exec [com].[RGRAFGESTCOM01] 7,'231','20210930'  
CREATE PROCEDURE [com].[RGRAFGESTCOM01]    
@tip_cod int,@cod_rel varchar(20),@Fecha varchar(10)   
as  
begin  
 SET NOCOUNT ON;     
--declare @Fecha date='20260131', @tip_cod varchar(5)=7, @cod_rel varchar(25)='231'  
------------------------------------    
set @tip_cod= case when @tip_cod='7' then '21' else @tip_cod end
set @cod_rel= case when @cod_rel='231' then '1' else @cod_rel end  
  
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jer varchar(100)                            
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL   
declare @fecs varchar(max)   
  
select *                            
into #FECS              --select * from #FECS              
from storage.util.FVECFEC01(@fecha,'cmg_6')   
  
declare @fec_ date   
set @fec_ =(select rfec from #FECS where rord=1)   
   
  
insert into @tvars                            
values                            
     ('TAPP_Mes_DDiario_flujo_flujo',null,null,null,null,null)   
  ,('Monto_DDiario_flujo_flujo',null,null,null,null,null)  
  
--insert into @tfil values ('todos', 'fec', @fecs)          
 insert into @tfil values('todos','fec','"'+cast(@fec_ as varchar(250))+'"')--,   
  
insert into @tconf                            
values                            
    ('level_alias', 'style') ,  ('fec_corr','true') ,('insert_to','#RDiario')           
  
insert into @tfil                            
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jer output      
  
   
 select @jer = '"fec_dese"'+ ',' +@jer   
  
create table #RDiario   
(  
fila int null,  
cod_fec_dese  varchar(250) null,  
cod_fc varchar(50) null,  
cod_ugru varchar(50) null,  
style int null,  
descripcion varchar(250) null,  
TAPP_Mes_DDiario_flujo_flujo FLOAT NULL,  
Monto_DDiario_flujo_flujo FLOAT NULL  
)  
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1              
        
delete FROM #RDiario WHERE STYLE=2  
  
select * into #DataMostrar from #RDiario where style=1 order by fila asc  
  
;with cte_a as (  
select DAY(cod_fec_dese) day_fec,TAPP_Mes_DDiario_flujo_flujo TAPPD,Monto_DDiario_flujo_flujo MONTOD  
FROM #DataMostrar   --select * from #DataMostrar  
)  
SELECT  
JSON_QUERY(    
 '[' +     
   STRING_AGG('"' + CONVERT(NVARCHAR(MAX), day_fec, 23) + '"', ',')  
 WITHIN GROUP (ORDER BY day_fec ASC) +     
  ']'   
  ) AS categories,    
  
JSON_QUERY(    
'[{    
   "name": "Desemebolsos Diarios",    
                "data": [' + STRING_AGG(CONVERT(NVARCHAR(MAX), MONTOD), ',') WITHIN GROUP (ORDER BY day_fec ASC) + ']    
  },  
{    
  "name": "TAPP Diario",    
  "data": [' + STRING_AGG(CONVERT(NVARCHAR(MAX), TAPPD), ',') WITHIN GROUP (ORDER BY day_fec ASC) + ']    
            }]'   
  
) AS series    
from cte_a  
 FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;    
  
end
