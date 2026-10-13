-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-07-07 15:06:02.637000

--exec [com].[GCOMCRE01]   7,'231','20230630'
CREATE  procedure [com].[GCOMCRE01]  
@tip_cod int, @cod_rel varchar(10),@fec date                
----------------------------------------------------------------------------------                
as                
begin                
SET NOCOUNT ON;  
--declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20230630'    
 
---> OBTIENE FECHAS  
 
 select RORD, format(RFEC,'yyyy-MM-dd') F, format(RFEC,'yyyyMMdd') RFEC    into #fechas   from storage.[util].[FVECFEC01](@fec,'cmg_5+12,cmg_5+2,cmg_5,cmg_6')   

  --declare @fec as date ='2023-06-30'
	create table #FEC_anio (RORD int IDENTITY(1,1) NOT NULL,RFEC varchar(10)null)                
	insert into #FEC_anio  
	select RFEC  from storage.ref.RCALEN001 where rciebt = 1 and year(RFEC) between year(@fec)-1 and year(@fec) and RFEC <= @fec order by 1


 declare @fecst varchar(250);     
 select @fecst=string_agg(RFEC,',') from #fechas    
 declare @fecha1 as date, @fecha2 as date, @fecha3 as date, @fecha4 as date, @fecha5 as date, @fecha6 as date
 select @fecha1 = RFEC from #fechas where RORD=1    
 select @fecha2 = RFEC from #fechas where RORD=2    
 select @fecha3 = RFEC from #fechas where RORD=3    
 select @fecha4 = RFEC from #fechas where RORD=4 
     
 declare @defs as rep.TTHCOLDEF;      
      
  insert into @defs          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,THIDDEN)  values       

 (0,1,1,'RDESVAR','Variable (en miles PEN, %, y número)',NULL,2,1,'string',null,null),   
 (1,null,1,'2021',format(@fecha1,'yyyy'),2,1,NULL,NULL,null,null),   
 (2,null,1,'2022',format(@fecha4,'yyyy'),4,1,NULL,NULL,null,null),  
 (5,10,1,'TMM','TMM',2,2,NULL,'number',null,null),  
 (6,11,1,'STMM',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),   
 (7,12,1,'TMA','TAM',2,2,NULL,'number',null,null),   
 (8,13,1,'STMA',NULL,1,NULL,NULL,'traffic-light',null,'TRUE'),

 (10,2,2,'col_1',format(@fecha1,'dd-MMM'),null,null,null,'number',null,null),   
 (11,3,2,'col_6',format(@fecha1,'yyyy'),null,null,null,'number',null,null),   
 (12,4,2,'col_2',format(@fecha2,'dd-MMM'),null,null,null,'number',null,null),   
 (13,5,2,'col_3',format(@fecha3,'dd-MMM'),null,null,null,'number',null,null),   
 (14,6,2,'col_4',format(@fecha4,'dd-MMM'),null,null,null,'number',null,null),   
 (15,7,2,'col_7',format(@fecha4,'yyyy'),null,null,null,'number',null,null)  
  
 select rep.FFTHCOLDEF(@defs) result;  

   
