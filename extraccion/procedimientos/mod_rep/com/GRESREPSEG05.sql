-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-07 06:03:05.733000
-- exec mod_rep.[com].[GRESREPSEG05]  7,'231'                
CREATE procedure [com].[GRESREPSEG05]                 
@tip_cod int,                
@cod_rel varchar(10)                
AS                     
BEGIN               
SET NOCOUNT ON;              
-- declare @tip_cod int=7, @cod_rel varchar(50)='231'            
declare @dFechaMax date=(select MAX(SFECPRO) from storage.[com_act].[SDAF002])         
 DECLARE @FecMeta date,@FecJerar date        
set @FecMeta=(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR=5001 )                
         
set @FecJerar=(select max(rfecpro) from storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' )           
            
declare @defs as rep.TTHCOLDEF;                        
             
             
insert into @defs                        
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH)  values                        
 (1,1,1,'descripcion','Descripción',null,2,1,'string',null,null),                        
 (2,1,null,'TotalOper','Total Operaciones',18,null,null,null,null,null),                        
 (3,1,null,'PymeCC','PYME - CC',8,null,null,null,null,null),                           
 (4,1,null,'agro','Agropecuario',9,null,null,null,null,null),                           
 (5,1,null,'consumo','Consumo',7,null,null,null,null,null),                           
 (6,1,null,'CE','Credito Educativo',5,null,null,null,null,null),                             
 (8,1,null,'IO','Iniciando Oficios',9,null,null,null,null,null),            
 (9,1,null,'ONC','Oncologico',3,null,null,null,null,null),                 
 (10,2,2,'T_OPE_TOTAL','Total Operaciones',null,null,null,'number','.0-0','100px'),                    
 (11,2,2,'T_S_TOTAL','Total Seguros',null,null,null,'number','.0-0','100px'),                          
 (12,2,2,'PERCENT_S_TOTAL','%Penetracion',null,null,null,'percent','.0-0','100px'),                     
 (13,2,2,'T_S_T_MR','Multiriesgo',null,null,null,'number','.0-0','100px'),              
 (14,2,2,'T_S_T_MC','Multicredito',null,null,null,'number','.0-0','100px'),             
 (15,2,2,'T_S_T_PC','Protección de cuota',null,null,null,'number','.0-0','100px'),             
 (16,2,2,'T_S_T_AGRO','Agropecuario',null,null,null,'number','.0-0','100px'),              
             
  (17,2,2,'T_Ope_EC','Emprendiendo Confianza',null,null,null,'number','.0-0','100px'),              
  (18,2,2,'T_Ope_CC','Construyendo Confianza',null,null,null,'number','.0-0','100px'),              
  (19,2,2,'T_Ope_Agro','Agropecuario',null,null,null,'number','.0-0','100px'),              
  (20,2,2,'T_Ope_CONSU','Consumo',null,null,null,'number','.0-0','100px'),              
  (21,2,2,'T_Ope_CE','Credito Educativo',null,null,null,'number','.0-0','100px'),               
  (22,2,2,'T_Ope_IN','Iniciando Negocios',null,null,null,'number','.0-0','100px'),             
  (23,2,2,'T_Ope_IO','Iniciando Oficios',null,null,null,'number','.0-0','100px'),             
  (24,2,2,'META','Meta',null,null,null,'number','.0-0','100px'),            
  (25,2,2,'Avance','Avance',null,null,null,'percent','.0-0','100px'),            
  (26,2,2,'META_I','Meta Incentivos',null,null,null,'number','.0-0','100px'),            
  (27,2,2,'Cumplimiento','Cumplimiento',null,null,null,'string',null,'100px'),            
            
              
  (28,2,2,'T_OPE_PYME_CC','Total Operaciones',null,null,null,'number','.0-0','100px'),            
  (29,2,2,'T_S_PYME_CC','Total Seguros',null,null,null,'number','.0-0','100px'),            
  (30,2,2,'% Penetración','PERCENT_S_PYME_CC',null,null,null,'percent','.0-0','100px'),            
  (31,2,2,'S_MR_PYME_CC','Seguro Multiriesgo',null,null,null,'number','.0-0','100px'),            
  (32,2,2,'S_MC_PYME_CC','Seguro Multicredito',null,null,null,'number','.0-0','100px'),            
  (33,2,2,'S_PC_PYME_CC','Seguro Protección Cuota',null,null,null,'number','.0-0','100px'),            
  (34,2,2,'MET_PYME_CC','Meta',null,null,null,'number','.0-0','100px'),            
  (35,2,2,'AVANCE_PYME_CC','Avance',null,null,null,'percent','.0-0','100px'),             
            
  (36,2,2,'T_OPE_AGRO','Total Operaciones',null,null,null,'number','.0-0','100px'),            
  (37,2,2,'T_S_AGRO','Total Seguros',null,null,null,'number','.0-0','100px'),            
  (38,2,2,'PERCENT_S_AGRO','% Penetración',null,null,null,'percent','.0-0','100px'),            
  (39,2,2,'S_MR_AGRO','Seguro Multiriesgo',null,null,null,'number','.0-0','100px'),            
  (40,2,2,'S_MC_AGRO','Seguro Multicredito',null,null,null,'number','.0-0','100px'),            
  (41,2,2,'S_PC_AGRO','Seguro PC',null,null,null,'number','.0-0','100px'),            
  (42,2,2,'S_AGRO_AGRO','Seguro Agro',null,null,null,'number','.0-0','100px'),            
  (43,2,2,'MET_AGRO','Meta',null,null,null,'number','.0-0','100px'),            
  (44,2,2,'AVANCE_AGRO','Avance',null,null,null,'percent','.0-0','100px'),            
            
              
  (45,2,2,'T_OPE_CONSUMO','Total Operaciones',null,null,null,'number','.0-0','100px'),            
  (46,2,2,'T_S_CONSUMO','Total Seguros',null,null,null,'number','.0-0','100px'),            
  (47,2,2,'PERCENT_S_CONSUMO','% Penetración',null,null,null,'percent','.0-0','100px'),            
  (48,2,2,'S_MC_CONSUMO','Seguro MC',null,null,null,'number','.0-0','100px'),            
  (49,2,2,'S_PC_CONSUMO','Seguro PC',null,null,null,'number','.0-0','100px'),            
  (50,2,2,'MET_CONSUMO','Meta',null,null,null,'number','.0-0','100px'),            
  (51,2,2,'AVANCE_CONSUMO','Avance',null,null,null,'percent','.0-0','100px'),            
            
              
  (52,2,2,'T_OPE_CE','Total Operaciones',null,null,null,'number','.0-0','100px'),            
  (53,2,2,'T_S_EC','Total Seguros',null,null,null,'number','.0-0','100px'),            
  (54,2,2,'PERCENT_S_CE','% Penetración',null,null,null,'percent','.0-0','100px'),            
  (55,2,2,'MET_EC','Meta',null,null,null,'number','.0-0','100px'),            
  (56,2,2,'AVANCE_EC','Avance',null,null,null,'percent','.0-0','100px'),            
            
              
  (57,2,2,'T_OPE_IO','Total Operaciones',null,null,null,'number','.0-0','100px'),            
  (58,2,2,'T_S_IO','Total Seguros',null,null,null,'number','.0-0','100px'),            
  (59,2,2,'PERCENT_S_IO','% Penetración',null,null,null,'percent','.0-0','100px'),            
  (60,2,2,'S_MR_IO','Seguro MR',null,null,null,'number','.0-0','100px'),            
  (61,2,2,'S_MC_IO','Seguro MC',null,null,null,'number','.0-0','100px'),            
  (62,2,2,'S_PC_IO','Seguro PC',null,null,null,'number','.0-0','100px'),            
  (63,2,2,'MET_IO','Meta',null,null,null,'number','.0-0','100px'),            
  (64,2,2,'AVANCE_IO','Avance',null,null,null,'percent','.0-0','100px')          ,  
            
  (65,2,2,'T_OPE_ONCO','Total Operaciones',null,null,null,'number','.0-0','100px'),            
  (66,2,2,'S_ONCO','Total Seguros',null,null,null,'number','.0-0','100px'),            
  (67,2,2,'PERCENT_S_ONCO','% Penetración',null,null,null,'percent','.0-0','100px')         
              
   select rep.FFTHCOLDEF(@defs) result;          
           
            
