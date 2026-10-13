-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-09-01 09:01:34.137000
                
--exec mod_rep.[com].[GSEGCAPBP01] 7,'231','20250617','TODOS'                  
CREATE procedure [com].[GSEGCAPBP01]                     
@tip_cod int,                        
@cod_rel varchar(10),                    
@fec varchar(10) ,              
@prod varchar(250)              
              
                  
  AS                        
BEGIN                       
  SET NOCOUNT ON;                     
                   
   set @fec=(select MAX(rfec) from storage.ref.RCALEN001 where RFEC<=@fec and RDIAFER=0)              
   declare @DescNom varchar(250)                      
set @DescNom =(                      
select                       
DISTINCT CASE WHEN @tip_cod=7 then CAST(RDESFC AS VARCHAR(250))                         
   when @tip_cod=18 then CAST(RDESTER AS VARCHAR(250))                          
   when @tip_cod=17 then CAST(RDESMAC AS VARCHAR(250))                          
   when @tip_cod=4 then CAST(RDESMAT AS VARCHAR(250))                          
   when @tip_cod=16 then CAST(RDESAGEH AS VARCHAR(250)) END                      
from storage.ref.VJERCOR04  --select top 5 * from storage.ref.VJERCOR04                      
where                        
case when @tip_cod=18 then  ISNULL(cast(RCODTER as nvarchar(10)),'9999')                                         
     when @tip_cod=17 then cast(RCODMAC as nvarchar(10))                                      
     when @tip_cod=4 then CAST(RCODMAT  as nvarchar(10))                                            
      when @tip_cod=16 then CAST(RCODAGEH as nvarchar(10)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                       
)              
    
    
select DISTINCT CASE WHEN @tip_cod=7 then CAST(RCODTER AS VARCHAR(250))                         
   when @tip_cod=18 then CAST(RCODMAC AS VARCHAR(250))                          
   when @tip_cod=17 then CAST(RCODMAT  AS VARCHAR(250))                          
   when @tip_cod=4 then CAST(RCODAGEH AS VARCHAR(250))   END RCOD,                      
   CASE WHEN @tip_cod=7 then RDESTER                         
   when @tip_cod=18 then RDESMAC                          
   when @tip_cod=17 then RDESMAT                          
   when @tip_cod=4 then RDESAGEH END RDESC,'Nivel 2' RNIVEL                      
INTO #JERAR                      
from  storage.ref.VJERCOR04                      
where                        
case when @tip_cod=18 then  ISNULL(cast(RCODTER as nvarchar(10)),'9999')                                         
     when @tip_cod=17 then cast(RCODMAC as nvarchar(10))                                      
     when @tip_cod=4 then CAST(RCODMAT  as nvarchar(10))                                            
      when @tip_cod=16 then CAST(RCODAGEH as nvarchar(10)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)                
          
    
declare @fecAnual date, @fecAFunc date          
set @fecAnual = (select DateAdd(YEAR,-1,(GETDATE())))          
set @fecAFunc =(SELECT DATEFROMPARTS(YEAR(@fecAnual), 12, 31))          
-------------------------------------------------------------------------------------          
-------------------------------------------------------------------------------------          
          
create table #FECS (ord int identity(1,1) not null,rfec date)          
          
;with cte_a as (                            
 select distinct  rfec from storage.util.FVECFEC01(@fec,'cie_ant') union all              
 select distinct  rfec from storage.util.FVECFEC01(@fec,'cmg_6') union all          
 select distinct  rfec from storage.util.FVECFEC01(@fec,'ayer')            
union all          
select rfec from storage.util.FVECFEC01(@fecAFunc,'hoy')          
)            
insert into #FECS  --select * from #FECS          
select   rfec from cte_a ORDER BY RFEC ASC            
    
 declare @defs as rep.TTHCOLDEF;                    
                        
 insert into @defs                    
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH,TSTBACKGROUND,THIDDEN)  values        
    
 (1,1,1,'descripcion','Nivel',null,2,1,'string',null,'70px',NULL,NULL),                    
 (2,1,null,'Pasivos','Pasivos',7,null,null,null,null,'70px',NULL,NULL),            
 (3,1,null,'FondeoE','Fondeo Base',6,null,null,null,null,'50px','#9d3ea6',NULL),  ---    
 (4,1,null,'Clientes','Clientes',5,null,null,null,null,'70px','#f0da20',NULL),                    
 (5,1,null,'TPPP','TPPP',6,null,null,null,null,'50px','#51a41b',NULL),   
 (6,1,null,'Usabilidad','Usabilidad',6,null,null,null,null,'50px','#44838c',NULL),    
      
    
 (7,2,2,'saldo4','Saldo Pasivo',null,null,null,'number','.0-0','70px',NULL,NULL),               
 (8,2,3,'sem_sal_anual',null,null,null,null,'traffic-light',null,'70px',null,1)  ,          
 (9,2,4,'var_sal_anual','Variación Anual',2,null,null,'number','.0-0','70px',NULL,NULL),             
 (10,2,5,'sem_sal_diario',null,null,null,null,'traffic-light',null,NULL,null,1)  ,          
 (11,2,6,'var_sal_diario','Variación Día',2,null,null,'number','.0-0','70px',NULL,NULL),             
 (12,2,7,'sem_sal_mes',null,null,null,null,'traffic-light',null,NULL,null,1)  ,          
 (13,2,8,'var_sal_mes','Variación Mes',2,null,null,'number','.0-0','70px',NULL,NULL)          
    
 insert into @defs         
  (TORDER,TLEV,TISDATA,TKEY,TDESC,TFORTYP,TFORMOD,thidden,TCOLS,TSTBACKGROUND)  values   ---      
 (14,2,9, 'CLI_FE','Saldo','number','.0-0',null,null,'#9d3ea6'),                                
 (15,2,10,'percent_FE','%','percent','.2-2',null,null,'#9d3ea6'),                                
 (16,2,11,'VARANUCLI_FE','Variación Anual','number','.0-0',null,null,'#9d3ea6'),                                      
 (17,2,12,'VARDIA_FE','Variación Día','number','.0-0',null,null,'#9d3ea6'),                                 
 (18,2,13,'semafvarmesfondeobase','','traffic-light',null,1,null,null) , --semafvarmesfondeobase          
 (19,2,14,'VARMESCLI_FE','Variación Mes','number','.0-0',null,2,'#9d3ea6')         
     
  insert into @defs                    
 (TORDER,TLEV,TISDATA,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTDEWIDTH,TSTBACKGROUND,THIDDEN)  values        
 (20,2,15,'cli4','Clientes',null,null,null,'number','.0-0','70px','#f0da20',NULL),                    
 (21,2,16,'sem_cli_anual','',null,null,null,'traffic-light',null,'10px','#51a41b',1)      , ---          
 (22,2,17,'var_cli_anual','Variación Cliente Anual',2,null,null,'number','.0-0','80px','#f0da20',NULL),              
 (23,2,18,'sem_cli_mes','',null,null,null,'traffic-light',null,'20px','#51a41b',1)      , ---          
 (24,2,19,'var_cli_mes','Variación Cliente Mes',2,null,null,'number','.0-0','80px','#f0da20',NULL),         
     
    
 (25,2,20,'ts4','TPPP Stock BP (%)',null,null,null,'percent','.2-2','70px','#51a41b',NULL)      ,           
 (26,2,21,'semTS','',null,null,null,'traffic-light',null,'20px','#51a41b',1)      , ---          
 (27,2,22,'var_ts_mes','Var. Mes',2,null,null,'string',null,'20px','#51a41b',NULL),              
 (28,2,23,'tm4','TPPP Mes BP (%)',null,null,null,'percent','.2-2','70px','#51a41b',NULL),              
 (29,2,24,'semTMES','Var. Mes',null,null,null,'traffic-light',null,'70px','#51a41b',1)  ,          
 (30,2,25,'var_tm_mes','Var. Mes',2,null,null,'string',null,'20px','#51a41b',null)   , 
 
 (31,2,26,'enroladoT2','Enrolado Total',null,null,null,'number','.0-0','70px','#84a4a4',NULL)      ,  
 (32,2,27,'varmesenro','Variación mes enrolado',null,null,null,'number','.0-0','70px','#84a4a4',NULL)      ,  
 (33,2,28,'enrolado2','Enrolados Activo',null,null,null,'number','.0-0','70px','#44838c',NULL)      ,  
 (34,2,29,'usabilidad2','Uso App',null,null,null,'number','.0-0','70px','#84a4a4',NULL)      ,  
 (35,2,30,'varmesusa','Variación Mes Uso APP',null,null,null,'number','.0-0','70px','#44838c',NULL)      ,  
 (36,2,31,'tasausa','Usabilidad',null,null,null,'percent','.0-0','70px','#44838c',NULL)    
                 
 --select * from @defs                    
 select rep.FFTHCOLDEF(@defs) result;                    
              
 create table #Fec (RORD INT IDENTITY(1,1) NOT NULL,rfec date null)              
