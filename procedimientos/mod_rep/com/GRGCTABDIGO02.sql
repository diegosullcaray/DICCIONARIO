-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-11-29 16:11:19.073000
--exec [com].[GRGCTABDIGO02] 7,'231','20230331'                                                                
CREATE  PROCEDURE [com].[GRGCTABDIGO02]                                                                                    
 @tip_cod int,                                                                                        
 @cod_rel varchar(20),                                                                                    
 @fec date                                                                                   
 as                                                                                    
begin                                                                                    
  SET NOCOUNT ON;  
     
--declare @fec varchar(50)='20230331',@tip_cod int =7,@cod_rel varchar(250)='231',@prod varchar(50)='TODOS'   
declare @prod varchar(50)='TODOS',@fec1 varchar(250)              
  ------------                  
  set @fec1=(select max(RFEC) from [storage].[ref].[RCALEN001] where rfec<=@fec and RDIAFER=0)  
   
 declare @defs as rep.TTHCOLDEF                                                                          
 insert into @defs                                                                            
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,TROWS,TCOLS)  values                                                                           
 (1,1,1,'descripcion','Descripción','string',null,'20px',2,null),                                                                            
 (2,2,1,'CLI_NET_1','Clientes Totales','number',null,null,2,null),                   
 (3,null,1,'2','Enrolamiento','number',null,null,1,4),                         
 (4,null,1,'3','Usabilidad','number',null,null,1,4) ,                         
  --(5,null,1,'4','Huella Digital','number',null,null,1,3),                                  
                               
 (6,2,2,'CLI_ENBO_1','# Enrolados','number',null,null,1,1),     
 (7,3,2,'PERCENT_ENRO','% Enrolados','number',null,null,1,1),    
 (8,4,2,'MHNUMENROLADO','Meta de Enrolamiento %','number',null,null,1,1),    
 (9,5,2,'AVENROLA','Avance de Enrolamiento','number',null,null,1,1),         
   
 (10,6,2,'CLI_USAB_1','# Usabilidad','number',null,null,1,1),     
 (11,7,2,'PERCENT_USA','% Usabilidad','number',null,null,1,1),    
 (12,8,2,'MHNUMUSA','Meta de Usabilidad %','number',null,null,1,1),    
 (13,9,2,'AVUSA','Avance de Usabilidad','number',null,null,1,1)      
   
 /*,(14,10,2,'CLI_HDV_1','Registro por huella de voz','number',null,null,1,1),     
 (15,11,2,'MHNUMHV','Meta de registros por huella de voz','number',null,null,1,1),    
 (16,12,2,'AVHV','Avance de huella de voz','number',null,null,1,1)                                    
   */
select rep.FFTHCOLDEF(@defs) result;  


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
union all            
select DISTINCT CASE WHEN @tip_cod=7 then CAST(RCODMAC AS VARCHAR(250))               
   when @tip_cod=18 then CAST(RCODMAT AS VARCHAR(250))                
   when @tip_cod=17 then CAST(RCODAGEH  AS VARCHAR(250))                
   when @tip_cod=4 then CAST(RCODAGEH AS VARCHAR(250))   END RCOD,            
   CASE WHEN @tip_cod=7 then RDESMAC               
   when @tip_cod=18 then RDESMAT                
   when @tip_cod=17 then RDESAGEH                
   when @tip_cod=4 then RDESAGEH END RDESC,'Nivel 3' RNIVEL            
             
from  storage.ref.VJERCOR04            
where              
case when @tip_cod=18 then  ISNULL(cast(RCODMAC as nvarchar(10)),'9999')                               
     when @tip_cod=17 then cast(RCODMAT as nvarchar(10))                            
     when @tip_cod=4 then CAST(RCODAGEH  as nvarchar(10))             
      when @tip_cod=16 then CAST(RCODAGEH as nvarchar(10)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)          
