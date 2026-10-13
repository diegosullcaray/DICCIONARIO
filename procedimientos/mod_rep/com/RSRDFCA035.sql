-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-04-17 13:44:54.047000
--EXEC [mod_rep].[com].[RSRDFCA035] 7,'231','20230228','TODOS'
CREATE PROCEDURE [com].[RSRDFCA035]      
@tip_cod int,@cod_rel varchar(20),@fec varchar(10) ,@prod varchar(250)   
AS          
BEGIN          
 SET NOCOUNT ON;      
  
 --  declare @fec varchar(50)='20230221',@tip_cod int =7,@cod_rel varchar(250)='231',@prod varchar(50)='AHORROS'  
  ------------  
     
  declare @fecs varchar(max)  
      
  --create table #FECS (RORD int identity(1,1) not null,RFEC date null)  
 -- ;with cte_f1 as (  
  select * into #FECS   from storage.util.FVECFEC01(@fec,'cmg_4,cie_ant,hoy')  
  --),  
  --cte_f2 as (  
  --select top 1 * from storage.ref.RCALEN001 where rfec<=DATEADD(MM, -1,@fec)  and RDIAFER=0 order by 2 desc  
  --)  
  --insert into #FECS  
  --select rfec from cte_f2  
  --union all  
  --select rfec from cte_f1  
     
declare @fec1 varchar(10),@fec2 varchar(10),@fec3 varchar(10)  
set @fec1 =(select rfec from #fecs where rord=1)  
set @fec2 =(select rfec from #fecs where rord=2)  
set @fec3 =(select rfec from #fecs where rord=3)  
  
declare @defs as rep.TTHCOLDEF;      
  insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS)  values      
 (1,1,1,'descripcion','Descripción','string',null,1,2)      
  
 insert into @defs      
 (TORDER,TLEV,TKEY,TDESC,TCOLS) values       
 (2,1,'m_SP','Saldo Puntual',9),  
 (3,1,'m_SPSM','Saldo Medio',9)  
     
  
  insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTICKY,TROWS,TCOLS,thidden)  values      
 (20,20,1,'numcli_cartera_caract_3','Clientes','number','.0-0',null,2,null,null)   ,  
 (21,21,1,'15','','traffic-light',NULL,null,2,null,1),  
 (22,22,1,'dif_clientes','Var. Clientes','number','.0-0',null,2,2,null)    
  
 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,thidden,TCOLS)  values      
 (2,2,2,'monto_cartera_caract_1',@fec1,'number',null,null,null)   ,  
 (3,3,2,'monto_cartera_caract_2',@fec2,'number',null,null,null) ,   
 (4,4,2,'monto_cartera_caract_3',@fec3,'number',null,null,null),    
 (5,5,2,'metasaldo','Meta','number',null,null,null),  
 (6,6,2,'8','','traffic-light',NULL,1,null),  
 (7,7,2,'TMMSALDO','TMM','number',null,null,2),  
 (8,8,2,'10','','traffic-light',NULL,1,null),  
 (9,9,2,'TFMSALDO','TFM','number',null,null,2),  
 (10,10,2,'VARMETS','Var. Meta','number',null,null,null),  
 ---------------------------------------------------------------  
 (11,11,2,'A1',@fec1,'number',null,null,null)   ,  
 (12,12,2,'A2',@fec2,'number',null,null,null) ,   
 (13,13,2,'A3',@fec3,'number',null,null,null),    
 (14,14,2,'metasaldoM','Meta','number',null,null,null),  
 (15,15,2,'9','','traffic-light',NULL,1,null),  
 (16,16,2,'TMMSM','TMM','number',null,null,2),  
 (17,17,2,'11','','traffic-light',NULL,1,null),  
 (18,18,2,'TFMSM','TFM','number',null,null,2),  
 (19,19,2,'VARMETSM','Var. Meta','number',null,null,null)  
  
   
 select rep.FFTHCOLDEF(@defs) hdefs ;      
select @fecs=string_agg(convert(varchar(10),RFEC,112),',')  
from #FECS  
   
   
        
 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF              
              
 insert into @tvars values               
 ('monto_cartera_caract',null,null,null,null,null),  
 ('numcli_cartera_caract',null,null,null,null,null)             
               
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
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output              
              
 insert into @tconf              
 values              
 ('level_alias','style'),  
 ('fec_corr','true')   ,('insert_to', '#RESULTPIV')               
           
 create table #RESULTPIV       --select * from #RESULTPIV    
 (  
 fila int null,cod_fc varchar(250)null, cod_ugru varchar(250)null, style int null,  
 descripcion varchar(250)null,  
monto_cartera_caract_1 float null,  
monto_cartera_caract_2 float null,  
monto_cartera_caract_3 float null,  
numcli_cartera_caract_1 float null,  
numcli_cartera_caract_2 float null,  
numcli_cartera_caract_3  float null   
 )  
  
 --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf--,@show_query=1       
 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars","fec_corr"',@config=@tconf,@show_query=1
   
  