declare @fec_dant date              
set @fec_dant=(select cast(DATEADD(day,-1,@fec) as date))              
;with cte_a as (              
 select rfec  from storage.util.FVECFEC01(@fec,'cmg_3,cie_ant,cmg_6')                
 union all              
 select  rfec  from storage.util.FVECFEC01(@fec_dant,'cmg_6')                
)              
insert into #Fec              
select * from cte_a order by 1 asc              
                
declare @fecs nvarchar(max)              
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                
from #Fec                
                 
create table #Rs_              
(   
descripcion varchar(350)null,ord int null,saldo1 float null,cli1 int null,tm1 float null,ts1 float null,saldo2 float null,cli2 int null,              
tm2 float null,ts2 float null,saldo3 float null,cli int null,tm3 float null,ts3 float null,saldo4 float null,cli4 int null,              
tm4 float null,ts4 float null              
)              
              
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                
                
 insert into @tvars                
 values ('Sal_Cap_BP',null,null,null,null,null) ,              
     ('Num_Cli_BP',null,null,null,null,null) ,              
        ('TPP_MES_BP_MACRO_DIFTEA',null,null,null,null,null) ,        ---TPP_MES_BP_MACRO_DIFTEA      
  ('tppp_stock',null,null,null,null,null)               
              
 insert into @tfil                
 values                
 --tabla,clave,valores (usar la doble comilla para valores texto/fecha)                
 ('todos','fec',@fecs)                
              
  if @prod<>'TODOS'                
 begin                
 insert into @tfil                  
 values('TODOS','prod_capt','"'+@prod+'"')                   
 end                   
                
 insert into @tconf                
 values                
 ('level_alias','style') ,('fec_corr','true')                 
                
 declare @jer varchar(100)                
  insert into @tfil                 
  exec [piv].[GPIVLEV02] @tip_cod,@cod_rel,@jer output                
                  
 create table #PreResult (fila int null,cod_fec varchar(250)null,cod_bp varchar(250) null,style int null,descripcion varchar(250)null,              
 sal_cap_bp float null,num_cli_bp int null,tpp_mes float null,tpp_stock float null)              
              
 insert into #PreResult              
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1                
                 
 -- delete top (4) from #PreResult               
              
 select * into #Back from #PreResult              
              
              
