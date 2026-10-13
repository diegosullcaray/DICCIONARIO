-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-05-14 09:17:52.177000
--exec [com].[RSRDFCA036] 7,'231','20240511','TODOS','TODOS'                  
CREATE PROCEDURE [com].[RSRDFCA036]                      
@tip_cod int,@cod_rel varchar(20),@fec varchar(10)='20240511'  ,@prod varchar(250),@segmento varchar(250)              
AS                          
BEGIN                          
 SET NOCOUNT ON;                     
  
 --declare @fec varchar(50)='20230928',@tip_cod int =7,@cod_rel varchar(250)='231'   ,@prod VARCHAR(250)='TODOS'               
  ------------                    
  declare @fecs varchar(max)                  
  select* into #FECS from storage.util.FVECFEC01(@fec,'cmg_4,cie_ant,hoy') --select * from #FECS                  
                  
  declare @fec1 varchar(10),@fec2 varchar(10),@fec3 varchar(10)                  
set @fec1 =(select rfec from #fecs where rord=1)                  
set @fec2 =(select rfec from #fecs where rord=2)                  
set @fec3 =(select rfec from #fecs where rord=3)                  
                  
declare @defs as rep.TTHCOLDEF;                      
  insert into @defs                      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS)  values                      
 (1,1,1,'descripcion','Descripci n','string',null,1,2)                      
                  
 insert into @defs                      
 (TORDER,TLEV,TKEY,TDESC,TCOLS) values                       
 (2,1,'m_SP','Saldo Puntual',9),                  
 (3,1,'m_SPSM','Saldo Medio',9)                  
                   
  insert into @defs                      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS,TCOLS,thidden)  values                      
 (20,20,1,'numcli_pas_caract_NL_3','Clientes','number','.0-0',null,2,null,null)   ,                  
 (21,21,1,'15','','traffic-light',NULL,null,2,null,1),                  
 (22,22,1,'dif_clientes','Var. Clientes','number','.0-0',null,2,2,null)                    
                  
 insert into @defs                      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,thidden,TCOLS)  values                      
 (2,2,2,'monto_pas_caract_NL_1',@fec1,'number',NULL,null,null)   ,                  
 (3,3,2,'monto_pas_caract_NL_2',@fec2,'number',NULL,null,null) ,                   
 (4,4,2,'monto_pas_caract_NL_3',@fec3,'number',NULL,null,null),                    
 (5,5,2,'metasaldo','Meta','number',null,null,null),                  
 (6,6,2,'8','','traffic-light',NULL,1,null),                  
 (7,7,2,'TMMSALDO','TMM','number',NULL,null,2),                  
 (8,8,2,'10','','traffic-light',NULL,1,null),                  
 (9,9,2,'TFMSALDO','TFM','number',NULL,null,2),                  
 (10,10,2,'VARMETS','Distancia Meta','number',NULL,null,null),                  
 ---------------------------------------------------------------                  
 (11,11,2,'A1',@fec1,'number',NULL,null,null)   ,                  
 (12,12,2,'A2',@fec2,'number',NULL,null,null) ,                   
 (13,13,2,'A3',@fec3,'number',NULL,null,null),                    
 (14,14,2,'metasaldoM','Meta',null,'.0-0',null,null),                  
 (15,15,2,'9','','traffic-light',NULL,1,null),                  
 (16,16,2,'TMMSM','TMM','number',NULL,null,2),                  
 (17,17,2,'11','','traffic-light',NULL,1,null),                  
 (18,18,2,'TFMSM','TFM','number',NULL,null,2)                  
 ,(19,19,2,'VARMETSM','Distancia Meta','number',NULL,null,null)                  
                  
                   
 select rep.FFTHCOLDEF(@defs) hdefs ;                     
                   
                  
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')                  
from #FECS                  
                        
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF                              
            --exec STORAGE.[com_pas].[PSLSDPS010] '20230218'                  
 