-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20230630'               
---> resultados sin API      
	select B.RORD, B.RFEC -- B.RORD fila, B.RFEC descripcion 
	
	,case when A.HDESEMB_COM > 0 then   A.HDESEMB_COM / cast(A.HTOT_OPEDESEMB  as float) else 0 end [10200] --P_HDESEMB_COM
	,case when A.HDESEMB_SCOM > 0 then   A.HDESEMB_SCOM / cast(A.HTOT_OPEDESEMB  as float) else 0 end [10201] --P_HDESEMB_SCOM

 	,case when A.HCOM_10K > 0 then      A.HCOM_10K   / cast(A.HTOT_OPEDESEMB as float)   else 0 end [10202] --P_HCOM_10K  
	,case when A.HCOM_10_20K > 0 then   A.HCOM_10_20K / cast(A.HTOT_OPEDESEMB  as float) else 0 end [10203] --P_HCOM_10_20K
	,case when A.HCOM_M20K > 0 then     A.HCOM_M20K / cast(A.HTOT_OPEDESEMB  as float) else 0 end [10204] --P_HCOM_M20K
	,case when A.HSCOM_10K > 0 then     A.HSCOM_10K / cast(A.HTOT_OPEDESEMB  as float) else 0 end [10205] --P_HSCOM_10K
	,case when A.HSCOM_10_20K > 0 then  A.HSCOM_10_20K / cast(A.HTOT_OPEDESEMB  as float) else 0 end [10206] --P_HSCOM_10_20K
	,case when A.HSCOM_M20K > 0 then    A.HSCOM_M20K / cast(A.HTOT_OPEDESEMB  as float) else 0 end [10207] --P_HSCOM_M20K
 
	,case when A.HCOM_SFIRMA > 0 then   A.HCOM_SFIRMA / cast(A.HNUM_COMITE  as float) else 0 end  [10208] --P_HCOM_SFIRMA
	,case when A.HCOM_FIRMA > 0 then    A.HCOM_FIRMA / cast(A.HNUM_COMITE  as float) else 0 end [10209] --P_HCOM_FIRMA
	,case when A.HCOM_DESEMB > 0 then   A.HCOM_DESEMB / cast(A.HNUM_COMITE  as float) else 0 end  [10210] --P_HCOM_DESEMB
	,case when A.HCOM_SDESEMB > 0 then  A.HCOM_SDESEMB / cast(A.HNUM_COMITE  as float) else 0 end [10211] --P_HCOM_SDESEMB 
	,cast(A.HCOM_FISICO  as float) [10212] --HCOM_FISICO
	,cast(A.HCOM_VIRTUAL  as float) [10213] --HCOM_VIRTUAL
	,cast(A.HNUM_COMITE  as float) [10214] --cast(A.HCOM_FISICO +A.HCOM_VIRTUAL  as float)[10214] --HHCOM_TOTAL
	,cast(A.HDESEMB_COM  as float) [10215] --HDESEMB_COM
	
	,CAST(HAVG_OPE as float) [10216] --HAVG_OPE 
	,CAST(HMAX_OPE as float) [10217] --HMAX_OPE
	,CAST(HAVG_DURA as float) [10218] --HAVG_DURA
	,CAST(HMAX_DURA as float) [10219] --HMAX_DURA
	,CAST(HAVG_ASIST as float) [10220] --HAVG_ASIST
	,CAST(HMAX_ASIST as float) [10221] --HMAX_ASIST

	,(HSALVENMN_CC + HCAST12M +HVENTA_CARTMN12M -HRECCAST12M) / (HSALCAPMN_CC + HCAST12M +HVENTA_CARTMN12M -HRECCAST12M)  [10222] --HCC_MORAR
	,(HSALVENMN_SC + HCAST12M +HVENTA_CARTMN12M -HRECCAST12M) / (HSALCAPMN_SC + HCAST12M +HVENTA_CARTMN12M -HRECCAST12M) [10223] --HSC_MORAR
	,CAST(null as float) [10224] --HCC_MORA6M
	,CAST(null as float) [10225] --HSC_MORA6M 

	into    #ACUM000 -- select * from #ACUM000  drop table #ACUM000
	from storage.com_act.WDCB001 A   
	join #fechas B               
    on  A.HFECPRO=B.RFEC   
	left join storage.com_act.WDCB002 C
	on A.htipcod = C.htipcod and a.hcodrel = C.hcodrel and A.hfecpro = C.HFECPRO
	left join storage.com_act.wjas002 D
	on A.htipcod = D.htipcod and a.hcodrel = D.hcodrel and A.hfecpro = D.HFECPRO
	where A.HTIPCOD=@tip_cod and A.HCODREL=@cod_rel   

	
	----> VENCIDOS + CAST12M + VENTA12M - rec CAST 12M / CARTERA + CAST12M + VENTA12M - rec CAST 12M 
	 

  	 create table #COL_ANIO (RORD int IDENTITY(6,1) NOT NULL,RFEC varchar(10)null)                
	 insert into #COL_ANIO
	select distinct year(RFEC)  from #FEC_anio order by 1 asc 

	-- declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20230630'               

	 select  E.RORD, year(B.RFEC) RFEC 
	,case when SUM(A.HDESEMB_COM) > 0 then   SUM(A.HDESEMB_COM) / SUM(cast(A.HTOT_OPEDESEMB  as float)) else 0 end [10200] --P_HDESEMB_COM
	,case when SUM(A.HDESEMB_SCOM) > 0 then   SUM(A.HDESEMB_SCOM) / SUM(cast(A.HTOT_OPEDESEMB  as float)) else 0 end [10201] --P_HDESEMB_SCOM

 	,case when SUM(A.HCOM_10K) > 0 then      SUM(A.HCOM_10K)   / SUM(cast(A.HTOT_OPEDESEMB as float))   else 0 end [10202] --P_HCOM_10K  
	,case when SUM(A.HCOM_10_20K) > 0 then   SUM(A.HCOM_10_20K) / SUM(cast(A.HTOT_OPEDESEMB  as float)) else 0 end [10203] --P_HCOM_10_20K
	,case when SUM(A.HCOM_M20K) > 0 then     SUM(A.HCOM_M20K) / SUM(cast(A.HTOT_OPEDESEMB  as float)) else 0 end [10204] --P_HCOM_M20K
	,case when SUM(A.HSCOM_10K) > 0 then     SUM(A.HSCOM_10K) / SUM(cast(A.HTOT_OPEDESEMB  as float)) else 0 end [10205] --P_HSCOM_10K
	,case when SUM(A.HSCOM_10_20K) > 0 then  SUM(A.HSCOM_10_20K) / SUM(cast(A.HTOT_OPEDESEMB  as float)) else 0 end [10206] --P_HSCOM_10_20K
	,case when SUM(A.HSCOM_M20K) > 0 then    SUM(A.HSCOM_M20K) / SUM(cast(A.HTOT_OPEDESEMB  as float)) else 0 end [10207] --P_HSCOM_M20K
 
	,case when SUM(A.HCOM_SFIRMA) > 0 then   SUM(A.HCOM_SFIRMA) / SUM(cast(A.HNUM_COMITE  as float)) else 0 end  [10208] --P_HCOM_SFIRMA
	,case when SUM(A.HCOM_FIRMA) > 0 then    SUM(A.HCOM_FIRMA) / SUM(cast(A.HNUM_COMITE  as float)) else 0 end [10209] --P_HCOM_FIRMA
	,case when SUM(A.HCOM_DESEMB) > 0 then   SUM(A.HCOM_DESEMB) / SUM(cast(A.HNUM_COMITE  as float)) else 0 end  [10210] --P_HCOM_DESEMB
	,case when SUM(A.HCOM_SDESEMB) > 0 then  SUM(A.HCOM_SDESEMB) / SUM(cast(A.HNUM_COMITE  as float)) else 0 end [10211] --P_HCOM_SDESEMB 
	,SUM(cast(A.HCOM_FISICO  as float)) [10212] --HCOM_FISICO
	,SUM(cast(A.HCOM_VIRTUAL  as float)) [10213] --HCOM_VIRTUAL
	,SUM(cast(A.HNUM_COMITE  as float)) [10214] --cast(A.HCOM_FISICO +A.HCOM_VIRTUAL  as float)[10214] --HHCOM_TOTAL
	,SUM(cast(A.HDESEMB_COM  as float)) [10215] --HDESEMB_COM
	
	,AVG(CAST(HAVG_OPE as float)) [10216] --HAVG_OPE 
	,MAX(CAST(HMAX_OPE as float)) [10217] --HMAX_OPE
	,AVG(CAST(HAVG_DURA as float)) [10218] --HAVG_DURA
	,MAX(CAST(HMAX_DURA as float)) [10219] --HMAX_DURA
	,AVG(CAST(HAVG_ASIST as float)) [10220] --HAVG_ASIST
	,MAX(CAST(HMAX_ASIST as float)) [10221] --HMAX_ASIST

	,(SUM(HSALVENMN_CC) + SUM(HCAST12M) +SUM(HVENTA_CARTMN12M) -SUM(HRECCAST12M)) / (SUM(HSALCAPMN_CC) + SUM(HCAST12M) +SUM(HVENTA_CARTMN12M )-SUM(HRECCAST12M))[10222] --HCC_MORAR
	,(SUM(HSALVENMN_SC) + SUM(HCAST12M) +SUM(HVENTA_CARTMN12M) -SUM(HSALCAPMN_SC)) / (SUM(HSALCAPMN_CC) + SUM(HCAST12M) +SUM(HVENTA_CARTMN12M )-SUM(HRECCAST12M)) [10223] --HSC_MORAR
	,SUM(CAST(null as float)) [10224] --HCC_MORA6M
	,SUM(CAST(null as float)) [10225] --HSC_MORA6M 

	into    #ACUM00A -- select * from #ACUM00A  drop table #ACUM00A
	from storage.com_act.WDCB001 A   
	join #FEC_anio B               
    on  A.HFECPRO=B.RFEC 
	join #COL_ANIO E on year(B.RFEC) = E.RFEC 
	left join storage.com_act.WDCB002 C
	on A.htipcod = C.htipcod and a.hcodrel = C.hcodrel and A.hfecpro = C.HFECPRO
	left join storage.com_act.wjas002 D
	on A.htipcod = D.htipcod and a.hcodrel = D.hcodrel and A.hfecpro = D.HFECPRO
	where A.HTIPCOD=@tip_cod and A.HCODREL=@cod_rel   
	group by year(B.RFEC), E.RORD
	 
 


