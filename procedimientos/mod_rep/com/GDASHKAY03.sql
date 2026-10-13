-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-06-13 11:27:39.510000
--exec [com].[GDASHKAY03] 'TGRES001','20220630','NOR ANDINO'      
-- EXEC [mod_rep].[com].[GDASHKAY03] 'TPFLE002','20220930','CENTRO ORIENTE'      
--  EXEC [mod_rep].[com].[GDASHKAY03] 'TPFLE002','20221031','TODO'      
CREATE procedure [com].[GDASHKAY03]      
@cod_rel varchar(20),@fec date,@Ter varchar(250)      
AS      
BEGIN      
 SET NOCOUNT ON;         
declare @defs as rep.TTHCOLDEF;                  
                  
insert into @defs                  
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TFORTYP,TFORMOD)  values                  
 (1,1,1,'HCOLNOM','Descripción','string',null),             
 (2,1,2,'HDESTER','Territorio','string',null),        
 (3,1,4,'TOTAL_MES','Total Acumulado','number','.0-0')        
      
 select rep.FFTHCOLDEF(@defs) result;         
      
select distinct hcodbt INTO #Jer from [storage].[gpr].[HPPC001] where   hfecpro='20221031' and hcodbt in('TVBLC001','TAAKS001','TUZAR100','TPFLE002','TAJAC001','TRMOJ001','TDFEH100','TMPAM001','TMCAG001')      
declare @tipUsuario int=0       
set @tipUsuario =(select count(*) from #Jer where hcodbt=@cod_rel)      
      
      
declare @tipo int,@TerIn varchar(250),@fecmax date 
/*     
set @fecmax =(select max(hfecpro) from storage.com.[HBDK002]   where hcolbt=@cod_rel )    
set @TerIn =(select HDESTER from storage.com.[HBDK002]   where hcolbt=@cod_rel and HFECPRO=@fecmax)     
set @tipo=(select MAX(HCOLTIP) from storage.com.[HBDK002] where HCOLBT=@cod_rel) 
*/
;WITH CTE_A AS (
select HFECPRO,HDESTER,HCOLTIP from storage.[com].[HBDK002]   where hcolbt=@cod_rel       
UNION ALL 
select HFECPRO,HDESTER,HCOLTIP from storage.[com].[HBDK003]   where hcolbt=@cod_rel
)
SELECT   @fecmax=MAX(HFECPRO) ,@TerIn=HDESTER,@tipo=MAX(HCOLTIP) FROM CTE_A
GROUP BY HDESTER       
      
create table #Result (      
TipoM int null, TipoH int null       
)      
insert into #Result values(3,1)      
insert into #Result values(3,3)      
insert into #Result values(3,8)      
      
insert into #Result values(4,2)      
insert into #Result values(4,4)       
      
insert into #Result values(5,3)      
insert into #Result values(5,5)       
insert into #Result values(5,8)       
      
      
insert into #Result values(6,2)      
insert into #Result values(6,4)       
insert into #Result values(6,6)       
      
insert into #Result values(9,2)      
insert into #Result values(9,3)       
insert into #Result values(9,4)       
insert into #Result values(9,5)       
insert into #Result values(9,6)       
insert into #Result values(9,9)       
      
create table #Cab (      
ORD INT IDENTITY(1,1)NOT NULL,      
HCOLTIP int null,      
HCOLNOM varchar(250)null,      
HDESTER varchar(250)null,      
TOTAL_MES float null,      
style int null      
)      
      
