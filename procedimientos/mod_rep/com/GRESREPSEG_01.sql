-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2026-08-11 16:23:07.463000
--exec mod_rep.[com].[GRESREPSEG02] 18,'40'                  
-- exec mod_rep.[com].[GRESREPSEG_01] 7,'231','20260731'     --28124                
--pre                    
CREATE procedure [com].[GRESREPSEG_01]                     
@tip_cod int,                        
@cod_rel varchar(10),
@fec date
AS                        
BEGIN                       
  SET NOCOUNT ON;             
   
      
DECLARE @dFechaMax date = (select max(rfec) from storage.ref.RCALEN001 where rfec<=@fec and RDIAFER=0)
                  --select MAX(SFECPRO) from storage.[com_seg].SDSF001)    



/* Meta */    
 DECLARE @FecMeta date,@FecJerar date    
set @FecMeta=@dFechaMax--(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR=5001 )    
set @FecJerar=@dFechaMax--(select max(rfecpro) from storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' )    
       
select * into #fjercor02 from storage.ref.fjercor02(@FecJerar)

;WITH CTE_A AS (      
select *      
from [storage].[com].[VDMCOM01]      
where HTIPCOD=case when @tip_cod=7 then  '21'      
       when @tip_cod=21 then '20'      
    when @tip_cod=20 then '19'      
       when @tip_cod=19 then '18'             
       when @tip_cod=18 then '17'
	   when @tip_cod=17 then '2'
	   end and hcodvar=5001 and hfecpro=eomonth(@dFechaMax)        
)       
 ,      
CTE_B AS (      
SELECT DISTINCT CASE WHEN @tip_cod=7 THEN CAST(RCODGRU  AS VARCHAR(250))      
      WHEN @tip_cod=21 THEN CAST(RCODTER AS VARCHAR(250))      
      WHEN @tip_cod=20 THEN CAST(RCODCOR AS VARCHAR(250))      
      WHEN @tip_cod=19 THEN CAST(RCODUNI AS VARCHAR(250))       
      WHEN @tip_cod=18 THEN CAST(RCODUCO AS VARCHAR(250)) 
	  WHEN @tip_cod=17 THEN CAST(RCODSEC AS VARCHAR(250)) 
	  END   RCOD      
      
FROM #fjercor02--storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' AND RFECPRO=@FecJerar    
where CASE WHEN @tip_cod='21' THEN CAST(RCODGRU AS VARCHAR(250))       
         WHEN @tip_cod='20' THEN CAST(RCODTER AS VARCHAR(250))      
         WHEN @tip_cod='19' THEN CAST(RCODCOR AS VARCHAR(250))      
         WHEN @tip_cod='18' THEN CAST(RCODUNI AS VARCHAR(250)) 
		 WHEN @tip_cod='17' THEN CAST(RCODUCO AS VARCHAR(250)) 
		 ELSE '1' END = IIF(@tip_cod=7,'1',@cod_rel)       
),      
CTE_C AS (      
SELECT B.RCOD HCODREL,HVALVAR      --select * from  storage.[ref].WJERCOR03 where rindfec='actual' and rfecpro='20260731'
FROM CTE_A A      
LEFT JOIN CTE_B B      
ON A.HCODREL=B.RCOD      
)  ,      
CTE_D AS (      
SELECT '0' HCODREL,SUM(HVALVAR) SMETSEGINC      
FROM CTE_C      
WHERE HCODREL IS NOT NULL      
UNION ALL      
SELECT HCODREL,SUM(HVALVAR)      
FROM CTE_C      
WHERE HCODREL IS NOT NULL      
GROUP BY HCODREL      
)      
SELECT * INTO #Meta_Vr2 FROM CTE_D     
  
    
;with cte_a as (    
select * from   storage.[com_act].[SDAF002]                 
WHERE SFECPRO=@dFechaMax AND SCODAGR=6 --AND SCODMOD=104 -- EMPRENDIENDO CONFIANZA         
),    
cte_b as (    
select a.*,c.HCODSEG,c.HDESSEG from cte_a a    
left join  storage.com_seg.retp003 c  --select * from  storage.com_seg.retp003    
on a.SCODMOD=c.hcodmod and a.STIPOPE=c.HTIPOPE and a.SSUBTIP=c.HSUBTIP    
),    
cte_c as (    
select * from cte_b where HCODSEG is not null    
),    
cte_d as (    
SELECT '0' SCODDESCRIP,HDESSEG,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'                
   when @tip_cod=21 then C.RDESGRU                
   when @tip_cod=20 then C.RDESTER                
   when @tip_cod=19 then C.RDESCOR                
   when @tip_cod=18 then C.RDESUNI        
   when @tip_cod=17 then C.RDESUCO END descripcion,SUM(A.SNUMOPE)  SNUMOPE                
FROM cte_c A                
LEFT JOIN #fjercor02 C
--storage.[ref].WJERCOR03 C 
on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO              
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                               
     when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                            
     when @tip_cod=19 then  CAST(c.RCODCOR AS VARCHAR(250))                                  
      when @tip_cod=18 then CAST(c.RCODUNI AS VARCHAR(250))        
  when @tip_cod=17 then     CAST(c.RCODUCO AS VARCHAR(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                 
GROUP BY HDESSEG,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'                
   when @tip_cod=21 then C.RDESGRU                
   when @tip_cod=20 then C.RDESTER                
   when @tip_cod=19 then C.RDESCOR                
   when @tip_cod=18 then C.RDESUNI        
   when @tip_cod=17 then C.RDESUCO END              
UNION ALL                
SELECT CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')                
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))                
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))                
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))                
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))        
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,                
  HDESSEG,CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')                
   when @tip_cod=21 then C.RDESTER                
   when @tip_cod=20 then C.RDESCOR                
   when @tip_cod=19 then C.RDESUNI                
   when @tip_cod=18 then C.RDESUCO        
   when @tip_cod=17 then C.RDESSEC END,SUM(A.SNUMOPE)                 