--/* Saldo Medio */  
   
declare @DescNom varchar(250)  
set @DescNom =(  
select   
DISTINCT CASE WHEN @tip_cod=7 then CAST(RDESFC AS VARCHAR(250))     
   when @tip_cod=21 then CAST(RDESGRU AS VARCHAR(250))      
   when @tip_cod=20 then CAST(RDESTER AS VARCHAR(250))      
   when @tip_cod=19 then CAST(RDESCOR AS VARCHAR(250))      
   when @tip_cod=18 then CAST(RDESUNI AS VARCHAR(250)) END  
from storage.ref.wjercor03  --select top 5 * from storage.ref.wjercor03   
where rfecpro=@fec3 and   
case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                     
     when @tip_cod=20 then cast(RCODTER as nvarchar(10))                  
     when @tip_cod=19 then CAST(RCODCOR  as nvarchar(10))          
    when @tip_cod=18 then CAST(RCODUNI as nvarchar(10)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)   
)  
  
  
select DISTINCT CASE WHEN @tip_cod=7 then CAST(RCODGRU AS VARCHAR(250))     
   when @tip_cod=21 then CAST(RCODTER AS VARCHAR(250))      
   when @tip_cod=20 then CAST(RCODCOR AS VARCHAR(250))      
   when @tip_cod=19 then CAST(RCODUNI AS VARCHAR(250))      
   when @tip_cod=18 then CAST(RCODSEC AS VARCHAR(250)) END RCOD,  
   CASE WHEN @tip_cod=7 then RDESGRU     
   when @tip_cod=21 then RDESTER      
   when @tip_cod=20 then RDESCOR      
   when @tip_cod=19 then RDESUNI      
   when @tip_cod=18 then RDESSEC END RDESC  
INTO #JERAR  
from storage.ref.wjercor03   
where rfecpro=@fec3 and   
case when @tip_cod=21 then  ISNULL(cast(RCODGRU as nvarchar(10)),'9999')                     
     when @tip_cod=20 then cast(RCODTER as nvarchar(10))                  
     when @tip_cod=19 then CAST(RCODCOR  as nvarchar(10))                        
      when @tip_cod=18 then CAST(RCODUNI as nvarchar(10)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)   
  
      
  