--pivotea el resultado por las variables de meta    
select * into #ACUM001 from #ACUM000 unpivot (valores for variables in( [10200],[10201],[10202],[10203],[10204],[10205],[10206],[10207],[10208],[10209],
[10210],[10211],[10212],[10213],[10214],[10215],[10216],[10217],[10218],[10219],[10220],[10221],[10222],[10223],[10224],[10225]
)) UNPVT    order by RORD asc       --select * from #ACUM001  drop table #ACUM001
   

--pivotea el resultado por las variables de meta    
select * into #ACUM002 from #ACUM00A unpivot (valores for variables in( [10200],[10201],[10202],[10203],[10204],[10205],[10206],[10207],[10208],[10209],
[10210],[10211],[10212],[10213],[10214],[10215],[10216],[10217],[10218],[10219],[10220],[10221],[10222],[10223],[10224],[10225]
)) UNPVT    order by RORD asc       --select * from #ACUM002  drop table #ACUM002


select * into #ACUM001T from #ACUM001
UNION
select * from #ACUM002 --select * from #ACUM001T  drop table #ACUM001T
  

--variacion
select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR               
into #AAA --select * from #AAA       drop table #AAA         
from #ACUM001T 
UNION ALL   
select  case 
	when concat(A.RORD,'-',B.RORD) = '3-4' then 8 --variacion mensual TMM
	when concat(A.RORD,'-',B.RORD) = '1-4' then 10 end RORD  --variacion anual TMA              
    ,A.variables,     
	util.FFMTVAR(A.variables,B.valores-A.valores,iif(A.variables in
  ( 10200,10201,10202,10203,10204,10205,10206,10207,10208,10209,10210,10222,10223 ),1,null)) SVALOR  
	from #ACUM001 A       
        join #ACUM001 B                
        on A.variables=B.variables                
	where concat(A.RORD,'-',B.RORD) in('1-4','3-4')