/* Total Operaciones*/            
;with cte_a as (            
select b.*, EP03.RCODPROD            
from  storage.[com_act].[SDAF002] B            
left join storage.[com_act].RETP001 EP01            
 on EP01.RCODMOD=B.SCODMOD and EP01.RTIPOPE=B.STIPOPE            
 left join storage.[com_act].RETP002 EP02            
 on EP02.RCODMOD=B.SCODMOD and EP02.RTIPOPE=B.STIPOPE and EP02.RSUBTIP=B.SSUBTIP            
 left join storage.[com_act].RETP003 EP03 --select * from storage.[com_act].RETP003            
 on EP03.RCODPROD=isnull(EP02.RCODPROD,EP01.RCODPROD)            
WHERE SFECPRO=@dFechaMax AND SCODAGR=6            
),            
cte_b as (            
SELECT 'Cartera' Tip, null SEG, RCODPROD,'0' SCODDESCRIP,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'            
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
GROUP BY RCODPROD,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'            
    when @tip_cod=21 then C.RDESGRU            
   when @tip_cod=20 then C.RDESTER            
   when @tip_cod=19 then C.RDESCOR           
   when @tip_cod=18 then C.RDESUNI
   when @tip_cod=17 then C.RDESUCO END          
UNION ALL            
SELECT 'Cartera' Tip,null SEG,RCODPROD,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')            
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))            
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))            
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))            
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,            
  CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')            
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
GROUP BY  RCODPROD,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')            
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))            
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))            
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))            
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END  ,            
   CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')            
   when @tip_cod=21 then C.RDESTER            
   when @tip_cod=20 then C.RDESCOR            
   when @tip_cod=19 then C.RDESUNI         
   when @tip_cod=18 then C.RDESUCO
   when @tip_cod=17 then C.RDESSEC END         
),            
cte_seg as (            
select b.*, EP03.RCODPROD            
from storage.[com_seg].SDSF001 B    --select max(sfecpro) from storage.[com_seg].SDSF001         
left join storage.[com_act].RETP001 EP01            
 on EP01.RCODMOD=B.SCODMOD and EP01.RTIPOPE=B.STIPOPE            
 left join storage.[com_act].RETP002 EP02            
 on EP02.RCODMOD=B.SCODMOD and EP02.RTIPOPE=B.STIPOPE and EP02.RSUBTIP=B.SSUBTIP            
 left join storage.[com_act].RETP003 EP03 --select * from storage.[com_act].RETP003            
 on EP03.RCODPROD=isnull(EP02.RCODPROD,EP01.RCODPROD)            
where b.sfecpro=@dFechaMax  and scodagr=13            
),            
CTE_SEG_PC_JER as (            
SELECT 'Seguro' Tip,SCODSEG seg ,RCODPROD,'0' SCODDESCRIP,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'            
   when @tip_cod=21 then C.RDESGRU            
   when @tip_cod=20 then C.RDESTER            
   when @tip_cod=19 then C.RDESCOR            
   when @tip_cod=18 then C.RDESUNI
   when @tip_cod=17 then C.RDESUCO END descripcion,SUM(A.SNUMPLZ)  SNUMPLZ            
FROM cte_seg A            
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO and RINDFEC='ACTUAL'             
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                           
when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                        
         when @tip_cod=19 then c.RCODCOR                              
         when @tip_cod=18 then c.RCODUNI
		 when @tip_cod=17 then c.RCODUCO else '1' end=IIF(@tip_cod=7,'1',@cod_rel)             
GROUP BY SCODSEG,RCODPROD,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'            
   when @tip_cod=21 then C.RDESGRU            
   when @tip_cod=20 then C.RDESTER            
   when @tip_cod=19 then C.RDESCOR            
   when @tip_cod=18 then C.RDESUNI
   when @tip_cod=17 then C.RDESUCO END            
UNION ALL            
SELECT 'Seguro' Tip,SCODSEG seg ,RCODPROD,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')            
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))            
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))            
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))            
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,            
  CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')            
   when @tip_cod=21 then C.RDESTER           
   when @tip_cod=20 then C.RDESCOR            
   when @tip_cod=19 then C.RDESUNI         
   when @tip_cod=18 then C.RDESUCO
   when @tip_cod=17 then C.RDESSEC END,SUM(A.SNUMPLZ)  SNUMPLZ            
