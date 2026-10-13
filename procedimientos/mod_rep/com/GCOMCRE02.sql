-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-03-14 14:25:49.413000
 --exec [com].[GCOMCRE02]  7,'231' 
CREATE  procedure [com].[GCOMCRE02]  
@tip_cod int, @cod_rel varchar(10)--,@fec date                
----------------------------------------------------------------------------------                
as                
begin                
SET NOCOUNT ON;  
 
---> OBTIENE FECHAS   
  --
  declare @fec  date =getdate()-1
   
	 --declare @tip_cod int = 7, @cod_rel varchar(10) = '231',@fec date  = '20240313'    

	create table #fechas (RORD int IDENTITY(1,1) NOT NULL,RFEC varchar(10)null)                
	insert into #fechas   
	select RFEC  from storage.ref.RCALEN001 where eomonth(RFEC) = EOMONTH(@fec) and RFEC <=@fec and RDIAFER  = 0
	--select * from #fechas
 
     
 declare @defs as rep.TTHCOLDEF;      
      
  insert into @defs          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,THIDDEN)  values       

 (0,1,1,'RDESVAR','Variable (en miles PEN, %, y número)',NULL,2,1,'string',null,null), 
 (0,2,1,'col_1','01',NULL,2,1,'number',null,null),
 (0,3,1,'col_2','02',NULL,2,1,'number',null,null),
 (0,4,1,'col_3','04',NULL,2,1,'number',null,null),
 (0,5,1,'col_4','05',NULL,2,1,'number',null,null),
 (0,6,1,'col_5','06',NULL,2,1,'number',null,null),
 (0,7,1,'col_6','07',NULL,2,1,'number',null,null),
 (0,8,1,'col_7','08',NULL,2,1,'number',null,null),
 (0,9,1,'col_8','09',NULL,2,1,'number',null,null),
 (0,10,1,'col_9','11',NULL,2,1,'number',null,null),
 (0,11,1,'col_10','12',NULL,2,1,'number',null,null),
 (0,12,1,'col_11','13',NULL,2,1,'number',null,null),
 (0,13,1,'col_12','14',NULL,2,1,'number',null,null),
 (0,14,1,'col_13','15',NULL,2,1,'number',null,null),
 (0,15,1,'col_14','16',NULL,2,1,'number',null,null),
 (0,16,1,'col_15','18',NULL,2,1,'number',null,null),
 (0,17,1,'col_16','19',NULL,2,1,'number',null,null),
 (0,18,1,'col_17','20',NULL,2,1,'number',null,null),
 (0,19,1,'col_18','21',NULL,2,1,'number',null,null),
 (0,20,1,'col_19','22',NULL,2,1,'number',null,null),
 (0,21,1,'col_20','23',NULL,2,1,'number',null,null),
 (0,22,1,'col_21','25',NULL,2,1,'number',null,null),
 (0,23,1,'col_22','26',NULL,2,1,'number',null,null),
 (0,24,1,'col_23','27',NULL,2,1,'number',null,null),
 (0,25,1,'col_24','28',NULL,2,1,'number',null,null),
 (0,26,1,'col_25','29',NULL,2,1,'number',null,null),
 (0,27,1,'col_26','30',NULL,2,1,'number',null,null) 
  
 select rep.FFTHCOLDEF(@defs) result;  
 
---> resultados sin API      
	select B.RORD, B.RFEC -- B.RORD fila, B.RFEC descripcion 
	 
	,cast(A.HNUM_COMITE  as float) [10214] --cast(A.HCOM_FISICO +A.HCOM_VIRTUAL  as float)[10214] --HHCOM_TOTAL 
	,CAST(HMIN_DURA_H as float) [10218] --HMIN_DURA
	,CAST(HMAX_DURA_H as float) [10219] --HMAX_DURA
	,CAST(HOPE_APROB as float) [10212]
	,CAST(HOPE_OBS as float) [10213]
	,CAST(HOPE_RECH as float) [10215]
	,case when A.HOPE_APROB  > 0 then      A.HOPE_APROB   / cast(A.HDESEMB_COM as float)   else 0 end [10200]  ----
	,case when A.HCOM_3K > 0 then      A.HCOM_3K   / cast(A.HDESEMB_COM as float)   else 0 end [10202] --P_HCOM_10K  
	,case when A.HCOM_3_5K > 0 then      A.HCOM_3_5K   / cast(A.HDESEMB_COM as float)   else 0 end [10228] --P_HCOM_10K  
 	,case when A.HCOM_5_10K > 0 then      A.HCOM_5_10K   / cast(A.HDESEMB_COM as float)   else 0 end [10229] --P_HCOM_10K  
	,case when A.HCOM_10_20K > 0 then   A.HCOM_10_20K / cast(A.HDESEMB_COM  as float) else 0 end [10203] --P_HCOM_10_20K
	,case when A.HCOM_M20K > 0 then     A.HCOM_M20K / cast(A.HDESEMB_COM  as float) else 0 end [10204] --P_HCOM_M20K 
	
	into    #ACUM000 -- select * from #ACUM000  drop table #ACUM000
	from storage.com_act.WDCB003 A   
	join #fechas B               
    on  A.HFECPRO=B.RFEC   
	where A.HTIPCOD=@tip_cod and A.HCODREL=@cod_rel   
	 
	--pivotea el resultado por las variables de meta    
