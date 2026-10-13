-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-14 17:38:41.287000
--EXEC  [com].[GDCEROCN002] '11','TRGAC100', '20211031'           
CREATE PROCEDURE [com].[GDCEROCN004](          
@tip_cod varchar(5),@cod_rel varchar(25), @fecha date)              
AS                
BEGIN              
 SET NOCOUNT ON;            
-------------          
 ;set language spanish          
 select '' json

declare @fec date, @fecacumu varchar(250)          
set @fec =(SELECT  max(RFEC)  FROM [storage].[ref].[RCALEN001] WHERE (RFEC)<=@fecha and RDIAFER = 0)                   
          
select * into #Fec from storage.util.FVECFEC01((@fec),'hoy,cie_ant,cie_ant+2,cie_ant+3,cie_ant+4,cie_ant+5,cie_ant+6,cie_ant+7,cie_ant+8,cie_ant+9,cie_ant+10,cie_ant+11')b          
--drop table #Fec drop table #cte_a          
select @fecacumu=string_agg(format(RFEC,'yyyyMMdd'),',')           
from #Fec          
          
;with cte_a as (          
select * ,          
 case when HDIAATR<=8 then 1           
   when HDIAATR between 9 and 15 then 2          
   when HDIAATR between 16 and 30 then 3          
   when HDIAATR>=31 then 4 else null end regD          
from storage.[com_act].WCUONUEV001           
),          
cte_datos as (          
select * from cte_a where regD is not null          
)          
select ts.sfecpro,regD,isnull(SNUMOPEZCNUE,0)SNUMOPEZCNUE,isnull(SSALZCMNNUE,0)SSALZCMNNUE          
into #cte_a   --drop table #cte_a          
from cte_datos TS          
left join storage.ref.FJERCOR02(@fecacumu) JER               --select * from storage.ref.FJERCOR01('20210915')          
 on  TS.SCODSEC=JER.RCODSEC     ANd TS.SFECPRO=JER.RFECPRO                         
 WHERE case                           
   when @tip_cod=7 then '231'                          
   when @tip_cod=21 then CAST(JER.RCODGRU AS VARCHAR(250))                         
   when @tip_cod=20 then CAST(JER.RCODTER AS VARCHAR(250))                         
   when @tip_cod=19 then CAST(JER.RCODCOR AS VARCHAR(250))                         
   when @tip_cod=18 then CAST(JER.RCODUNI AS VARCHAR(250))                              
       end = @cod_rel           
  --select sum(SNUMOPEZCNUE),sum(SSALZCMNNUE)  from #cte_a where sfecpro='2021-09-13'          
      
insert into #cte_a      
select '',1,0,0 union all      
select '',2,0,0 union all      
select '',3,0,0 union all      
select '',4,0,0        
          
declare @Query nvarchar(max)          
          
SET @Query = N'SELECT sfecpro ord,format(sfecpro,''MMM-yy'') sfecpro ' + NCHAR(10)                                         
--Después colocamos las columnas que vamos a transponer                                        
+ ( SELECT REPLACE( N',sum( CASE WHEN regD = <<regD>> THEN isnull(SNUMOPEZCNUE,0) END) AS num_trans<<regD>>                                        
    ,sum( CASE WHEN regD = <<regD>> THEN isnull(SSALZCMNNUE,0) END) AS sum_monto<<regD>>', N'<<regD>>', regD)+ NCHAR(10)                                        
    FROM #cte_a     --DROP TABLE #temp1     SELECT * FROM #temp1                          
    --Eliminamos duplicados usando GROUP BY                                        
    GROUP BY regD                                       
 --Definimos el orden de las columnas                                        
    ORDER BY regD                                        
    --Usamos esta instrucción para concatenar los valores                                        
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                        
--Ponemos el resto de la consulta                                        
+ N'FROM #cte_a         
where   sfecpro<>''1900-01-01''                            
GROUP BY sfecpro               
order by  ord  asc                         
'                    
EXEC sp_Executesql @Query;               
        
end