create table #PRFC              
(fila int null,cod_fec varchar(250)null,style int null,cod_bp varchar(250)null,sal_cap_bp float null,num_cli_bp int null,tpp_mes float null,tpp_stock float null)              
              
INSERT INTO #PRFC              
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows='"fec"',@columns='"vars"',@config=@tconf--,@show_query=1                
              
        
  select a.rord fila,a.rfec cod_fec, style,cod_bp,sal_cap_bp,num_cli_bp,tpp_mes,tpp_stock       
 into #PRFC_      
 from #fec a       
 left join #PRFC b      
 on a.rfec=b.cod_fec       
              
      
alter table #PRFC_ add descripcion varchar(250)null              
update #PRFC_ set descripcion='FINANCIERA CONFIANZA'                
              
              
 delete from #PreResult  where cod_bp is null  ---select * from #PreResult              
              
alter table #PreResult add ord int null              
              
update a              
set a.ord=B.RORD              
from #PreResult a               
inner join #Fec b              
on a.cod_fec=b.rfec              
      
select b.fila,a.rfec cod_fec,b.cod_bp,b.style,b.descripcion,b.sal_cap_bp,b.num_cli_bp,b.tpp_mes,b.tpp_stock,a.rord ord      
 into #PreResult_   --select * from #PreResult_      
 from #fec a       
 left join #PreResult b  --select * from #fec  select * from #PreResult      
 on a.rfec=b.cod_fec       
              
