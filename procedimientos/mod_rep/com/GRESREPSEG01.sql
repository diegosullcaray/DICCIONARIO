-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-07 05:40:04.323000
-- exec mod_rep.[com].[GRESREPSEG01]  7,'231'                  
CREATE procedure [com].[GRESREPSEG01]                   
@tip_cod int,                  
@cod_rel varchar(10)                  
AS                       
BEGIN                     
  SET NOCOUNT ON;    
  --declare  @tip_cod int =18,  @cod_rel varchar(10)  ='133'       
   --declare  @tip_cod int =19,  @cod_rel varchar(10)  ='18'                  
   DECLARE @dFechaMax date = (select MAX(SFECPRO) from storage.[com_seg].SDSF001)                      
                 
  exec [rep].[FTHEACOLS01] 'RSCMIS_01';                      
          
 /* Meta*/        
 DECLARE @FecMeta date,@FecJerar date        
set @FecMeta=(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR=5001 )        
set @FecJerar=(select max(rfecpro) from storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' )        
           
 ;WITH CTE_A AS (     
 select *          
from [storage].[com].[VDMCOM01]          
where HTIPCOD=case when @tip_cod=7 then  '21'          
       when @tip_cod=21 then '20'          
    when @tip_cod=20 then '19'          
       when @tip_cod=19 then '18'                 
       when @tip_cod=18 then '17'
	   when @tip_cod=17 then '2'end and hcodvar=5001 and hfecpro=eomonth(@dFechaMax)               
             
)            
,CTE_A1 AS (          
select *          
from [storage].[com].[VDMCOM01]          
where HTIPCOD= @tip_cod     
and HCODREL = @cod_rel and hcodvar=5001 and hfecpro=eomonth(@dFechaMax)           
)     
,          
CTE_B AS (          
SELECT DISTINCT CASE WHEN @tip_cod=7 THEN CAST(RCODGRU  AS VARCHAR(250))          
      WHEN @tip_cod=21 THEN CAST(RCODTER AS VARCHAR(250))          
      WHEN @tip_cod=20 THEN CAST(RCODCOR AS VARCHAR(250))          
      WHEN @tip_cod=19 THEN CAST(RCODUNI AS VARCHAR(250))           
      WHEN @tip_cod=18 THEN CAST(RCODUCO AS VARCHAR(250))
	  WHEN @tip_cod=17 THEN CAST(RCODSEC AS VARCHAR(250))END   RCOD          
          
FROM storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' AND RFECPRO=@FecJerar        
AND CASE WHEN @tip_cod='21' THEN CAST(RCODGRU AS VARCHAR(250))           
         WHEN @tip_cod='20' THEN CAST(RCODTER AS VARCHAR(250))          
         WHEN @tip_cod='19' THEN CAST(RCODCOR AS VARCHAR(250))          
         WHEN @tip_cod='18' THEN CAST(RCODUNI AS VARCHAR(250))
		 WHEN @tip_cod='17' THEN CAST(RCODUCO AS VARCHAR(250)) 
		 ELSE '1' END = IIF(@tip_cod=7,'1',@cod_rel)           
 )          
 ,CTE_C AS (          
SELECT B.RCOD HCODREL,A.HVALVAR  , C.HVALVAR as HVALVAR1          
FROM CTE_A A          
LEFT JOIN CTE_B B          
ON A.HCODREL=B.RCOD    
CROSS JOIN CTE_A1 C          
)          
,CTE_D AS (          
SELECT distinct '0' HCODREL,HVALVAR1 SMETSEGINC          
FROM CTE_C          
WHERE HCODREL IS NOT NULL          
UNION ALL          
SELECT HCODREL,SUM(HVALVAR)          
FROM CTE_C          
WHERE HCODREL IS NOT NULL          
GROUP BY HCODREL          
)          
SELECT * INTO #Meta_Vr2 FROM CTE_D   --select * from #Meta_Vr2        
                     
 ;with cte_a as (              
select CASE WHEN scodseg=802 THEN 'S_PC'              
     WHEN SCODSEG in(806,815) THEN 'S_AG'   --nuevo: 815           
     WHEN SCODSEG=803 THEN 'S_MC'              
     WHEN SCODSEG in(200,220,230) THEN 'S_MR'  
     when SCODSEG=814 then 'S_ONCO'              
     END SEG,*              
from storage.[com_seg].[SDSF001]              
where sfecpro=@dFechaMax              
and scodagr=6              
),              
CTE_B AS (              
SELECT * FROM cte_a              
WHERE SEG IS NOT NULL              
),              
cte_c as (SELECT '0' SCODDESCRIP,SEG,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'              
   when @tip_cod=21 then cast(C.RDESGRU as varchar(250))              
   when @tip_cod=20 then cast(C.RDESTER as varchar(250))              
   when @tip_cod=19 then cast(C.RDESCOR as varchar(250))              
   when @tip_cod=18 then cast(C.RDESUNI as varchar(250))
   when @tip_cod=17 then cast(C.RDESUCO as varchar(250)) END descripcion,SUM(A.SNUMPLZ)  SNUMPLZ,'NUM_SEG' TIPO              
FROM CTE_B A              
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO and RINDFEC='ACTUAL'               
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(250)),'9999')                             
         when @tip_cod=20 then  cast(c.RCODTER as nvarchar(250))                          
         when @tip_cod=19 then  CAST(c.RCODCOR AS VARCHAR(250))                                
         when @tip_cod=18 then  CAST(c.RCODUNI  AS VARCHAR(250))
		 when @tip_cod=17 then  CAST(c.RCODUCO  AS VARCHAR(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)               
GROUP BY SEG,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'              
   when @tip_cod=21 then cast(C.RDESGRU as varchar(250))              
   when @tip_cod=20 then cast(C.RDESTER as varchar(250))              
   when @tip_cod=19 then cast(C.RDESCOR as varchar(250))              
   when @tip_cod=18 then cast(C.RDESUNI as varchar(250))
   when @tip_cod=17 then cast(C.RDESUCO as varchar(250)) END              
UNION ALL              
SELECT CASE WHEN @tip_cod=7 then  ISNULL(cast(C.RCODGRU as varchar(250)),'9999')              
   when @tip_cod=21 then CAST(C.RCODTER AS VARCHAR(250))               
   when @tip_cod=20 then CAST(C.RCODCOR AS VARCHAR(250))              
   when @tip_cod=19 then CAST(C.RCODUNI AS VARCHAR(250))              
   when @tip_cod=18 then CAST(C.RCODUCO AS VARCHAR(250))
   when @tip_cod=17 then CAST(C.RCODSEC AS VARCHAR(250)) END ,              
  SEG,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RDESGRU as varchar(250)),'SIN ASIGNAR')              
   when @tip_cod=21 then cast(C.RDESTER as varchar(250))              
   when @tip_cod=20 then cast(C.RDESCOR as varchar(250))              
   when @tip_cod=19 then cast(C.RDESUNI as varchar(250))              
   when @tip_cod=18 then cast(C.RDESUCO as varchar(250))
   when @tip_cod=17 then cast(C.RDESSEC as varchar(250)) END,SUM(A.SNUMPLZ)  SNUMPLZ,'NUM_SEG' TIPO              