;with cte_a as (      
select HFECPRO,HCOLBT,HCOLDOC,HCOLNOM,HCOLCAR,cast(HBLOACU as float) TOTAL_MES,cast(HCOLTIP as int)HCOLTIP,HDESTER      
from storage.com.[HBDK002]      
WHERE isnull(HDESTER,'') like CASE WHEN @Ter='TODO' then '%%' else @Ter+'%' end      
union all
select  HFECPRO,HCOLBT,HCOLDOC,HCOLNOM,HCOLCAR, 
case when hcoltip=1 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0) + isnull(cast(HBDIGITA as float),0) + isnull(cast(HBDESSOC as float),0) +isnull(cast(HBRIEOPE as float),0) + isnull( cast(HBAMONES  as float),0)
	 when hcoltip=1 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0) + isnull(cast(HBSALCAR as float),0) + isnull(cast(HBSTOCLI as float),0) +isnull(cast(HBEFE30A1  as float),0) +isnull(cast(HBEFE1A30  as float),0) +isnull(cast(HBFOREXT  as float),0) +isnull(cast(HBDIGITA  as float),0) +isnull(cast(HBDESSOC  as float),0) +isnull(cast(HBRIEOPE  as float),0) + isnull(cast(HBAMONES  as float),0)
	 when hcoltip=2 and HBPTOBAS=0 then isnull(cast(HBCANDAD as float),0) + isnull(cast(HBFOREXT as float),0) + isnull(cast(HBDIGITA as float),0) +isnull(cast(HBDESSOC  as float),0) + isnull(cast(HBRIEOPE  as float),0) +isnull( cast(HBAMONES  as float),0)
	 when hcoltip=2 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0) + isnull(cast(HBGRUDES as float),0) + isnull(cast(HBVARCLI as float),0) +isnull(cast(HBCLINUE  as float),0)+  isnull(cast(HBEFE30A1  as float),0)+isnull( cast(HBEFE1A30  as float),0)+isnull(cast(HBCANDAD  as float),0) +isnull(cast(HBFOREXT  as float),0) + isnull(cast(HBDIGITA  as float),0) +isnull(cast(HBDESSOC  as float),0) +isnull(cast(HBRIEOPE  as float),0) +isnull(cast(HBAMONES  as float),0)
	 when hcoltip=3 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0) + isnull(cast(HBDIGITA as float),0) + isnull(cast(HBCAPCOM as float),0) +isnull(cast(HBDESSOC  as float),0) + isnull(cast(HBRIEOPE  as float),0) +isnull(cast(HBAMONES  as float),0)
	 when hcoltip=3 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBSALCAR as float),0)+isnull(cast(HBSTOCLI as float),0)+isnull(cast(HBEFE30A1  as float),0)+isnull(cast(HBEFE1A30 as float),0)+isnull(cast(HBSUPERV as float),0)+isnull(cast(HBASECOM as float),0)+isnull(cast(HBFOREXT as float),0) + isnull(cast(HBDIGITA as float),0) + isnull(cast(HBCAPCOM as float),0) + isnull(cast(HBDESSOC as float),0) + isnull(cast(HBRIEOPE as float),0) + isnull( cast(HBAMONES as float),0)
	 when hcoltip=4 and HBPTOBAS=0 then isnull(cast(HBCANDAD as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCAPCOM  as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=4 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBGRUDES as float),0)+isnull(cast(HBVARCLI as float),0)+isnull(cast(HBCLINUE  as float),0)+isnull(cast(HBEFE30A1 as float),0)+isnull(cast(HBEFE1A30 as float),0)+isnull(cast(HBSUPERV as float),0)+isnull(cast(HBASECOM as float),0)+isnull(cast(HBCANDAD as float),0) +isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCAPCOM as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=5 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCAPCOM as float),0)+isnull(cast(HBDESSOC  as float),0)+isnull(cast(HBRIEOPE as float),0)+ isnull(cast(HBCLILAB as float),0)+isnull(cast(HBROTTOT as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=5 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBSALCAR as float),0)+isnull(cast(HBSTOCLI as float),0)+isnull(cast(HBEFE30A1  as float),0)+isnull(cast(HBEFE1A30 as float),0)+isnull(cast(HBSUPERV as float),0)+isnull(cast(HBADMCOM as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCAPCOM as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBCLILAB as float),0)+isnull(cast(HBROTTOT as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=6 and HBPTOBAS=0 then isnull(cast(HBCANDAD as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBCUMMET as float),0)+isnull(cast(HBDESSOC  as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=6 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBGRUDES as float),0)+isnull(cast(HBVARCLI as float),0)+isnull(cast(HBCLINUE  as float),0)+isnull(cast(HBEFE30A1 as float),0)+isnull(cast(HBEFE1A30 as float),0)+isnull(cast(HBSUPERV as float),0)+isnull(cast(HBADMCOM as float),0)+isnull(cast(HBCANDAD as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBCUMMET as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0) 
	 when hcoltip=7 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=7 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBSTOCLI as float),0)+isnull(cast(HBSALAGR as float),0)+isnull(cast(HBMORREA as float),0)+isnull(cast(HBEFE30A1 as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=8 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCLINUE1 as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=8 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBDESRED as float),0)+isnull(cast(HBDESZBP as float),0)+ isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCLINUE1 as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=9 and HBPTOBAS=0 then isnull(cast(HBAMONES as float),0)
	 when hcoltip=9 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBCLILAB as float),0)+isnull(cast(HBROTTOT as float),0)+isnull(cast(HBAMONES as float),0) END ,HCOLTIP,HDESTER 
