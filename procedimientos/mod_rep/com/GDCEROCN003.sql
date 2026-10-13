-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-09-14 17:49:11.543000

 


--EXEC  [com].[GDCEROCN001] 7,'231', '20220614'            
--EXEC  [com].[GDCEROCN002] 7,'231', '20210831'          
CREATE PROCEDURE [com].[GDCEROCN003](          
@tip_cod varchar(5),@cod_rel varchar(25), @fecha date)              
AS                
BEGIN              
 SET NOCOUNT ON;            
-------------          
 ;set language spanish      
 
 SELECT '' JSON
declare @fec date, @fecacumu varchar(250)          
set @fec =(SELECT  max(RFEC)  FROM [storage].[ref].[RCALEN001] WHERE (RFEC)<=@fecha and RDIAFER = 0)                   
          
select * into #Fec from storage.util.FVECFEC01((@fec),'hoy,cie_ant,cie_ant+2,cie_ant+3')b          
--drop table #Fec          
select @fecacumu=string_agg(format(RFEC,'yyyyMMdd'),',')           
from #Fec          
          
;with cte_fechas as (          
 select * from #Fec          
),          
cte_cn as (          
select *           
from storage.[com_act].SDAS020           
where sfecpro in(select rfec from cte_fechas) and scodagr=3              
)          
          
,          
cte_cunormales as (          
select sfecpro,scodagr, SCODSEC , SNUMOPEZC,SSALZCMN          
from storage.[com_act].[SDAS001]          
where sfecpro in(select rfec from cte_fechas) and scodagr=3            
),          
cte_resultCN as (          
select TS.sfecpro, sum(SNUMOPEZCNUE) SNUMOPEZCNUE,          
   sum(SSALZCMNNUE)  SSALZCMNNUE          
from cte_cn TS          
left join storage.ref.FJERCOR02(@fecacumu) JER                         
 on  TS.SCODSEC=JER.RCODSEC     ANd TS.SFECPRO=JER.RFECPRO                         
 WHERE case                           
   when @tip_cod=7 then '231'                          
   when @tip_cod=21 then CAST(JER.RCODGRU AS VARCHAR(250))                           
   when @tip_cod=20 then CAST(JER.RCODTER AS VARCHAR(250))                           
   when @tip_cod=19 then CAST(JER.RCODCOR AS VARCHAR(250))                           
   when @tip_cod=18 then CAST(JER.RCODUNI AS VARCHAR(250))                           
       end = @cod_rel          
 GROUP BY TS.sfecpro          
),          
cte_resulCnormales as (          
select TS.sfecpro, sum(SNUMOPEZC) SNUMOPEZC,          
   sum(SSALZCMN)  SSALZCMN          
from cte_cunormales TS          
left join storage.ref.FJERCOR02(@fecacumu) JER                         
 on  TS.SCODSEC=JER.RCODSEC     ANd TS.SFECPRO=JER.RFECPRO                         
 WHERE case                           
   when @tip_cod=7 then '231'                          
   when @tip_cod=21 then CAST(JER.RCODGRU AS VARCHAR(250))                           
   when @tip_cod=20 then CAST(JER.RCODTER AS VARCHAR(250))                           
   when @tip_cod=19 then CAST(JER.RCODCOR AS VARCHAR(250))                           
   when @tip_cod=18 then CAST(JER.RCODUNI AS VARCHAR(250))                          
       end = @cod_rel           
 GROUP BY TS.sfecpro          
)          
select a.sfecpro ord,format(A.sfecpro,'MMM-yy')sfecpro,          
    a.SNUMOPEZCNUE,a.SSALZCMNNUE,b.SNUMOPEZC,SSALZCMN,  isnull(b.SNUMOPEZC,0) - isnull(a.SNUMOPEZCNUE,0)  as numMantiene, isnull(b.SSALZCMN,0) - isnull(a.SSALZCMNNUE,0) sumMantiene        
from cte_resultCN a          
left join cte_resulCnormales b on a.sfecpro=b.sfecpro          
order by a.SFECPRO asc          
end
