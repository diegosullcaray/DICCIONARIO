-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-06-13 11:29:36.760000
/* SP PARA LOS RECUPERACIONES */        
-- EXEC [mod_rep].[com].[GDASHKAY06] 'TPFLE002','20221031','TODO'          
-- EXEC [mod_rep].[com].[GDASHKAY06] 'TCCIO001','20220930','TODO'          
CREATE procedure [com].[GDASHKAY06]          
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
          
select distinct hcodbt INTO #Jer   
from [storage].[gpr].[HPPC001]   
where   hfecpro='20221031' and hcodbt in('TVBLC001','TAAKS001','TUZAR100','TPFLE002','TAJAC001','TRMOJ001','TDFEH100','TMPAM001','TMCAG001','TCGAS001')    
union all  
select hcodbt from [storage].[gpr].[VPPH001]  where HDESCAR='RESPONSABLE DE MORA TEMPRANA'  
        
declare @tipUsuario int=0           
set @tipUsuario =(select count(*) from #Jer where hcodbt=@cod_rel)          
          
          
declare @tipo int,@TerIn varchar(250),@fecmax date          
/*set @fecmax =(select max(hfecpro) from storage.com.[HBDK006]   where hcolbt=@cod_rel )        
set @TerIn =(select HDESTER from storage.com.[HBDK006]   where hcolbt=@cod_rel and HFECPRO=@fecmax) 
set @tipo=(select MAX(HCOLTIP) from storage.com.[HBDK006] where HCOLBT=@cod_rel)        
*/

;WITH CTE_A AS (
select HFECPRO,HDESTER,HCOLTIP from storage.[com].[HBDK006]   where hcolbt=@cod_rel       
UNION ALL 
select HFECPRO,HDESTER,HCOLTIP from storage.[com].[HBDK007]   where hcolbt=@cod_rel
)
SELECT   @fecmax=MAX(HFECPRO) ,@TerIn=HDESTER,@tipo=MAX(HCOLTIP) FROM CTE_A
GROUP BY HDESTER    
        
          
create table #Result (          
TipoM int null, TipoH int null           
)          
insert into #Result values(3,1)          
insert into #Result values(3,2)          
insert into #Result values(3,3)    
insert into #Result values(3,4)     
insert into #Result values(4,1)          
insert into #Result values(4,2)          
insert into #Result values(4,3)          
insert into #Result values(4,4)            
          
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
from storage.com.[HBDK006]          
WHERE isnull(HDESTER,'') like CASE WHEN @Ter='TODO' then '%%' else @Ter+'%' end        
UNION ALL
SELECT HFECPRO,HCOLBT,HCOLDOC,HCOLNOM,HCOLCAR, 
ISNULL(CAST(HBPTOBAS AS FLOAT),0) + ISNULL(CAST(HBPTOPLUS AS FLOAT),0) + ISNULL(CAST(HBFOREXT AS FLOAT),0)+ISNULL(CAST(HBRIEOPE AS FLOAT),0)+ISNULL(CAST(HBFRENO AS FLOAT),0),HCOLTIP,HDESTER  
FROM storage.com.[HBDK007] 
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
IF @tipo IN(3,4)          
BEGIN           
      
INSERT INTO #Cab          
select 100 HCOLTIP,'Ranking Analista de Cobranzas' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1 style             
          
INSERT INTO #Cab          
select l.HCOLTIP,l.HCOLNOM,HDESTER ,l.TOTAL_MES,0          
from #T l          
where  HCOLTIP=1 and TOTAL_MES in (select top 15 lg.TOTAL_MES       
           from #T lg          
           where  lg.HDESTER   =     l.HDESTER            
           and HCOLTIP=1 order by lg.TOTAL_MES desc      
           )          
order by l.HDESTER,l.TOTAL_MES desc          
         
          
INSERT INTO #Cab          
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0 style                
          
INSERT INTO #Cab          
select 100 HCOLTIP,'Ranking Analista de Recuperaciones' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1 style               
          
INSERT INTO #Cab          
select l.HCOLTIP,l.HCOLNOM,HDESTER ,l.TOTAL_MES,0          
 from #T l          
 where  HCOLTIP=2 and TOTAL_MES in (select top 15 lg.TOTAL_MES       
            from #T lg          
               --   where  lg.HDESTER  = l.HDESTER            
         where HCOLTIP=2 order by lg.TOTAL_MES desc      
         )          
order by l.HDESTER,l.TOTAL_MES desc          
          
INSERT INTO #Cab          
select 102 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0             
          