from storage.com.[HBDK003]
WHERE isnull(HDESTER,'') like CASE WHEN @Ter='TODO' then '%%' else @Ter+'%' end    
),      
cte_b as (      
select HCOLTIP,HCOLNOM,HDESTER,SUM(TOTAL_MES)  TOTAL_MES      
from cte_a      
where HCOLTIP in(select TipoH from #Result where TipoM=@tipo) and HFECPRO<=@fec       
and HDESTER like @TerIn + '%'    
group by HCOLTIP,HCOLNOM,HDESTER       
)      
select*  into #T      
from cte_b       
order by HCOLTIP asc      
      
if @tipUsuario=0      
begin      
IF @tipo=3      
BEGIN      
    
     
    
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Asesor Individual' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1 style         
      
INSERT INTO #Cab      
select l.HCOLTIP,l.HCOLNOM,      
case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then HDESTER+'_IND'      
  when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else HDESTER end HDESTER ,l.TOTAL_MES,0      
 from #T l      
 where  HCOLTIP=1 and TOTAL_MES in (select top 15 lg.TOTAL_MES from #T lg      
       where case when lg.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then lg.HDESTER+'_IND'       
    when lg.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
    when lg.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'  else lg.HDESTER end =       
    case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then l.HDESTER+'_IND'       
         when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
   when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else l.HDESTER end      
    and HCOLTIP=1 order by lg.TOTAL_MES desc)      
order by   l.HDESTER,l.TOTAL_MES desc      
     
/*      
select top 15 *,0 from  #T      
where HCOLTIP=1      
order by TOTAL_MES desc      
*/      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0 style            
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Admin Individual' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1 style           
      
INSERT INTO #Cab      
/*select  top 12 *,0 from  #T      
where HCOLTIP=3      
order by TOTAL_MES desc      
*/      
select l.HCOLTIP,l.HCOLNOM,      
case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then HDESTER+'_IND'      
  when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else HDESTER end HDESTER ,l.TOTAL_MES,0      
 from #T l      
 where  HCOLTIP=3 and TOTAL_MES in (select top 15 lg.TOTAL_MES from #T lg      
       where case when lg.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then lg.HDESTER+'_IND'       
    when lg.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
    when lg.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'  else lg.HDESTER end =       
    case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then l.HDESTER+'_IND'       
         when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
   when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else l.HDESTER end      
    and HCOLTIP=3 order by lg.TOTAL_MES desc)      
order by   l.HDESTER,l.TOTAL_MES desc      
      
INSERT INTO #Cab      
select 102 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Ejecutivo Captaciones BP' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1        
      
INSERT INTO #Cab      
select  top 5 *,0 from  #T      
where HCOLTIP=8      
order by TOTAL_MES desc      
      
SELECT * FROM #Cab   order by ORD asc    
      
END      
      
IF @tipo=4      
BEGIN      
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Asesor Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1         
      
INSERT INTO #Cab      
select top 10 *,0 from  #T      
where HCOLTIP=2      
order by TOTAL_MES desc      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Admin Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1        
      
INSERT INTO #Cab      
select  top 5 *,0 from  #T      
where HCOLTIP=4      
order by TOTAL_MES desc      
      
SELECT * FROM #Cab    order by ord asc     
       
END      
      
IF @tipo=5      
BEGIN      
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Admin Individual' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1        
      
INSERT INTO #Cab      
/*      
select top 12 *,0 from  #T      
where HCOLTIP=3      
order by TOTAL_MES desc      
*/      
select l.HCOLTIP,l.HCOLNOM,      
case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then HDESTER+'_IND'      
  when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else HDESTER end HDESTER ,l.TOTAL_MES,0      
 from #T l      
 where  HCOLTIP=3 and TOTAL_MES in (select top 15 lg.TOTAL_MES from #T lg      
       where case when lg.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then lg.HDESTER+'_IND'       
    when lg.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
    when lg.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'  else lg.HDESTER end =       
    case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then l.HDESTER+'_IND'       
         when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
   when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else l.HDESTER end      
    and HCOLTIP=3 order by lg.TOTAL_MES desc)      
order by   l.HDESTER,l.TOTAL_MES desc      
      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Gerente Corredor Individual' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1        
      
INSERT INTO #Cab      
/*select  top 5 *,0 from  #T      
where HCOLTIP=5      
order by TOTAL_MES desc*/      
      
select l.HCOLTIP,l.HCOLNOM,case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then HDESTER+'_IND'       
when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'      
  else HDESTER end HDESTER ,l.TOTAL_MES,0      
 from #T l      
 where  HCOLTIP=5 and TOTAL_MES in (select top 10 lg.TOTAL_MES from #T lg      
       where case when lg.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then lg.HDESTER+'_IND'      
    when lg.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
    when lg.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'      
     else lg.HDESTER end =       
    case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then l.HDESTER+'_IND'       
    when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'      
  else l.HDESTER end      
    and HCOLTIP=5 order by lg.TOTAL_MES desc)      
order by   l.HDESTER,l.TOTAL_MES desc      
      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,0        
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Ejecutivo Captaciones BP' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1        
      
INSERT INTO #Cab      
select  top 5 *,0 from  #T      
where HCOLTIP=8      
order by TOTAL_MES desc      
      
SELECT * FROM #Cab   order by ord asc     
       
END      
      
IF @tipo=6      
BEGIN      
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Asesor Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1         
      
INSERT INTO #Cab      
select top 10 *,0 from  #T      
where HCOLTIP=2       
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,0        
      
 INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Admin Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1        
      
INSERT INTO #Cab      
select  top 5 *,0 from  #T      
where HCOLTIP=4      
order by TOTAL_MES desc      
      
INSERT INTO #Cab      
select 102 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES  ,0       
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Gerente Corredor Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1         
      
INSERT INTO #Cab      
select  top 5 *,0 from  #T      
where HCOLTIP=6      
order by TOTAL_MES desc      
      
SELECT * FROM #Cab  order by ord asc     
       
END      
      
IF @tipo=9      
BEGIN      
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Asesor Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1        
      
INSERT INTO #Cab      
select top 10 *,0 from  #T      
where HCOLTIP=2      
order by TOTAL_MES desc      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES   ,0      
      
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Admin Individual' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1        
      
INSERT INTO #Cab      
select l.HCOLTIP,l.HCOLNOM,      
case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then HDESTER+'_IND'      
  when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else HDESTER end HDESTER ,l.TOTAL_MES,0      
 from #T l      
 where  HCOLTIP=3 and TOTAL_MES in (select top 15 lg.TOTAL_MES from #T lg      
       where case when lg.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then lg.HDESTER+'_IND'       
    when lg.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
    when lg.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'  else lg.HDESTER end =       
    case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then l.HDESTER+'_IND'       
         when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
   when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else l.HDESTER end      
    and HCOLTIP=3 order by lg.TOTAL_MES desc)      
order by   l.HDESTER,l.TOTAL_MES desc      
/*      
select  top 12 *,0 from  #T      
where HCOLTIP=3      
order by TOTAL_MES desc      
*/      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Admin Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1      
      
INSERT INTO #Cab      
select  top 5 *,0 from  #T      
where HCOLTIP=4      
order by TOTAL_MES desc      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Gerente Corredor Individual' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1      
      
INSERT INTO #Cab      
/*select  top 5 * ,0 from  #T      
where HCOLTIP=5      
order by TOTAL_MES desc      
*/      
select l.HCOLTIP,l.HCOLNOM,case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then HDESTER+'_IND'       
when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'      
  else HDESTER end HDESTER ,l.TOTAL_MES,0      
 from #T l      
 where  HCOLTIP=5 and TOTAL_MES in (select top 10 lg.TOTAL_MES from #T lg      
       where case when lg.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then lg.HDESTER+'_IND'      
    when lg.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
    when lg.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'      
     else lg.HDESTER end =       
    case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then l.HDESTER+'_IND'       
    when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'      
  else l.HDESTER end      
    and HCOLTIP=5 order by lg.TOTAL_MES desc)      
order by   l.HDESTER,l.TOTAL_MES desc      
      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Gerente Corredor Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1        
      
INSERT INTO #Cab      
select  top 5 *,0 from  #T      
where HCOLTIP=6      
order by TOTAL_MES desc      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,0       
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Gerente Territorio' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1      
      
INSERT INTO #Cab      
select  top 5 *,0 from  #T      
where HCOLTIP=9      
order by TOTAL_MES desc      
      
SELECT ORD,HCOLTIP,HCOLNOM,HDESTER,TOTAL_MES,CASE WHEN ord in(2,3,4,5,6,7,8,9,19,20,21,22,23,31,32,45,46,52,59,68) then 2 else style end style        
FROM #Cab       
order by ord asc       
END      
      
end      
if @tipUsuario=1      
begin      
      
;with cte_a as (      
select HFECPRO,HCOLBT,HCOLDOC,HCOLNOM,HCOLCAR,cast(HBLOACU as float) TOTAL_MES,cast(HCOLTIP as int)HCOLTIP,HDESTER      
from storage.com.[HBDK002]      
WHERE isnull(HDESTER,'') like CASE WHEN @Ter='TODO' then '%%' else @Ter+'%' end     
union all
select  HFECPRO,HCOLBT,HCOLDOC,HCOLNOM,HCOLCAR, 
case when hcoltip=1 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0) + isnull(cast(HBDIGITA as float),0) + isnull(cast(HBDESSOC as float),0) +isnull(cast(HBRIEOPE as float),0) + isnull( cast(HBAMONES  as float),0)
	 when hcoltip=1 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0) + isnull(cast(HBSALCAR as float),0) + isnull(cast(HBSTOCLI as float),0) +isnull(cast(HBEFE30A1  as float),0) +isnull(cast(HBEFE1A30  as float),0) +isnull(cast(HBFOREXT  as float),0) +isnull(cast(HBDIGITA  as float),0) +isnull(cast(HBDESSOC  as float),0) +isnull(cast(HBRIEOPE  as float),0) + isnull(cast(HBAMONES  as float),0)
	 when hcoltip=2 and HBPTOBAS=0 then isnull(cast(HBCANDAD as float),0) + isnull(cast(HBFOREXT as float),0) + isnull(cast(HBDIGITA as float),0) +isnull(cast(HBDESSOC  as float),0) + isnull(cast(HBRIEOPE  as float),0) +isnull( cast(HBAMONES  as float),0)
	 when hcoltip=2 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0) + isnull(cast(HBGRUDES as float),0) + isnull(cast(HBVARCLI as float),0) +isnull(cast(HBCLINUE  as float),0)+  isnull(cast(HBEFE30A1  as float),0)+isnull( cast(HBEFE1A30  as float),0)+isnull(cast(HBCANDAD  as float),0) +isnull(cast(HBFOREXT  as float),0) + isnull(cast(HBDIGITA  as float),0) +isnull(cast(HBDESSOC  as float),0) +isnull(cast(HBRIEOPE  as float),0) +isnull(cast(HBAMONES  as float),0)
	 when hcoltip=3 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0) + isnull(cast(HBDIGITA as float),0) + isnull(cast(HBCAPCOM as float),0) +isnull(cast(HBDESSOC  as float),0) + isnull(cast(HBRIEOPE  as float),0) +isnull(cast(HBAMONES  as float),0)
	 when hcoltip=3 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBSALCAR as float),0)+isnull(cast(HBSTOCLI as float),0)+isnull(cast(HBEFE30A1  as float),0)+isnull(cast(HBEFE1A30 as float),0)+isnull(cast(HBSUPERV as float),0)+isnull(cast(HBASECOM as float),0)+isnull(cast(HBFOREXT as float),0) + isnull(cast(HBDIGITA as float),0) + isnull(cast(HBCAPCOM as float),0) + isnull(cast(HBDESSOC as float),0) + isnull(cast(HBRIEOPE as float),0) + isnull( cast(HBAMONES as float),0)
	 when hcoltip=4 and HBPTOBAS=0 then isnull(cast(HBCANDAD as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCAPCOM  as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=4 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBGRUDES as float),0)+isnull(cast(HBVARCLI as float),0)+isnull(cast(HBCLINUE  as float),0)+isnull(cast(HBEFE30A1 as float),0)+isnull(cast(HBEFE1A30 as float),0)+isnull(cast(HBSUPERV as float),0)+isnull(cast(HBASECOM as float),0)+isnull(cast(HBCANDAD as float),0) +isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCAPCOM as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=5 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCAPCOM as float),0)+isnull(cast(HBDESSOC  as float),0)+isnull(cast(HBRIEOPE as float),0)+ isnull(cast(HBCLILAB as float),0)+isnull(cast(HBROTTOT as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=5 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBSALCAR as float),0)+isnull(cast(HBSTOCLI as float),0)+isnull(cast(HBEFE30A1  as float),0)+isnull(cast(HBEFE1A30 as float),0)+isnull(cast(HBSUPERV as float),0)+isnull(cast(HBADMCOM as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCAPCOM as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBCLILAB as float),0)+isnull(cast(HBROTTOT as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=6 and HBPTOBAS=0 then isnull(cast(HBCANDAD as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBCUMMET as float),0)+isnull(cast(HBDESSOC  as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=6 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBGRUDES as float),0)+isnull(cast(HBVARCLI as float),0)+isnull(cast(HBCLINUE  as float),0)+isnull(cast(HBEFE30A1 as float),0)+isnull(cast(HBEFE1A30 as float),0)+isnull(cast(HBSUPERV as float),0)+isnull(cast(HBADMCOM as float),0)+isnull(cast(HBCANDAD as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBCUMMET as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0) 
	 when hcoltip=7 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=7 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBSTOCLI as float),0)+isnull(cast(HBSALAGR as float),0)+isnull(cast(HBMORREA as float),0)+isnull(cast(HBEFE30A1 as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBDESSOC as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=8 and HBPTOBAS=0 then isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCLINUE1 as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=8 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBDESRED as float),0)+isnull(cast(HBDESZBP as float),0)+ isnull(cast(HBFOREXT as float),0)+isnull(cast(HBDIGITA as float),0)+isnull(cast(HBCLINUE1 as float),0)+isnull(cast(HBRIEOPE as float),0)+isnull(cast(HBAMONES as float),0)
	 when hcoltip=9 and HBPTOBAS=0 then isnull(cast(HBAMONES as float),0)
	 when hcoltip=9 and HBPTOBAS>0 then isnull(cast(HBPTOBAS as float),0)+isnull(cast(HBFOREXT as float),0)+isnull(cast(HBCLILAB as float),0)+isnull(cast(HBROTTOT as float),0)+isnull(cast(HBAMONES as float),0) END ,HCOLTIP,HDESTER 
from storage.com.[HBDK003]
WHERE isnull(HDESTER,'') like CASE WHEN @Ter='TODO' then '%%' else @Ter+'%' end    
),      
cte_b as (      
select HCOLTIP,HCOLNOM,HDESTER,SUM(TOTAL_MES)  TOTAL_MES      
from cte_a      
where  HFECPRO<=@fec       
group by HCOLTIP,HCOLNOM,HDESTER       
)      
select*  into #TT      
from cte_b       
order by HCOLTIP asc      
      
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Asesor Individual' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1 style         
      