FROM CTE_B A --SELECT * FROM storage.[ref].WJERCOR01              
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO and RINDFEC='ACTUAL'               
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(250)),'9999')                             
         when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                          
         when @tip_cod=19 then cast(c.RCODCOR as varchar(50))                               
         when @tip_cod=18 then cast(c.RCODUNI as varchar(50))
		 when @tip_cod=17 then cast(c.RCODUCO as varchar(50))else '1' end=IIF(@tip_cod=7,'1',@cod_rel)               
GROUP BY  CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')              
   when @tip_cod=21 then CAST(C.RCODTER AS VARCHAR(250))              
   when @tip_cod=20 then CAST(C.RCODCOR AS VARCHAR(250))              
   when @tip_cod=19 then CAST(C.RCODUNI AS VARCHAR(250))              
   when @tip_cod=18 then CAST(C.RCODUCO AS VARCHAR(250))
   when @tip_cod=17 then CAST(C.RCODSEC AS VARCHAR(250))END ,              
    SEG,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RDESGRU as varchar(250)),'SIN ASIGNAR')              
   when @tip_cod=21 then cast(C.RDESTER as varchar(250))              
   when @tip_cod=20 then cast(C.RDESCOR as varchar(250))              
   when @tip_cod=19 then cast(C.RDESUNI as varchar(250))              
   when @tip_cod=18 then cast(C.RDESUCO as varchar(250))
   when @tip_cod=17 then cast(C.RDESSEC as varchar(250)) END              
),              
cte_d as (              
              
SELECT * , @dFechaMax SFECPRO2              
FROM storage.[com_act].[SDAF002]                
WHERE SFECPRO>=convert(char(6), @dFechaMax, 112) + '01' AND SCODAGR=6                
),     cte_e as (              
SELECT '0' SCODDESCRIP,'T_SECT' seg,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'              
   when @tip_cod=21 then C.RDESGRU              
   when @tip_cod=20 then C.RDESTER             
   when @tip_cod=19 then C.RDESCOR              
   when @tip_cod=18 then C.RDESUNI
   when @tip_cod=17 then C.RDESUCO END descripcion,count(distinct SCODSEC)  SNUMCODSEC,'NUMERO_SEC' TIPO              
FROM cte_d A              
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO2=C.RFECPRO and RINDFEC='ACTUAL'               
AND case when @tip_cod=21 then  ISNULL(cast(C.RCODGRU as varchar(250)),'9999')                       
     when @tip_cod=20 then      cast(c.RCODTER as nvarchar(250))                          
     when @tip_cod=19 then      cast(c.RCODCOR as varchar(250))         
     when @tip_cod=18 then cast(c.RCODUNI as varchar(250))
	 when @tip_cod=17 then cast(c.RCODUCO as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)               
GROUP BY CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'              
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
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250))
   END ,'T_SECT' seg,              
  CASE WHEN @tip_cod=7 then ISNULL(cast(C.RDESGRU as varchar(250)),'SIN ASIGNAR')              
   when @tip_cod=21 then cast(C.RDESTER as varchar(250))              
   when @tip_cod=20 then cast(C.RDESCOR as varchar(250))              
   when @tip_cod=19 then cast(C.RDESUNI as varchar(250))              
   when @tip_cod=18 then cast(C.RDESUCO as varchar(250))
   when @tip_cod=17 then cast(C.RDESSEC as varchar(250))
   END,count(distinct SCODSEC)  SNUMCODSEC,'NUMERO_SEC' TIPO              