UNION ALL              
   select  case
    when concat(A.RORD,'-',B.RORD) = '3-4' then 9 --variacion mensual TMM
	when concat(A.RORD,'-',B.RORD) = '1-4' then 11 end RORD  --variacion anual TMA            
            ,A.variables, cast(util.FSEMVAR(A.variables,A.valores,B.valores-A.valores) as varchar) SVALOR  
   from #ACUM001 A              
   join #ACUM001 B              
   on A.variables=B.variables              
   where concat(A.RORD,'-',B.RORD) in('1-4','3-4')

    
select *
into #RES  --  select*from #RES        drop table #RES                         
from #AAA pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11])) PVT                      
    
                
    
-->CREAMOS LA TABLA A PUBLICAR           
create table #CMG      --drop table   #CMG          
(   RDESVAR varchar(250),                
    RCODVAR int           
)            
insert into #CMG             
values  
 ('Detalle Comite',1),
 ('Nro Comités Físico',10212),    
 ('Nro Comités Virtual',10213),   
 ('Nro Comités Total', 10214), 
 ('Operaciones por comité Promedio',10216),           
 ('Operaciones por comité Máxima',  10217),    
 ('Duración Comité (min) Promedio', 10218),         
 ('Duración Comité (min) Máxima',   10219),         
 ('Nro Participantes en Comité Promedio', 10220),        
 ('Nro Participantes en Comité Máxima',   10221),
 ('Comités (%) Sin firma Asistencia',10208),    
 ('Comités (%) Con firma Asistencia',10209),  
 ('Numero de Desembolsos',2),
 ('Desembolsos (%) Con Comité', 10200),                
 ('Desembolsos (%) Sin Comité', 10201),                
 ('Desembolsos (%) Con Comité 0-10 mil', 10202), 
 ('Monto de Desembolsos',3),
 ('Desembolsos (%) Con Comité 10-20 mil',10203),          
 ('Desembolsos (%) Con Comité > 20 mill',10204),              
 ('Desembolsos (%) Sin Comité 0-10 mil', 10205),         
 ('Desembolsos (%) Sin Comité 10-20 mil',10206),          
 ('Desembolsos (%) Sin Comité > 20 mill',10207),
 ('Detalle de Efectividad',5),
 ('Comités (%) Desembolsan', 10210),     
 ('Comités (%) No Desembolsan', 10211),          
 ('Nro operaciones desembolsadas por comité', 10215), 
 ('Mora',6),
 ('Mora Real Con Comité',10222),    
 ('Mora Real Sin Comité',10223)  
 --('Mora 6m Con Comité',  10224),      
 --('Mora 6m Sin Comité',  10225)    
    
	--select * from #CMG
	--select * from #RES
 
 select 
 CASE WHEN A.RCODVAR in (1,2,3,4,5,6) THEN 1 ELSE 0 END AS style,  
 RDESVAR,[1]col_1, [2]col_2,[3]col_3,[4]col_4,[5]col_5,[6]col_6,[7]col_7,[8] TMM, [9] STMM,[10] TMA , [11] STMA                    
 from #CMG A                      
    left join           
 #RES B                       
    on A.RCODVAR=B.variables   

END