INSERT INTO #Cab      
/*select top 15 *,0 from  #TT      
where HCOLTIP=1      
order by TOTAL_MES desc      
*/      
select l.HCOLTIP,l.HCOLNOM,      
case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then HDESTER+'_IND'      
  when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else HDESTER end HDESTER ,l.TOTAL_MES,0      
 from #TT l      
 where  HCOLTIP=1 and TOTAL_MES in (select top 15 lg.TOTAL_MES from #TT lg      
       where case when lg.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then lg.HDESTER+'_IND'       
    when lg.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
    when lg.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'  else lg.HDESTER end =       
    case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then l.HDESTER+'_IND'       
         when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
   when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else l.HDESTER end      
    and HCOLTIP=1 order by lg.TOTAL_MES desc)      
order by   l.HDESTER,l.TOTAL_MES desc      
      
INSERT INTO #Cab      
select 102 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Asesor Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1        
      
INSERT INTO #Cab      
select top 10 *,0 from  #TT      
where HCOLTIP=2      
order by TOTAL_MES desc      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES   ,0      
      
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Admin Individual' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1        
      
     
/*      
select l.HCOLTIP,l.HCOLNOM,l.HDESTER,l.TOTAL_MES,0      
 from #TT l      
 where HCOLTIP=3 and TOTAL_MES in (select top 15 lg.TOTAL_MES from #TT lg      
       where lg.HDESTER = l.HDESTER  and HCOLTIP=3 order by lg.TOTAL_MES desc)      
order by   l.HDESTER,l.TOTAL_MES desc      
*/     
;with cte_a as (    
select l.HCOLTIP,l.HCOLNOM,      
case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then HDESTER+'_IND'      
  when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else HDESTER end HDESTER ,l.TOTAL_MES,0  punt    
     
 from #TT l      
 where  HCOLTIP=3 and TOTAL_MES in (select top 15 lg.TOTAL_MES from #TT lg      
       where case when lg.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then lg.HDESTER+'_IND'       
    when lg.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
    when lg.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'  else lg.HDESTER end =       
    case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then l.HDESTER+'_IND'       
         when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
   when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND' else l.HDESTER end      
    and HCOLTIP=3 order by lg.TOTAL_MES desc)      
      
)  
INSERT INTO #Cab       
select * from cte_a order by  HDESTER,TOTAL_MES desc    
  
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Admin Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1      
      