SELECT fila,cod_fec,0 cod_bp,0 style,descripcion,sal_cap_bp,num_cli_bp,tpp_mes,tpp_stock,fila ord              
into #TB              
FROM #PRFC_              
union all              
select * from #PreResult_-- #PreResult                 
               
              
DECLARE @Query NVARCHAR(MAX)                                                    
 --Primero ponemos las columnas sobre las cuales agruparemos                                                              
 SET @Query = N'SELECT descripcion,cod_bp' + NCHAR(10)                                          
 --Después colocamos las columnas que vamos a transponer                                                              
 + ( SELECT REPLACE( N',sum( CASE WHEN ord = <<ord>> THEN sal_cap_bp  END) AS Saldo<<ord>>              
,sum( CASE WHEN ord = <<ord>> THEN num_cli_bp  END) AS Cli<<ord>>              
,sum( CASE WHEN ord = <<ord>> THEN tpp_mes  END) AS tm<<ord>>              
,sum( CASE WHEN ord = <<ord>> THEN tpp_stock  END) AS ts<<ord>>      
', N'<<ord>>', ord)+ NCHAR(10)                                                              
                                                              
    FROM  #TB                                                                    
    --Eliminamos duplicados usando GROUP BY                                                              
    GROUP BY ord                                                              
    --Definimos el orden de las columnas                                                              
   -- ORDER BY RORD asc                                                             
    --Usamos esta instrucción para concatenar los valores                                                              
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                                              
 --Ponemos el resto de la consulta                                                              
 + N'FROM  #TB                                                             
 group by descripcion,cod_bp                                            
 order by cod_bp asc                   
 '               
              
insert into #Rs_ --select * from #Rs_              
EXEC sp_Executesql @Query;                   
    
/* FONDEO BASE ININICIO */    
SELECT HFECPRO,HTIPCOD,HCODREL,MIN(HSALFESI)HSALFESI,RDESCPROD,@DescNom DESCR     ,MIN(HSALFENO) HSALFENO                        
into #TPRECLI2     --select * from #TPRECLI2      DROP TABLE #TPRECLI2    
FROM STORAGE.[com_pas].[WJAS009] --select  distinct RDESCPROD from sTORAGE.[com_pas].[WJAS009] where htipcod=7 order by 1 asc          
WHERE HTIPCOD=@tip_cod AND HCODREL=@COD_REL AND RDESCPROD=@PROD AND  hfecpro in(select rfec from #FECS)               
group by HFECPRO,HTIPCOD,HCODREL,RDESCPROD          
UNION ALL                  
SELECT HFECPRO,HTIPCOD,HCODREL, min(HSALFESI)HSALFESI,RDESCPROD , a.HCODREL RDESC   ,MIN(HSALFENO) HSALFENO                      
FROM STORAGE.[com_pas].[WJAS009]   a    --SELECT * FROM STORAGE.[com_pas].[WJAS009]             
WHERE A.HTIPCOD=18          
and hfecpro in(select rfec from #FECS)  and   RDESCPROD=@PROD         
group by HFECPRO,HTIPCOD,HCODREL,RDESCPROD        
    
select b.ord,a.*,HSALFESI + HSALFENO HSALTOTAL      
into #rst2  --select * from #rst2   DROP TABLE #rst2          
from  #TPRECLI2 a      --SELECT * FROM #TPRECLI2     
left join #fecs b  --select * from #fecs          
on a.hfecpro=b.rfec         
    
alter table #rst2 add style int null          
          
update #rst2 set style=case when htipcod=@tip_cod then 1 else 0 end         
    
create table #CliPivot2(Descr varchar(250)null,style int null,A1 float null,B1 float null,A2 FLOAT NULL,B2 FLOAT NULL,A3 FLOAT NULL,B3 FLOAT NULL,A4 FLOAT NULL,B4 FLOAT NULL)        
          
SET @Query                                                                    
= N'SELECT   DESCR,style ' + NCHAR(10)                                                                                       
 + ( SELECT REPLACE( N',SUM(CASE WHEN ord = <<ord>> THEN HSALFESI  END) AS A<<ord>>,          
 SUM(CASE WHEN ord = <<ord>> THEN HSALTOTAL  END) AS B<<ord>>', N'<<ord>>', ord)+ NCHAR(10)                                                                                                                       
    FROM  #rst2                                                                                                             
    GROUP BY ord           
    ORDER BY ord                                                                                                
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                                      
 + N'FROM #rst2                                                                      
 group by DESCR,style  '                                                                            
insert into #CliPivot2         --SELECT * FROM #rst2                                                                                                        
EXEC sp_Executesql @Query;        
    
SELECT DESCR,style,A4 CLI_FE,A4 - A1 VARANUCLI_FE,A4 - A2 VARMESCLI_FE,A4 - A3 VARDIA_FE INTO #BCLIPIVOT2 FROM #CliPivot2 --select * from #fecs select * from #CliPivot2         
    
/* FONDEO BASE FIN*/    

/**/
select *   
into #fecsS
from storage.util.FVECFEC01(@fec,'cmg_5,cmg_6')  


select distinct b.rord, HFECPRO,HTIPNUMDOC 
into #WAPP 
from storage.[com_act].WAPPCLI001  a
inner join #fecsS b
on a.hfecpro=b.rfec 

select b.rord,hfecpro,concat_ws('',HTIPDOC,HNUMDOC) HTIPNUMDOC 
into #USOAPP  
from   storage.[com_act].[HTDA001] a
inner join #fecsS b
on a.hfecpro=b.rfec 
where a.HCANAL = 'APP CLIENTE'
  
;with abph_ as (    
 select * from [storage].[ref].[REABP001] where RESTSEC=1  AND RESTACT=1  
 ),    
 abph as (    
 select A.*,B.RDESZBP    
 from abph_ A    
 left join [storage].[ref].[REABP002] B    
 on A.RCODZBP=B.RCODZBP    
 )  ,
 cte_b as (
 select b.rord,a.*,concat(isnull([HPENDOC],'00000000'),'-',isnull([HPETDOC],'0'),'-',isnull([HPEPAIS],'0')) HDOCCON,  
  concat(isnull([HSBCTA],'0'),'-',isnull([HSBOPER],'0'),'-',isnull([HSBSBOP],'0')) HOPECON  
  from [storage].[com_pas].[HCDP001] A  
	inner join #fecsS b
	on a.hfecpro=b.rfec 
  and HCODSEC=1    
 )
 select A.*,B.RCODZBP,B.RDESZBP    
 into #VCPH007
 from cte_b A    
 left join abph B    
 on A.HUSERBP=B.RCODSEC    

;with cte_a as (
select concat_ws('',LTRIM(LTRIM(HPETDOC)),LTRIM(RTRIM(HPENDOC)))HTIPNUMDOC,* 
from #VCPH007

)
select a.*,
CASE   WHEN b.HTIPNUMDOC IS NOT NULL THEN 1
          ELSE 0
       END AS APP_CLIENTE
into #BP
from cte_a a
left join #WAPP b
on a.hfecpro=b.hfecpro and a.HTIPNUMDOC=b.HTIPNUMDOC


select a.*,
CASE 
        WHEN MAX(CASE WHEN HNGRUPO <> '81' THEN 1 ELSE 0 END) 
            OVER (PARTITION BY a.hfecpro, HPEPAIS, HPETDOC, HPENDOC) = 1 
        THEN 'ACTIVO'
        ELSE 'INACTIVO'
    END AS HESTADO_,
    CASE 
        WHEN b.HTIPNUMDOC IS NOT NULL THEN 'SI'
        ELSE 'NO'
    END AS USO_APP
INTO #BP_FINAL  --drop table #BP_FINAL
from #BP a  --select top 6 * from #BP
left join #USOAPP b
on a.hfecpro=b.hfecpro and  a.HTIPNUMDOC=b.HTIPNUMDOC
--group by RDESZBP
  
create table #BP__
(
RORD INT NULL,
HFECPRO DATE NULL,
RDESZBP VARCHAR(250)NULL,
HDESPROD VARCHAR(250)NULL,
ENROLADOS_TOTAL FLOAT NULL,
ENROLADOS_ACTIVOS FLOAT NULL,
USO_APP_SI FLOAT NULL,
TASA_USO_APP FLOAT NULL
)

create table #BP__FC
(
RORD INT NULL,
HFECPRO DATE NULL,
RDESZBP VARCHAR(250)NULL,
HDESPROD VARCHAR(250)NULL,
ENROLADOS_TOTAL FLOAT NULL,
ENROLADOS_ACTIVOS FLOAT NULL,
USO_APP_SI FLOAT NULL,
TASA_USO_APP FLOAT NULL
)



IF @prod='TODOS'
begin
 
insert into #BP__
select rord,hfecpro,RDESZBP ,'TODOS' HDESPROD,
 COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1
        THEN HTIPNUMDOC END) AS Enrolados_Total,

    COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1 AND HESTADO_ = 'ACTIVO' 
        THEN HTIPNUMDOC END) AS Enrolados_Activos,
    
    COUNT(DISTINCT CASE 
        WHEN USO_APP = 'SI' 
        THEN HTIPNUMDOC END) AS Uso_APP_SI,

    CAST(COUNT(DISTINCT CASE 
        WHEN USO_APP = 'SI' 
        THEN HTIPNUMDOC END) AS FLOAT) /
    NULLIF(COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1 AND HESTADO_ = 'ACTIVO' 
        THEN HTIPNUMDOC END), 0) AS Tasa_Uso_APP
 
from #BP_FINAL  --select * from #BP_FINAL
group by rord,hfecpro,RDESZBP


insert into #BP__FC
select rord,hfecpro,'FINANCIERA CONFIANZA' ,'TODOS' HDESPROD,
 COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1
        THEN HTIPNUMDOC END) AS Enrolados_Total,

    COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1 AND HESTADO_ = 'ACTIVO' 
        THEN HTIPNUMDOC END) AS Enrolados_Activos,
    
    COUNT(DISTINCT CASE 
        WHEN USO_APP = 'SI' 
        THEN HTIPNUMDOC END) AS Uso_APP_SI,

    CAST(COUNT(DISTINCT CASE 
        WHEN USO_APP = 'SI' 
        THEN HTIPNUMDOC END) AS FLOAT) /
    NULLIF(COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1 AND HESTADO_ = 'ACTIVO' 
        THEN HTIPNUMDOC END), 0) AS Tasa_Uso_APP
 