FROM cte_c A --SELECT * FROM storage.[ref].WJERCOR01                
LEFT JOIN #fjercor02 C --storage.[ref].WJERCOR03 C 
on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO                
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                               
     when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                            
     when @tip_cod=19 then CAST(c.RCODCOR AS VARCHAR(250))                                  
     when @tip_cod=18 then CAST(c.RCODUNI AS VARCHAR(250))        
  when @tip_cod=17 then    CAST(c.RCODUCO AS VARCHAR(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                 
GROUP BY  CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')                
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))                
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))                
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))                
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))        
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,                
    HDESSEG,CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')                
   when @tip_cod=21 then C.RDESTER                
   when @tip_cod=20 then C.RDESCOR                
   when @tip_cod=19 then C.RDESUNI                
   when @tip_cod=18 then C.RDESUCO        
   when @tip_cod=17 then C.RDESSEC END     
),                
CTE_SEG_PC AS (                
SELECT *,                
   CASE WHEN scodseg in(802,824) THEN 'S_PC'                
     WHEN SCODSEG in(806,815,825) THEN 'S_AG'                
     WHEN SCODSEG in(803,817) THEN 'S_MC'                
 WHEN SCODSEG in(200,220,230) THEN 'S_MR'          
 when scodseg in(814,828) then 'S_ONCO'          
  when scodseg=822 then 'S_PT'          
     END SEG                
FROM storage.[com_seg].SDSF001                  
where sfecpro=@dFechaMax  and scodagr=6 --and scodseg in(802)                 
),               
CTE_SEG_PC_JER AS (                
SELECT '0' SCODDESCRIP,SEG,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'                
   when @tip_cod=21 then C.RDESGRU                
   when @tip_cod=20 then C.RDESTER               
   when @tip_cod=19 then C.RDESCOR                
   when @tip_cod=18 then C.RDESUNI        
   when @tip_cod=17 then C.RDESUCO END descripcion,SUM(A.SNUMPLZ)  SNUMPLZ                
FROM CTE_SEG_PC A                
LEFT JOIN #fjercor02 C --storage.[ref].WJERCOR03 C 
on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO        
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                               
         when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                            
         when @tip_cod=19 then CAST(c.RCODCOR AS VARCHAR(250))                                  
         when @tip_cod=18 then CAST(c.RCODUNI AS VARCHAR(250))        
   when @tip_cod=17 then    CAST(c.RCODUCO AS VARCHAR(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                 
GROUP BY SEG,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'                
   when @tip_cod=21 then C.RDESGRU                
   when @tip_cod=20 then C.RDESTER               
   when @tip_cod=19 then C.RDESCOR                
   when @tip_cod=18 then C.RDESUNI        
   when @tip_cod=17 then C.RDESUCO END               
UNION ALL                
SELECT CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')                
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))                
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))                
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))                
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))        
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,                
  SEG,CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')                
   when @tip_cod=21 then C.RDESTER                
   when @tip_cod=20 then C.RDESCOR               
   when @tip_cod=19 then C.RDESUNI                
   when @tip_cod=18 then C.RDESUCO        
   when @tip_cod=17 then C.RDESSEC END,SUM(A.SNUMPLZ)  SNUMPLZ                