FROM cte_seg A --SELECT * FROM storage.[ref].WJERCOR01            
LEFT JOIN storage.[ref].WJERCOR03 C on A.SCODSEC =  C.RCODSEC and A.SFECPRO=C.RFECPRO and RINDFEC='ACTUAL'             
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                           
         when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                        
         when @tip_cod=19 then cast(c.RCODCOR as varchar(250))                              
         when @tip_cod=18 then cast(c.RCODUNI as varchar(250))
		 when @tip_cod=17 then cast(c.RCODUCO as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)             
GROUP BY  SCODSEG,RCODPROD,CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')            
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))            
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))            
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))            
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END,            
  CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')            
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
WHERE descripcion  IS NOT NULL              
)            
select * into #Data from CTE_RESULT        --select * from #Data     
             
            
SELECT TIP,SCODDESCRIP,DESCRIPCION, [1],[2],[3],[4],[5],[6],[7],[8],[9],[18],[19]            
into #TABRESULTCartera --DROP TABLE #TABRESULTCartera select * from #TABRESULTCartera            
FROM               
(SELECT SNUMOPE, RCODPROD, DESCRIPCION ,SCODDESCRIP ,TIP            
FROM #Data           --select distinct rcodprod from #Data  
where tip='Cartera') p              
PIVOT              
(              
SUM (SNUMOPE)              
FOR RCODPROD IN              
(             
[1],[2],[3],[4],[5],[6],[7],[8],[9],[18] ,[19]           
  )              
) AS pvt              
ORDER BY pvt.SCODDESCRIP;              
            