from #BP_FINAL  --select * from #BP_FINAL
group by rord,hfecpro 
 
 
end
else 
begin

insert into #BP__
select rord,hfecpro,RDESZBP ,'TODOS' HDESPROD,
 COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1
        THEN HTIPNUMDOC END) AS Enrolados_Total,

    COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1 AND HESTADO_ = 'ACTIVO' 
        THEN HTIPNUMDOC END) AS Enrolados_Activos,
    
    COUNT(DISTINCT CASE 
        WHEN USO_APP = 'SI' 
        THEN HTIPNUMDOC END) AS Uso_APP_SI,

    CAST(COUNT(DISTINCT CASE 
        WHEN USO_APP = 'SI' 
        THEN HTIPNUMDOC END) AS FLOAT) /
    NULLIF(COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1 AND HESTADO_ = 'ACTIVO' 
        THEN HTIPNUMDOC END), 0) AS Tasa_Uso_APP
from #BP_FINAL a 
inner join (
				select * 
				from storage.[com_pas].[RETP001] 
				where RDESCPROD02=case when @prod='Ahorros' then 'AHORROS' 
									   when @prod='Cts' then 'CTS'
									   when @prod='Plazo Fijo' then 'PLAZO FIJO' end) B on A.HSBMOD=B.RCODMOD
