-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-02-16 16:11:09.757000
--exec [com].[GRTABAPPO01] 7,'231','20230130'                                                              
CREATE  PROCEDURE [com].[GRTABAPPO01]        --DROP PROCEDURE com.GRTABAPPO01_BACK                                                                     
 @tip_cod int,                                                                                      
 @cod_rel varchar(20),                                                                                  
 @fec date                                                                                 
 as                                                                                  
begin                                                                                  
  SET NOCOUNT ON;  
 
--declare @fec date='20230518' ,@tip_cod int=7, @cod_rel varchar(250)='231' 
      
select * into #vjercor03 from storage.ref.vjercor03  
declare @Fecha date  
set @Fecha=(SELECT  max(rfec) FROM [storage].[ref].[RCALEN001] WHERE (RFEC)<=@fec and RDIAFER=0)  
                      
select *  into #FECS  --drop table #FECS,#vjercor03  select * from  #FECS                                 
from storage.util.FVECFEC01(@Fecha,'cmg_2,cie_ant+6,cie_ant+5,cie_ant+4,cie_ant+3,cie_ant+2,cie_ant,hoy')                             
  
insert into #FECS
select max(RFEC) from [storage].[ref].[RCALEN001] where rfec<=cast(DATEADD(MM, -1,@Fecha) as date) and RDIAFER=0

alter table #FECS add RORDD int null

