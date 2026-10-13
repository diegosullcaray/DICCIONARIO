-- Extraído de mish/mod_rep el 2026-10-13 con extraccion/herramientas/bd.py · modificado en la base: 2026-10-13 14:22:27.730000
--exec [com].[RSROPERA001] 4,'323','20260128','TODOS'                                                
CREATE PROCEDURE [com].[RSROPERA002]                                                    
@tip_cod int,@cod_rel varchar(20),@fec varchar(10)  ,@prod varchar(250)                                           
AS                                                        
BEGIN                                                        
 SET NOCOUNT ON;                                  
                           
--declare @fec varchar(50)='20250308',@tip_cod int =7,@cod_rel varchar(250)='231' ,@prod VARCHAR(250)='AHORROS' --,@segmento varchar(250)='TODOS'                                  
--declare @fec varchar(50)='20250217',@tip_cod int =18,@cod_rel varchar(250)='5' ,@prod VARCHAR(250)='TODOS'                                 
  declare @fecRep varchar(250)              
   set @fecRep=(select FORMAT(max(hfecpro), 'dd MMM', 'es-ES') from  STORAGE.[com_pas].[WJAS008] )                  
               
declare @defs as rep.TTHCOLDEF;                                                    
  insert into @defs                                                    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS)  values                                                    
 (1,1,1,'descripcion','Descripción','string',null,1,2)                                                    
                                                
 insert into @defs                                                    
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND) values                                                     
 (2,1,'m_SP','Pasivo al '+@fecRep,7,null),                                                
 (3,1,'m_FB','Fondeo Base',6,'#9d3ea6') ,                                     
 (4,1,'m_cli','Clientes',5,'#e3bc10') ,                                     
 (5,1,'m_TPPP','TPPP',6,'#3ab61b')              
     
 insert into @defs                                                    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,thidden,TCOLS,TSTBACKGROUND)  values                                                    
 (4,2,2,'saldo','Saldo','number','.0-0',null,null,null)   ,                                                
 (5,3,2,'varAnualSaldo','Variación Anual','number','.0-0',null,null,null) ,                                                 
 (6,4,2,'vardiaSaldo','Variación Día','number','.0-0',null,null,null),                       
 (7,5,2,'semafvarmessaldo','','traffic-light',null,1,null,null),                      
 (8,6,2,'varmesSaldo','Variación Mes','number','.0-0',null,2,null),        
 (9,7,2,'metasaldopuntual','Meta','number','.0-0',null,1,null),                
 (10,8,2,'varsaldometapuntual','Distancia Meta','number','.0-0',null,1,null),                
                       
 (11,9,2,'CLI_FE','Saldo','number','.0-0',null,null,'#9d3ea6'),                                                
 (12,10,2,'percent_FE','%','percent','.2-2',null,null,'#9d3ea6'),                                                
 (13,11,2,'VARANUCLI_FE','Variación Anual','number','.0-0',null,null,'#9d3ea6'),                                                
 (14,12,2,'VARDIA_FE','Variación Día','number','.0-0',null,null,'#9d3ea6'),                                                
 (15,13,2,'semafvarmesfondeobase','','traffic-light',null,1,null,null) , --semafvarmesfondeobase                          
 (16,14,2,'VARMESCLI_FE','Variación Mes','number','.0-0',null,2,'#9d3ea6')       
     
insert into @defs                                                    
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS,TCOLS,thidden,TSTBACKGROUND)  values                                                    
 (17,15,2,'CLI','Clientes','number','.0-0',null,2,null,null,'#e3bc10')   ,                                                
 (18,16,2,'VARANUCLI','Var. Anual Clientes','number','.0-0',null,2,null,null,'#e3bc10'),                      
 (19,17,2,'VARDICLI','Var. Día Clientes','number','.0-0',null,2,null,null,'#e3bc10'),             
 (20,18,2,'semafvarmescliente','','traffic-light',null,null,null,null,1,null),                          
 (21,19,2,'VARMESCLI','Var. Mes Clientes','number','.0-0',null,2,2,null,'#e3bc10'),         
                      
 (22,20,2,'percentStock','TPPP Stock RED (%)','percent','.2-2',null,2,null,null,'#3ab61b'),                          
 (23,21,2,'senaftppstock','','traffic-light',null,null,null,null,1,null),                          
 (24,22,2,'varmesStock','Var. Mes','string',null,null,2,2,null,'#3ab61b'),                            
                       
 (25,23,2,'percentMes','TPPP Mes RED (%)','percent','.2-2',null,2,null,null,'#3ab61b'),                        
 (26,24,2,'semafmesmes','','traffic-light',null,null,null,null,1,null) ,                          
 (27,25,2,'varmesMes','Var. Mes','string',null,null,2,2,null,'#3ab61b')                            
                                                 
 select rep.FFTHCOLDEF(@defs) hdefs ;                   
                          
 ----------------------------------------------------------                                                  