INSERT INTO #Cab      
select  top 5 *,0 from  #TT      
where HCOLTIP=4      
order by TOTAL_MES desc      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Gerente Corredor Individual' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1      
      
;with cte_a as (     
select l.HCOLTIP,l.HCOLNOM,case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then HDESTER+'_IND'       
when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'      
  else HDESTER end HDESTER ,l.TOTAL_MES,0  punt    
 from #TT l      
 where  HCOLTIP=5 and TOTAL_MES in (select top 10 lg.TOTAL_MES from #TT lg      
       where case when lg.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then lg.HDESTER+'_IND'      
    when lg.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
    when lg.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'      
     else lg.HDESTER end =       
    case when l.HDESTER in('CENTRO ORIENTE','LIMA SELVA','NOR ANDINO','SUR') then l.HDESTER+'_IND'       
    when l.hdester in('CENTRO SUR') then 'CENTRO ORIENTE_IND'      
  when l.hdester in('LIMA ORIENTE') then 'LIMA SELVA_IND'      
  else l.HDESTER end      
    and HCOLTIP=5 order by lg.TOTAL_MES desc)      
    
)    
insert into #Cab    
select * from cte_a order by  HDESTER,TOTAL_MES desc    
--order by   l.HDESTER,l.TOTAL_MES desc      
       
    
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Gerente Corredor Grupal' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1        
      