FROM CTE_SEG_PC A --SELECT * FROM storage.[ref].WJERCOR01                
LEFT JOIN #fjercor02 C --storage.[ref].WJERCOR03 C 
on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO             
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                               
         when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                            
         when @tip_cod=19 then cast(c.RCODCOR as varchar(250))                                  
         when @tip_cod=18 then cast(c.RCODUNI as varchar(250))        
   when @tip_cod=17 then cast(c.RCODUCO as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                
GROUP BY  CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')                
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))                
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))                
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))                
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))        
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,                
    SEG,CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')                
   when @tip_cod=21 then C.RDESTER               
   when @tip_cod=20 then C.RDESCOR                
   when @tip_cod=19 then C.RDESUNI                
   when @tip_cod=18 then C.RDESUCO        
   when @tip_cod=17 then C.RDESSEC END                
),             
CTE_RESULT AS (                
SELECT *                 
FROM cte_d                
UNION ALL                
SELECT *                
FROM CTE_SEG_PC_JER                
WHERE descripcion  IS NOT NULL AND SEG IS NOT NULL                
)         
     
    
SELECT SCODDESCRIP,DESCRIPCION, AGRO, MultiRiesgo, Oncologico, [Protección de cuotas], [Protección Total Crédito],[Vida Segura], S_MC,S_MR,S_ONCO,S_PC,S_PT,S_AG    
into #TABRESULT --DROP TABLE #TABRESULT        select * from #TABRESULT        
FROM                   
(SELECT SNUMOPE, HDESSEG, DESCRIPCION ,SCODDESCRIP                 
FROM CTE_RESULT) p                  
PIVOT                  
(             
SUM (SNUMOPE)                  
FOR HDESSEG IN                  
( AGRO, MultiRiesgo, Oncologico, [Protección de cuotas], [Protección Total Crédito],[Vida Segura], S_MC,S_MR,S_ONCO,S_PC,S_PT,S_AG)                  
) AS pvt                  
ORDER BY pvt.SCODDESCRIP;     
    
select descripcion RNOMSUB,    
[Protección de cuotas],S_PC SegPC ,cast(S_PC as float) / [Protección de cuotas] PorcPenPC,    
[Vida Segura] TOpeMC,S_MC SegMC ,cast(S_MC as float)/[Vida Segura]  PorcPenMC,    
AGRO TOpeAgro,S_AG  SegAgro, case when S_AG is null then 0 else cast(S_AG as float)/AGRO end PorcPenAgro,    
MultiRiesgo TOpeMR,S_MR SegMR, cast(S_MR as float)/ MultiRiesgo PorcPenMR,    
Oncologico TOpeOnco,S_ONCO SegOnco, cast(S_ONCO as float)/ Oncologico  PorcPenOnco,    
[Protección Total Crédito], S_PT segPT , cast(S_PT as float) /[Protección Total Crédito] PorcPenPT    
into #R1    
from #TABRESULT  --select * from #TABRESULT    
    
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)      
declare @tvarsPRD as piv.TPIVVAR, @tconfPRD as piv.TPIVCONF, @tfilPRD as piv.TPIVFIL      
insert into @tvars  values ('num_ope_sf2', null, '5006', null, null, null)    
insert into @tfil values ('todos', 'fec', '"'+cast(@dFechaMax as varchar)+'"')      
insert into @tconf values ('level_alias', 'style')    
insert into @tfil      
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output      
    
create table #TP (    
fila int null,cod_fc varchar(250)null,cod_ugru varchar(250) null,style int null,descripcion varchar(250)null,numope int null)    
insert into #TP    
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf--,@show_query=1      
      
