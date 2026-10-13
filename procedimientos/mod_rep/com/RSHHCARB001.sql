-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-05-16 11:01:01.773000

--exec MOD_REP.[com].[RSHHCARB001] 7,'231','20230131','TODOS'        
CREATE PROCEDURE [com].[RSHHCARB001]  
@tip_cod int,@cod_rel varchar(250),@fec date,@cargambiental varchar(250)--,@pagen int  
AS  
BEGIN  
SET NOCOUNT ON;    
--declare @fec date='20230131',@tip_cod int=7,@cod_rel varchar(250)='231'  
  
-------------------------------------------------------------------------------  
  
declare @defs as rep.TTHCOLDEF                  
 insert into @defs                
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values                
 (1,1,1,'HFECPRO','Fecha','string',null,null),                
 (2,2,1,'RDESTER','Territorio','string',null,null),                
 (3,3,1,'RDESCOR','Corredor','string',null,null),                
 (4,4,1,'RDESMAT','Matriz','string',null,null),                
 (5,5,1,'RDESAGE','Agencia','string',null,null),                
 ---(6,6,1,'HCODSUCU','Cod Agencia','string',null,null),                
 (7,7,1,'HCTACONT','Cta Contable','string',null,null),                
 (8,8,1,'HNOMBCTA','Nombre Cta Contable','string',null,null),                
 (9,9,1,'HHUCARUN','Unidad','string',null,null),                
 (10,10,1,'HuellaCarbonoCantidad','Cantidad','number','.2-2',null),  
 (11,11,1,'HuellaCarbonoMonto','Monto','number','.2-2',null),  
 (12,12,1,'Promedio','Costo Promedio','number','.2-2',null)    
          
           --HCODGRUP=b.HNROG, a.HDESGRUP=b.HNOMG      
 select rep.FFTHCOLDEF(@defs) result;  
  
select distinct rdester,rdescor,rdesmat,rdesage ,RCODAGE  
into #VJERCOR02  
from STORAGE.REF.VJERCOR02  
where   
case when @tip_cod=7 then 1      
  WHEN @tip_cod=15 then rcodter      
  WHEN @TIP_COD=14 then rcodcor      
  when @TIP_COD=4  then rcodmat      
  when @tip_cod=16 then RCODAGEH end = case when @tip_cod=7 then 1 else @cod_rel end       
  
  
;with cte_ctaContable as (  
select '45130106010000' HCTACONT,'ENERGIA' HDESCCTA  
union all  
select '45130106020000','AGUA'  
union all  
select '45130111010105','COMBUSTIBLES'  
union all  
select '45130111010113','PAPEL'  
union all  
select '45130101040000','AEREOS'  
),  
CTE_CAJACHICA AS (  
SELECT eomonth(A.HFECPRO) HFECPRO,A.HCTACONT,A.HNOMBCTA,HHUCARUN,SUM(HHCARBCA) HuellaCarbonoCantidad,A.HCODSUCU,sum(HHCARBMO)HuellaCarbonoMonto,  
cast(sum(HHCARBMO) as float)/SUM(HHCARBCA) Promedio,  
case when a.HCTACONT='45130106010000' and rtrim(ltrim(HHUCARUN)) ='Kw/H' then 1  
 when a.HCTACONT='45130106020000' and rtrim(ltrim(HHUCARUN)) ='M3' then 1  
 when a.HCTACONT='45130111010105' and rtrim(ltrim(HHUCARUN)) ='GAL' then 1  
 when a.HCTACONT='45130111010113' and rtrim(ltrim(HHUCARUN)) in('Mi','Kg') then 1  
 when a.HCTACONT='45130101040000' and rtrim(ltrim(HHUCARUN)) in('Km') then 1 else 0 end style  
from storage.COM.HHDC001 A --select * from storage.COM.HHDC001   
INNER JOIN cte_ctaContable B   
ON A.HCTACONT=B.HCTACONT --AND A.NOMBRE_CUENTA=B.HDESCONT  
WHERE eomonth(A.HFECPRO)=eomonth(@fec)  
and b.HCTACONT  like CASE WHEN @cargambiental='TODOS' then '%%' else @cargambiental+'%' end   
GROUP BY eomonth(A.HFECPRO),A.HCTACONT,A.HNOMBCTA,A.HHUCARUN,A.HCODSUCU  
),  
CTE_OBLIGACIONES AS (  
SELECT eomonth(A.HFECPRO) HFECPRO,A.HCTACONT,A.HDESCCTA,HHUECARUN,SUM(HHUECARCA)HuellaCarbonoCantidad,A.HCODSUCU,sum(HHUECARMO)HuellaCarbonoMonto,  
cast(sum(HHUECARMO) as float)/SUM(HHUECARCA) Promedio,  
case when a.HCTACONT='45130106010000' and rtrim(ltrim(HHUECARUN)) ='Kw/H' then 1  
 when a.HCTACONT='45130106020000' and rtrim(ltrim(HHUECARUN)) ='M3' then 1  
 when a.HCTACONT='45130111010105' and rtrim(ltrim(HHUECARUN)) ='GAL' then 1  
 when a.HCTACONT='45130111010113' and rtrim(ltrim(HHUECARUN)) in('Mi','Kg') then 1  
 when a.HCTACONT='45130101040000' and rtrim(ltrim(HHUECARUN)) in('Km') then 1 else 0 end style  
FROM storage.COM.HHDC002 A --select distinct rtrim(ltrim(HHUECARUN)) from storage.COM.HHDC002  
INNER JOIN cte_ctaContable B   
ON A.HCTACONT=B.HCTACONT --AND A.NOMBRE_CUENTA=B.HDESCONT   
WHERE  eomonth(A.HFECPRO)=eomonth(@fec)  
and b.HCTACONT  like CASE WHEN @cargambiental='TODOS' then '%%' else @cargambiental+'%' end   
GROUP BY eomonth(A.HFECPRO),A.HCTACONT,A.HDESCCTA,HHUECARUN,A.HCODSUCU  
),  
cte_b as (  
SELECT * FROM CTE_CAJACHICA  
UNION ALL   
SELECT * FROM CTE_OBLIGACIONES  
),  
CTE_C AS (  
select * from cte_b   
)  
SELECT a.style,A.HFECPRO,B.RDESTER,B.RDESCOR,B.RDESMAT,B.RDESAGE,A.HCODSUCU,    
A.HCTACONT,A.HNOMBCTA,A.HHUCARUN,A.HuellaCarbonoCantidad,HuellaCarbonoMonto,Promedio   
into #T  
FROM CTE_C A  
inner JOIN #VJERCOR02 B  
ON A.HCODSUCU=B.RCODAGE --SELECT * FROM STORAGE.REF.VJERCOR03  
  
select * from #T   
order by style asc  
 
END