INSERT INTO #Cab      
select  top 5 *,0 from  #TT      
where HCOLTIP=6      
order by TOTAL_MES desc      
      
INSERT INTO #Cab      
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,0       
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Gerente Territorio' HCOLNOM ,null HDESTER ,NULL TOTAL_MES ,1      
      
INSERT INTO #Cab      
select  top 5 *,0 from  #TT      
where HCOLTIP=9      
order by TOTAL_MES desc      
      
      
INSERT INTO #Cab      
select 102 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
      
INSERT INTO #Cab      
select 100 HCOLTIP,'Ranking Ejecutivo Captaciones BP' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1        
      
INSERT INTO #Cab      
select  top 5 *,0 from  #TT      
where HCOLTIP=8      
order by TOTAL_MES desc      
      
SELECT ORD,HCOLTIP,HCOLNOM,HDESTER,TOTAL_MES,style/*CASE WHEN ord in(      
2,3,4,5,6,7,8,9,      
17,18,19,20,21,22,23,24,      
32,33,34,35,36,37,38,39,      
47,48,49,50,51,52,53,54,      
65,66,67,68,69,      
77,78,      
92,93,      
107,108,      
122,123,      
139,140,      
146,      
156,      
166,      
176,      
188,      
197      
) then 2 else style end style  */      
FROM #Cab       
order by ord asc     
      
end      
end