---------------
 
  
select hfecpro,htipcod,hcodrel,1 STYLE ,@DescNom DESCR,SUM(HNUMCLINET)HNUMCLINET,SUM(HNUMUSAB)HNUMUSAB,sum(HTIPCRED)HTIPCRED,sum(HTIPPASI)HTIPPASI,sum(HTIPAMBO)HTIPAMBO ,sum(HTIPFALT)HTIPFALT
into #CliNetUsab  --SELECT * FROM #SalMedio         
from storage.[com_act].WUSABCLIENR001 --select * from storage.[com_act].WUSABCLIENR001 WHERE HTIPCOD=7  TRUNCATE TABLE  STORAGE.[com_act].[WUSABCLIENR001]  
where hfecpro=@fec and htipcod=@TIP_COD and hcodrel=@cod_rel
group by hfecpro,htipcod,hcodrel    
union all            
select hfecpro,htipcod,hcodrel,0 style,B.RDESC,SUM(HNUMCLINET)HNUMCLINET,SUM(HNUMUSAB)HNUMUSAB,sum(HTIPCRED)HTIPCRED,sum(HTIPPASI)HTIPPASI,sum(HTIPAMBO)HTIPAMBO ,sum(HTIPFALT)HTIPFALT
from storage.[com_act].WUSABCLIENR001 A            
INNER JOIN (select * from #JERAR where rnivel='Nivel 2') B --DROP TABLE #JERAR            
ON A.HCODREL=B.RCOD            
where htipcod =case when @tip_cod=7 then 18            
        when @tip_cod=18 then 17            
        when @tip_cod=17 then 4             
        when @tip_cod=4 then 16            
            
         end      
AND hfecpro=@fec        
group by hfecpro,htipcod,hcodrel,b.rdesc

union all 		         
select hfecpro,htipcod,hcodrel,0 style,b.rdesc,SUM(HNUMCLINET)HNUMCLINET,SUM(HNUMUSAB)HNUMUSAB,sum(HTIPCRED)HTIPCRED,sum(HTIPPASI)HTIPPASI,sum(HTIPAMBO)HTIPAMBO ,sum(HTIPFALT)HTIPFALT
from storage.[com_act].WUSABCLIENR001 A            
INNER JOIN (select * from #JERAR where rnivel='Nivel 3') B            
ON A.HCODREL=B.RCOD            
where htipcod =case when @tip_cod=7 then 17            
					when @tip_cod=18 then 4            
					when @tip_cod=17 then 4            
					when @tip_cod=4 then 16            
					when @tip_cod=16 then 16            
              end
AND hfecpro=@fec    
group by hfecpro,htipcod,hcodrel,b.rdesc


--drop table #JERAR,#CliEnrolado,#CliNetUsab,#D_

--select * from #CliNetUsab
 
select hfecpro,htipcod,hcodrel,style,descr,HNUMCLINET CLI_NET_1,HTIPCRED+HTIPPASI+HTIPAMBO+HTIPFALT  CLI_ENBO_1 ,
(HTIPCRED+HTIPPASI+HTIPAMBO+HTIPFALT) / HNUMCLINET PERCENT_ENRO, null MHNUMENROLADO, null AVENROLA,
HNUMUSAB CLI_USAB_1,HNUMUSAB/ (HTIPCRED+HTIPPASI+HTIPAMBO+HTIPFALT) PERCENT_USA ,null MHNUMUSA,null AVUSA
into #TR
from #CliNetUsab

declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                            
            --exec STORAGE.[com_pas].[PSLSDPS010] '20230218'                
 insert into @tvars values                             
 ('CLI_NET',null,null,null,null,null)                     
                             
 insert into @tfil                            
 values                            
 ('todos','fec','"'+cast(@fec1 as varchar(50))+'"')                
                
 if @prod<>'TODOS'                
 begin                
 insert into @tfil                  
 values('TODOS','prod_capt','"'+@prod+'"')         
 end                          
                            
 --declare @tip_cod int=15,@cod_rel varchar(100)='2'                            
 declare @jer varchar(100);                          
 insert into @tfil                    
 exec piv.GPIVLEV06 @tip_cod,@cod_rel,@jer output                            
                            
 insert into @tconf                            
 values   
 ('level_alias','style'),                
 ('fec_corr','true'),('insert_to', '#RESULTPIV')                              
                      
  create table #RESULTPIV       --select * from #RESULTPIV                  
 (                
 fila int null,cod_fc varchar(250)null, cod_cter_capt_m  varchar(250)null,cod_ccor_capt_m varchar(250)null, style int null,                
 descripcion varchar(250)null,    
 CLI_ENBO_1 int null 
 )           
                      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1                            
   
       select a.style,a.descripcion,b.HNUMCLINET CLI_NET_1,HTIPCRED+HTIPPASI+HTIPAMBO+HTIPFALT  CLI_ENBO_1 ,
 cast((HTIPCRED+HTIPPASI+HTIPAMBO+HTIPFALT) as float) / HNUMCLINET PERCENT_ENRO, null MHNUMENROLADO, null AVENROLA,
  HNUMUSAB CLI_USAB_1, cast(HNUMUSAB as float)/ (HTIPCRED+HTIPPASI+HTIPAMBO+HTIPFALT) PERCENT_USA ,null MHNUMUSA,null AVUSA 
 from #RESULTPIV a
  left join #CliNetUsab b
  on a.descripcion=b.descr 
    
	/*        DESCOMENTAR AQUI           
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                            
            --exec STORAGE.[com_pas].[PSLSDPS010] '20230218'                
 insert into @tvars values                             
 ('CLI_NET',null,null,null,null,null),                
 ('CLI_ENBO',null,null,null,null,null),  
 ('CLI_USAB',null,null,null,null,null), ---       
 ('CLI_HDV',null,null,null,null,null)                      
                             
 insert into @tfil                            
 values                            
 ('todos','fec','"'+cast(@fec1 as varchar(50))+'"')                
                
 if @prod<>'TODOS'                
 begin                
 insert into @tfil                  
 values('TODOS','prod_capt','"'+@prod+'"')         
 end                          
                            
 --declare @tip_cod int=15,@cod_rel varchar(100)='2'                            
 declare @jer varchar(100);                          
 insert into @tfil                    
 exec piv.GPIVLEV06 @tip_cod,@cod_rel,@jer output                            
                            
 insert into @tconf                            
 values   
 ('level_alias','style'),                
 ('fec_corr','true'),('insert_to', '#RESULTPIV')                              
                      
  create table #RESULTPIV       --select * from #RESULTPIV                  
 (                
 fila int null,cod_fc varchar(250)null, cod_cter_capt_m  varchar(250)null,cod_ccor_capt_m varchar(250)null, style int null,                
 descripcion varchar(250)null,    
 CLI_ENBO_1 int null,  
 CLI_NET_1  int null,  
 CLI_USAB_1 int null,  
 CLI_HDV_1 INT NULL  
 )           
                      
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1                            
   
   
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
union all              
select DISTINCT CASE WHEN @tip_cod=7 then CAST(RCODMAC AS VARCHAR(250))                 
   when @tip_cod=18 then CAST(RCODMAT AS VARCHAR(250))                  
   when @tip_cod=17 then CAST(RCODAGEH  AS VARCHAR(250))                  
   when @tip_cod=4 then CAST(RCODAGEH AS VARCHAR(250))   END RCOD,              
   CASE WHEN @tip_cod=7 then RDESMAC                 
   when @tip_cod=18 then RDESMAT                  
   when @tip_cod=17 then RDESAGEH                  
   when @tip_cod=4 then RDESAGEH END RDESC,'Nivel 3' RNIVEL              
               
from  storage.ref.VJERCOR04              
where                
case when @tip_cod=18 then  ISNULL(cast(RCODMAC as nvarchar(10)),'9999')                                 
     when @tip_cod=17 then cast(RCODMAT as nvarchar(10))                              
     when @tip_cod=4 then CAST(RCODAGEH  as nvarchar(10))               
      when @tip_cod=16 then CAST(RCODAGEH as nvarchar(10)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)               
              
create table #Met (hfecpro date null,hcodvar int null,htipcod int null,hcodrel varchar(250)null,hvalvar float null,rnivel varchar(50)null, DESCR varchar(250)null,style int null)              
                
 declare @TabdigOpeMeta varchar(250), @FecMeta date,@SQL nvarchar(max),@TabdigOpeMeta_ varchar(250)   
 set @FecMeta=(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR  in(10226,10227,10228) and hfecpro=eomonth(@fec1) )   
 set @TabdigOpeMeta='10226,10227,10228'  
 set @TabdigOpeMeta_ ='[10226],[10227],[10228]'  
   
 set @SQL ='              
with cte_a as (              
select  hfecpro,hcodvar,htipcod,hcodrel,sum(hvalvar) hvalvar,''Nivel 1'' RNIVEL, '''+@DescNom+''' DESCR ,1 STYLE              
from STORAGE.com.VDMCOM01              
where HTIPCOD='+cast(@tip_cod as varchar(250))+'    and  hcodrel='''+cast(@cod_rel as varchar(250))+'''           
and hfecpro=eomonth('''+cast(@FecMeta as varchar(250))+''')       and hcodvar IN ('+@TabdigOpeMeta+')               
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
and hfecpro=eomonth('''+cast(@FecMeta as varchar(250))+''') and hcodvar IN ('+@TabdigOpeMeta+')              
                              
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
and hfecpro=eomonth('''+cast(@FecMeta as varchar(250))+''')    and hcodvar IN ('+@TabdigOpeMeta+')              
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
  
create table #M (hfecpro date null, style int null,descr varchar(250)null,HNUMENROLADO FLOAT NULL, HNUMUSA FLOAT NULL,HNUMHV FLOAT NULL)     
set @sql ='                 
;with cte_a as (              
SELECT HFECPRO,STYLE,DESCR,'+@TabdigOpeMeta_+'              
               
FROM                
(              
  SELECT HFECPRO,STYLE,DESCR,hcodvar, hvalvar                 
  FROM #Met              
) AS SourceTable                
PIVOT                
(                
  sum(hvalvar)                
  FOR hcodvar  IN ( '+@TabdigOpeMeta_+')                
) AS PivotTable                
 )                 
               
 select * from cte_a              
'              
               
INSERT INTO #M  --select * from #T_              
exec(@sql)   
    
 if @tip_cod<>4  
 begin  
 select   A.style,descripcion,format(CLI_NET_1,'N0','en-US')CLI_NET_1,  
 format(CLI_ENBO_1,'N0','en-US') CLI_ENBO_1,format(( case when CLI_NET_1=0 then 0 else CAST(CLI_ENBO_1 AS FLOAT)/CLI_NET_1 end),'P') PERCENT_ENRO,  
 format(CLI_USAB_1,'N0','en-US')CLI_USAB_1,format((case when CLI_ENBO_1=0 then  0 else CAST(CLI_USAB_1 AS FLOAT)/CLI_ENBO_1 end),'P') PERCENT_USA,  
 format(CLI_HDV_1,'N0','en-US') CLI_HDV_1,  
 format(B.HNUMENROLADO,'N0','en-US') MHNUMENROLADO,  
 format(B.HNUMUSA,'N0','en-US') MHNUMUSA,  
 format(B.HNUMHV ,'N0','en-US') MHNUMHV,  
 format((case when B.HNUMENROLADO=0 then 0 else CLI_ENBO_1/B.HNUMENROLADO end),'P') AS AVENROLA,  
 format((case when B.HNUMUSA=0 then 0 else CLI_USAB_1/B.HNUMUSA end),'P') AVUSA,  
 format((case when B.HNUMHV=0 then 0 else CLI_HDV_1/B.HNUMHV end),'P') AVHV  
 from #RESULTPIV A  
 LEFT JOIN #M  B       
 ON A.descripcion=B.descr   
 end  
 else  
 begin  
 select   A.style,descripcion,format(CLI_NET_1,'N0','en-US')CLI_NET_1,  
 format(CLI_ENBO_1,'N0','en-US') CLI_ENBO_1,format(( case when CLI_NET_1=0 then 0 else CAST(CLI_ENBO_1 AS FLOAT)/CLI_NET_1 end),'P') PERCENT_ENRO,  
 format(CLI_USAB_1,'N0','en-US')CLI_USAB_1,format((case when CLI_ENBO_1=0 then  0 else CAST(CLI_USAB_1 AS FLOAT)/CLI_ENBO_1 end),'P') PERCENT_USA,  
 format(CLI_HDV_1,'N0','en-US') CLI_HDV_1,  
 format(B.HNUMENROLADO,'N0','en-US') MHNUMENROLADO,  
 format(B.HNUMUSA,'N0','en-US') MHNUMUSA,  
 format(B.HNUMHV ,'N0','en-US') MHNUMHV,  
 format((case when B.HNUMENROLADO=0 then 0 else CLI_ENBO_1/B.HNUMENROLADO end),'P') AS AVENROLA,  
 format((case when B.HNUMUSA=0 then 0 else CLI_USAB_1/B.HNUMUSA end),'P') AVUSA,  
 format((case when B.HNUMHV=0 then 0 else CLI_HDV_1/B.HNUMHV end),'P') AVHV  
 from #RESULTPIV A  
 LEFT JOIN #M  B       
 ON a.style=b.style and A.descripcion=B.descr   
 end  
 --order by a.style desc  
 
  DESCOMENTAR AQUI
 */
   
 end