declare @fecs varchar(max)                                                
-------------------------------------------------------------------------------------                          
-------------------------------------------------------------------------------------                          
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
                          
                                                
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                                                
from #FECS                                                
                                                      
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                                                            
                           
 insert into @tvars values                                                             
 ('monto_pas_caract_NL',null,null,null,null,null),                          
 ('TPP_MES_RED_MACRO_DIFTEA',null,null,null,null,null),                          
 ('tppp_stock_cap_macro',null,null,null,null,null)                          
                          
 if @prod<>'TODOS'                                                
 begin                                                
   insert into @tfil                                                  
   values('TODOS','prod_capt','"'+@prod+'"')                                         
 end                             
                              
 insert into @tfil                                                            
 values                                                            
 ('todos','fec',@fecs)        
                                                                               
 declare @jer varchar(100);                                                          
 insert into @tfil                                    
 exec piv.GPIVLEV10 @tip_cod,@cod_rel,@jer output                                                            
                                                            
 insert into @tconf                                                            
 values                                                            
 ('level_alias','style'),                          
 ('fec_corr','true') ,('insert_to', '#TR')                          
                          
 create table #TR (  --select * from #TR                          
fila int null,cod_fc varchar(250)null,cod_cter_capt_m varchar(50)null,style int null,                          
descripcion varchar(250)null,monto_pas_caract_NL_1 float null,monto_pas_caract_NL_2 float null,monto_pas_caract_NL_3 float null,monto_pas_caract_NL_4 float null,                 
TPP_MES_RED_MACRO_DIFTEA_1 float null,TPP_MES_RED_MACRO_DIFTEA_2 float null,TPP_MES_RED_MACRO_DIFTEA_3 float null,TPP_MES_RED_MACRO_DIFTEA_4 float null,                          
tppp_stock_cap_macro_1 float null,tppp_stock_cap_macro_2 float null,tppp_stock_cap_macro_3 float null, tppp_stock_cap_macro_4 float null                          
)                          
                          
                                                      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1                                    
                            
 select fila,cod_fc,cod_cter_capt_m,style,descripcion,                          
monto_pas_caract_NL_4 saldo,                           
monto_pas_caract_NL_4 - monto_pas_caract_NL_1 varAnualSaldo ,                           
monto_pas_caract_NL_4 - monto_pas_caract_NL_3 vardiaSaldo,                          
monto_pas_caract_NL_4 - monto_pas_caract_NL_2 varmesSaldo,                          
tppp_stock_cap_macro_4 percentStock,    concat(format((tppp_stock_cap_macro_4  -  tppp_stock_cap_macro_2)*10000,'N0'),' pbs')  varmesStock,                          
TPP_MES_RED_MACRO_DIFTEA_4 percentMes, concat(format((TPP_MES_RED_MACRO_DIFTEA_4 - TPP_MES_RED_MACRO_DIFTEA_2)*10000,'N0'),' pbs')  varmesMes   ,                      
(tppp_stock_cap_macro_4  -  tppp_stock_cap_macro_2) semvarmesStock,                      
(TPP_MES_RED_MACRO_DIFTEA_4 - TPP_MES_RED_MACRO_DIFTEA_2) semafmesmes                      
INTO #trf                          
from #TR                          
                          
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
                          
                          
                          