update #FECS set RORDD=RORD
update #FECS set RORDD=10 where RORDD=8  
update #FECS set RORDD=8 where RORDD=9   
update #FECS set RORDD=9 where RORDD=10 
   
    
declare @defs as rep.TTHCOLDEF                                                                        
 insert into @defs                                                                          
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH)  values                                                                         
 (1,1,1,'descripcion','Descripción','string',null,'20px'),                                                                          
 (2,2,1,'v1',(select cast(rfec as varchar(10)) from #FECS where RORDD=1),'number',null,null),                                                                          
 (3,3,1,'v2',(select cast(rfec as varchar(10)) from #FECS where RORDD=2),'number',null,null),                                                                          
 (4,4,1,'v3',(select cast(rfec as varchar(10)) from #FECS where RORDD=3),'number',null,null),                                 
                             
 (5,5,1,'v4',(select cast(rfec as varchar(10)) from #FECS where RORDD=4),'number',null,null),                                           
 (6,6,1,'v5',(select cast(rfec as varchar(10)) from #FECS where RORDD=5),'number',null,null),                                           
 (7,7,1,'v6',(select cast(rfec as varchar(10)) from #FECS where RORDD=6),'number',null,null),                                           
 (8,8,1,'v7',(select cast(rfec as varchar(10)) from #FECS where RORDD=7),'number',null,null),                                           
 (9,9,1,'v8',(select cast(rfec as varchar(10)) from #FECS where RORDD=8),'number',null,null),                                            
 (10,10,1,'v9',(select cast(rfec as varchar(10)) from #FECS where RORDD=9),'number',null,null),                           
                                                                                    
 (11,11,1,'variacion','Variación Porcentual','percent','.2-2',null)  
                                                    
declare @fecs varchar(max) 
 select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                         
from #FECS   
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                                                              
                               
insert into @tvars values                                               
 ('Num_Cli_App',null,null,null,null,null),                                                      
  ('Num_Cli_App_Pas',null,null,null,null,null),                                                          
  ('Num_Cli_App_Cart_Pasiv',null,null,null,null,null),                                                      
  ('num_cli_enro',null,null,null,null,null),                                                         
  ('num_cli_pas_enro',null,null,null,null,null),                                              
  ('num_ope_ce02',null,null,null,null,null) ,                                      
  ('num_ope_ce01',null,null,null,null,null)                                                 
                                               
  insert into @tfil values                                                                
  ('todos','fec',@fecs)                                                     
                                                              
  declare @jer varchar(100);                                                            
  insert into @tfil                                                              
  exec piv.GPIVLEV03 @tip_cod,@cod_rel,@jer output                                                              
                                                                
  insert into @tconf                                                                
  values                                                                
  ('level_alias','style') ,('fec_corr','true')--,('insert_to','#AB')                                             
 
create table #AB (fila int null,vars varchar(250)null,[1] float null,[2] float null,[3] float null,[4] float null,[5] float null,[6] float null,[7] float null,[8] float null,[9] float null)                                       
insert into #AB                         
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"vars"',@columns='"fec_corr"',@config=@tconf --,@show_query=1                                         
                
    --drop table #FECS,#vjercor03,#A,#AB
                      
   delete from   @tvars               --select * from #AB       
delete from @tconf                    
delete from @tfil                    
                                    
create table #A (fila int null,vars varchar(250)null,fec1 float null,fec2 float null,fec3 float null,fec4 float null,fec5 float null,fec6 float null,fec7 float null,fec8 float null,fec9 float null)                                                    
insert into #A                                                    
select * from #AB where vars not in('num_ope_ce01','num_ope_ce02')                                              
                                              
insert into #A                                              
select 7,'PERCENTCE', b.[1]/a.[1],b.[2]/a.[2],b.[3]/a.[3] ,b.[4]/a.[4] ,b.[5]/a.[5] ,b.[6]/a.[6] ,b.[7]/a.[7] ,b.[8]/a.[8],b.[9]/a.[9]                                    
from #AB a                                              
inner join (select [1],[2],[3],[4],[5],[6],[7],[8],[9] from #AB where vars  in('num_ope_ce02'))b                                              
on 1=1                                              
where vars  in('num_ope_ce01')         
-- 

alter table #A         ---select * from #A                                                  
add VarPorce float null                                                       
  update #A set VarPorce= (fec9 - fec7) / fec7    

/* Transacciones  Monetarias*/                             
;with CTE_AA as (                                                
 select  HFECPRO HFEC ,CONCAT(HTIPDOC,HNUMDOC) HTIPNUNDOC,RCODSUC,HTOTINTE ,HMONTO ,HDESPROC ,HCANAL                                   
 FROM storage.[com_act].[HTDA001]                                              
 where  htiptrax='S'                                              
 ),                                              
 CTE_B AS (                                              
 Select B.RORDD,B.RFEC,HTIPNUNDOC,RCODSUC,  HDESPROC, HCANAL,                                            
    SUM(ISNULL(HTOTINTE,0)) HTOTINTE,SUM(ISNULL(HMONTO,0)) HMONTO                                                 
from CTE_AA  A                                                
inner JOIN (SELECT * FROM #FECS) B                                              
--ON A.HFEC=eomonth(B.RFEC)                         
ON A.HFEC=B.RFEC                                       
group by  B.RORDD,B.RFEC,HTIPNUNDOC,RCODSUC ,HDESPROC ,HCANAL                                                 
 )            
   SELECT * INTO #TM ---Transacciones  Monetarias           select distinct rordd,rfec from #TM    order by 1 asc                               
FROM CTE_B A --select * from storage.[com_act].WTRXMON001                                              
INNER JOIN (SELECT distinct                          
    case when @tip_cod=7 then '1' ELSE RCODAGE END RDESJER                                                
   FROM #vjercor03                                               
   where case when @tip_cod=7 then 1                                                                              
         when @tip_cod=15 then RCODTER                                                                              
        when @tip_cod=14 then RCODCOR                                                                              
        when @tip_cod=4 then RCODMAT                                                                     
     end = case when @tip_cod=7 then 1 else @cod_rel end                                              
     )B                                              
ON case when @tip_cod=7 then '1' else A.RCODSUC end =B.RDESJER                          
/* Transacciones No Monetarias*/                                             
;with CTE_AA as (                  
 select --EOMONTH(HFEC)HFEC,CONCAT(HTIPDOC,HNUMDOC) HTIPNUNDOC,RCODSUC,HTOTINTE                   
   HFECPRO HFEC,CONCAT(HTIPDOC,HNUMDOC) HTIPNUNDOC,RCODSUC,HTOTINTE                                                
 FROM storage.[com_act].[HTDA001]                                              
 where  htiptrax='N'                                              
 ),                                              
 CTE_B AS (                                              
 Select B.RORDD,B.RFEC,HTIPNUNDOC,RCODSUC,                                               
    SUM(ISNULL(HTOTINTE,0)) HTOTINTE                           
from CTE_AA  A                                                
inner JOIN (SELECT * FROM #FECS) B                                              
--ON A.HFEC=eomonth(B.RFEC)                       
ON A.HFEC= (B.RFEC)                                                
group by  B.RORDD,B.RFEC,HTIPNUNDOC,RCODSUC                                                   
 )                                              
   SELECT * INTO #TNM ---Transacciones NO Monetarias  select distinct rordd,rfec from #TNM               
FROM CTE_B A                                             
INNER JOIN (SELECT distinct                                               
    case when @tip_cod=7 then '1' ELSE RCODAGE END RDESJER                                                
   FROM #vjercor03                                        
   where case when @tip_cod=7 then 1                                                                              
        when @tip_cod=15 then RCODTER                                                                              
        when @tip_cod=14 then RCODCOR                                      
        when @tip_cod=4 then RCODMAT                                           
         end = case when @tip_cod=7 then 1 else @cod_rel end                                              
     )B                                              
ON case when @tip_cod=7 then '1' else A.RCODSUC end =B.RDESJER     

SELECT * INTO #TD ---Transacciones Monetarias    SELECT * FROM #TD                                
FROM storage.[com_act].WTRXMON001 A       --SELECT * FROM storage.[com_act].WTRXMON001                                       
INNER JOIN (SELECT distinct                                               
    case when @tip_cod=7 then '1' ELSE RCODAGE END RDESJER                                                
   FROM #vjercor03                                          
   where case when @tip_cod=7 then 1                                                                              
        when @tip_cod=15 then RCODTER                                                                              
        when @tip_cod=14 then RCODCOR                                                                              
        when @tip_cod=4 then RCODMAT                                                                      
         end = case when @tip_cod=7 then 1 else @cod_rel end                                              
     )B                                              
ON case when @tip_cod=7 then '1' else A.RCODSUC end =B.RDESJER  

 
--HUELLA DE VOZ
;with WHDV001 as (
	select * from storage.[com_act].WHDV001 
	WHERE htipcod = @tip_cod and hcodrel = @cod_rel 
)
SELECT RORDD, RFEC,SUMCLI HTIPNUNDOC,'HDV' descripcion into #HDV FROM #FECS A                                     
left JOIN WHDV001  B                
ON A.RFEC = B.HFECPRO  
 
--VALIDACION DE REGISTRO DE HUELLA DE VOZ
;with WHDV002 as (
	select * from storage.[com_act].WHDV002 
	WHERE htipcod = @tip_cod and hcodrel = @cod_rel 
)
SELECT RORDD, RFEC,SUMLOGEOS HTIPNUNDOC,'HDV2' descripcion into #HDV2 FROM #FECS A                                     
left JOIN WHDV002  B                
ON A.RFEC = B.HFECPRO  --SELECT * FROM #HDV


--ON BOARDING
;with WHOP001 as (
	select * from storage.[com_act].WHOP001 
	WHERE htipcod = @tip_cod and hcodrel = @cod_rel 
)
SELECT RORDD, RFEC,SUMCLI HTIPNUNDOC,'HOP' descripcion into #HOP FROM #FECS A                                     
left JOIN WHOP001  B                
ON A.RFEC = B.HFECPRO  
 

 

--SELECT * FROM #TM
select a.RORDD,a.RFEC,'CLI' descripcion,COUNT(DISTINCT ISNULL(a.HTIPNUNDOC,0)) HTIPNUNDOC,null style into #CLITRANSMES  --DROP TABLE #CLITRANSMES                                
from #TM a                                
left JOIN (select * from #tnm ) b                                  
on  a.RORDD=b.RORDD and a.HTIPNUNDOC=b.HTIPNUNDOC                                 
where  b.HTIPNUNDOC  is null                                
GROUP BY a.RORDD,a.RFEC                                     
UNION ALL                                
select a.RORDD,a.RFEC,'NOCLI' descripcion,COUNT(DISTINCT a.HTIPNUNDOC) HTIPNUNDOC,null style                                 
from #tnm a                                
left JOIN (select * from #TM ) b                                 
on  a.RORDD=b.RORDD and a.HTIPNUNDOC=b.HTIPNUNDOC                                 
where  b.HTIPNUNDOC  is null                                
GROUP BY a.RORDD,a.RFEC    

  
SELECT b.RORDD,
a.hfecpro,
cast(HTIPCRED as float) Num_Cli_App_v2,cast(HTIPPASI as float)Num_Cli_App_Pas_v2,cast(HTIPAMBO as float)Num_Cli_App_Cart_Pasiv_v2,
cast(HTIPFALT as float) falta_v2,cast(HPERCENTCART as float)PERCENTCartera,cast(HPERCENTPASI as float) PERCENTPasivo,
cast(HTOTALCLIENROL as float)total_app_cliente_v2,cast(HPERCENTUSABILIDAD as float)PERCENT_USABILIDAD_APP,cast(HPERCENTENROCLINET  as float)PERCENTenro_Clientes_Netos,
cast(HDATINPUTRXUSA as float)NCLITOTRX
into #res  --drop table select * from #res
FROM storage.[com].[WJAS004]  a
inner join #FECS b  --select  * from storage.[com].[WJAS004]
on a.hfecpro=b.rfec  --select * from #FECS
where a.htipcod=@tip_cod  and hcodrel=@cod_rel
 
SELECT * into #P FROM #res  --select * from #P  drop table #P
unpivot (data for descripcion in
    (
      Num_Cli_App_v2,Num_Cli_App_Pas_v2,Num_Cli_App_Cart_Pasiv_v2,falta_v2,PERCENTCartera,PERCENTPasivo,total_app_cliente_v2,PERCENT_USABILIDAD_APP,PERCENTenro_Clientes_Netos,NCLITOTRX  
     )
    ) pvt;

insert into #P --DELETE FROM #P WHERE descripcion='NOCLI'  
SELECT RORDD,rfec,HTIPNUNDOC,descripcion FROM #CLITRANSMES WHERE descripcion='NOCLI'  
UNION ALL
SELECT RORDD,rfec,HTIPNUNDOC,descripcion FROM #CLITRANSMES WHERE descripcion='CLI'    
UNION ALL
select A.RORDD,A.RFEC,COUNT(DISTINCT A.HTIPNUNDOC) HTIPNUNDOC,'AMBOSCLI' descripcion from #TD  a                                  
inner join #TNM b                        
on a.HTIPNUNDOC=b.HTIPNUNDOC and a.RORDD=b.RORDD                                  
GROUP BY A.RORDD,A.RFEC     
UNION ALL
select a.RORDD,a.RFEC, cast(COUNT(DISTINCT a.HTIPNUNDOC) as float)/b.HTIPNUNDOC,'PERCENT_ALTASMONET' descripcion                                              
from #TD a                                               
inner join (select rfec,COUNT(DISTINCT HTIPNUNDOC) HTIPNUNDOC from #TD group by rfec) b                                              
on a.RFEC=b.RFEC                                              
where a.HRECURR='Nuevo'                                              
GROUP BY a.RORDD,a.RFEC,b.HTIPNUNDOC 
UNION ALL
select a.RORDD,a.RFEC, cast(COUNT(DISTINCT a.HTIPNUNDOC) as float)/b.HTIPNUNDOC,'PERCENT_RECURRMONET' descripcion                                              
from #TD a  --SELECT * FROM #TD            
inner join (select rfec,COUNT(DISTINCT HTIPNUNDOC) HTIPNUNDOC from #TD group by rfec) b                                     
on a.RFEC=b.RFEC                                              
where a.HRECURR='Recurrente'   
GROUP BY a.RORDD,a.RFEC,b.HTIPNUNDOC
UNION ALL
select a.RORDD,a.RFEC,(SUM(HTOTINTE))/b.HTIPNUNDOC HTOTINTE,'PROMETRANSMONE' descripcion                                              
from #TD   a                              
left join (SELECT *  FROM #CLITRANSMES WHERE descripcion='CLI')b                              
on a.RORDD=b.RORDD    --select * from #TD                    
GROUP BY a.RORDD,a.RFEC,b.HTIPNUNDOC     
UNION ALL
select RORDD,RFEC,sum(HTOTINTE)HTOTINTE,'TMON_NOMONETA' descripcion from #TNM       GROUP BY RORDD,RFEC  
UNION ALL
select RORDD,RFEC,sum(HTOTINTE)HTOTINTE,'TMON' descripcion from #TM       GROUP BY RORDD,RFEC 
UNION ALL
SELECT a.RORDD,a.RFEC,cast(sum(a.HTOTINTE) as float)/(b.HTOTINTE),'TTMONPERCENT_'+HDESPROC descripcion                              
FROM #TM A                         
INNER JOIN (SELECT RFEC,sum(HTOTINTE)HTOTINTE FROM #TM  group by RFEC)b                              
on a.RFEC=b.RFEC                                              
GROUP BY a.RORDD,a.RFEC,HDESPROC,b.HTOTINTE   
UNION ALL                              
select RORDD,RFEC,sum(HTOTINTE)HTOTINTE,'TMON_APP' descripcion                                              
from #TM                                              
WHERE HCANAL='APP CLIENTE'                                              
GROUP BY RORDD,RFEC 
UNION ALL
SELECT a.RORDD,a.RFEC,cast(sum(a.HTOTINTE) as float)/(b.HTOTINTE),'TTMONPERCENT_APP_'+HDESPROC descripcion                                              
FROM #TM a                                               
inner join (select RFEC,sum(HTOTINTE)HTOTINTE from #TM WHERE HCANAL='APP CLIENTE' group by RFEC)b                                              
on a.RFEC=b.RFEC                                              
WHERE A.HCANAL='APP CLIENTE'                                              
GROUP BY a.RORDD,a.RFEC,HDESPROC,b.HTOTINTE 
UNION ALL
select RORDD,RFEC,sum(HTOTINTE)HTOTINTE,'TMON_HOME' descripcion                                               
from #TM                                              
WHERE HCANAL='HOMEBANKING'                                              
GROUP BY RORDD,RFEC                                         
UNION ALL                           
SELECT a.RORDD,a.RFEC,cast(sum(a.HTOTINTE) as float)/(b.HTOTINTE),'TTMONPERCENT_HOME_'+HDESPROC descripcion                                              
FROM #TM a                                               
left join (select RFEC,sum(HTOTINTE)HTOTINTE from #TM WHERE HCANAL='HOMEBANKING' group by RFEC)b                                              
on a.RFEC=b.RFEC                                              
WHERE A.HCANAL='HOMEBANKING'              --select * from #TD     WHERE HCANAL='HOMEBANKING'                            
GROUP BY a.RORDD,a.RFEC,HDESPROC,b.HTOTINTE                            
UNION ALL                              
select RORDD,RFEC,sum(HMONTO)HMONTO,'TMONTO' descripcion from #TM       GROUP BY RORDD,RFEC                                           
UNION ALL                          
select RORDD,RFEC,sum(HMONTO)HMONTO,'TMONTO_APP' descripcion                                         
from #TM                                              
WHERE HCANAL='APP CLIENTE'                                              
GROUP BY RORDD,RFEC                                         
UNION ALL                         
SELECT RORDD,RFEC,sum(HMONTO)HMONTO,'TMONTO_APP_' +HDESPROC descripcion                                              
FROM #TM                                              
WHERE HCANAL='APP CLIENTE'                                              
GROUP BY RORDD,RFEC,HDESPROC        
UNION ALL                                 
select RORDD,RFEC,sum(HMONTO)HMONTO,'TMONTO_HOME' descripcion                                              
from #TM                                              
WHERE HCANAL='HOMEBANKING'                                              
GROUP BY RORDD,RFEC                                         
UNION ALL                         
SELECT RORDD,RFEC,sum(HMONTO)HMONTO,'TMONTO_HOME_' +HDESPROC descripcion                                              
FROM #TM                                              
WHERE HCANAL='HOMEBANKING'                                              
GROUP BY RORDD,RFEC,HDESPROC      
union all
select * from #HDV 
union all
select * from #HDV2 
union all
select * from #HOP
UNION ALL
 select a.RORDD,a.RFEC, 
 case when HTIPNUNDOC = null or HTIPNUNDOC = 0 then 0
 else  cast(HTIPNUNDOC as float)/cast(HCONTIPO as float) end HTIPNUNDOC,'PERCENTCEHBV' descripcion
 from #HDV a   
 left join (select RORDD,hfecpro RFEC,total_app_cliente_v2 HCONTIPO FROM #res   ) b
 on a.RORDD = b.RORDD 
UNION ALL
 select a.RORDD,a.RFEC, 
 case when HTIPNUNDOC = null or HTIPNUNDOC = 0 then 0
 else  cast(HTIPNUNDOC as float)/cast(HCONTIPO as float) end HTIPNUNDOC, 'PERCENTCEHOP' descripcion
 from #HOP a
 left join (select RORDD,hfecpro RFEC,total_app_cliente_v2 HCONTIPO FROM #res  ) b
 on a.RORDD = b.RORDD
UNION ALL
 --select a.RORD,a.RFEC, 
 --case when HTIPNUNDOC = null or HTIPNUNDOC = 0 then 0
 --else  cast(HTIPNUNDOC as float)/cast(HCONTIPO as float) end HTIPNUNDOC, 'PERCENTCEHBV2' descripcion
 --from #HDV2 a
 --left join (select RORD,hfecpro RFEC,total_app_cliente_v2 HCONTIPO FROM #res  ) b
 --on a.RORD = b.RORD 
 select a.RORDD,a.RFEC, 
 case when a.HTIPNUNDOC = null or a.HTIPNUNDOC = 0 then 0
 else  cast(a.HTIPNUNDOC as float)/cast(c.HTIPNUNDOC as float) end HTIPNUNDOC, 'PERCENTCEHBV2' descripcion
 from #HDV2 a
 left join (select RORDD,hfecpro RFEC,total_app_cliente_v2 HCONTIPO FROM #res  ) b
 on a.RORDD = b.RORDD 
 left join #HDV c
 on a.RORDD = c.RORDD
                                          

create table #RPRETRANSX(id int identity(1,1) not null,vars varchar(250)null,v1 float null, v2 float null,v3 float null,                            
       v4 float null,v5 float null,v6 float null,v7 float null,v8 float null,v9 float null) --drop table #RPRETRANSX    

declare  @Query nvarchar(max)                                              
SET @Query                                              
= N'SELECT   descripcion  as vars' + NCHAR(10)                                                                 
 + ( SELECT REPLACE( N',MAX( CASE WHEN RORDD = <<RORDD>> THEN data  END) AS V<<RORDD>>', N'<<RORDD>>', RORDD)+ NCHAR(10)                                                                                                
    FROM  #P                                                                                       
    GROUP BY RORDD                                                                           
    ORDER BY RORDD                                                                          
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                                     
 + N'FROM #P                                                 
 group by descripcion  '                                                      
  
INSERT INTO #RPRETRANSX                                                                             
EXEC sp_Executesql @Query;  
alter table #RPRETRANSX                                              
add variacion float null          

update #RPRETRANSX set variacion=case when (v7)=0 then 0 else (v9-v7)/(v7)end      

                                          
insert into #A                        
 select 1,vars,v1,v2,v3,v4,v5,v6,v7,v8,v9,variacion                                              
 from #RPRETRANSX where /*id <>1 and*/ vars is not null         
 
 create table #TFORMAT                                              
  (                                              
  ID INT IDENTITY(1,1)NOT NULL,                              
  vars varchar(250) null,                                       
  descripcion varchar(250) null,                                              
  style int null                                              
  )                                              
  insert into #TFORMAT                                              
  select 'total_app_cliente_v2','N° Clientes Enrolados',1 union all                                              
  select 'Num_Cli_App_v2','Solo clientes de crédito',null union all                                              
  select 'Num_Cli_App_Pas_v2','Solo clientes de pasivos',null  union all                                              
  select 'Num_Cli_App_Cart_Pasiv_v2','Clientes con créditos y pasivos',null  union all                         
  select 'falta_v2','Sin Producto',null  union all 
  select 'HDV','Registros de Huella de voz',null  union all 
  select 'HDV2','validaciones de huella de voz',null  union all
  select 'HOP','Registros de Onboarding Process',null  union all 
  select 'PERCENTCartera','% clientes enrolados créditos / Total clientes créditos',1  union all                                              
  select 'PERCENTPasivo','% clientes enrolados pasivos / Total clientes pasivos',1  union all                                              
  select 'PERCENTenro_Clientes_Netos','% de clientes enrolados / Total clientes netos',1  union all                                              
  select 'PERCENT_USABILIDAD_APP','% usabilidad APP / Total clientes enrolados',1  union all                                              
  select 'PERCENTCE','% operaciones vía Contratación electrónica',1  union all 
  select 'PERCENTCEHBV','% Registros de Huella de voz/ Total clientes enrolados',1  union all
  select 'PERCENTCEHBV2','% validaciones de voz/ registros de voz',1  union all
  select 'PERCENTCEHOP','% Clientes Onboarding Process/ Total clientes enrolados',1  union all
  select 'TCLITRANMES','Clientes que Transaccionan en el Mes',4  union all                                              
  select 'NCLITOTRX','N° Clientes',1 UNION ALL                                              
  select 'CLI','Operaciones Monetarias',NULL UNION ALL                                              
  select 'NOCLI','Operaciones no Monetarias ',NULL UNION ALL                                   
  select 'AMBOSCLI','Ambos tipos de operaciones', null union all                                              
  select 'PERCENT_ALTASMONET','% Altas Monetaria',1 union all                                              
  select 'PERCENT_RECURRMONET','% Recurrentes Monetaria',1 union all                                              
  select 'PROMETRANSMONE','Promedio N° trans. monetarias por cliente',1 union all                                              
  select '','Transacciones en el Mes',4 union all                                              
  select 'TMON_NOMONETA','N° Transacciones No monetarias',2 union all                                              
  select 'TMON','N° Transacciones monetarias',2 union all                                              
  select 'TTMONPERCENT_PAGO DE CREDITO','% Pago De Credito',null union all                                    
  select 'TTMONPERCENT_PAGO DE TARJETA CCE','% Pago De Tarjeta CCE',null union all                                              
  select 'TTMONPERCENT_TRANSFERENCIA CCE','% Transferencia CCE',null union all                                              
  select 'TTMONPERCENT_TRANSFERENCIAS','% Transferencias',null union all           
  select 'TMON_APP','App Cliente',1 union all                                              
  select 'TTMONPERCENT_APP_PAGO DE CREDITO','% Pago De Credito',null union all                                              
  select 'TTMONPERCENT_APP_PAGO DE TARJETA CCE','% Pago De Tarjeta CCE',null union all                                              
  select 'TTMONPERCENT_APP_TRANSFERENCIA CCE','% Transferencia CCE',null union all                                              
  select 'TTMONPERCENT_APP_TRANSFERENCIAS','% Transferencias',null union all                                              
  select 'TMON_HOME','Homebanking',1 union all                                              
  select 'TTMONPERCENT_HOME_PAGO DE CREDITO','% Pago De Credito',null union all                                              
  select 'TTMONPERCENT_HOME_PAGO DE TARJETA CCE','% Pago De Tarjeta CCE',null union all                                          
  select 'TTMONPERCENT_HOME_TRANSFERENCIA CCE','% Transferencia CCE',null union all                                              
  select 'TTMONPERCENT_HOME_TRANSFERENCIAS','% Transferencias',null union all                                              
  select 'TMONTO','Monto Transacciones Monetarias',2 union all                                              
  select 'TMONTO_APP','App Cliente',1 union all                                              
  select 'TMONTO_APP_PAGO DE CREDITO','Pago De Credito',null union all                                              
  select 'TMONTO_APP_PAGO DE TARJETA CCE','Pago De Tarjeta Cce',null union all                                              
  select 'TMONTO_APP_TRANSFERENCIA CCE','Transferencia Cce',null union all                                                
  select 'TMONTO_APP_TRANSFERENCIAS','Transferencias',null union all                                              
  select 'TMONTO_HOME','Homebanking',1 union all                                              
  select 'TMONTO_HOME_PAGO DE CREDITO','Pago De Credito',null union all                                              
  select 'TMONTO_HOME_PAGO DE TARJETA CCE','Pago De Tarjeta Cce',null union all                                              
  select 'TMONTO_HOME_TRANSFERENCIA CCE','Transferencia Cce',null union all                               
  select 'TMONTO_HOME_TRANSFERENCIAS','Transferencias',null                                               
                                              
   select rep.FFTHCOLDEF(@defs) result;       
   
    select a.descripcion,b.vars,                                                       
case when b.vars like '%PERCENT%' then format(b.fec1,'P') else format(CASE WHEN a.STYLE=4 THEN NULL ELSE ISNULL(b.fec1,0) END,'N0','en-US') end v1,                                              
    case when b.vars like '%PERCENT%' then format(b.fec2,'P') else format(CASE WHEN a.STYLE=4 THEN NULL ELSE ISNULL(b.fec2,0) END,'N0','en-US') end v2,                                              
    case when b.vars like '%PERCENT%' then format(b.fec3,'P') else format(CASE WHEN a.STYLE=4 THEN NULL ELSE ISNULL(b.fec3,0) END,'N0','en-US') end v3,                              
 case when b.vars like '%PERCENT%' then format(b.fec4,'P') else format(CASE WHEN a.STYLE=4 THEN NULL ELSE ISNULL(b.fec4,0) END,'N0','en-US') end v4,                               
 case when b.vars like '%PERCENT%' then format(b.fec5,'P') else format(CASE WHEN a.STYLE=4 THEN NULL ELSE ISNULL(b.fec5,0) END,'N0','en-US') end v5,                               
 case when b.vars like '%PERCENT%' then format(b.fec6,'P') else format(CASE WHEN a.STYLE=4 THEN NULL ELSE ISNULL(b.fec6,0) END,'N0','en-US') end v6,                               
 case when b.vars like '%PERCENT%' then format(b.fec7,'P') else format(CASE WHEN a.STYLE=4 THEN NULL ELSE ISNULL(b.fec7,0) END,'N0','en-US') end v7,                               
 case when b.vars like '%PERCENT%' then format(b.fec8,'P') else format(CASE WHEN a.STYLE=4 THEN NULL ELSE ISNULL(b.fec8,0) END,'N0','en-US') end v8,                               
 case when b.vars like '%PERCENT%' then format(b.fec9,'P') else format(CASE WHEN a.STYLE=4 THEN NULL ELSE ISNULL(b.fec9,0) END,'N0','en-US') end v9,                                                                                           
 b.VarPorce variacion,A.style                                              
from #TFORMAT a                                               
left join #A b on a.vars=b.vars                                        
                                        
END