SELECT TIP,SEG,SCODDESCRIP,DESCRIPCION, [1],[2],[3],[4],[5],[6],[7],[8],[9],[18],[19]--[0],[1],[7],[10],[11],[15],[200],[360],[802],[803],[804],[805],[806],[807]            
into #TABRESULTSeguros --DROP TABLE #TABRESULTSeguros select * from #TABRESULTSeguros WHERE SEG=200            
FROM               
(SELECT SNUMOPE, RCODPROD, DESCRIPCION ,SCODDESCRIP ,TIP,SEG            
FROM #Data --SELECT * FROM #Data            
where tip='Seguro') p              
PIVOT              
(              
SUM (SNUMOPE)              
FOR RCODPROD IN              
(             
[1],[2],[3],[4],[5],[6],[7],[8],[9],[18],[19]--[0],[1],[7],[10],[11],[15],[200],[360],[802],[803],[804],[805],[806],[807]            
  )              
) AS pvt              
ORDER BY pvt.SCODDESCRIP;              
--select * from #TABRESULTSeguros WHERE SEG=200            
--select * from #TABRESULTCartera            
            
;with cte_a as (            
select *            
from storage.com.metas_saldos            
where HTIPCOD=2 and hcodvar=5001 and hfecpro=eomonth(@dFechaMax)            
)            
SELECT '0' SCODDESCRIP,CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'            
   when @tip_cod=21 then C.RDESGRU            
   when @tip_cod=20 then C.RDESTER           
   when @tip_cod=19 then C.RDESCOR            
   when @tip_cod=18 then C.RDESUNI
   when @tip_cod=17 then C.RDESUCO END descripcion,SUM(A.HVALVAR)  SMETSEGINC            
into #MetSeg  --select * from #REPSEG  select * from #MetSeg            
FROM cte_a A            
LEFT JOIN (SELECT * FROM storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' AND RFECPRO=@dFechaMax) C             
on A.hcodrel =  C.RCODSEC              
WHERE case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                           
         when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                        
         when @tip_cod=19 then c.RCODCOR                              
         when @tip_cod=18 then c.RCODUCO
		 when @tip_cod=17 then c.RCODUNI else '1' end=IIF(@tip_cod=7,'1',@cod_rel)             
GROUP BY CASE WHEN @tip_cod=7 then 'FINANCIERA CONFIANZA'            
   when @tip_cod=21 then C.RDESGRU            
   when @tip_cod=20 then C.RDESTER           
   when @tip_cod=19 then C.RDESCOR            
   when @tip_cod=18 then C.RDESUNI
   when @tip_cod=17 then C.RDESUCO END          
            
UNION ALL            
select CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')            
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))            
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))            
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))            
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END ,            
   CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')            
   when @tip_cod=21 then C.RDESTER            
   when @tip_cod=20 then C.RDESCOR          
   when @tip_cod=19 then C.RDESUNI            
   when @tip_cod=18 then C.RDESUCO
   when @tip_cod=17 then C.RDESSEC END,SUM(a.HVALVAR)  SMETSEGINC            
            
