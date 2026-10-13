-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:21:49.807000
--exec [com].[GRTABDIGO01] 7,'231','20230511'                                                              
CREATE PROCEDURE [com].[GRTABDIGO01]                                                                                  
 @tip_cod int,                                                                                      
 @cod_rel varchar(20),                                                                                  
 @fec date                                                                                 
 as                                                                                  
begin                                                                                  
  SET NOCOUNT ON;
--DECLARE @tip_cod int=7,@cod_rel varchar(250)='231',@fec date='20230511'
----------------------------------------------------------
/* Fechas Panel Tablero Digital V2 */    
--SET @fec='20230410'
select *   into #FECS       
from storage.util.FVECFEC01(@fec,'cmg_2,cmg_3,cie_ant+2,cie_ant+1')    
    
insert into #FECS    
select max(RFEC) from [storage].[ref].[RCALEN001] where rfec<=cast(DATEADD(MM, -1,@fec) as date) and RDIAFER=0    
    
insert into #FECS    
select RFEC                                
from storage.util.FVECFEC01(@fec,'hoy')            
----------------------------------------------------------------   

declare @defs as rep.TTHCOLDEF                                                                        
 insert into @defs                                                                          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values                                                                         
 (1,1,1,'descripcion','Descripción','string',null,'20px'),                                                                          
 (2,2,1,'1',(select cast(rfec as varchar(10)) from #FECS where RORD=1),'number',null,null),                                                                          
 (3,3,1,'2',(select cast(rfec as varchar(10)) from #FECS where RORD=2),'number',null,null),                                                                          
 (4,4,1,'3',(select cast(rfec as varchar(10)) from #FECS where RORD=3),'number',null,null),                                 
                             
 (5,5,1,'4',(select cast(rfec as varchar(10)) from #FECS where RORD=4),'number',null,null),                                           
 (6,6,1,'5',(select cast(rfec as varchar(10)) from #FECS where RORD=5),'number',null,null),                                           
 (7,7,1,'6',(select cast(rfec as varchar(10)) from #FECS where RORD=6),'number',null,null),
  (8,8,1,'hvalvar','Meta','number',null,null),
  (9,9,1,'PAvance','% Avance','number',null,null),
  (10,10,1,'TMM','TMM','number',null,null)
 
select rep.FFTHCOLDEF(@defs) result;

 


--- Jerarquia Macrocorredor 
SELECT DISTINCT RCODAGE RCODAGEH--DISTINCT RCODAGEH 
into #vjercor04   --DROP TABLE #vjercor04
FROM storage.ref.vjercor04
where case when @tip_cod=7 then 1                          
                     when @tip_cod=18 then RCODTER                          
                     when @tip_cod=17 then RCODMAC  
                     when @tip_cod=16 then RCODMAT                          
                     when @tip_cod=4 then RCODAGEH                           
                 end =case when @tip_cod=7 then 1 else @cod_rel end

;WITH CTE_H_ENROLADO AS (
select HORD,HFECPRO,HTIPNUMDOC   
from STORAGE.[com_pas].WCLIENRO001 a
inner join #vjercor04 b
on a.HSBSUC=b.RCODAGEH 
where a.hcodcan=1  
),
CTE_H_BASE_CAREC AS (
SELECT DISTINCT HORD,HFECPRO,HPETDOC,HPENDOC,HPEPAIS
FROM storage.com_pas.[WCAP002]  a  
inner join #vjercor04 b
on a.HSBSUC=b.RCODAGEH 
WHERE HCODCAN=1    
),
CTE_RESULT_ENROLADO AS (
 select 'Enrolado' HDESC,A.HORD,A.HFECPRO,COUNT(a.htipnumdoc)  htipnumdoc
 FROM CTE_H_ENROLADO A   
 GROUP BY A.HORD,A.HFECPRO
),
cte_result_cli_net as (
 select 'CliNet' HDESC,HORD,HFECPRO,
 COUNT(distinct concat_ws('-',HPENDOC,HPETDOC,HPEPAIS)) htipnumdoc
 from CTE_H_BASE_CAREC
 group by HORD,HFECPRO
), 
cte_RESUL_NUM_USAB as ( 
select   'NUM_USAB' HDESC,HORD,HFECPRO,COUNT(DISTINCT concat(HTIPDOC,HNUMDOC)) htipnumdoc  
from  STORAGE.[com_pas].WTRXMONE001 a --SELECT TOP 100 * FROM STORAGE.[com_pas].WTRXMONE001
inner join #vjercor04 b
on a.RCODSUC=b.RCODAGEH  
 WHERE HCODCAN=1
 GROUP BY  HORD,HFECPRO
),
cte_RESULT_PERCE_ENROLADO as (
select 'percent_enrolado' HDESC,a.HORD,a.hfecpro,cast(a.htipnumdoc as float)/b.htipnumdoc 'percent_enrolado' 
from CTE_RESULT_ENROLADO a
inner join cte_result_cli_net b
on a.HORD=b.HORD and a.hfecpro=b.hfecpro
),
cte_RESULT_PERCE_USAB as (
select 'percent_usab' HDESC,a.HORD,a.hfecpro,cast(a.htipnumdoc as float)/b.htipnumdoc 'percent_enrolado' 
from cte_RESUL_NUM_USAB a
inner join CTE_RESULT_ENROLADO b
on a.HORD=b.HORD and a.hfecpro=b.hfecpro
), 
CTE_H_MAESTRO_CORRE AS (
SELECT *
FROM STORAGE.[com_pas].WMTCORRE001
WHERE HCODCAN=1
),
cte_base_activos as (
select *
from CTE_H_MAESTRO_CORRE    
WHERE  HESTCORR='AC' AND  HFECINSTALA is not null  
)  
 ,
cte_base_cancelados as (
select *
from CTE_H_MAESTRO_CORRE
where HESTCORR='CA'  AND  HFECINSTALA is not null  
--GROUP BY HFECPRO,HESTCORR,HCODSUC
),
cte_base_stock as (
SELECT * FROM cte_base_activos
UNION ALL
SELECT * FROM cte_base_cancelados
),
cte_RESULT_STOCK_AC_CAN as ( 
select 'stock_ac_can'+'_'+a.HESTCORR as variable,a.HORD,a.hfecpro,count(distinct HCODREDEXT) HNUMCBASE
from cte_base_stock a
 
group by a.HORD,a.hfecpro,a.HESTCORR
),
cte_Result_TRX_N_MONETARIA AS (
select   'TRX_N_MONETARIA' HDESC,HORD,HFECPRO,SUM(HTOTINTE)  N_TRX
from  STORAGE.[com_pas].WTRXMONE001 a --SELECT TOP 100 * FROM STORAGE.[com_pas].WTRXMONE001
inner join #vjercor04 b
on a.RCODSUC=b.RCODAGEH  
WHERE HCODCAN=1 AND HTIPTRAX='N'
GROUP BY  HORD,HFECPRO
),
cte_Result_TRX_S_MONETARIA AS (
select   'TRX_S_MONETARIA' HDESC,HORD,HFECPRO,SUM(HTOTINTE)  N_TRX
from  STORAGE.[com_pas].WTRXMONE001 a --SELECT DISTINCT HDESPROC FROM STORAGE.[com_pas].WTRXMONE001
inner join #vjercor04 b
on a.RCODSUC=b.RCODAGEH  
WHERE HCODCAN=1 AND HTIPTRAX='S'
GROUP BY  HORD,HFECPRO
),
cte_Result_Transferencia_S_MONETARIA AS (
select   'TRX_TRANSFERENCIA_MONETARIA' HDESC,HORD,HFECPRO,SUM(HTOTINTE)  N_TRX
from  STORAGE.[com_pas].WTRXMONE001 a --SELECT DISTINCT HDESPROC FROM STORAGE.[com_pas].WTRXMONE001
inner join #vjercor04 b
on a.RCODSUC=b.RCODAGEH  
WHERE HCODCAN=1 AND HTIPTRAX='S' AND HDESPROC IN('TRANSFERENCIAS','TRANSFERENCIA CCE')
GROUP BY  HORD,HFECPRO
),
cte_Result_PAGOCREDITO_S_MONETARIA AS (
select   'TRX_PAGOCREDITO_MONETARIA' HDESC,HORD,HFECPRO,SUM(HTOTINTE)  N_TRX
from  STORAGE.[com_pas].WTRXMONE001 a --SELECT DISTINCT HDESPROC FROM STORAGE.[com_pas].WTRXMONE001 WHERE HTIPTRAX='S' AND HDESPROC IN('PAGO DE CREDITO')
inner join #vjercor04 b
on a.RCODSUC=b.RCODAGEH  
WHERE HCODCAN=1 AND HTIPTRAX='S' AND HDESPROC IN('PAGO DE CREDITO')
GROUP BY  HORD,HFECPRO
),
CTE_RESULT_OTROS_TX_S_MONETARIAS AS (
select   'TRX_OTROX_TRX_MONETARIA' HDESC,HORD,HFECPRO,SUM(HTOTINTE)  N_TRX
from  STORAGE.[com_pas].WTRXMONE001 a --SELECT DISTINCT HDESPROC FROM STORAGE.[com_pas].WTRXMONE001 WHERE HTIPTRAX='S'
inner join #vjercor04 b
on a.RCODSUC=b.RCODAGEH  
WHERE HCODCAN=1 AND HTIPTRAX='S' AND HDESPROC NOT IN('PAGO DE CREDITO','TRANSFERENCIAS','TRANSFERENCIA CCE')
GROUP BY  HORD,HFECPRO
) 
,
CTE_RESULT AS (
SELECT HDESC,HORD,HFECPRO,htipnumdoc  data 
FROM CTE_RESULT_ENROLADO
UNION ALL
SELECT  * FROM cte_result_cli_net
UNION ALL
SELECT * FROM cte_RESUL_NUM_USAB 
union all
select * from cte_RESULT_PERCE_ENROLADO
union all
select * from cte_RESULT_PERCE_USAB
union all
select * from cte_RESULT_STOCK_AC_CAN
UNION ALL
SELECT * FROM cte_Result_TRX_N_MONETARIA
UNION ALL
SELECT * FROM cte_Result_TRX_S_MONETARIA
UNION ALL
SELECT * FROM cte_Result_Transferencia_S_MONETARIA
UNION ALL
SELECT * FROM cte_Result_PAGOCREDITO_S_MONETARIA
UNION ALL
SELECT * FROM CTE_RESULT_OTROS_TX_S_MONETARIAS
)
SELECT * INTO #PreRESULT FROM CTE_RESULT
 

select * into #Result
from 
(
  select HDESC, HORD, data
  from #PreRESULT 
) src
pivot
(
  sum(data)
  for HORD in ([1], [2], [3],[4],[5],[6])
) piv;

create table #TFORMAT                                              
  (                                              
  ID INT IDENTITY(1,1)NOT NULL,                              
  vars varchar(250) null,                                       
  descripcion varchar(250) null,                                              
  style int null                                              
  )
insert into #TFORMAT values('FB','Funcionalidades Base',4)
insert into #TFORMAT values('CliNet','N° Clientes Netos',null)
insert into #TFORMAT values('Enrolado','N° Clientes Enrolados',null)
insert into #TFORMAT values('percent_enrolado','% Enrolamiento',null)
insert into #TFORMAT values('NUM_USAB','N° Clientes de Usabilidad',null)
insert into #TFORMAT values('percent_usab','% Usabilidad',null)
insert into #TFORMAT values('v','',null)
insert into #TFORMAT values('OF','Otras Funcionalidades',4)
insert into #TFORMAT values('stock_ac_can_AC','N° Agentes Stock',null)
insert into #TFORMAT values('stock_ac_can_CA','N° Cancelación de Agentes',null)
insert into #TFORMAT values('vv','',null)
insert into #TFORMAT values('tx','Transacciones',4)
insert into #TFORMAT values('TRX_N_MONETARIA','N° TRX no monetarias ',null)
insert into #TFORMAT values('TRX_S_MONETARIA','N° TRX monetarias APP/HMBK',null)
insert into #TFORMAT values('TRX_TRANSFERENCIA_MONETARIA','N° Transferencias  APP/HMBK',null)
insert into #TFORMAT values('TRX_OTROX_TRX_MONETARIA','N° Otras transacciones monetarias APP/HMBK',null) 

DECLARE @FecMeta DATE
set @FecMeta=(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR  in(10226,10227,10228) and hfecpro=eomonth(@fec) ) 
create table #M(hfecpro date null,hcodvar int null,htipcod varchar(250)null,hcodrel varchar(250)null,hvalvar float null,style int null,HDESCM varchar(250)null)

insert into   #M   
select  hfecpro,hcodvar,htipcod,hcodrel,CAST(sum(hvalvar) AS FLOAT) hvalvar,1 STYLE,
case when hcodvar=  10226 then 'Enrolado' 
     when hcodvar=10227 then 'NUM_USAB'
     when hcodvar=10228 then 'NUM_HV' END HDESCM
															       
from STORAGE.com.VDMCOM01              
where HTIPCOD=@tip_cod    and  hcodrel=@cod_rel           
and hfecpro=eomonth(@FecMeta)       and hcodvar IN (10226,10227,10228)               
group by  hfecpro,hcodvar,htipcod,hcodrel    

insert into #M
select  hfecpro,0,CAST(htipcod AS VARCHAR(50)),CAST(hcodrel AS VARCHAR(50)), 
CAST(SUM((case when hcodvar=10227 then hvalvar else 0 end)) AS FLOAT)/ SUM(case when hcodvar=10226 then hvalvar else 0 end) hvalvar,
STYLE,'percent_usab'
from #M
GROUP BY hfecpro,CAST(htipcod AS VARCHAR(50)),CAST(hcodrel AS VARCHAR(50)),STYLE
   

  
;with cte_a as (
select a.ID,a.descripcion,a.style,b.HDESC,
CASE WHEN ID IN(1,2,3,5,9,10,13,14,15,16) THEN format(b.[1],'N0','en-US') ELSE format(b.[1],'P') END [1],
CASE WHEN ID IN(1,2,3,5,9,10,13,14,15,16) THEN format(b.[2],'N0','en-US') ELSE format(b.[2],'P') END [2],
CASE WHEN ID IN(1,2,3,5,9,10,13,14,15,16) THEN format(b.[3],'N0','en-US') ELSE format(b.[3],'P') END [3],
CASE WHEN ID IN(1,2,3,5,9,10,13,14,15,16) THEN format(b.[4],'N0','en-US') ELSE format(b.[4],'P') END [4],
CASE WHEN ID IN(1,2,3,5,9,10,13,14,15,16) THEN format(b.[5],'N0','en-US') ELSE format(b.[5],'P') END [5],
CASE WHEN ID IN(1,2,3,5,9,10,13,14,15,16) THEN format(b.[6],'N0','en-US') ELSE format(b.[6],'P') END [6],
format((cast([6] as float)/ c.hvalvar),'P') PAvance,format((b.[6]/b.[4]),'P') TMM,--format(case when c.hvalvar,'N0','en-US') hvalvar
case when c.hcodvar=0 then format(c.hvalvar,'P') ELSE  format(c.hvalvar,'N0','en-US') end hvalvar
from #TFORMAT a                                               
left join #Result b on a.vars=b.HDESC  --SELECT * FROM #Result
left join #M C
on b.hdesc=C.HDESCM
)/*,
cte_b as (
select a.*,b.hvalvar,cast([6] as float)/ b.hvalvar PAvance,[6]/[4] TMM
from cte_a  a
left join #M b
on a.hdesc=b.HDESCM
)
*/
SELECT * FROM cte_a
END