declare @headers varchar(max)    
select @headers  ='[                       
   { "label":"Descripción","key":"RNOMSUB","sticky": "true","cellStyle":{"text-align":"left","max-width":"190px","min-width":"190px","width":"190px"}},                      
   { "label":"Total de Operaciones y Seguros",  
   "subs":[ {"label": "Tot.Operaciones","key":"TOpeOS","format":{"type":"decimal"}, "cellStyle":{"text-align":"right","max-width":"40px","min-width":"40px","width":"40px"},"style":{"min-width":"80px","width":"80px"}} ,                 
            {"label": "Tot. Seguros","key":"TSegOS","format":{"type":"decimal"},"cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"style":{"min-width":"80px","width":"80px","background":"#10b981"}},
			{"label": "Meta","key":"MetaT","format":{"type":"decimal"},"cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"style":{"min-width":"80px","width":"80px","background":"#E3DB42"}},
			{"label": "%Cump. T","key":"CumpT","format":{"type":"percent", "mode":".2-2"} ,"cellStyle":{"text-align":"right","max-width":"80px","min-width":"80px","width":"80px"},"style":{"min-width":"80px","width":"80px","background":"#198754"}},
   {"label": "% Penetración","key":"PorcPenOS","cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"},"format":{"type":"percent"}},  
   {"label": "MultiRiesgo","key":"SMROS","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px","background":"#10b981"}},  
   {"label": "Vida Segura","key":"SMCOS","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px","background":"#10b981"}},  
   {"label": "Agro","key":"SegAgro","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px","background":"#10b981"}},  
    {"label": "Prot. Cuota","key":"SegPC","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px","background":"#10b981"}},  
	{"label": "Oncologico","key":"SegOnco","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"70px","width":"70px","background":"#10b981"}},  
   {"label": "Prot. Total","key":"SPCCOS","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px","background":"#10b981"}} ]},  
     
   { "label":"MultiRiesgo",  
   "subs":[ {"label": "Tot.Operaciones","key":"TOpeMR","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},                
      {"label": "Seguro MultiRiesgo","key":"SegMR","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px","background":"#10b981"}},  
   {"label": "% Penetración Multiriesgo","key":"PorcPenMR","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"},"format":{"type":"percent"}}]},  
   
  
    { "label":"Agropecuario",  
   "subs":[ {"label": "Tot.Operaciones","key":"TOpeAgro","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},                
      {"label": "Seguro Agro.","key":"SegAgro","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px","background":"#10b981"}},  
   {"label": "% Penetración Agro","key":"PorcPenAgro","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"},"format":{"type":"percent"}}]},  
  
 { "label":"Vida Segura",  
   "subs":[ {"label": "Tot.Operaciones","key":"TOpeMC","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},                
      {"label": "Seguro Vida Segura.","key":"SegMC","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px","background":"#10b981"}},  
   {"label": "% Penetración Vida Segura.","key":"PorcPenMC","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"},"format":{"type":"percent"}}]},  
  
 { "label":"Prot. Cuota",  
   "subs":[ {"label": "Tot.Operaciones","key":"TOpePC","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},                
      {"label": "Seguro Prot.Cuota","key":"SegPC","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px","background":"#10b981"}},  
   {"label": "% Penetración PC","key":"PorcPenPC","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"},"format":{"type":"percent"}}]},  
  
{ "label":"Oncologico",  
   "subs":[ {"label": "Tot.Operaciones","key":"TOpeOnco","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},                
      {"label": "Seguro Onco.","key":"SegOnco","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px","background":"#10b981"}},  
   {"label": "% Penetración Onco.","key":"PorcPenOnco","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"},"format":{"type":"percent"}}]},  
  
{ "label":"Prot. Total",  
   "subs":[ {"label": "Tot.Operaciones","key":"TOpePT","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"}},                
      {"label": "Seguro Prot.Total","key":"segPT","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px","background":"#10b981"}},  
   {"label": "% Penetración PT","key":"PorcPenPT","format":{"type":"decimal"},"cellStyle":{"text-align":"right"},"style":{"min-width":"100px","width":"100px"},"format":{"type":"percent"}}]}  
   ] '                          
                 
                
select @headers    
    
    
  
select a.style,   
case when @tip_cod=7 and cod_ugru is not null then 21  
     when @tip_cod=21 and cod_ugru is not null then 20  
  when @tip_cod=20  and cod_ugru is not null then 19  
  when @tip_cod=19  and cod_ugru is not null then 18  
  when @tip_cod=18  and cod_ugru is not null then 17  
  when @tip_cod=17  and cod_ugru is not null then 2  
  else @tip_cod end htipcod,  
cod_fc  
,isnull(cod_ugru,@cod_rel) hcodrel,  
  
a.descripcion RNOMSUB,numope TOpeOS,    
     
[Protección de cuotas] TOpePC ,SegPC,PorcPenPC,TOpeMC,SegMC,PorcPenMC,TOpeAgro,SegAgro,PorcPenAgro,TOpeMR,SegMR,PorcPenMR,TOpeOnco,SegOnco,PorcPenOnco,[Protección Total Crédito] TOpePT,    
segPT,PorcPenPT     
,isnull(SegPC,0) + isnull(SegMC,0) + isnull(SegAgro,0) + isnull(SegMR,0) + isnull(SegOnco,0) + isnull(segPT,0)  TSegOS,    
cast((isnull(SegPC,0) + isnull(SegMC,0) + isnull(SegAgro,0) + isnull(SegMR,0) + isnull(SegOnco,0) + isnull(segPT,0) ) as float) / a.numope PorcPenOS,    
    
SegMR SMROS,SegMC SMCOS ,segPT SPCCOS ,
c.SMETSEGINC  MetaT,
 CASE WHEN c.SMETSEGINC=0 THEN 0 ELSE (isnull(SegPC,0) + isnull(SegMC,0) + isnull(SegAgro,0) + isnull(SegMR,0) + isnull(SegOnco,0) + isnull(segPT,0)) / c.SMETSEGINC  END 'CumpT'

from #TP a  --select * from #TP    
left join #R1 b    
on a.descripcion=b.RNOMSUB    
left join (select * from #Meta_Vr2) C on isnull(a.cod_ugru,0) =c.HCODREL 
    
                       
END