INSERT INTO #Cab          
select 100 HCOLTIP,'Ranking Responsable de Dpto. De Cobranzas' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1            
          
INSERT INTO #Cab          
select l.HCOLTIP,l.HCOLNOM,HDESTER ,l.TOTAL_MES,0          
 from #T l          
 where  HCOLTIP=3 and TOTAL_MES in (select top 15 lg.TOTAL_MES       
            from #T lg          
               --   where  lg.HDESTER  = l.HDESTER            
         where HCOLTIP=3 order by lg.TOTAL_MES desc      
         )          
order by l.HDESTER,l.TOTAL_MES desc        
    
INSERT INTO #Cab          
select 102 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
    
INSERT INTO #Cab          
select 100 HCOLTIP,'Ranking Mora Temprana' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1 style             
          
INSERT INTO #Cab          
select l.HCOLTIP,l.HCOLNOM,HDESTER ,l.TOTAL_MES,0          
from #T l          
where  HCOLTIP=4 and TOTAL_MES in (select top 15 lg.TOTAL_MES       
           from #T lg          
           where  lg.HDESTER   =     l.HDESTER            
           and HCOLTIP=4 order by lg.TOTAL_MES desc      
           )          
order by l.HDESTER,l.TOTAL_MES desc     
          
SELECT * FROM #Cab   order by ORD asc        
          
END          
          
       
          
end          
if @tipUsuario=1          
begin          
          
;with cte_a as (          
select HFECPRO,HCOLBT,HCOLDOC,HCOLNOM,HCOLCAR,cast(HBLOACU as float) TOTAL_MES,cast(HCOLTIP as int)HCOLTIP,HDESTER          
from storage.com.[HBDK006]          
WHERE isnull(HDESTER,'') like CASE WHEN @Ter='TODO' then '%%' else @Ter+'%' end    
UNION ALL
SELECT HFECPRO,HCOLBT,HCOLDOC,HCOLNOM,HCOLCAR, 
ISNULL(CAST(HBPTOBAS AS FLOAT),0) + ISNULL(CAST(HBPTOPLUS AS FLOAT),0) + ISNULL(CAST(HBFOREXT AS FLOAT),0)+ISNULL(CAST(HBRIEOPE AS FLOAT),0)+ISNULL(CAST(HBFRENO AS FLOAT),0),HCOLTIP,HDESTER  
FROM storage.com.[HBDK007] 
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
select 100 HCOLTIP,'Ranking Analista de Cobranzas' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1 style             
          
INSERT INTO #Cab         
select l.HCOLTIP,l.HCOLNOM,HDESTER ,l.TOTAL_MES,0            
 from #TT l            
 where  HCOLTIP=1 and TOTAL_MES in (select top 15 lg.TOTAL_MES       
         from #TT lg            
            where lg.HDESTER  = l.HDESTER              
         and HCOLTIP=1 order by lg.TOTAL_MES desc      
         )            
order by   l.HDESTER,l.TOTAL_MES desc            
          
INSERT INTO #Cab          
select 102 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0         
          
INSERT INTO #Cab          
select 100 HCOLTIP,'Ranking Analista de Recuperaciones' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1            
          
INSERT INTO #Cab          
select top 10 *,0 from  #TT          
where HCOLTIP=2          
order by TOTAL_MES desc          
          
INSERT INTO #Cab          
select 101 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES   ,0          
       
INSERT INTO #Cab          
select 102 HCOLTIP,'' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,0          
          
INSERT INTO #Cab          
select 100 HCOLTIP,'Ranking Responsable de Dpto. De Cobranzas' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1            
          
INSERT INTO #Cab             
select top 10 *,0 from  #TT          
where HCOLTIP=3          
order by TOTAL_MES desc        
    
INSERT INTO #Cab          
select 100 HCOLTIP,'Ranking Mora Temprana' HCOLNOM ,null HDESTER ,NULL TOTAL_MES,1 style             
          
INSERT INTO #Cab         
select l.HCOLTIP,l.HCOLNOM,HDESTER ,l.TOTAL_MES,0            
 from #TT l            
 where  HCOLTIP=4 and TOTAL_MES in (select top 15 lg.TOTAL_MES       
         from #TT lg            
            where lg.HDESTER  = l.HDESTER              
         and HCOLTIP=4 order by lg.TOTAL_MES desc      
         )            
order by   l.HDESTER,l.TOTAL_MES desc     
           
SELECT ORD,HCOLTIP,HCOLNOM,HDESTER,TOTAL_MES,style         
FROM #Cab           
order by ord asc         
          
end          
end
