-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-07 06:06:57.980000
--EXEC com.GRESREPSEG06  7,'231'              
CREATE procedure [com].[GRESREPSEG06]                
 @tip_cod int,                          
@cod_rel varchar(10)                          
AS                               
BEGIN                         
SET NOCOUNT ON;                     
 /*                
@tip_cod int=15,                          
@cod_rel varchar(10) ='1'                         
 */                
DECLARE @dFechaMax date = (select MAX(SFECPRO) from storage.[com_seg].SDSF001)                    
                
                
/* Meta */                  
 DECLARE @FecMeta date,@FecJerar date                  
set @FecMeta=(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR=5001 )                  
set @FecJerar=(select max(rfecpro) from storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' )                  
                     
 ;WITH CTE_A AS (                    
select *                    
from [storage].[com].[VDMCOM01] --SELECT MAX(HFECPRO) FROM [storage].[com].[VDMCOM01]  WHERE    hcodvar=5001 DROP TABLE #Meta_Vr2                
where HTIPCOD='2'   and hcodvar=5001 and hfecpro=eomonth(@dFechaMax)                      
)                    
 ,                    
CTE_B AS (                    
SELECT DISTINCT   CAST(RCODSEC AS VARCHAR(250))     RCOD                    
                    
FROM storage.[ref].WJERCOR03 where RINDFEC='ACTUAL' AND RFECPRO=@FecJerar                  
AND CASE WHEN @tip_cod='21' THEN CAST(RCODGRU AS VARCHAR(250))                     
         WHEN @tip_cod='20' THEN CAST(RCODTER AS VARCHAR(250))                    
         WHEN @tip_cod='19' THEN CAST(RCODCOR AS VARCHAR(250))                    
         WHEN @tip_cod='18' THEN CAST(RCODUNI AS VARCHAR(250))
		 WHEN @tip_cod='17' THEN CAST(RCODUCO AS VARCHAR(250)) ELSE '1' END = IIF(@tip_cod=7,'1',@cod_rel)                     
),                    
CTE_C AS (                    
--SELECT B.RCOD HCODREL,HVALVAR               
SELECT A.HCODREL HCODREL,HVALVAR                     
FROM CTE_A A                    
LEFT JOIN CTE_B B                    
ON A.HCODREL=B.RCOD                    
)  ,                    
CTE_D AS (                     
SELECT HCODREL,SUM(HVALVAR)  METASEG                  
FROM CTE_C                    
WHERE HCODREL IS NOT NULL                    
GROUP BY HCODREL                    
)                    
SELECT * INTO #Meta_Vr2 FROM CTE_D                 
                 
--select * into #Fec from storage.util.FVECFEC01((@dFechaMax),'cie_ant,cie_ant+2')b                   
--select * into #Fec from storage.util.FVECFEC01((@dFechaMax),'hoy,cie_ant')b                  
select * into #Fec from storage.util.FVECFEC01((@dFechaMax),'hoy')b                   
insert into #Fec              
select top 1  rfec              
from storage.ref.RCALEN001                
where  rfec <= DATEADD(MM,-1,convert(date,@dFechaMax))  and  RDIAFER=0               
order by 1 desc                
              
declare @fecacumu varchar(max)              
select @fecacumu=string_agg(format(RFEC,'yyyyMMdd'),',')                   
from #Fec                 
select * into #FJERCOR FROM storage.ref.FJERCOR02(@fecacumu)              
                
declare @Fec1 varchar(50),@fec2 varchar(50)                
set @Fec1=(select rfec from #Fec where rord=1)                
set @Fec2=(select rfec from #Fec where rord=2)                
                
declare @defs as rep.TTHCOLDEF                                                                          
 insert into @defs                                                                            
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values                                                                           
 (1,1,1,'Territorio','Territorio','string',null,'20px'),                                                                            
 (2,2,1,'Corredor','Corredor','string',null,null),                                                                            
 (3,3,1,'Grupo','Grupo','string',null,null),                               
 (4,4,1,'Administrador','Administrador','string',null,null),                        
                               
 (5,5,1,'Sectorista','Sectorista','string',null,null),                                             
 (6,6,1,'Cod_Sect','Código BT Sectorista','string',null,null),                                            
 (7,7,1,'TOpeOS1','Total Opera '+@Fec1,'number',null,null),                                             
 (8,8,1,'TSegOS1','Total Seguros '+@Fec1,'number',null,null),                                             
 (9,9,1,'TSegOS2','Total Seguros '+@Fec2,'number',null,null),                  
 (10,10,1,'Meta','Meta','number','.2-2',null),                                       
 (11,11,1,'Avance','Avance','percent','.2-2',null)                     
                 
    select rep.FFTHCOLDEF(@defs) result;                              
   ;WITH CTE_A AS (                  
SELECT  b.RORD,a.*,                  
    CASE WHEN SCODMOD=104   AND STIPOPE=2   AND SSUBTIP=99 THEN 'TO_IN'                  
      WHEN SCODMOD=104  AND STIPOPE IN(1,2,130)   AND SSUBTIP IN(1,6,8,34,36,5000,9991,2,3,4,5,7,11,12,35,99,1000,9990) THEN 'TO_EC'                  
   WHEN SCODMOD=101  AND STIPOPE IN(1,2,4)  THEN 'TO_AG'                   
   WHEN SCODMOD=103 AND STIPOPE=36 THEN 'TO_CC'                  
   WHEN SCODMOD=103 AND STIPOPE=2 THEN 'TO_CO'                   
   WHEN SCODMOD=103 AND STIPOPE=120 THEN 'TO_CE'                  
   WHEN SCODMOD=102   AND STIPOPE=12 THEN 'TO_IC'                  
   END SEG                  
FROM storage.[com_act].[SDAF002]  a  --select * from storage.[com_act].[SDAF002] where scodagr=6                
inner join #Fec b on a.sfecpro=b.RFEC --select * from #Fec                
WHERE SCODAGR=6 --AND SCODMOD=104 -- EMPRENDIENDO CONFIANZA                  
)                 
,                  
cte_b as (                   
SELECT cast(C.RCODSEC as varchar(250)) SCODDESCRIP ,    c.RDESGRU,c.RDESCOR,c.RDESTER,                
  SEG,a.RORD,a.SFECPRO,C.RDESSEC descripcion ,SUM(A.SNUMOPE)   SNUMOPE                
FROM CTE_A A --SELECT * FROM storage.[ref].WJERCOR01  where rcodsec='TSARQ100'  and RINDFEC='ACTUAL' and rfecpro in('20220331','20220228')                   
--LEFT JOIN storage.[ref].WJERCOR01 C on A.SCODSEC =  C.RCODSEC and  a.SFECPRO =C.RFECPRO and RINDFEC='ACTUAL'                    
LEFT JOIN #FJERCOR C on A.SCODSEC =  C.RCODSEC and  a.SFECPRO =C.RFECPRO                  
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                                 
     when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                              
     when @tip_cod=19 then c.RCODCOR                                    
      when @tip_cod=18 then c.RCODUNI
	when @tip_cod=17 then c.RCODUCO else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                   
                
GROUP BY   cast(C.RCODSEC as varchar(250))                  
,c.RDESGRU,c.RDESCOR,c.RDESTER,                
    SEG,a.RORD,a.SFECPRO,C.RDESSEC                 
                 
),                  
CTE_SEG_PC AS (                  
SELECT b.RORD,a.*,                  
   CASE WHEN scodseg=802 THEN 'S_PC'                  
     WHEN SCODSEG in(806,815) THEN 'S_AG'                  
     WHEN SCODSEG=803 THEN 'S_MC'                  
     WHEN SCODSEG in(200,220,230) THEN 'S_MR'                  
     END SEG                  
FROM storage.[com_seg].SDSF001 a                
inner join #Fec b on a.sfecpro=b.RFEC                 
where   scodagr=6 --and scodseg in(802)                   
),                  
CTE_SEG_PC_JER AS (                  
SELECT cast(C.RCODSEC as varchar(250)) SCODDESCRIP ,    c.RDESGRU,c.RDESCOR,c.RDESTER,                 
  SEG,a.RORD,a.SFECPRO,C.RDESSEC descripcion,SUM(A.SNUMPLZ)  SNUMPLZ                  
FROM CTE_SEG_PC A                  
--LEFT JOIN storage.[ref].WJERCOR01 C on A.SCODSEC =  C.RCODSEC and  a.SFECPRO =C.RFECPRO and RINDFEC='ACTUAL'                 
LEFT JOIN #FJERCOR C on A.SCODSEC =  C.RCODSEC and  a.SFECPRO =C.RFECPRO                  
AND case when @tip_cod=21 then  ISNULL(cast(c.RCODGRU as nvarchar(10)),'9999')                                 
         when @tip_cod=20 then cast(c.RCODTER as nvarchar(10))                              
         when @tip_cod=19 then cast(c.RCODCOR as varchar(250))                             
         when @tip_cod=18 then cast(c.RCODUNI as varchar(250))
		 when @tip_cod=17 then cast(c.RCODUCO as varchar(250)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                   
GROUP BY  cast(C.RCODSEC as varchar(250)) ,                
c.RDESGRU,c.RDESCOR,c.RDESTER,                 
    SEG,a.RORD,a.SFECPRO,C.RDESSEC                 
),                  
CTE_RESULT AS (                  
SELECT *                   
FROM cte_b                  
UNION ALL                  
SELECT *                  
FROM CTE_SEG_PC_JER                  
--WHERE descripcion  IS NOT NULL AND SEG IS NOT NULL                  
)                  
                   
SELECT SCODDESCRIP,DESCRIPCION,sfecpro,rord,  RDESGRU,RDESCOR,RDESTER,                
 TO_IC, TO_CE, TO_EC, TO_CC, TO_CO , TO_IN,TO_AG,S_PC,S_AG,S_MC,S_MR                  
into #TABRESULT --DROP TABLE #TABRESULT                  
FROM                     
(SELECT SNUMOPE, SEG, DESCRIPCION ,SCODDESCRIP ,sfecpro,rord, RDESGRU,RDESCOR,RDESTER                  
FROM CTE_RESULT) p                    
PIVOT                    
(                    
SUM (SNUMOPE)                    
FOR SEG IN                    
( TO_IC, TO_CE, TO_EC, TO_CC, TO_CO , TO_IN,TO_AG,S_PC,S_AG,S_MC,S_MR)                    
) AS pvt                    
ORDER BY pvt.SCODDESCRIP;                    
                   
                  
SELECT  --PROTECCION CUOTA                  
  SCODDESCRIP,DESCRIPCION as RNOMSUB, sfecpro,  rord,  RDESGRU,RDESCOR,RDESTER,                 
  --TOTAL OPERACIONES                  
   (isnull(TO_EC,0) + ISNULL(TO_IN,0) ) +  ISNULL(TO_CC,0) +                  
  ISNULL(TO_IC,0)  +  ISNULL(TO_CE,0) +                  
  ISNULL(TO_AG,0)  +  ISNULL(TO_CO,0) AS 'TOpeOS',                  
  ISNULL(S_MR,0)+ISNULL(S_MC,0)+ISNULL(S_PC,0)+ISNULL(S_AG,0) AS 'TSegOS'                 
  into #PreResult    --drop table #PreResult            
FROM #TABRESULT -- SELECT * FROM #PreResult --DROP TABLE #TABRESULT    select * from #TABRESULT                
--where descripcion is not null                  
ORDER BY SCODDESCRIP ASC                 
             
                 
alter table #PreResult                
add RDESUNI varchar(250)null                
                
update a                
set a.RDESUNI=c.RDESUNI                
from #PreResult a                 
left join (select * from storage.[ref].WJERCOR03 where RFECPRO in(select rfec from #Fec where RORD=1)  and RINDFEC='ACTUAL' )C                 
on A.SCODDESCRIP =  C.RCODSEC                 
              
update a                
set a.RDESUNI=c.RDESUNI                
from #PreResult a                 
left join (select * from #FJERCOR where RFECPRO in(select rfec from #Fec where RORD=2)   )C                 
on A.SCODDESCRIP =  C.RCODSEC                 
where  a.RDESUNI is null               
                 
              
SELECT A.*,B.METASEG INTO #ResultSeg   --select * from #ResultSeg where sfecpro='2022-04-30'             
FROM #PreResult A    --select* from #PreResult  where sfecpro='2022-04-30'             
left join (select * from #Meta_Vr2) B on a.SCODDESCRIP =B.HCODREL                    
                
create table #REPSEGUROS --DROP TABLE #REPSEGUROS                
(                
RDESTER VARCHAR(250)NULL,                
RDESCOR VARCHAR(250)NULL,                
RDESGRU VARCHAR(250)NULL,                
RDESUNI VARCHAR(250)NULL,                
SDESSEC VARCHAR(250)NULL,                
SCODSEC VARCHAR(250)NULL,                
METASEG INT NULL,TOpeOS1 INT NULL,                
TSegOS1 INT NULL,TOpeOS2 INT NULL,                
TSegOS2 INT NULL                
)                
                
declare  @Query nvarchar(max)                                
SET @Query = N'SELECT   RDESTER,RDESCOR,RDESGRU,RDESUNI,RNOMSUB SDESSEC,SCODDESCRIP SCODSEC,METASEG ' + NCHAR(10)                                         
--Después colocamos las columnas que vamos a transponer                         
+ ( SELECT REPLACE( N',MAX( CASE WHEN rord = <<rord>> THEN TOpeOS END) AS TOpeOS<<rord>>,                
 MAX( CASE WHEN rord = <<rord>> THEN TSegOS  END) AS TSegOS<<rord>>', N'<<rord>>', rord)+ NCHAR(10)                                    
    FROM #ResultSeg     --DROP TABLE #temp1  SELECT * FROM #temp1                                         
    --Eliminamos duplicados usando GROUP BY                                                
    GROUP BY rord                                               
 --Definimos el orden de las columnas                                                
    ORDER BY rord                                                
    --Usamos esta instrucción para concatenar los valores                      
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                                
--Ponemos el resto de la consulta                                                
+ N'FROM #ResultSeg                                                   
GROUP BY RDESTER,RDESCOR,RDESGRU,RDESUNI,RNOMSUB,SCODDESCRIP,METASEG                
order by SCODDESCRIP asc ;                                      
'                    
INSERT INTO #REPSEGUROS                        
EXEC sp_Executesql @Query;                      
                
SELECT ISNULL(RDESTER,'SIN ASIGNAR') Territorio, ISNULL(RDESCOR,'SIN ASIGNAR') Corredor, ISNULL(RDESGRU,'SIN ASIGNAR') Grupo, ISNULL(RDESUNI,'SIN ASIGNAR') Unidad, ISNULL(SDESSEC,'SIN ASIGNAR') Sectorista,                
 ISNULL(SCODSEC,'SIN ASIGNAR') [Cod_Sect],                
 ISNULL(TOpeOS1,0)   TOpeOS1  , ISNULL(TSegOS1,0) TSegOS1, ISNULL(TOpeOS2,0) TOpeOS2, ISNULL(TSegOS2,0) TSegOS2, ISNULL( METASEG,0) as Meta,                
ISNULL((CASE WHEN ISNULL(METASEG,0)=0 THEN 0 ELSE CAST(TSegOS1 AS FLOAT)/ISNULL(METASEG,0) END ),0) Avance                 
INTO #PreResult2        
FROM #REPSEGUROS               
--order by RDESADM,METASEG,TOpeOS1 desc                   
        
select * from #PreResult2 where grupo <>'GRUPAL' order by Unidad,TSegOS1 desc                   
--          
                    
 drop table  #Meta_Vr2, #Fec , #TABRESULT , #PreResult , #ResultSeg , #REPSEGUROS  ,#FJERCOR   ,#PreResult2           
                
end