and A.HSBTOPE=B.RTIPOPE
group by rord,hfecpro,RDESZBP


INSERT INTO #BP__FC
select rord,hfecpro,'FINANCIERA CONFIANZA' ,'TODOS' HDESPROD,
 COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1
        THEN HTIPNUMDOC END) AS Enrolados_Total,

    COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1 AND HESTADO_ = 'ACTIVO' 
        THEN HTIPNUMDOC END) AS Enrolados_Activos,
    
    COUNT(DISTINCT CASE 
        WHEN USO_APP = 'SI' 
        THEN HTIPNUMDOC END) AS Uso_APP_SI,

    CAST(COUNT(DISTINCT CASE 
        WHEN USO_APP = 'SI' 
        THEN HTIPNUMDOC END) AS FLOAT) /
    NULLIF(COUNT(DISTINCT CASE 
        WHEN APP_CLIENTE = 1 AND HESTADO_ = 'ACTIVO' 
        THEN HTIPNUMDOC END), 0) AS Tasa_Uso_APP
from #BP_FINAL a 
inner join (
				select * 
				from storage.[com_pas].[RETP001] 
				where RDESCPROD02=case when @prod='Ahorros' then 'AHORROS' 
									   when @prod='Cts' then 'CTS'
									   when @prod='Plazo Fijo' then 'PLAZO FIJO' end) B on A.HSBMOD=B.RCODMOD