from cte_a a             
left join (select * from storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' AND RFECPRO=@dFechaMax)C            
on a.hcodrel=c.RCODSEC            
where  case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                           
         when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                        
         when @tip_cod=19 then cast(c.RCODCOR as varchar(250))                              
         when @tip_cod=18 then cast(c.RCODUNI as varchar(250))
		 when @tip_cod=17 then cast(c.RCODUCO as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)             
GROUP BY CASE WHEN @tip_cod=7 then ISNULL(cast(C.RCODGRU as varchar(250)),'9999')            
   when @tip_cod=21 then cast(C.RCODTER as varchar(250))            
   when @tip_cod=20 then cast(C.RCODCOR as varchar(250))            
   when @tip_cod=19 then cast(C.RCODUNI as varchar(250))            
   when @tip_cod=18 then cast(C.RCODUCO as varchar(250))
   when @tip_cod=17 then cast(C.RCODSEC as varchar(250)) END,            
   CASE WHEN @tip_cod=7 then ISNULL(C.RDESGRU,'SIN ASIGNAR')            
   when @tip_cod=21 then C.RDESTER            
   when @tip_cod=20 then C.RDESCOR          
   when @tip_cod=19 then C.RDESUNI            
   when @tip_cod=18 then C.RDESUCO
   when @tip_cod=17 then C.RDESSEC END          
            
;WITH CTE_A AS (            
select *            
from [storage].[com].[VDMCOM01]            
where HTIPCOD=case when @tip_cod=7 then  '21'            
       when @tip_cod=21 then '20'            
    when @tip_cod=20 then '19'            
       when @tip_cod=19 then '18'                   
       when @tip_cod=18 then '17'
	   when @tip_cod=17 then '2' end and hcodvar=5001 and hfecpro=eomonth(@FecMeta)              
)             
 ,            
CTE_B AS (            
SELECT DISTINCT CASE WHEN @tip_cod=7 THEN CAST(RCODGRU  AS VARCHAR(250))            
      WHEN @tip_cod=21 THEN CAST(RCODTER AS VARCHAR(250))            
      WHEN @tip_cod=20 THEN CAST(RCODCOR AS VARCHAR(250))            
      WHEN @tip_cod=19 THEN CAST(RCODUNI AS VARCHAR(250))             
      WHEN @tip_cod=18 THEN CAST(RCODUCO AS VARCHAR(250))
	  WHEN @tip_cod=17 THEN CAST(RCODSEC AS VARCHAR(250)) END   RCOD            
            
FROM storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' AND RFECPRO=@FecJerar         
AND CASE WHEN @tip_cod='21' THEN CAST(RCODGRU AS VARCHAR(250))             
         WHEN @tip_cod='20' THEN CAST(RCODTER AS VARCHAR(250))            
         WHEN @tip_cod='19' THEN CAST(RCODCOR AS VARCHAR(250))            
         WHEN @tip_cod='18' THEN CAST(RCODUNI AS VARCHAR(250))
		 WHEN @tip_cod='17' THEN CAST(RCODUCO AS VARCHAR(250)) ELSE '1' END = IIF(@tip_cod=7,'1',@cod_rel)             
),            
CTE_C AS (            
SELECT B.RCOD HCODREL,HVALVAR            
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
            
select a.SCODDESCRIP,a.descripcion,            
 --INICIANDO OFICIOS---            
 a.[18] AS T_OPE_IO,b.[18]+c.[18]+d.[18] as T_S_IO ,            
CASE WHEN (a.[18])=0 THEN 0 ELSE CAST(b.[18]+c.[18]+d.[18] AS FLOAT)/  (a.[18]) END PERCENT_S_IO,            
    b.[18] AS S_MR_IO,c.[18] AS S_MC_IO,d.[18] AS S_PC_IO,            
    NULL MET_IO , NULL AVANCE_IO,            
 --CREDITO EDUCATIVO ---            
 a.[3] as T_OPE_CE,D.[3] as T_S_EC,CASE WHEN  (a.[3])=0 THEN 0 ELSE CAST(d.[3] AS FLOAT) / (a.[3]) END PERCENT_S_CE,            
 NULL MET_EC , NULL AVANCE_EC,            
 --CONSUMO ---            
 a.[7] as T_OPE_CONSUMO,c.[7]+d.[7] as T_S_CONSUMO,CASE WHEN a.[7]=0 THEN 0 ELSE CAST(c.[7]+d.[7] AS FLOAT) / a.[7] END AS PERCENT_S_CONSUMO,            
 c.[7] as S_MC_CONSUMO,d.[7] as S_PC_CONSUMO,NULL MET_CONSUMO , NULL AVANCE_CONSUMO,            
 --AGRO---            
 A.[1] AS T_OPE_AGRO, isnull(B.[1],0) + isnull(C.[1],0)+ isnull(D.[1],0) + isnull(e.[1],0) AS T_S_AGRO,            
 CASE WHEN (A.[1])=0 THEN 0 ELSE cast(isnull(B.[1],0) + isnull(C.[1],0)+ isnull(D.[1],0) + isnull(e.[1],0) as float)/(A.[1]) END AS PERCENT_S_AGRO,            
 B.[1] AS S_MR_AGRO , C.[1] AS S_MC_AGRO , D.[1] AS S_PC_AGRO , e.[1] AS S_AGRO_AGRO,            
 NULL MET_AGRO , NULL AVANCE_AGRO,         
 --ONCOLOGICO  
 isnull(a.[1],0)+isnull(a.[18],0)+isnull(a.[7],0)+isnull(a.[2],0)+isnull(a.[3],0)+isnull(a.[4],0)+isnull(a.[19],0)   T_OPE_ONCO,  
 isnull(f.[1],0)+isnull(f.[18],0)+isnull(f.[7],0)+isnull(f.[2],0)+isnull(f.[3],0)+isnull(f.[4],0)+isnull(f.[19],0)  as S_ONCO,  
 CASE WHEN (isnull(a.[1],0)+isnull(a.[18],0)+isnull(a.[7],0)+isnull(a.[2],0)+isnull(a.[3],0)+isnull(a.[4],0)+isnull(a.[19],0))=0 THEN 0 ELSE cast((isnull(f.[1],0)+isnull(f.[18],0)+isnull(f.[7],0)+isnull(f.[2],0)+isnull(f.[3],0)+isnull(f.[4],0)+isnull(f.[19],0)) as float)/(isnull(a.[1],0)+isnull(a.[18],0)+isnull(a.[7],0)+isnull(a.[2],0)+isnull(a.[3],0)+isnull(a.[4],0)+isnull((isnull(f.[1],0)+isnull(f.[18],0)+isnull(f.[7],0)+isnull(f.[2],0)+isnull(f.[3],0)+isnull(f.[4],0)+isnull(f.[19],0)),0)) END AS PERCENT_S_ONCO,  
 --PYME_CC            
 isnull(a.[4],0)+isnull(a.[2],0)+isnull(a.[5],0) as T_OPE_PYME_CC,             
 (isnull(b.[4],0) + isnull(b.[2],0) + isnull(b.[5],0)) +             
 (isnull(c.[4],0) + isnull(c.[2],0) + isnull(c.[5],0)) +            
 (isnull(d.[4],0) + isnull(d.[2],0) + isnull(d.[5],0))  T_S_PYME_CC,    
CASE WHEN (isnull(a.[4],0)+isnull(a.[2],0)+isnull(a.[5],0))=0 THEN  0 ELSE             
 cast((isnull(b.[4],0) + isnull(b.[2],0) + isnull(b.[5],0)) +             
 (isnull(c.[4],0) + isnull(c.[2],0) + isnull(c.[5],0)) +             
 (isnull(d.[4],0) + isnull(d.[2],0) + isnull(d.[5],0)) as float) / (isnull(a.[4],0)+isnull(a.[2],0)+isnull(a.[5],0)) END PERCENT_S_PYME_CC,            
 (isnull(b.[4],0) + isnull(b.[2],0) + isnull(b.[5],0)) S_MR_PYME_CC,            
 (isnull(c.[4],0) + isnull(c.[2],0) + isnull(c.[5],0)) S_MC_PYME_CC,            
 (isnull(d.[4],0) + isnull(d.[2],0) + isnull(d.[5],0)) as S_PC_PYME_CC,            
 NULL MET_PYME_CC , NULL AVANCE_PYME_CC,            
 --TOTAL            
 ISNULL(A.[18],0) + ISNULL(A.[3],0) + ISNULL(A.[7],0) + ISNULL(A.[1],0) + (isnull(A.[4],0)+isnull(A.[2],0)+isnull(A.[5],0)+isnull(a.[19],0)) AS T_OPE_TOTAL,            
 ISNULL(B.[1],0)+ ISNULL(B.[2],0) + ISNULL(B.[3],0) + ISNULL(B.[4],0)+(isnull(B.[5],0)+isnull(B.[6],0)+isnull(B.[7],0))+            
 ISNULL(B.[8],0) +    ISNULL(B.[9],0)+ ISNULL(B.[18],0) +            
--            
 ISNULL(C.[1],0)+ ISNULL(C.[2],0) + ISNULL(C.[3],0) + ISNULL(C.[4],0)+(isnull(C.[5],0)+isnull(C.[6],0)+isnull(C.[7],0))+            
 ISNULL(C.[8],0) +    ISNULL(C.[9],0)+ ISNULL(C.[18],0) +             
 --            
 ISNULL(D.[1],0)+ ISNULL(D.[2],0) + ISNULL(D.[3],0) + ISNULL(D.[4],0)+(isnull(D.[5],0)+isnull(D.[6],0)+isnull(D.[7],0))+            
 ISNULL(D.[8],0) +    ISNULL(D.[9],0)+ ISNULL(D.[18],0) +             
 --            
 ISNULL(E.[1],0)+ ISNULL(E.[2],0) + ISNULL(E.[3],0) + ISNULL(E.[4],0)+(isnull(E.[5],0)+isnull(E.[6],0)+isnull(E.[7],0))+            
 ISNULL(E.[8],0) +    ISNULL(E.[9],0)+ ISNULL(E.[18],0)  AS T_S_TOTAL,            
 --------------------------------------------------------------------------------------            
 --Total seguro Mr            
 ISNULL(B.[1],0)+ ISNULL(B.[2],0) + ISNULL(B.[3],0) + ISNULL(B.[4],0)+(isnull(B.[5],0)+isnull(B.[6],0)+isnull(B.[7],0))+            
 ISNULL(B.[8],0) +    ISNULL(B.[9],0)+ ISNULL(B.[18],0)  as T_S_T_MR,            
             
 --Total seguro Mc            
 ISNULL(C.[1],0)+ ISNULL(C.[2],0) + ISNULL(C.[3],0) + ISNULL(C.[4],0)+(isnull(C.[5],0)+isnull(C.[6],0)+isnull(C.[7],0))+            
 ISNULL(C.[8],0) +    ISNULL(C.[9],0)+ ISNULL(C.[18],0) as T_S_T_MC,            
            
 --Total seguro PC            
 ISNULL(D.[1],0)+ ISNULL(D.[2],0) + ISNULL(D.[3],0) + ISNULL(D.[4],0)+(isnull(D.[5],0)+isnull(D.[6],0)+isnull(D.[7],0))+            
 ISNULL(D.[8],0) +    ISNULL(D.[9],0)+ ISNULL(D.[18],0) as T_S_T_PC,            
            
 --Total Seguro Agro            
 ISNULL(E.[1],0)+ ISNULL(E.[2],0) + ISNULL(E.[3],0) + ISNULL(E.[4],0)+(isnull(E.[5],0)+isnull(E.[6],0)+isnull(E.[7],0))+            
 ISNULL(E.[8],0) +    ISNULL(E.[9],0)+ ISNULL(E.[18],0) as T_S_T_AGRO,            
            
 --- Total Operacion Emprendiendo Confianza            
 isnull(A.[4],0)  as T_Ope_EC, isnull(A.[2],0)  as T_Ope_CC,  isnull(A.[1],0)  as T_Ope_CC,            
 isnull(A.[7],0)  as T_Ope_CONSU,isnull(A.[3],0)  as T_Ope_CE,isnull(A.[18],0)  as T_Ope_IO,            
 isnull(A.[5],0)  as T_Ope_IN,            
  CASE WHEN (ISNULL(A.[18],0) + ISNULL(A.[3],0) + ISNULL(A.[7],0) +     
 ISNULL(A.[1],0) + (isnull(A.[4],0)+isnull(A.[2],0)+isnull(A.[5],0)))=0 THEN 0 ELSE           
 CAST((ISNULL(B.[1],0)+ ISNULL(B.[2],0) + ISNULL(B.[3],0) + ISNULL(B.[4],0)+(isnull(B.[5],0)+isnull(B.[6],0)+isnull(B.[7],0))+            
 ISNULL(B.[8],0) +    ISNULL(B.[9],0)+ ISNULL(B.[18],0) +            
 --            
 ISNULL(C.[1],0)+ ISNULL(C.[2],0) + ISNULL(C.[3],0) + ISNULL(C.[4],0)+(isnull(C.[5],0)+isnull(C.[6],0)+isnull(C.[7],0))+            
 ISNULL(C.[8],0) +    ISNULL(C.[9],0)+ ISNULL(C.[18],0) +             
 --            
 ISNULL(D.[1],0)+ ISNULL(D.[2],0) + ISNULL(D.[3],0) + ISNULL(D.[4],0)+(isnull(D.[5],0)+isnull(D.[6],0)+isnull(D.[7],0))+            
 ISNULL(D.[8],0) +    ISNULL(D.[9],0)+ ISNULL(D.[18],0) +             
 --            
 ISNULL(E.[1],0)+ ISNULL(E.[2],0) + ISNULL(E.[3],0) + ISNULL(E.[4],0)+(isnull(E.[5],0)+isnull(E.[6],0)+isnull(E.[7],0))+            
 ISNULL(E.[8],0) +    ISNULL(E.[9],0)+ ISNULL(E.[18],0)) AS FLOAT) / (ISNULL(A.[18],0) + ISNULL(A.[3],0) + ISNULL(A.[7],0) +     
 ISNULL(A.[1],0) + (isnull(A.[4],0)+isnull(A.[2],0)+isnull(A.[5],0))) END AS PERCENT_S_TOTAL,            
 ---MET            
 M.SMETSEGINC AS META,            
 CASE WHEN M.SMETSEGINC=0 THEN 0 ELSE cast(ISNULL(B.[1],0)+ ISNULL(B.[2],0) + ISNULL(B.[3],0) + ISNULL(B.[4],0)+(isnull(B.[5],0)+isnull(B.[6],0)+isnull(B.[7],0))+            
 ISNULL(B.[8],0) +    ISNULL(B.[9],0)+ ISNULL(B.[18],0) +            
 --            
 ISNULL(C.[1],0)+ ISNULL(C.[2],0) + ISNULL(C.[3],0) + ISNULL(C.[4],0)+(isnull(C.[5],0)+isnull(C.[6],0)+isnull(C.[7],0))+            
 ISNULL(C.[8],0) +    ISNULL(C.[9],0)+ ISNULL(C.[18],0) +             
 --            
 ISNULL(D.[1],0)+ ISNULL(D.[2],0) + ISNULL(D.[3],0) + ISNULL(D.[4],0)+(isnull(D.[5],0)+isnull(D.[6],0)+isnull(D.[7],0))+            
 ISNULL(D.[8],0) +    ISNULL(D.[9],0)+ ISNULL(D.[18],0) +             
 --            
             
 ISNULL(E.[1],0)+ ISNULL(E.[2],0) + ISNULL(E.[3],0) + ISNULL(E.[4],0)+(isnull(E.[5],0)+isnull(E.[6],0)+isnull(E.[7],0))+            
 ISNULL(E.[8],0) +    ISNULL(E.[9],0)+ ISNULL(E.[18],0) as float)/M.SMETSEGINC  END AS Avance,            
 case when             
 (ISNULL(B.[1],0)+ ISNULL(B.[2],0) + ISNULL(B.[3],0) + ISNULL(B.[4],0)+(isnull(B.[5],0)+isnull(B.[6],0)+isnull(B.[7],0))+            
 ISNULL(B.[8],0) +    ISNULL(B.[9],0)+ ISNULL(B.[18],0) +            
 --            
 ISNULL(C.[1],0)+ ISNULL(C.[2],0) + ISNULL(C.[3],0) + ISNULL(C.[4],0)+(isnull(C.[5],0)+isnull(C.[6],0)+isnull(C.[7],0))+            
 ISNULL(C.[8],0) +    ISNULL(C.[9],0)+ ISNULL(C.[18],0) +             
 --            
 ISNULL(D.[1],0)+ ISNULL(D.[2],0) + ISNULL(D.[3],0) + ISNULL(D.[4],0)+(isnull(D.[5],0)+isnull(D.[6],0)+isnull(D.[7],0))+            
 ISNULL(D.[8],0) +    ISNULL(D.[9],0)+ ISNULL(D.[18],0) +             
 --            
 ISNULL(E.[1],0)+ ISNULL(E.[2],0) + ISNULL(E.[3],0) + ISNULL(E.[4],0)+(isnull(E.[5],0)+isnull(E.[6],0)+isnull(E.[7],0))+            
 ISNULL(E.[8],0) +    ISNULL(E.[9],0)+ ISNULL(E.[18],0) ) >=M.SMETSEGINC then  'SI' else 'NO' end Cumplimiento            
            
from #TABRESULTCartera a  --SELECT * FROM #TABRESULTCartera      
left join (select * from #TABRESULTSeguros where seg in(200,220,230)) b --MR            
on a.SCODDESCRIP=b.SCODDESCRIP            
left join (select * from #TABRESULTSeguros where seg in(803))c  --MC            
on a.SCODDESCRIP=c.SCODDESCRIP            
left join (select * from #TABRESULTSeguros where seg in(802))d  --PC            
on a.SCODDESCRIP=d.SCODDESCRIP            
left join (select * from #TABRESULTSeguros where seg in(806,815))e --AGRO            
on a.SCODDESCRIP=E.SCODDESCRIP            
left join (select * from #TABRESULTSeguros where seg in(814))f  --PC            
on a.SCODDESCRIP=f.SCODDESCRIP        
left join #Meta_Vr2 M on a.SCODDESCRIP=M.HCODREL            
--left join #MetSeg  M on a.SCODDESCRIP=M.SCODDESCRIP            
WHERE A.descripcion IS NOT NULL            
   
        
            
END