if @segmento='TODOS'
 begin
 insert into @tvars values                               
 ('monto_pas_caract_NL',null,null,null,null,null)  
 end

 if @segmento='Mujer'
 begin
 insert into @tvars values                               
 ('monto_pas_muj_caract_NL',null,'monto_pas_caract_NL',null,null,null) 
 end
 if @segmento='Rural'
 begin
  insert into @tvars values                               
 ('monto_pas_rur_caract_NL',null,'monto_pas_caract_NL',null,null,null) 
 end 
 if @segmento='Urbano'
 begin
 insert into @tvars values                               
 ('monto_pas_urb_caract_NL',null,'monto_pas_caract_NL',null,null,null) 
 end
                               
 insert into @tfil                              
 values                              
 ('todos','fec',@fecs)                  
                  
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
 ('fec_corr','true')   ,('insert_to', '#RESULTPIV')                               
                  
 create table #RESULTPIV       --select * from #RESULTPIV                    
 (                  
 fila int null,cod_fc varchar(250)null, cod_cter_capt_m  varchar(250)null,cod_ccor_capt_m varchar(250)null, style int null,                  
 descripcion varchar(250)null,                  
monto_pas_caract_NL_1 float null,                  
monto_pas_caract_NL_2 float null,                  
monto_pas_caract_NL_3 float null                    
 )                                 
                           
                            
                        
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1                              
      
    --  select * from #RESULTPIV
                  
 /* Saldo Medio */                  
                   
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
                  