and A.HSBTOPE=B.RTIPOPE
group by rord,hfecpro

end
 
create table #RBP
(
RDESZBP varchar(250)null,
EnroladoT1	float null,
EnroladoA1	float null,
Usa1 float null,
TASA_USO_APP1 float null,
EnroladoT2 float null,
EnroladoA2 float null,
Usa2 float null,
TASA_USO_APP2  float null
)

create table #RBPFC
(
RDESZBP varchar(250)null,
EnroladoT1	float null,
EnroladoA1	float null,
Usa1 float null,
TASA_USO_APP1 float null,
EnroladoT2 float null,
EnroladoA2 float null,
Usa2 float null,
TASA_USO_APP2  float null
)

DECLARE @cols NVARCHAR(MAX) = ''; 

-- Paso 1: construir dinámicamente las columnas
SELECT @cols = STRING_AGG(
    'MAX(CASE WHEN rord = ' + CAST(rord AS VARCHAR) + ' THEN ENROLADOS_TOTAL END) AS EnroladoT' + CAST(rord AS VARCHAR) + ',' +
    'MAX(CASE WHEN rord = ' + CAST(rord AS VARCHAR) + ' THEN ENROLADOS_ACTIVOS END) AS EnroladoA' + CAST(rord AS VARCHAR) + ',' +
    'MAX(CASE WHEN rord = ' + CAST(rord AS VARCHAR) + ' THEN USO_APP_SI END) AS Usa' + CAST(rord AS VARCHAR) + ',' +
    'MAX(CASE WHEN rord = ' + CAST(rord AS VARCHAR) + ' THEN TASA_USO_APP END) AS TASA_USO_APP' + CAST(rord AS VARCHAR),
    ',' + CHAR(10)
)
FROM (
    SELECT DISTINCT rord
    FROM #BP__
) AS r;

SET @query = '
SELECT 
    RDESZBP,
    ' + @cols + '
FROM #BP__
GROUP BY RDESZBP
ORDER BY RDESZBP;';

-- Paso 3: ejecutar
insert into #RBP
EXEC sp_executesql @query;