select hfecpro,htipcod,hcodrel hcodrel,RDESCPROD02,sum(hsalmedmn)hsalmedmn, @DescNom DESCR ,1 STYLE  
into #SalMedio  --select * from #SalMedio where htipcod=7 order by 1,4 asc  
from storage.com_act.WJAS004   
where htipcod=@tip_cod  and hcodrel=@cod_rel   AND   
hfecpro in(select rfec from #FECS) AND RDESCPROD02 IS NOT NULL  --AND  
--RDESCPROD02=@prod  
and RDESCPROD02 like CASE WHEN @prod='TODOS' then '%%' else @prod+'%' end     
group by hfecpro,htipcod,hcodrel,RDESCPROD02  
union all  
select hfecpro,htipcod,hcodrel,RDESCPROD02,sum(hsalmedmn)hsalmedmn,B.RDESC,0 STYLE    
from storage.com_act.WJAS004 A  
INNER JOIN #JERAR B  
ON A.HCODREL=B.RCOD  
where htipcod =case when @tip_cod=7 then 21  
        when @tip_cod=21 then 20  
        when @tip_cod=20 then 19  
           when @tip_cod=19 then 18  
           when @tip_cod=18 then 1  
  
         end    
 and hfecpro in(select rfec from #FECS)  
 --AND RDESCPROD02=@prod  
  AND RDESCPROD02 IS NOT NULL  
 and RDESCPROD02 like CASE WHEN @prod='TODOS' then '%%' else @prod+'%' end     
group by  hfecpro,htipcod,hcodrel,B.RDESC,RDESCPROD02  
  
create table #T_ (hfecpro date null,style int null,descr varchar(250)null,prod float null,rord int null)  
    
DECLARE @PROD2 varchar(max)  
DECLARE @sql NVARCHAR(MAX)  
set @PROD2 =(select case when @prod='TODOS' then '[AHORROS],[CTS],[PLAZO FIJO]' ELSE '['+@prod+']' END)  
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
SELECT fila,cod_fc,cod_ugru,style,descripcion,monto_cartera_caract_1,monto_cartera_caract_2,monto_cartera_caract_3,  
numcli_cartera_caract_3 [5],numcli_cartera_caract_2 [4]  
   FROM #RESULTPIV  
),  
  
cte_a AS (  
 SELECT fila,cod_fc,cod_ugru,style,descripcion, replace(RORD,'monto_cartera_caract_','') RORD, valores,9510 VARIABLES    
FROM     
   (SELECT fila,cod_fc,cod_ugru,style,descripcion,monto_cartera_caract_1,monto_cartera_caract_2,monto_cartera_caract_3,  
   [4],[5]  
   FROM CTE_A_) p    
UNPIVOT    
  (valores FOR RORD IN     
      (monto_cartera_caract_1,monto_cartera_caract_2,monto_cartera_caract_3,[4],[5])    
)AS unpvt   
),  
cte_b as (    
SELECT A.fila,A.cod_fc,A.cod_ugru,A.style,A.descripcion,  
case when concat(A.RORD,'-',B.RORD) ='3-1' then 8              
      when concat(A.RORD,'-',B.RORD) ='3-2' then 10  
   when concat(A.RORD,'-',B.RORD) ='5-4' then 15   end RORD ,  
cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR    
FROM CTE_A A  
join CTE_A B      
on A.variables=B.variables    and a.descripcion=b.descripcion  
where concat(A.RORD,'-',B.RORD) in('3-1','3-2','5-4' )   
)  
SELECT fila,cod_fc,cod_ugru,style,descripcion, [8] AS [8], [10] AS [10] ,[15] AS [15]  into #SemSaldo   
FROM     
(SELECT SVALOR, RORD, fila,cod_fc,cod_ugru,style,descripcion    
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
   FROM #TD) p    
UNPIVOT    
   (valores FOR RORD IN     
      (A1,A2,A3 )    
)AS unpvt   
),  
cte_b as (    
SELECT A.style,A.descripcion,  
case when concat(A.RORD,'-',B.RORD) ='3-1' then 9              
            when concat(A.RORD,'-',B.RORD) ='3-2' then 11   end RORD ,  
cast(util.FSEMVAR(A.variables,A.valores,A.valores-B.valores) as varchar) SVALOR    FROM CTE_A A  
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
set @ProdCaptacionesMet =(select case when @prod='AHORROS' then ('10110,10113')  
           when @prod='CTS' THEN ('10111,10114')  
           when @prod='PLAZO FIJO' THEN ('10112,10115')  
           when @prod='TODOS' THEN ('10110,10111,10112,10113,10114,10115')  
           END  
       )  
set @ProdCaptacionesMetM =(select case when @prod='AHORROS' then ('[10110],[10113]')  
           when @prod='CTS' THEN ('[10111],[10114]')  
           when @prod='PLAZO FIJO' THEN ('[10112],[10115]')  
           when @prod='TODOS' THEN ('[10110],[10111],[10112],[10113],[10114],[10115]')  
           END  
       )  
  
declare @FecMeta date   
set @FecMeta=(select max(hfecpro) from [storage].[com].[VDMCOM01] where HCODVAR  in(10110,10111,10112,10113,10114,10115) )   
  
create table #Met (hfecpro date null,hcodvar int null,htipcod int null,hcodrel varchar(250)null,hvalvar float null,rnivel varchar(50)null, DESCR varchar(250)null,style int null)  
   
set @SQL ='  
with cte_a as (  
select  hfecpro,hcodvar,htipcod,hcodrel,sum(hvalvar) hvalvar,''Nivel 1'' RNIVEL, '''+@DescNom+''' DESCR ,1 STYLE  
from STORAGE.com.VDMCOM01  
where HTIPCOD='+cast(@tip_cod as varchar(250))+'  and hcodrel='''+cast(@cod_rel as varchar(250))+'''  
and hfecpro=eomonth('''+cast(@fec as varchar(250))+''')       and hcodvar IN ('+@ProdCaptacionesMet+')   
group by  hfecpro,hcodvar,htipcod,hcodrel  
),   
cte_b as (   
SELECT hfecpro,hcodvar,htipcod,hcodrel,sum(hvalvar) hvalvar,''Nivel 2'' RNIVEL  
FROM STORAGE.com.VDMCOM01   
WHERE HTIPCOD=case when '+cast(@tip_cod as varchar(250))+'=7 then  21  
     when '+cast(@tip_cod as varchar(250))+'=21 then 20   
     when '+cast(@tip_cod as varchar(250))+'=20 then 19   
     when '+cast(@tip_cod as varchar(250))+'=19 then 18    
     when '+cast(@tip_cod as varchar(250))+'=18 then 2  
   end   
and hfecpro=eomonth('''+cast(@fec as varchar(250))+''') and hcodvar IN ('+@ProdCaptacionesMet+')  
                  
group by hfecpro,hcodvar,htipcod,hcodrel  
),  
cte_b_ as (  
select a.*,B.RDESC,0 STYLE     
from cte_b a  
INNER JOIN (select * from #JERAR) B --DROP TABLE #JERAR  
ON A.HCODREL=B.RCOD  
) ,  
cte_u as (  
select * from cte_a   
union all  
select  * from cte_b_  
   
)  
select * from cte_u  
'  
insert into #Met  
exec(@SQL)  
  
--  
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
SELECT  HFECPRO,STYLE,DESCR,ISNULL([10110],0)+ISNULL([10111],0)+ISNULL([10112],0) HMSP , ISNULL([10113],0)+ISNULL([10114],0)+ISNULL([10115],0) HMSM  
FROM CTE_A  
)     
   
 select * from CTE_B  
'  
   
INSERT INTO #M  --select * from #T_  drop table #M  
exec(@sql)   
 end  
  
select  a.style,a.descripcion,  
/*a.monto_cartera_caract_1,a.monto_cartera_caract_2,a.monto_cartera_caract_3,monto_cartera_caract_3 - monto_cartera_caract_1 TMMSALDO, monto_cartera_caract_3 - monto_cartera_caract_2 TFMSALDO,[8],[10],  
b.A1,b.A2,b.A3, b.A3 - b.A1 TMMSM, b.A3-b.A2 TFMSM,[9],[11],  
a.numcli_cartera_caract_3, (isnull(numcli_cartera_caract_3,0))- (isnull(numcli_cartera_caract_2,0))  dif_clientes,c.[15]*/  
  
format(a.monto_cartera_caract_1/1000,'N0')monto_cartera_caract_1,  
format(a.monto_cartera_caract_2/1000,'N0')monto_cartera_caract_2,  
format(a.monto_cartera_caract_3/1000,'N0')monto_cartera_caract_3,  
format((a.monto_cartera_caract_3 - monto_cartera_caract_1)/1000,'N0') TMMSALDO,   
format((a.monto_cartera_caract_3 - monto_cartera_caract_2)/1000,'N0') TFMSALDO,  
[8],[10],  
format(b.A1/1000,'N0')A1,  
format(b.A2/1000,'N0')A2,  
format(b.A3/1000,'N0')A3,  
format((b.A3-b.A1)/1000,'N0')TMMSM,  
format((b.A3-b.A2)/1000,'N0')TFMSM,  
[9],[11],  
A.numcli_cartera_caract_3,  
 ((isnull(numcli_cartera_caract_3,0))- (isnull(numcli_cartera_caract_2,0)))  dif_clientes,[15],  
format( m.HMSP/1000,'N0')   metasaldo,  
format(m.HMSM/1000,'N0')  metasaldoM,  
--format((CASE WHEN m.HMSP=0 THEN 0 ELSE CAST(a.monto_cartera_caract_3  as float)/ m.HMSP END) /1000,'N5') VARMETS,  
  
--format((CASE WHEN m.HMSM=0 THEN 0 ELSE cast(b.A3 as float) / m.HMSM END)/1000,'N5') VARMETSM  ,
format(((case when m.HMSP=0 then 0 else (a.monto_cartera_caract_3 - monto_cartera_caract_2) / m.HMSP end)  *100)/1000,'N5')  VARMETS,
format(((case when m.HMSM=0 then 0 else (b.A3-b.A2) / m.HMSM end) *100)/1000,'N5')  VARMETSM
/*  
m.HMSP metasaldo,  
m.HMSM metasaldoM  
*/  
from #RESULTPIV a  
left join #TD b  
on a.style=b.STYLE and a.descripcion=b.DESCR  
left join #SemSaldo c  
on a.style=c.style and a.descripcion=c.descripcion  
left join #SemSaldoMedio d  
on a.style=d.style and a.descripcion=d.descripcion  
LEFT JOIN #M m  
on a.descripcion=m.descr   
  
    
  
end