select hfecpro,htipcod,hcodrel hcodrel,RDESCPROD02,sum(hsalmedmn)hsalmedmn, @DescNom DESCR ,1 STYLE                  
into #SalMedio_  --SELECT * FROM #SalMedio                  
from storage.com_pas.WJAS004                   
where htipcod=@tip_cod  and hcodrel=@cod_rel and hfecpro in(select rfec from #FECS) AND RDESCPROD02 IS NOT NULL                  
--AND RDESCPROD02=@prod                  
and RDESCPROD02 like CASE WHEN @prod='TODOS' then '%%' else @prod+'%' end                     
group by hfecpro,htipcod,hcodrel,RDESCPROD02                  
union all                  
select hfecpro,htipcod,hcodrel,RDESCPROD02,sum(hsalmedmn)hsalmedmn,B.RDESC,0 STYLE                    
from storage.com_pas.WJAS004 A                  
INNER JOIN (select * from #JERAR where rnivel='Nivel 2') B --DROP TABLE #JERAR                  
ON A.HCODREL=B.RCOD                  
where htipcod =case when @tip_cod=7 then 18                  
        when @tip_cod=18 then 17                  
        when @tip_cod=17 then 4                   
        when @tip_cod=4 then 16                  
                  
         end                    
and hfecpro in(select rfec from #FECS)                  
--AND RDESCPROD02=@prod                  
and RDESCPROD02 like CASE WHEN @prod='TODOS' then '%%' else @prod+'%' end                     
group by  hfecpro,htipcod,hcodrel,B.RDESC,RDESCPROD02                  
---                  
union all                  
select hfecpro,htipcod,hcodrel,RDESCPROD02,sum(hsalmedmn)hsalmedmn,B.RDESC,0 STYLE                    
from storage.com_pas.WJAS004 A                  
INNER JOIN (select * from #JERAR where rnivel='Nivel 3') B                  
ON A.HCODREL=B.RCOD                  
where htipcod =case when @tip_cod=7 then 17                  
     when @tip_cod=18 then 4                  
        when @tip_cod=17 then 4                  
        when @tip_cod=4 then 16                  
        when @tip_cod=16 then 16                  
                  
         end                    
and hfecpro in(select rfec from #FECS)                  
--AND RDESCPROD02=@prod                  
and RDESCPROD02 like CASE WHEN @prod='TODOS' then '%%' else @prod+'%' end                     
group by  hfecpro,htipcod,hcodrel,B.RDESC,RDESCPROD02                  
         
SELECT  DISTINCT HFECPRO,HTIPCOD,hcodrel,RDESCPROD02,hsalmedmn,DESCR,STYLE           
INTO #SalMedio FROM #SalMedio_         
                  
create table #T_ (hfecpro date null,style int null,descr varchar(250)null,prod float null,rord int null)                  
                  
DECLARE @PROD2 varchar(max)                  
set @PROD2 =(select case when @prod='TODOS' then '[AHORROS],[CTS],[PLAZO FIJO]' ELSE '['+@prod+']' END)                  
                    
declare @sql nvarchar(max)      --exec storage.[com_pas].[CWWJAS004]  '20230125'                  
if @prod<>'TODOS'                  
BEGIN                  
set @sql ='                     
;with cte_a as (                  
SELECT HFECPRO,STYLE,DESCR,'+@PROD2+'                  
                   
FROM                    
(                  
  SELECT HFECPRO,STYLE,DESCR,RDESCPROD02, hsalmedmn                     
  FROM #SalMedio                  
) AS SourceTable                    
PIVOT                    
(                    
  sum(hsalmedmn)                    
  FOR RDESCPROD02 IN ( '+@PROD2+')                    
) AS PivotTable                    
 )                     
,                  
cte_b as (                  
select a.*,b.rord from cte_a  a                  
left join #FECS b                  
on a.hfecpro=b.rfec --select top 5 * from #FECS                  
)                  
 select * from cte_b                  
'                  
                   
INSERT INTO #T_                  
exec(@sql)                   
END                  
                  
if @prod='TODOS'                  
BEGIN                  
set @sql ='                     
;with cte_a as (                  
SELECT HFECPRO,STYLE,DESCR,'+@PROD2+'                  
                   
FROM                    
(                  
  SELECT HFECPRO,STYLE,DESCR,RDESCPROD02, hsalmedmn                     
  FROM #SalMedio  ---SELECT * FROM #SalMedio                  
) AS SourceTable                    
PIVOT                    
(                    
  sum(hsalmedmn)                    
  FOR RDESCPROD02 IN ( '+@PROD2+')                    
) AS PivotTable                    
 )                     
,                  
cte_c as (           
SELECT HFECPRO, STYLE,DESCR, valores, rords                   
FROM                     
   (SELECT HFECPRO, STYLE,DESCR                    
   ,AHORROS,CTS,[PLAZO FIJO]                  
   FROM cte_a) p   --SELECT * FROM #RESULTPIV                  
UNPIVOT                    
   (valores FOR RORDS IN                     
      (AHORROS,CTS,[PLAZO FIJO])                    
)AS unpvt                   
),                  
cte_b as (                  
select a.*,b.rord from cte_c  a                  
left join #FECS b                  
on a.hfecpro=b.rfec --select top 5 * from #FECS                  
)                   
 select HFECPRO,STYLE,DESCR,valores,rord from cte_b                  
'                  
                   
INSERT INTO #T_                  
exec(@sql)             
END                  
                  
--SELECT * FROM #SalMedio                  
                  
CREATE TABLE #TD       
(                  
style int null,                  
descr varchar(250)null,                  
A1 float null,                    
A2 float null,                    
A3 float null                   
)                  
                  
declare  @Query nvarchar(max)                                                                
SET @Query                                                                
= N'SELECT   STYLE,DESCR ' + NCHAR(10)                                                                                   
 + ( SELECT REPLACE( N',SUM(CASE WHEN RORD = <<RORD>> THEN prod  END) AS A<<RORD>>', N'<<RORD>>', RORD)+ NCHAR(10)                                                                                                                  
    FROM  #T_                                                                                                         
    GROUP BY RORD                                                                                             
    ORDER BY RORD                                                                                            
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                                  
 + N'FROM #T_                                                                   
 group by STYLE,DESCR  '                                                                        
                  
insert into #TD                                                                                             
EXEC sp_Executesql @Query;                   
                  
;WITH CTE_A_ as (                  
SELECT fila, cod_fc,cod_cter_capt_m,cod_ccor_capt_m,style,descripcion                   
   ,monto_pas_caract_NL_1,monto_pas_caract_NL_2,monto_pas_caract_NL_3                
   FROM #RESULTPIV),                  
CTE_A  AS (                  
 SELECT fila, cod_fc,cod_cter_capt_m,cod_ccor_capt_m,style,descripcion , replace(RORD,'monto_pas_caract_','') RORD, valores,9510 VARIABLES                    
FROM                     
   (SELECT fila, cod_fc,cod_cter_capt_m,cod_ccor_capt_m,style,descripcion                   
   ,monto_pas_caract_NL_1,monto_pas_caract_NL_2,monto_pas_caract_NL_3                
   FROM CTE_A_) p   --SELECT * FROM #RESULTPIV                  
UNPIVOT                    
   (valores FOR RORD IN                     
      (monto_pas_caract_NL_1,monto_pas_caract_NL_2,monto_pas_caract_NL_3)                    
)AS unpvt                   
),                  
cte_b as (                    
SELECT a.fila, a.cod_fc,a.cod_cter_capt_m,a.cod_ccor_capt_m,a.style,a.descripcion ,                  
case when concat(A.RORD,'-',B.RORD) ='3-1' then 8                              
     when concat(A.RORD,'-',B.RORD) ='3-2' then 10                  
  when concat(A.RORD,'-',B.RORD) ='5-4' then 15   end RORD ,        
cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR                    
FROM CTE_A A                  
join CTE_A B                      
on A.variables=B.variables    and a.descripcion=b.descripcion                  
where concat(A.RORD,'-',B.RORD) in('3-1','3-2','5-4')                   
)                  
SELECT fila, cod_fc,cod_cter_capt_m,cod_ccor_capt_m,style,descripcion, [8] AS [8], [10] AS [10],[15] AS [15]  into #SemSaldo                   
FROM                     
(SELECT SVALOR, RORD, fila,cod_fc,cod_cter_capt_m,cod_ccor_capt_m,style,descripcion                    
FROM cte_b) p                    
PIVOT                    
(                    
max (SVALOR)                    
FOR RORD IN                    
( [8], [10],[15] )                    
) AS pvt   ;                   
                  
                  
;WITH CTE_A AS (                  
 SELECT style,descr descripcion, replace(RORD,'A','') RORD, valores,9560 VARIABLES                    
FROM                     
   (SELECT style,descr,A1,A2,A3                  
   FROM #TD) p   --select * from #TD                  
UNPIVOT         
   (valores FOR RORD IN                     
      (A1,A2,A3 )                    
)AS unpvt                   
),                  
cte_b as (                    
SELECT A.style,A.descripcion,                  
case when concat(A.RORD,'-',B.RORD) ='3-1' then 9                              
            when concat(A.RORD,'-',B.RORD) ='3-2' then 11   end RORD ,                  
cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR                    
FROM CTE_A A             
join CTE_A B                      
on A.variables=B.variables    and a.descripcion=b.descripcion                  
where concat(A.RORD,'-',B.RORD) in('3-1','3-2')                   
)                  
SELECT style,descripcion, [9] AS [9], [11] AS [11]  into #SemSaldoMedio                   
FROM                     
(SELECT SVALOR, RORD, style,descripcion                    
FROM cte_b) p                    
PIVOT                    
(                    
max (SVALOR)                    
FOR RORD IN                    
( [9], [11] )                    
) AS pvt   ;                    
                  
                    
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
                          
declare @FecMeta date                   
set @FecMeta=(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR  in(10116,10117,10118,10119,10120,10121) )                   
                  
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
      /*            
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
 */         
    
create table #Jer (HTIPCOD INT null,HCODREL VARCHAR(250)NULL, HDESC VARCHAR(MAX) NULL, STYLE INT NULL)    
    
select * into #VJERCOR04 from storage.ref.VJERCOR04  --select * from #VJERCOR04    
    
IF @tip_cod=7 AND @COD_REL='231'    
BEGIN    
    
INSERT INTO #Jer  --DROP TABLE #Jer    
SELECT 7 HTIPCOD,'231' HCODREL,'FINANCIERA CONFIANZA' HDESC,1 style    
union all    
select distinct 18,RCODTER,RDESTER ,0     
from #VJERCOR04    
union all    
select distinct 17,RCODMAC ,RDESMAC  ,0    
from #VJERCOR04    
UNION ALL    
SELECT 7 HTIPCOD,'9999' HCODREL,'SIN ASIGNAR' HDESC,1 style    
    
END    
IF @TIP_COD<>7 AND @COD_REL<>'231'    
begin    
    
INSERT INTO #Jer --SELECT * FROM #Jer    
SELECT DISTINCT @tip_cod HTIPCOD,    
  CASE WHEN @tip_cod=18 THEN RCODTER      
    WHEN @tip_cod=17 THEN RCODMAC       
    WHEN @tip_cod=4 THEN RCODMAT     
    WHEN @tip_cod=16 THEN RCODAGEH     
 END HCODREL,    
  CASE WHEN @tip_cod=18 THEN RDESTER      
    WHEN @tip_cod=17 THEN RDESMAC       
    WHEN @tip_cod=4 THEN RDESMAT     
    WHEN @tip_cod=16 THEN RDESAGEH     
 END HDESC , 1 STYLE    
FROM #VJERCOR04 --SELECT * FROM #VJERCOR04  WHERE RCODMAT=214    
WHERE CASE WHEN @tip_cod=7 THEN RCODFC     
     WHEN @tip_cod=18 THEN RCODTER     
     WHEN @tip_cod=17 THEN RCODMAC      
     WHEN @tip_cod=4 THEN RCODMAT       
     WHEN @tip_cod=16 THEN RCODAGE        
  END=@COD_REL    
UNION ALL    
SELECT  DISTINCT CASE WHEN @tip_cod=17 THEN 4 WHEN @tip_cod=4 THEN 16 END HTIPCOD,    
CASE WHEN @tip_cod=18 THEN RCODMAC     
  WHEN @tip_cod=17 THEN RCODMAT      
  WHEN @tip_cod=4 THEN RCODAGEH    
  WHEN @tip_cod=16 THEN RCODAGEH    
  END HCODREL,     
CASE WHEN @tip_cod=18 THEN RDESMAC     
  WHEN @tip_cod=17 THEN RDESMAT      
  WHEN @tip_cod=4 THEN RDESAGEH     
  WHEN @tip_cod=16 THEN RDESAGEH     
  END HDESC,0 STYLE    
FROM #VJERCOR04  --SELECT * FROM #VJERCOR04 WHERE RCODMAT=214    
WHERE CASE WHEN @tip_cod=7 THEN RCODFC     
     WHEN @tip_cod=18 THEN RCODTER     
     WHEN @tip_cod=17 THEN RCODMAC      
     WHEN @tip_cod=4 THEN RCODMAT       
     WHEN @tip_cod=16 THEN RCODAGE        
  END=@COD_REL    
    
end      
    
   --DROP TABLE #Jer ,#TPRECLI    
     
	  
SELECT HFECPRO,HTIPCOD,HCODREL,
case when @segmento='TODOS' then HNUMCLI
     when @segmento='Mujer' then HCODPERFEME 
	 when @segmento='Urbano' then HCODPERURB 
	 when @segmento='Rural' then HCODPERRUR end HNUMCLI,RDESCPROD      
into #TPRECLI
FROM STORAGE.[com_pas].[WJAS007] --select * from sTORAGE.[com_pas].[WJAS007] where htipcod=7 and hcodrel='231' and hfecpro='2024-05-11' and HNUMCLI>1000    
WHERE HTIPCOD=@tip_cod AND HCODREL=@COD_REL AND RDESCPROD=@PROD AND HNUMCLI>1000  and hfecpro=@fec3    
UNION ALL    
SELECT HFECPRO,HTIPCOD,HCODREL,
case when @segmento='TODOS' then HNUMCLI
     when @segmento='Mujer' then HCODPERFEME 
	 when @segmento='Urbano' then HCODPERURB 
	 when @segmento='Rural' then HCODPERRUR end HNUMCLI,RDESCPROD      
FROM STORAGE.[com_pas].[WJAS007]     
WHERE HTIPCOD=CASE WHEN @tip_cod=7 THEN 18     
       WHEN @tip_cod=18 THEN 17     
       WHEN @tip_cod=17 THEN 4    
       WHEN @tip_cod=4 THEN 16 END AND RDESCPROD=@PROD     and hfecpro=@fec3    
UNION ALL    
SELECT HFECPRO,HTIPCOD,HCODREL,
case when @segmento='TODOS' then HNUMCLI
     when @segmento='Mujer' then HCODPERFEME 
	 when @segmento='Urbano' then HCODPERURB 
	 when @segmento='Rural' then HCODPERRUR end HNUMCLI,RDESCPROD     
FROM STORAGE.[com_pas].[WJAS007]     
WHERE HTIPCOD=CASE WHEN @tip_cod=7 THEN 17    
       WHEN @tip_cod=16 THEN 16 END AND RDESCPROD=@PROD   and hfecpro=@fec3    
UNION ALL    
SELECT HFECPRO,HTIPCOD,9999 HCODREL,
case when @segmento='TODOS' then HNUMCLI
     when @segmento='Mujer' then HCODPERFEME 
	 when @segmento='Urbano' then HCODPERURB 
	 when @segmento='Rural' then HCODPERRUR end HNUMCLI
,RDESCPROD  
FROM STORAGE.[com_pas].[WJAS007]     
WHERE HTIPCOD=@tip_cod AND HCODREL=@COD_REL AND RDESCPROD=@PROD AND HNUMCLI<1000    and hfecpro=@fec3    
    
SELECT distinct B.HFECPRO,A.HTIPCOD,A.HCODREL,A.HDESC,A.STYLE,B.HNUMCLI,B.RDESCPROD   INTO #FECCLIH    
FROM #Jer A     
INNER JOIN #TPRECLI B    
ON A.HTIPCOD=B.HTIPCOD  AND A.HCODREL=B.HCODREL           
    
   
----    
SELECT 
HFECPRO,HTIPCOD,HCODREL,
case when @segmento='TODOS' then HNUMCLI
     when @segmento='Mujer' then HCODPERFEME 
	 when @segmento='Urbano' then HCODPERURB 
	 when @segmento='Rural' then HCODPERRUR end HNUMCLI,RDESCPROD 
INTO #TPRECLI__    
FROM STORAGE.[com_pas].[WJAS007] --select top 5 * from STORAGE.[com_pas].[WJAS007] where HTIPCOD=7 AND HCODREL='231' AND HNUMCLI>1000   and hfecpro='2023-12-30'      
WHERE HTIPCOD=@tip_cod AND HCODREL=@COD_REL AND RDESCPROD=@PROD AND HNUMCLI>1000   and hfecpro=@fec2    
UNION ALL    
SELECT HFECPRO,HTIPCOD,HCODREL,
case when @segmento='TODOS' then HNUMCLI
     when @segmento='Mujer' then HCODPERFEME 
	 when @segmento='Urbano' then HCODPERURB 
	 when @segmento='Rural' then HCODPERRUR end HNUMCLI,RDESCPROD      
FROM STORAGE.[com_pas].[WJAS007]     
WHERE HTIPCOD=CASE WHEN @tip_cod=7 THEN 18     
       WHEN @tip_cod=18 THEN 17     
       WHEN @tip_cod=17 THEN 4    
       WHEN @tip_cod=4 THEN 16 END AND RDESCPROD=@PROD   and hfecpro=@fec2    
UNION ALL    
SELECT HFECPRO,HTIPCOD,HCODREL,
case when @segmento='TODOS' then HNUMCLI
     when @segmento='Mujer' then HCODPERFEME 
	 when @segmento='Urbano' then HCODPERURB 
	 when @segmento='Rural' then HCODPERRUR end HNUMCLI,RDESCPROD      
FROM STORAGE.[com_pas].[WJAS007]     
WHERE HTIPCOD=CASE WHEN @tip_cod=7 THEN 17    
       WHEN @tip_cod=16 THEN 16 END AND RDESCPROD=@PROD  and hfecpro=@fec2    
UNION ALL    
SELECT HFECPRO,HTIPCOD,9999 HCODREL, 
case when @segmento='TODOS' then HNUMCLI
     when @segmento='Mujer' then HCODPERFEME 
	 when @segmento='Urbano' then HCODPERURB 
	 when @segmento='Rural' then HCODPERRUR end HNUMCLI
,RDESCPROD 
FROM STORAGE.[com_pas].[WJAS007]     
WHERE HTIPCOD=@tip_cod AND HCODREL=@COD_REL AND RDESCPROD=@PROD AND HNUMCLI<1000 and hfecpro=@fec2    
    
SELECT distinct B.HFECPRO,A.HTIPCOD,A.HCODREL,A.HDESC,A.STYLE,B.HNUMCLI,B.RDESCPROD   INTO #FECCLIH__    
FROM #Jer A     
INNER JOIN #TPRECLI__ B    
ON A.HTIPCOD=B.HTIPCOD  AND A.HCODREL=B.HCODREL     
    
select a.htipcod,a.hcodrel,a.hdesc,a.style,a.HNUMCLI - b.HNUMCLI HNUMCLIVARCLI,a.RDESCPROD     
into #varCli    
from #FECCLIH a    
inner join #FECCLIH__ b    
on a.htipcod=b.htipcod and a.hcodrel=b.hcodrel and a.style=b.style    
    
    
--     
                  
 if @tip_cod<>4                  
begin                  
select      a.style,a.descripcion,                  
format(a.monto_pas_caract_NL_1/1000,'N0')monto_pas_caract_NL_1,                  
format(a.monto_pas_caract_NL_2/1000,'N0')monto_pas_caract_NL_2,                  
format(a.monto_pas_caract_NL_3/1000,'N0')monto_pas_caract_NL_3,                  
format((a.monto_pas_caract_NL_3 - monto_pas_caract_NL_1)/1000,'N0') TMMSALDO,                   
format((a.monto_pas_caract_NL_3 - monto_pas_caract_NL_2)/1000,'N0') TFMSALDO,                  
[8],[10],                  
format(b.A1/1000,'N0')A1,                  
format(b.A2/1000,'N0')A2,                  
format(b.A3/1000,'N0')A3,                  
format((b.A3-b.A1)/1000,'N0')TMMSM,                  
format((b.A3-b.A2)/1000,'N0')TFMSM,                  
[9],[11],[15],                  
format( m.HMSP/1000,'N0')   metasaldo,                  
format(m.HMSM/1000,'N0')  metasaldoM,                  
                 
 --format(cast((case when m.HMSP=0 then 0 else cast(a.monto_pas_caract_3  as float)/ m.HMSP end) as float)/1000,'N5') VARMETS,                  
format( (a.monto_pas_caract_NL_3 - m.HMSP)/1000,'N0') VARMETS,      
--format((case when m.HMSM=0 then 0 else cast(b.A3 as float) / m.HMSM end)/1000,'N5') VARMETSM            
format((b.A3 - m.HMSM ) /1000,'N0')  VARMETSM ,    
HNUMCLI numcli_pas_caract_NL_3 , varcli.HNUMCLIVARCLI dif_clientes    
/*m.HMSP metasaldo,                  
m.HMSM metasaldoM                  
*/                  
from #RESULTPIV a                  
left join #TD b                  
on  a.descripcion=b.DESCR                  
left join #SemSaldo c                  
on   a.descripcion=c.descripcion                  
left join #SemSaldoMedio d                  
on  a.descripcion=d.descripcion                  
LEFT JOIN #M m                  
on a.descripcion=m.descr          
left join #FECCLIH CLH   --select * from #FECCLIH    
ON A.descripcion=   CLH. HDESC         
left join #varCli varcli    
on a.descripcion=varcli.HDESC  --select * from #varCli    
    
end                  
else                  
begin                  
select    a.style,a.descripcion,                  
/*a.monto_pas_caract_1,a.monto_pas_caract_2,a.monto_pas_caract_3,monto_pas_caract_3 - monto_pas_caract_1 TMMSALDO, monto_pas_caract_3 - monto_pas_caract_2 TFMSALDO,[8],[10],                  
b.A1,b.A2,b.A3, b.A3 - b.A1 TMMSM, b.A3-b.A2 TFMSM,[9],[11],                  
a.numcli_pas_caract_3, (isnull(numcli_pas_caract_3,0))- (isnull(numcli_pas_caract_2,0))  dif_clientes,[15]                  
*/                  
format(a.monto_pas_caract_NL_1/1000,'N0')monto_pas_caract_NL_1,                  
format(a.monto_pas_caract_NL_2/1000,'N0')monto_pas_caract_NL_2,                  
format(a.monto_pas_caract_NL_3/1000,'N0')monto_pas_caract_NL_3,                  
format((a.monto_pas_caract_NL_3 - monto_pas_caract_NL_1)/1000,'N0') TMMSALDO,                   
format((a.monto_pas_caract_NL_3 - monto_pas_caract_NL_2)/1000,'N0') TFMSALDO,                  
[8],[10],                  
format(b.A1/1000,'N0')A1,                  
format(b.A2/1000,'N0')A2,                  
format(b.A3/1000,'N0')A3,                  
format((b.A3-b.A1)/1000,'N0')TMMSM,                  
format((b.A3-b.A2)/1000,'N0')TFMSM,                  
[9],[11],[15],                  
format( m.HMSP/1000,'N0')   metasaldo,                  
format(m.HMSM/1000,'N0')  metasaldoM,                  
--format(cast((case when m.HMSP=0 then 0 else cast(a.monto_pas_caract_3  as float)/ m.HMSP end) as float)/1000,'N5') VARMETS,                  
format((a.monto_pas_caract_NL_3 -     m.HMSP) /1000,'N0')   VARMETS,          
--format((case when m.HMSM=0 then 0 else cast(b.A3 as float) / m.HMSM end)/1000,'N5') VARMETSM        
format((  b.A3  -      m.HMSM)/1000,'N0')   VARMETSM  ,HNUMCLI numcli_pas_caract_NL_3,  varcli.HNUMCLIVARCLI dif_clientes    
        
/*m.HMSP metasaldo,                  
m.HMSM metasaldoM                  
*/                  
from #RESULTPIV a                  
left join #TD b                  
on a.style=b.style and a.descripcion=b.DESCR                  
left join #SemSaldo c                  
on  a.style=c.style and a.descripcion=c.descripcion                  
left join #SemSaldoMedio d                  
on a.style=d.style and a.descripcion=d.descripcion                  
LEFT JOIN #M m                  
on  a.style=m.style and a.descripcion=m.descr       
left join #FECCLIH CLH     
ON a.style=CLH.style and A.descripcion=   CLH. HDESC      
left join #varCli varcli    
on a.style=varcli.style and a.descripcion=varcli.HDESC        
            
end                       
     
end