select * into #ACUM001 from #ACUM000 unpivot (valores for variables in( [10214],[10218],[10219],[10212],[10213],[10215],[10200],[10202],[10228],[10229],
[10203],[10204]
)) UNPVT    order by RORD asc       --select * from #ACUM001  drop table #ACUM001
   



   
--variacion
select RORD, variables, util.FFMTVAR(variables,valores,null) SVALOR               
into #AAA --select * from #AAA       drop table #AAA         
from #ACUM001 
 



--select RORD, valores, variables into #AAA from #ACUM001

select *
into #RES  --  select*from #RES        drop table #RES                         
from #AAA pivot (max(SVALOR) for RORD in  ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31])) PVT    

 
 

    
-->CREAMOS LA TABLA A PUBLICAR           
create table #CMG      --drop table   #CMG          
(   RDESVAR varchar(250),                
    RCODVAR int           
)     

 
IF (@tip_cod = 21 and @cod_rel = '2')
	begin
		insert into #CMG             
		values  
		 ('Disponible solo para individual',1)
	end

else
begin

insert into #CMG             
values  
 ('1. Número de comités realizados',1),  
 ('Número de comités realizados', 10214),
 ('2. Comite dentro del horario',2),
 ('Duración minima (hh:mm:ss)', 10218),         
 ('Duración máxima (minutos)', 10219),  
 ('2.1. Número de créditos propuesto',3),
 ('Aprobadas',10212),
 ('Observadas',10213),
 ('Rechazadas',10215),
 ('2.2. Efectvidad: (Número de crédito aprobados/Número de desembolsos',4),
 ('Efectvidad', 10200),
 ('2.3 Número de créditos desesmbolsados por rangos de montos (soles)',5),
 ('Desembolsos(%) Con Comité dentro del horario 0-3 mil',10202),
 ('Desembolsos (%) Con Comité dentro del horario 3-5 mil',10228),
 ('Desembolsos (%) Con Comité dentro del horario 5-10 mil',10229),
 ('Desembolsos (%) Con Comité dentro del horario 10-20 mil',10203),
 ('Desembolsos (%) Cin Comité dentro del horario > 20 mil',10204)  
 end


 select 
 CASE WHEN A.RCODVAR in (1,2,3,4,5) THEN 1 ELSE 0 END AS style,  
 RDESVAR,[1]col_1, [2]col_2,[3]col_3,[4]col_4,[5]col_5,[6]col_6,[7]col_7,[8]col_8,[9]col_9,[10]col_10,[11]col_11,[12]col_12,[13]col_13,[14]col_14,[15]col_15,[16]col_16,[17]col_17
 ,[18]col_18,[19]col_19,[20]col_20,[21]col_21,[22]col_22,[23]col_23,[24]col_24,[25]col_25,[26]col_26,[27]col_27,[28]col_28,[29]col_29,[30]col_30,[31]col_31
 from #CMG A                      
    left join           
 #RES B                       
    on A.RCODVAR=B.variables   

	drop table #fechas,#ACUM000,#AAA,#RES
END



--insert into mod_sys_admin.[dbo].[SREGSEC01] values ('L_COMITE_CRE_DIA','N_CART','Comite de Créditos Diario',null,'/app/reportes/leg/com/rda/adm/com-dia',14,null,null,null,null)
--insert into [mod_rep].[rep].[RREGREP01] values('GCOMCRE_02','Comite de Créditos Diario','{"name":"mod_rep.com.GCOMCRE02","params":[{"order":1,"name":"tip_cod"},{"order":2,"name":"cod_rel"},{"order":3,"name":"fecha"}]}')
-- --insert into mod_sys_admin.[dbo].[SPROFSEC01] values ('PROF_RECUPERACIONES_STAFF','L_MON_EFC_TRAMC')

-- update [mod_rep].[rep].[RREGREP01] set RTPREP = '{"name":"mod_rep.com.GCOMCRE02","params":[{"order":1,"name":"tip_cod"},{"order":2,"name":"cod_rel"}]}'
--   where RCODREP ='GCOMCRE_02'
