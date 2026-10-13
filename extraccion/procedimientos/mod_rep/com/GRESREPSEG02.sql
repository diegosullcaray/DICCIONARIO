-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-07 05:49:00.313000
--exec mod_rep.[com].[GRESREPSEG02] 18,'40'          
-- exec mod_rep.[com].[GRESREPSEG02] 7,'231'            
--pre            
CREATE procedure [com].[GRESREPSEG02]             
@tip_cod int,                
@cod_rel varchar(10)                
AS                
BEGIN               
  SET NOCOUNT ON;               
            
 /*DECLARE @tip_cod int=11,                
@cod_rel varchar(10) ='TWIDC002' */          
  DECLARE @dFechaMax date = (select MAX(SFECPRO) from storage.[com_seg].SDSF001)               
           
   ;WITH CTE_A AS (        
SELECT *,        
    CASE WHEN SCODMOD=104   AND STIPOPE=2   AND SSUBTIP=99 THEN 'TO_IN'        
      WHEN SCODMOD=104  AND STIPOPE IN(1,2,130)   AND SSUBTIP IN(1,6,8,34,36,5000,9991,2,3,4,5,7,11,12,35,99,1000,9990) THEN 'TO_EC'        
   WHEN SCODMOD=101  AND STIPOPE IN(1,2,4)  THEN 'TO_AG'         
   WHEN SCODMOD=103 AND STIPOPE=36 THEN 'TO_CC'        
   WHEN SCODMOD=103 AND STIPOPE=2 THEN 'TO_CO'         
   WHEN SCODMOD=103 AND STIPOPE=120 THEN 'TO_CE'        
   WHEN SCODMOD=102   AND STIPOPE=12 THEN 'TO_IC'   
   when scodmod =101 and stipope in(1,2) and ssubtip in(101,0) then 'TO_ONCO'  
   when scodmod =102 and stipope=12 and ssubtip=0 then 'TO_ONCO'  
   when scodmod =103 and stipope in(2,36,120) and ssubtip in(101,0) then  'TO_ONCO'  
   when  scodmod =104 and stipope in(2,12) and ssubtip in(101,0)   then 'TO_ONCO'   
   END SEG        
FROM storage.[com_act].[SDAF002]         
WHERE SFECPRO=@dFechaMax AND SCODAGR=6 --AND SCODMOD=104 -- EMPRENDIENDO CONFIANZA        
),        
cte_b as (        
SELECT '0' SCODDESCRIP,SEG,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'        
   when @tip_cod=21 then C.RDESGRU        
   when @tip_cod=20 then C.RDESTER        
   when @tip_cod=19 then C.RDESCOR        
   when @tip_cod=18 then C.RDESUNI
   when @tip_cod=17 then C.RDESUCO END descripcion,SUM(A.SNUMOPE)  SNUMOPE        
FROM CTE_A A        
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO and RINDFEC='ACTUAL'         
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                       
     when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                    
     when @tip_cod=19 then c.RCODCOR                          
      when @tip_cod=18 then c.RCODUNI
	 when @tip_cod=17 then c.RCODUCO else '1' end=IIF(@tip_cod=7,'1',@cod_rel)         
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
   when @tip_cod=17 then C.RDESSEC END,SUM(A.SNUMOPE)         
FROM CTE_A A --SELECT * FROM storage.[ref].WJERCOR01        
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO and RINDFEC='ACTUAL'         
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                       
     when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                    
     when @tip_cod=19 then c.RCODCOR                          
     when @tip_cod=18 then c.RCODUNI
	 when @tip_cod=17 then c.RCODUCO else '1' end=IIF(@tip_cod=7,'1',@cod_rel)         
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
CTE_SEG_PC AS (        
SELECT *,        
   CASE WHEN scodseg=802 THEN 'S_PC'        
     WHEN SCODSEG in(806,815) THEN 'S_AG'        
     WHEN SCODSEG=803 THEN 'S_MC'        
 WHEN SCODSEG in(200,220,230) THEN 'S_MR'  
 when scodseg=814 then 'S_ONCO'        
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
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO and RINDFEC='ACTUAL'         
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                       
         when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                    
         when @tip_cod=19 then c.RCODCOR                          
         when @tip_cod=18 then c.RCODUNI
		 when @tip_cod=17 then c.RCODUCO else '1' end=IIF(@tip_cod=7,'1',@cod_rel)         
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
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO and RINDFEC='ACTUAL'         
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
FROM cte_b        
UNION ALL        
SELECT *        
FROM CTE_SEG_PC_JER        
WHERE descripcion  IS NOT NULL AND SEG IS NOT NULL        
)        
         
SELECT SCODDESCRIP,DESCRIPCION, TO_IC, TO_CE, TO_EC, TO_CC, TO_CO , TO_IN,TO_AG,TO_ONCO,S_PC,S_AG,S_MC,S_MR ,S_ONCO       
into #TABRESULT --DROP TABLE #TABRESULT        
FROM           
(SELECT SNUMOPE, SEG, DESCRIPCION ,SCODDESCRIP         
FROM CTE_RESULT) p          
PIVOT          
(     
SUM (SNUMOPE)          
FOR SEG IN          
( TO_IC, TO_CE, TO_EC, TO_CC, TO_CO , TO_IN,TO_AG,TO_ONCO,S_PC,S_AG,S_MC,S_MR,S_ONCO)          
) AS pvt          
ORDER BY pvt.SCODDESCRIP;          
        
exec mod_rep.[rep].[FTHEACOLS01] 'RSCMIS_02';           
        
SELECT  --PROTECCION CUOTA        
  SCODDESCRIP,DESCRIPCION as RNOMSUB,         
  ISNULL(TO_EC,0) + ISNULL(TO_CC,0) +         
        ISNULL(TO_CO,0) + ISNULL(TO_CE,0) +         
  ISNULL(TO_AG,0) +  ISNULL(TO_IN,0) AS 'TOpePC' ,        
  TO_EC + ISNULL(TO_IN,0) EMPCPC,        
  isnull(TO_CC,0)CCPC,isnull(TO_CO,0)CONSUMPC,isnull(TO_CE,0)CREPC,TO_AG,S_PC SegPC,        
case when (ISNULL(TO_EC,0) + ISNULL(TO_CC,0) + ISNULL(TO_CO,0) + ISNULL(TO_CE,0) + ISNULL(TO_AG,0) +  ISNULL(TO_IN,0))=0 then 0    
else CAST(S_PC AS FLOAT)/(ISNULL(TO_EC,0) + ISNULL(TO_CC,0) + ISNULL(TO_CO,0) + ISNULL(TO_CE,0) + ISNULL(TO_AG,0) +  ISNULL(TO_IN,0)) end AS 'PorcPenPC',         
  --MULTICREDITO        
  (TO_EC + ISNULL(TO_IN,0) )   + ISNULL(TO_CC,0) +        
  ISNULL(TO_CO,0) + ISNULL(TO_AG,0) +        
  ISNULL(TO_IN,0) +  ISNULL(TO_IC,0)    AS 'TOpeMC',S_MC as SegMC,        
case when ((TO_EC + ISNULL(TO_IN,0) )   + ISNULL(TO_CC,0) +ISNULL(TO_CO,0) + ISNULL(TO_AG,0) +ISNULL(TO_IN,0) +  ISNULL(TO_IC,0) )=0 then 0    
else CAST(S_MC AS FLOAT) / ((TO_EC + ISNULL(TO_IN,0) )   + ISNULL(TO_CC,0) +ISNULL(TO_CO,0) + ISNULL(TO_AG,0) +ISNULL(TO_IN,0) +  ISNULL(TO_IC,0) ) end AS 'PorcPenMC'        
  --AGRO        
  ,ISNULL(TO_AG,0)   AS 'TOpeAgro', ISNULL(S_AG,0) as SegAgro,        
 case when ISNULL(TO_AG,0)=0 then 0 else CAST(S_AG AS FLOAT)/ISNULL(TO_AG,0) end AS 'PorcPenAgro',        
     --MULTIRIESGO        
  (TO_EC + ISNULL(TO_IN,0) ) +  ISNULL(TO_CC,0) +        
  ISNULL(TO_IC,0)  +  ISNULL(TO_IN,0) AS 'TOpeMR',        
  S_MR as SegMR,  (TO_EC + ISNULL(TO_IN,0) ) SECMR, ISNULL(TO_CC,0) SECCMR,        
  ISNULL(TO_IC,0) TO_IC ,  ISNULL(TO_IN,0) TO_IN,        
case when ((TO_EC + ISNULL(TO_IN,0) ) +  ISNULL(TO_CC,0) + ISNULL(TO_IC,0)  +  ISNULL(TO_IN,0) )=0 then 0     
else CAST(S_MR AS FLOAT)/ ((TO_EC + ISNULL(TO_IN,0) ) +  ISNULL(TO_CC,0) + ISNULL(TO_IC,0)  +  ISNULL(TO_IN,0) ) end as PorcPenMR,--        
 --ONCOSALUD  
 ISNULL(TO_ONCO,0) AS 'TOpeOnco',ISNULL(S_ONCO,0) as SegOnco,  
 case when ISNULL(TO_ONCO,0)=0 then 0 else CAST(S_ONCO AS FLOAT)/ISNULL(TO_ONCO,0) end AS 'PorcPenOnco',        
  --TOTAL OPERACIONES        
  (ISNULL(TO_EC,0) + ISNULL(TO_IN,0) ) +  ISNULL(TO_CC,0) +        
  ISNULL(TO_IC,0)  +  ISNULL(TO_CE,0) +        
  ISNULL(TO_AG,0)  +  ISNULL(TO_CO,0) + ISNULL(TO_ONCO,0) AS 'TOpeOS',        
  ISNULL(S_MR,0)+ISNULL(S_MC,0)+ISNULL(S_PC,0)+ISNULL(S_AG,0) + ISNULL(S_ONCO,0) AS 'TSegOS',        
case when ((ISNULL(TO_EC,0) + ISNULL(TO_IN,0) ) +  ISNULL(TO_CC,0) +  ISNULL(TO_IC,0)  +  ISNULL(TO_CE,0) + ISNULL(TO_AG,0)  +  ISNULL(TO_CO,0))=0 then 0     
else CAST(ISNULL(S_MR,0)+ISNULL(S_MC,0)+ISNULL(S_PC,0)+ISNULL(S_AG,0)+ ISNULL(S_ONCO,0)  AS FLOAT)  / ((ISNULL(TO_EC,0) + ISNULL(TO_IN,0) ) +  ISNULL(TO_CC,0) +  ISNULL(TO_IC,0)  +  ISNULL(TO_CE,0) + ISNULL(TO_AG,0)  +  ISNULL(TO_CO,0)) end AS 'PorcPenOS
'        
  ,(TO_EC + ISNULL(TO_IN,0) ) as  'SEMPCOS',        
  ISNULL(TO_CC,0)  as  'SCCOS',ISNULL(TO_AG,0)  as  'SAGROPEOS',        
  ISNULL(TO_CO,0) as  'SCONSUMOS'  ,ISNULL(TO_CE,0) AS 'SCEOS', ISNULL(TO_IC,0) 'ST_T_IC',        
  ISNULL(S_MR,0) AS 'SMROS', ISNULL(S_MC,0) AS 'SMCOS',        
  ISNULL(S_PC,0)  AS 'SPCCOS', ISNULL(S_AG,0) AS 'SAGROS'         
FROM #TABRESULT -- SELECT * FROM #TABRESULT  --DROP TABLE #TABRESULT        
where descripcion is not null        
ORDER BY SCODDESCRIP ASC        
               
               
END