SELECT HFECPRO,HTIPCOD,HCODREL,HNUMCLI,RDESCPROD,@DescNom DESCR                      
into #TPRECLI                              
FROM STORAGE.[com_pas].[WJAS007] --select  top 50 * from sTORAGE.[com_pas].[WJAS007] where htipcod=7 order by 1 asc                          
WHERE HTIPCOD=@tip_cod AND HCODREL=@COD_REL AND RDESCPROD=@PROD AND  hfecpro in(select rfec from #FECS)                               
UNION ALL                                  
SELECT HFECPRO,HTIPCOD,HCODREL, HNUMCLI,RDESCPROD , B.RDESC                        
FROM STORAGE.[com_pas].[WJAS007]   a                                
INNER JOIN (select * from #JERAR where rnivel='Nivel 2') B --DROP TABLE #JERAR                                      
ON A.HCODREL=B.RCOD                                      
where htipcod =case when @tip_cod=7 then 18                                      
        when @tip_cod=18 then 17                                      
                    when @tip_cod=17 then 4                                       
     when @tip_cod=4 then 16                    
                                      
    end                              
and hfecpro in(select rfec from #FECS)  and   RDESCPROD=@PROD                          
                          
----------                          
SELECT HFECPRO,HTIPCOD,HCODREL,MIN(HSALFESI)HSALFESI,RDESCPROD,@DescNom DESCR     ,MIN(HSALFENO) HSALFENO                                        
into #TPRECLI2     --select * from #TPRECLI2            aqui              
FROM STORAGE.[com_pas].[WJAS011] --select distinct hfecpro from STORAGE.[com_pas].[WJAS008] where htipcod=7 order by 1 asc                          
WHERE HTIPCOD=@tip_cod AND HCODREL=@COD_REL AND RDESCPROD=@PROD AND  hfecpro in(select rfec from #FECS)                               
group by HFECPRO,HTIPCOD,HCODREL,RDESCPROD                          
UNION ALL                                  
SELECT HFECPRO,HTIPCOD,HCODREL, min(HSALFESI)HSALFESI,RDESCPROD , B.RDESC   ,MIN(HSALFENO) HSALFENO                                      
FROM STORAGE.[com_pas].[WJAS011]   a                                
INNER JOIN (select * from #JERAR where rnivel='Nivel 2') B --DROP TABLE #JERAR                                      
ON A.HCODREL=B.RCOD                                      
where htipcod =case when @tip_cod=7 then 18                                      
        when @tip_cod=18 then 17                                      
                    when @tip_cod=17 then 4                                       
     when @tip_cod=4 then 16                             
                                      
    end                              
and hfecpro in(select rfec from #FECS)  and   RDESCPROD=@PROD                          
group by HFECPRO,HTIPCOD,HCODREL,RDESCPROD,B.RDESC                          
-----                          
                              
select b.ord,a.*  into #rst                          
from  #TPRECLI a                           
left join #fecs b                          
on a.hfecpro=b.rfec                          
                          
select b.ord,a.*,HSALFESI + HSALFENO HSALTOTAL  into #rst2  --select * from #rst2   DROP TABLE #rst2                          
from  #TPRECLI2 a                           
left join #fecs b  --select * from #fecs                          
on a.hfecpro=b.rfec                          
                          
--update #rst set ord=3 where ord=4  --select * from #rst2                          
alter table #rst2 add style int null                          
                          
update #rst2 set style=case when htipcod=@tip_cod then 1 else 0 end                          
                            
create table #CliPivot_(HTIPCOD int null,Descr varchar(250)null,A1 float null,A2 FLOAT NULL,A3 FLOAT NULL,A4 FLOAT NULL)                            
create table #CliPivot2(Descr varchar(250)null,style int null,A1 float null,B1 float null,A2 FLOAT NULL,B2 FLOAT NULL,A3 FLOAT NULL,B3 FLOAT NULL,A4 FLOAT NULL,B4 FLOAT NULL)                          
                          
declare  @Query nvarchar(max)                                                                                    
SET @Query                        
= N'SELECT   HTIPCOD,DESCR ' + NCHAR(10)                                                                                                       
 + ( SELECT REPLACE( N',SUM(CASE WHEN ord = <<ord>> THEN HNUMCLI  END) AS A<<ord>>', N'<<ord>>', ord)+ NCHAR(10)                                                                                                                                  
    FROM  #rst                                                                                         
    GROUP BY ord                                                                                                                 
    ORDER BY ord                                                                                                                
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                                                      
 + N'FROM #rst                   
 group by HTIPCOD,DESCR  '                                                                                            
                                      
insert into #CliPivot_       --SELECT * FROM #CliPivot                                                                                                           
EXEC sp_Executesql @Query;    --select * from #CliPivot     select * from #rst   select * from #rst2                 
                           
           
SELECT *, CASE WHEN HTIPCOD=@tip_cod THEN 1 ELSE 0 END style INTO #CliPivot FROM #CliPivot_   --select * from #CliPivot                       
                           
                          
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
insert into #CliPivot2                                                                                                                                
EXEC sp_Executesql @Query;                           
                          
--SELECT DESCR,A3 CLI,A3 - A1 VARANUCLI,A3 - A2 VARMESCLI INTO #BCLIPIVOT FROM #CliPivot      ---select * from #CliPivot                      
SELECT HTIPCOD,style,DESCR,A4 CLI,A4 - A1 VARANUCLI,A4 - A2 VARMESCLI, A4 - A3 VARDICLI INTO #BCLIPIVOT FROM #CliPivot      ---select * from #CliPivot    select * from #BCLIPIVOT                     
SELECT DESCR,style,A4 CLI_FE,A4 - A1 VARANUCLI_FE,A4 - A2 VARMESCLI_FE,A4 - A3 VARDIA_FE INTO #BCLIPIVOT2 FROM #CliPivot2 --select * from #fecs select * from #CliPivot2                          
                          
SELECT distinct a.fila,a.cod_fc,a.cod_cter_capt_m,a.style,a.descripcion,a.saldo,a.varAnualSaldo,a.vardiaSaldo,a.varmesSaldo,a.percentStock,a.varmesStock,a.percentMes,a.varmesMes,a.semvarmesStock      
--a.semafmesmes,      
,B.CLI,B.VARANUCLI,B.VARMESCLI,C.CLI_FE,C.VARANUCLI_FE,C.VARMESCLI_FE,c.VARDIA_FE, case when saldo=0 then 0 else cast(CLI_FE as float)/ saldo end percent_FE ,                      
case when varmesSaldo <0 then -1 when varmesSaldo>0 then 1 end semafvarmessaldo,                      
case when C.VARMESCLI_FE <0 then -1 when C.VARMESCLI_FE>0 then 1 end semafvarmesfondeobase,                      
case when B.VARMESCLI <0 then -1 when B.VARMESCLI>0 then 1 end semafvarmescliente                       
,case when a.semvarmesStock<0 then 1 when a.semvarmesStock>0 then -1 end senaftppstock                      
,case when a.semafmesmes<0 then 1 when a.semafmesmes>0 then -1 end semafmesmes   ,            
b.VARDICLI            
into #Presult    --select * from #Presult  drop table #Presult  
FROM #trf A  --select * from #trf                          
LEFT JOIN #BCLIPIVOT B    --select * from #BCLIPIVOT     select * from #BCLIPIVOT2                   
ON A.DESCRIPCION=B.DESCR  and a.style=b.style                        
left join #BCLIPIVOT2 c  --select * from #BCLIPIVOT2                          
ON A.DESCRIPCION=C.DESCR and a.style=c.style           
      
       
                           
--      
      
declare @FecMeta date          
declare @sql nvarchar(max)      
      
set @FecMeta=(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR  in(10116,10117,10118)   )          
        
declare @ProdCaptacionesMet varchar(250),@ProdCaptacionesMetM varchar(250)                              
set @ProdCaptacionesMet =(select case when @prod='AHORROS' then ('10116,10119')                              
           when @prod='CTS' THEN ('10117,10120')                              
      when @prod='PLAZO FIJO' THEN ('10118,10121')                              
           when @prod='TODOS' THEN ('10116,10117,10118,10119,10120,10121')                              
           END                              
       )                              
set @ProdCaptacionesMetM =(select case when @prod='AHORROS' then ('[10116],[10119]')                              
           when @prod='CTS' THEN ('[10117],[10120]')                              
           when @prod='PLAZO FIJO' THEN ('[10118],[10121]')                              
           when @prod='TODOS' THEN ('[10116],[10117],[10118],[10119],[10120],[10121]')                              
           END                              
    )         
           
      
create table #Met (hfecpro date null,hcodvar int null,htipcod int null,hcodrel varchar(250)null,hvalvar float null,rnivel varchar(50)null, DESCR varchar(250)null,style int null)                              
                               
set @SQL ='                              
with cte_a as (                              
select  hfecpro,hcodvar,htipcod,hcodrel,sum(hvalvar) hvalvar,''Nivel 1'' RNIVEL, '''+@DescNom+''' DESCR ,1 STYLE                              
from STORAGE.com.VDMCOM01                              
where HTIPCOD='+cast(@tip_cod as varchar(250))+'    and  hcodrel='''+cast(@cod_rel as varchar(250))+'''                           
and hfecpro=eomonth('''+cast(@FecMeta as varchar(250))+''')       and hcodvar IN ('+@ProdCaptacionesMet+')                               
group by  hfecpro,hcodvar,htipcod,hcodrel                              
),                               
cte_b as (                               
SELECT hfecpro,hcodvar,htipcod,hcodrel,sum(hvalvar) hvalvar,''Nivel 2'' RNIVEL                              
FROM STORAGE.com.VDMCOM01                               
WHERE HTIPCOD=case when '+cast(@tip_cod as varchar(250))+'=7 then  18                              
     when '+cast(@tip_cod as varchar(250))+'=18 then 17                               
     when '+cast(@tip_cod as varchar(250))+'=17 then 4                                
     when '+cast(@tip_cod as varchar(250))+'=4 then 16                              
   end                               
and hfecpro=eomonth('''+cast(@FecMeta as varchar(250))+''') and hcodvar IN ('+@ProdCaptacionesMet+')                           
                                      
group by hfecpro,hcodvar,htipcod,hcodrel                              
),                              
cte_b_ as (                              
select a.*,B.RDESC,0 STYLE                                 
from cte_b a                              
INNER JOIN (select * from #JERAR where rnivel=''Nivel 2'') B --DROP TABLE #JERAR                              
ON A.HCODREL=B.RCOD                              
),                              
cte_c as (                              
SELECT hfecpro,hcodvar,htipcod,hcodrel,sum(hvalvar) hvalvar,''Nivel 3'' RNIVEL                              
FROM STORAGE.com.VDMCOM01                               
WHERE HTIPCOD=case when '+cast(@tip_cod as varchar(250))+'=7 then  17                              
     when '+cast(@tip_cod as varchar(250))+'=18 then 16                               
     when '+cast(@tip_cod as varchar(250))+'=16 then 16                                
   end                               
and hfecpro=eomonth('''+cast(@FecMeta as varchar(250))+''')    and hcodvar IN ('+@ProdCaptacionesMet+')                              
group by hfecpro,hcodvar,htipcod,hcodrel                              
),                              
cte_c_ as (                              
select a.*,B.RDESC,0 STYLE                                
from cte_c a                              
INNER JOIN (select * from #JERAR where rnivel=''Nivel 3'') B --DROP TABLE #JERAR                              
ON A.HCODREL=B.RCOD                              
),                              
cte_u as (                              
select * from cte_a                               
union all                              
select  * from cte_b_                              
union all                              
select * from cte_c_                              
)                              
select * from cte_u                              
'                              
insert into #Met                              
exec(@SQL)                    
      
create table #M (hfecpro date null, style int null,descr varchar(250)null,HMSP FLOAT NULL, HMSM FLOAT NULL)         
if @prod<>'TODOS'                              
BEGIN                                
set @sql ='                                 
;with cte_a as (                              
SELECT HFECPRO,STYLE,DESCR,'+@ProdCaptacionesMetM+'                              
                               
FROM                 
(                              
  SELECT HFECPRO,STYLE,DESCR,hcodvar, hvalvar                                 
  FROM #Met                              
) AS SourceTable                                
PIVOT                                
(                                
  sum(hvalvar)                                
  FOR hcodvar  IN ( '+@ProdCaptacionesMetM+')                                
) AS PivotTable                                
 )                                 
                               
 select * from cte_a                              
'                              
                   
INSERT INTO #M  --select * from #T_                              
exec(@sql)                               
 end         
if @prod='TODOS'                              
BEGIN                                
set @sql ='                                 
;with cte_a as (                              
SELECT HFECPRO,STYLE,DESCR,'+@ProdCaptacionesMetM+'                              
                               
FROM                                
(                              
  SELECT HFECPRO,STYLE,DESCR,hcodvar, hvalvar                                 
  FROM #Met                              
) AS SourceTable                                
PIVOT                                
(                                
  sum(hvalvar)                                
  FOR hcodvar  IN ( '+@ProdCaptacionesMetM+')                                
) AS PivotTable                                
 ),                              
CTE_B AS (                              
SELECT  HFECPRO,STYLE,DESCR,isnull([10116],0)+isnull([10117],0)+isnull([10118],0) HMSP , isnull([10119],0)+isnull([10120],0)+isnull([10121],0) HMSM                              
FROM CTE_A                              
)                                 
 select * from CTE_B                              
 '                        
INSERT INTO #M  --select * from #T_                              
exec(@sql)                               
 end          
      
alter table #Presult add metasaldopuntual float null,varsaldometapuntual float null      
      
update a      
set a.metasaldopuntual=b.HMSP       
from #Presult a       
inner join #M b      
on a.descripcion=b.descr       
      
update #Presult set varsaldometapuntual= saldo - metasaldopuntual      
      
select distinct * from #Presult      
                               
end
