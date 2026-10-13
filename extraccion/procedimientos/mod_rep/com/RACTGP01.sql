-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-04 04:44:30.853000
--EXEC [com].[RACTGP01] 7,'231','20220714'
CREATE PROCEDURE [com].[RACTGP01]
@tip_cod int,@cod_rel varchar(20),@fec DATE
AS
BEGIN 
SET NOCOUNT ON;   

DECLARE @FechaC date =(select max(hfecpro) from storage.[com_act].WACTGRP001)

declare @FecAntes date
--set @FecAntes =(select DATEADD(MM,-1,convert(date,@fec)))
set @FecAntes =(select DATEADD(MM,-1,convert(date,@FechaC)))

SELECT *
into #FECS  --DROP TABLE #FECS
from storage.util.FVECFEC01(@FecAntes,'cmg_1') 

INSERT INTO #FECS
select RFEC    
from storage.util.FVECFEC01(@FechaC,'cmg_4,cmg_5,ayer,cmg_6') 
--from storage.util.FVECFEC01(@fec,'cmg_4,cmg_5,ayer,cmg_6') 


 declare @defs as rep.TTHCOLDEF;   

insert into @defs  
(TORDER,TISDATA,TROWS,TCOLS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY,TFORMOD)  values  
(1,1,2,1,1,'descripcion','Variables','string',1,null),
(2,NULL,1,1,1,'diamesanterior','D a mes anterior','string',null,null),
(3,NULL,1,1,1,'finmesanterior','Fin mes anterior','string',null,null),
(4,NULL,1,1,1,'diaanterior','D a anterior','string',null,null),
(5,NULL,1,1,1,'diaactual','D a actual','string',null,null),
(6,NULL,1,2,1,'vardiaria','Variaci n diaria','string',null,null),
(7,NULL,1,2,1,'varmensual','Variaci n mensual','string',null,null),
(8,NULL,1,2,1,'varintermensual','Variaci n intermensual','string',null,null),
(9,12,2,1,1,'meta','Meta','string',null,null),
(10,NULL,1,2,1,'avancemeta','Avance Meta','string',null,null),
(11,2,1,1,2,'dat2',(select cast(rfec as varchar(250)) from #FECS where rord=2),'number',null,null),--
(12,3,1,1,2,'dat3',(select cast(rfec as varchar(250)) from #FECS where rord=3),'number',null,null),--
(13,4,1,1,2,'dat4',(select cast(rfec as varchar(250)) from #FECS where rord=4),'number',null,null),--
(14,5,1,1,2,'dat5',(select cast(rfec as varchar(250)) from #FECS where rord=5),'number',null,null),--
(15,6,1,1,2,'VARDIA','Distancia','number',null,null),
(16,7,1,1,2,'PerceDia','%','percent',null,'.0-0'),
(17,8,1,1,2,'VARMES','Distancia','number',null,null),
(18,9,1,1,2,'PerceMes','%','percent',null,'.0-0'),
(19,10,1,1,2,'VARINTANU','Distancia','number',null,null),
(20,11,1,1,2,'PerceINTAN','%','percent',null,'.0-0'),
(21,13,1,1,2,'varmeta','Distancia','number',null,null),
(22,14,1,1,2,'PerceMeta','%','percent',null,'.0-0')

  select rep.FFTHCOLDEF(@defs) result;   

declare @fecacumu varchar(max)
select @fecacumu=string_agg(format(RFEC,'yyyyMMdd'),',')         
from #FECS     
select * into #FJERCOR02 from storage.ref.FJERCOR02(@fecacumu)

--declare @tip_cod int =7,@cod_rel varchar(250)='231'
;with cte_a as (
select a.* from storage.[com_act].WACTGRP001 a
INNER join #FJERCOR02 b 
on a.hfecpro=b.rfecpro and a.HCODA=b.rcodsec  
and   case when @tip_cod=20 then ISNULL(cast(RCODTER as nvarchar(10)),'9999')  
		   when @tip_cod=19 then cast(RCODCOR as nvarchar(10))
		   when @tip_cod=21 then cast(RCODGRU as nvarchar(5))      
		   when @tip_cod=18 then cast(RCODUNI as varchar(50))
		   when @tip_cod=17 then cast(RCODUCO as varchar(50)) else '1' end=IIF(@tip_cod=7,'1',@cod_rel)
),
cte_b as (
select rord,HFECPRO,cast(count(distinct HNROG ) as float) HCGRSTOCK,
cast(COUNT(DISTINCT CASE WHEN HINDFECPROG=1 THEN HNROG  ELSE NULL END ) as float) HCGRPROG,avg(CAST(HNUMINT AS FLOAT)) HPROMGRUPROG,
CAST(COUNT(DISTINCT CASE WHEN HINDFECPROG=1 THEN HNROG ELSE NULL END ) AS FLOAT)/ count(distinct HNROG ) HPERCUOPROG
from cte_a
GROUP BY rord,hfecpro
)
select * into #Dat from cte_b  --select * from #Dat  drop table #Dat
 

SELECT variables, valor,hfecpro,rord into #UvpDat
FROM
(
  SELECT 
     [HCGRSTOCK],[HCGRPROG],[HPROMGRUPROG],[HPERCUOPROG],hfecpro,rord 
 FROM #Dat
) p
UNPIVOT
(
  valor for variables IN
  ([HCGRSTOCK],[HCGRPROG],[HPROMGRUPROG],[HPERCUOPROG])
) AS upvt;
 
create table #Grupos(rord int null,variables varchar(250) null,dat1 float null,dat2 float null,dat3 float null,dat4 float null,dat5 float null ) --drop table #Grupos

declare @Query nvarchar(max)       
        
SET @Query = N'SELECT case when variables=''HCGRSTOCK'' then 1
							         when variables=''HCGRPROG'' then 2
									 when variables=''HPERCUOPROG'' then 3
									 when variables=''HPROMGRUPROG'' then 4 end rod,variables ' + NCHAR(10)                                       
--Despu s colocamos las columnas que vamos a transponer                                      
+ ( SELECT REPLACE( N',sum( CASE WHEN rord = <<rord>> THEN isnull(valor,0) END) AS dat<<rord>>                                      
   ', N'<<rord>>', rord)+ NCHAR(10)                                      
    FROM #UvpDat     --DROP TABLE #temp1     SELECT * FROM #temp1                        
    --Eliminamos duplicados usando GROUP BY                                      
    GROUP BY rord                                     
 --Definimos el orden de las columnas                                      
    ORDER BY rord                                      
    --Usamos esta instrucci n para concatenar los valores                                      
    FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')                                      
--Ponemos el resto de la consulta                                      
+ N'FROM #UvpDat    
group by variables         
order by  variables  asc                       
'         
insert into #Grupos         
EXEC sp_Executesql @Query;  
 
select *,dat5 - dat4 VARDIA,dat5/dat4 PerceDia,dat5 - dat3 VARMES,dat5/dat3 PerceMes, dat5 - dat1 VARINTANU,dat5/dat1 PerceINTAN,
CASE WHEN variables='HCGRSTOCK' then 'Stock de grupos'
     when variables='HCGRPROG' then 'Nro Grupos con  lt cuota programada'
	 WHEN variables='HPERCUOPROG' then '% Grupos con cuota programada'
	 WHEN variables='HPROMGRUPROG' then 'Promedio integrantes x grupo'
end descripcion,
case when variables='HPERCUOPROG' then FORMAT(dat1,'P') else FORMAT(dat1,'N0') end dat99 
INTO #R
from #Grupos ORDER BY 1 ASC --DROP TABLE #Grupos
 
select rord,descripcion,
case when variables='HPERCUOPROG' then FORMAT(cast(dat1 as float),'P') else FORMAT(dat1,'N0') end dat1, 
case when variables='HPERCUOPROG' then FORMAT(dat2,'P') else FORMAT(dat2,'N0') end dat2,
case when variables='HPERCUOPROG' then FORMAT(dat3,'P') else FORMAT(dat3,'N0') end dat3,
case when variables='HPERCUOPROG' then FORMAT(dat4,'P') else FORMAT(dat4,'N0') end dat4,
case when variables='HPERCUOPROG' then FORMAT(dat5,'P') else FORMAT(dat5,'N0') end dat5,
case when variables='HPERCUOPROG' then FORMAT(VARDIA,'P') else FORMAT(VARDIA,'N0') end VARDIA,PerceDia,
case when variables='HPERCUOPROG' then FORMAT(VARMES,'P') else FORMAT(VARMES,'N0') end VARMES,PerceMes,
case when variables='HPERCUOPROG' then FORMAT(VARINTANU,'P') else FORMAT(VARINTANU,'N0') end VARINTANU, 
PerceINTAN 
from #R order by rord asc
 

END