FROM cte_d A                
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO2=C.RFECPRO and RINDFEC='ACTUAL'               
AND case when @tip_cod=21 then  ISNULL(cast(C.RCODGRU as varchar(250)),'9999')                      
     when @tip_cod=20 then cast(c.RCODTER as nvarchar(250))                          
     when @tip_cod=19 then  cast(c.RCODCOR as varchar(250))                                
      when @tip_cod=18 then cast(c.RCODUNI as varchar(250))
	  when @tip_cod=17 then cast(c.RCODUCO as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)               
GROUP BY  CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')              
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))              
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))              
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))              
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,              
    CASE WHEN @tip_cod=7 then ISNULL(cast(C.RDESGRU as varchar(250)),'SIN ASIGNAR')              
   when @tip_cod=21 then cast(C.RDESTER as varchar(250))              
   when @tip_cod=20 then cast(C.RDESCOR as varchar(250))              
   when @tip_cod=19 then cast(C.RDESUNI as varchar(250))              
   when @tip_cod=18 then cast(C.RDESUCO as varchar(250))
   when @tip_cod=17 then cast(C.RDESSEC as varchar(250)) END              
),              
cte_ase as (              
 select '0' SCODDESCRIP,'TOTAL_ASES_SEG' seg,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'              
   when @tip_cod=21 then C.RDESGRU              
   when @tip_cod=20 then C.RDESTER              
   when @tip_cod=19 then C.RDESCOR              
   when @tip_cod=18 then C.RDESUNI
   when @tip_cod=17 then C.RDESUCO END descripcion,count(distinct HCODSEC)  hnumsec,'NUM_SEG' TIPO               
from storage.[com_seg].VCSH006 a              
LEFT JOIN storage.[ref].WJERCOR03 C on A.HCODSEC =  C.RCODSEC and A.HFECPRO=C.RFECPRO and RINDFEC='ACTUAL'               
AND case when @tip_cod=21 then  ISNULL(cast(C.RCODGRU as varchar(250)),'9999')                       
     when @tip_cod=20 then      cast(c.RCODTER as nvarchar(250))                          
     when @tip_cod=19 then      cast(c.RCODCOR as varchar(250))                                
     when @tip_cod=18 then cast(c.RCODUNI as varchar(250))
	 when @tip_cod=17 then cast(c.RCODUCO as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)               
GROUP BY CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'              
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
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,'TOTAL_ASES_SEG' seg,              
  CASE WHEN @tip_cod=7 then ISNULL(cast(C.RDESGRU as varchar(250)),'SIN ASIGNAR')              
   when @tip_cod=21 then cast(C.RDESTER as varchar(250))              
   when @tip_cod=20 then cast(C.RDESCOR as varchar(250))              
   when @tip_cod=19 then cast(C.RDESUNI as varchar(250))              
   when @tip_cod=18 then cast(C.RDESUCO as varchar(250))
   when @tip_cod=17 then cast(C.RDESSEC as varchar(250)) END,count(distinct HCODSEC)  hnumsec,'NUM_SEG' TIPO              
FROM storage.[com_seg].VCSH006 A                
LEFT JOIN storage.[ref].WJERCOR03 C on A.HCODSEC =  C.RCODSEC and A.hfecpro=C.RFECPRO and RINDFEC='ACTUAL'               
AND case when @tip_cod=21 then  ISNULL(cast(C.RCODGRU as varchar(250)),'9999')                      
     when @tip_cod=20 then cast(c.RCODTER as nvarchar(250))                          
     when @tip_cod=19 then  cast(c.RCODCOR as varchar(250))                                
      when @tip_cod=18 then cast(c.RCODUNI as varchar(250))
	when @tip_cod=17 then cast(c.RCODUCO as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)               
GROUP BY  CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')              
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))              
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))              
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))              
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,              
    CASE WHEN @tip_cod=7 then ISNULL(cast(C.RDESGRU as varchar(250)),'SIN ASIGNAR')              
   when @tip_cod=21 then cast(C.RDESTER as varchar(250))              
   when @tip_cod=20 then cast(C.RDESCOR as varchar(250))              
   when @tip_cod=19 then cast(C.RDESUNI as varchar(250))              
   when @tip_cod=18 then cast(C.RDESUCO as varchar(250))
   when @tip_cod=17 then cast(C.RDESSEC as varchar(250)) END              
              
)               
select * into #PreResult from cte_c union all --DROP TABLE #PreResult              
select * from cte_e union all              
select * from cte_ase  --select * from #PreResult where tipo='NUM_SECTOR_SEG'              
               
               
SELECT SCODDESCRIP,DESCRIPCION,TIPO, T_SECT,S_MC,S_PC,S_MR,S_AG,S_ONCO,TOTAL_ASES_SEG              
INTO #PRESULT2 --DROP TABLE #PRESULT2   select * from  #PRESULT2              
FROM                 
(SELECT SNUMPLZ, SEG, DESCRIPCION ,SCODDESCRIP ,TIPO              
FROM #PreResult) p                
PIVOT                
(                
SUM (SNUMPLZ)                
FOR SEG IN                
( T_SECT,S_MC,S_PC,S_MR,S_AG,S_ONCO,TOTAL_ASES_SEG)                
) AS pvt                
ORDER BY pvt.SCODDESCRIP;                
               
              
SELECT A.SCODDESCRIP,A.DESCRIPCION as RNOMSUB,isnull(A.S_MC,0)+ isnull(A.S_PC,0)+isnull(A.S_MR,0)+ isnull(A.S_AG,0) + ISNULL(A.S_ONCO,0) VentaT ,c.SMETSEGINC  MetaT,-- 0 MetaT ,              
   --CASE WHEN (isnull(A.S_MC,0)+ isnull(A.S_PC,0)+isnull(A.S_MR,0)+ isnull(A.S_AG,0))=0 THEN 0 ELSE  0/ (isnull(A.S_MC,0)+ isnull(A.S_PC,0)+isnull(A.S_MR,0)+ isnull(A.S_AG,0)) END 'CumpT',              
    CASE WHEN c.SMETSEGINC=0 THEN 0 ELSE (isnull(A.S_MC,0)+ isnull(A.S_PC,0)+isnull(A.S_MR,0)+ isnull(A.S_AG,0) + ISNULL(A.S_ONCO,0)) / c.SMETSEGINC  END 'CumpT',           
 A.S_MR as VentaMR,0  as MetaMR,CASE WHEN A.S_MR =0 THEN 0 ELSE  0 / A.S_MR END 'CumpMR',              
    A.S_MC as VentaMC,0 MetaMC, CASE WHEN A.S_MC=0 THEN 0 ELSE 0 / A.S_MC END 'CumpMC',              
    A.S_PC as VentaPRO,0 MetaPRO,CASE WHEN A.S_PC=0 THEN 0 ELSE  0 / A.S_PC END 'CumpPRO',              
    A.S_AG as VentaAgro,0 MetaAgro,CASE WHEN A.S_AG=0 THEN 0 ELSE 0 / A.S_AG END 'CumpAgro',              
    -----              
   -- B.T_SECT as TotalAsesor, a.TOTAL_ASES_SEG AsesSegu,           
    B.T_SECT as AsesSegu, a.TOTAL_ASES_SEG TotalAsesor,           
  case when B.T_SECT=0 then 0 else  cast(a.TOTAL_ASES_SEG as float)/     B.T_SECT end as PorcCob,              
    case when B.T_SECT =0 then 0 else cast((isnull(A.S_MC,0)+ isnull(A.S_PC,0)+isnull(A.S_MR,0)+ isnull(A.S_AG,0)) as float) /  B.T_SECT end as Prod,  
    a.S_ONCO as VentaOnco              
FROM #PRESULT2  A  --select * from #PRESULT2              
LEFT JOIN (SELECT * FROM #PRESULT2 WHERE TIPO='NUMERO_SEC' AND DESCRIPCION IS NOT NULL ) B ON A.SCODDESCRIP=B.SCODDESCRIP         
left join (select * from #Meta_Vr2) C on a.SCODDESCRIP =c.HCODREL              
WHERE A.TIPO='NUM_SEG'              
AND a.DESCRIPCION IS NOT NULL                
order by 1 asc                                     
                         
END