SELECT @cols = STRING_AGG(
    'MAX(CASE WHEN rord = ' + CAST(rord AS VARCHAR) + ' THEN ENROLADOS_TOTAL END) AS EnroladoT' + CAST(rord AS VARCHAR) + ',' +
    'MAX(CASE WHEN rord = ' + CAST(rord AS VARCHAR) + ' THEN ENROLADOS_ACTIVOS END) AS EnroladoA' + CAST(rord AS VARCHAR) + ',' +
    'MAX(CASE WHEN rord = ' + CAST(rord AS VARCHAR) + ' THEN USO_APP_SI END) AS Usa' + CAST(rord AS VARCHAR) + ',' +
    'MAX(CASE WHEN rord = ' + CAST(rord AS VARCHAR) + ' THEN TASA_USO_APP END) AS TASA_USO_APP' + CAST(rord AS VARCHAR),
    ',' + CHAR(10)
)
FROM (
    SELECT DISTINCT rord
    FROM #BP__FC
) AS r;


SET @query = '
SELECT 
    RDESZBP,
    ' + @cols + '
FROM #BP__FC
GROUP BY RDESZBP
ORDER BY RDESZBP;';

-- Paso 3: ejecutar
insert into #RBPFC
EXEC sp_executesql @query;

 
select  rdeszbp,sum(enroladoT2) enroladoT2,sum(isnull(enroladoT2,0)) - sum(isnull(enroladoT1,0)) varmesenro,
sum(isnull(EnroladoA2,0)) enrolado2,sum(isnull(Usa2,0)) usabilidad2,sum(isnull(Usa2,0))-sum(isnull(Usa1,0)) varmesusa,
sum(isnull(TASA_USO_APP2,0)) tasausa
into #RBPP
from #RBPFC
GROUP BY rdeszbp
union all
select rdeszbp,enroladoT2,isnull(enroladoT2,0) - isnull(enroladoT1,0) varmesenro,
isnull(EnroladoA2,0) enrolado2,isnull(Usa2,0) usabilidad2,isnull(Usa2,0)-isnull(Usa1,0) varmesusa,isnull(TASA_USO_APP2,0) tasausa
from #RBP

/**/
              
--drop table #Fec,#PreResult              
              
select case when descripcion='Financiera Confianza' then 1 else 0 end style,ord,descripcion,          
saldo4,          
saldo4-saldo1 var_sal_anual,          
saldo4-saldo3 var_sal_diario,              
saldo4-saldo2 var_sal_mes,             
          
util.FSEMVAR(202,saldo4,saldo4-saldo1) sem_sal_anual,          
util.FSEMVAR(202,saldo4,saldo4-saldo3) sem_sal_diario,          
util.FSEMVAR(202,saldo4,saldo4-saldo2) sem_sal_mes,          
          
          
cli4,          
cli4-cli1 var_cli_anual,          
cli4-cli2 var_cli_mes,              
        
util.FSEMVAR(202,cli4,cli4-cli1) sem_cli_anual,          
util.FSEMVAR(202,cli4,cli4-cli2) sem_cli_mes,          
          
ts4,          
util.FFMTVAR(253,ts4-ts2,1) var_ts_mes,          
tm4,           
util.FFMTVAR(253,tm4-tm2,1)  var_tm_mes    ,          
--util.FSEMVAR(253,ts4,ts4-ts2) semTS,          
--util.FSEMVAR(253,tm4,tm4-ts2) semTMES   ,    
case when (ts4-ts2)<0 then 1 when (ts4-ts2)>0 then -1 end semTS    ,  
case when (tm4-ts2)<0 then 1 when (tm4-ts2)>0 then -1 end semTMES    ,  
C.CLI_FE,C.VARANUCLI_FE,C.VARMESCLI_FE,c.VARDIA_FE,  cast(CLI_FE as float)/ saldo4 percent_FE ,    
case when C.VARMESCLI_FE <0 then -1 when C.VARMESCLI_FE>0 then 1 end semafvarmesfondeobase  ,
enroladoT2,varmesenro,
enrolado2,usabilidad2,varmesusa,tasausa
              
from #Rs_          a    
left join #BCLIPIVOT2 c  --select * from #BCLIPIVOT2    
ON A.DESCRIPCION=C.DESCR   
left join #RBPP d
on a.descripcion=d.rdeszbp 
order by ord asc                     
  end
