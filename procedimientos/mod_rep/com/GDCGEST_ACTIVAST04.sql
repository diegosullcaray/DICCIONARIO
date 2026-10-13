-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-04 04:31:20.883000
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST04] '7', '231', 10, '20221107', 0
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST04] '20', '1_3', 9, '20221107', 0
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST04] '19', '20', 10, '20221107', 0--CORREDOR
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST04] '18', '231', 9, '20221107', 0--UNIDAD DE NEGOCIO
CREATE procedure [com].[GDCGEST_ACTIVAST04]
	@tip_cod varchar(10), @cod_rel varchar(10), @var int, @fec date, @diario int=0
as
begin
SET NOCOUNT ON;

--DECLARE @tip_cod varchar(10) = 7, @cod_rel varchar(10) = '231', @var int = 9, @fec date = '20221107', @diario int = 0--FC
--DECLARE @tip_cod varchar(10) = 20, @cod_rel varchar(10) = '1_3', @var int = 1, @fec date = '20221025', @diario int = 0--GRUPAL
----DECLARE @tip_cod varchar(10) = 20, @cod_rel varchar(10) = '1_3', @var int = 1, @fec date = '20221025', @diario int = 0--TERRITORIO

declare @fecs varchar(max), @ORD int, @format varchar(10) ,@calc varchar(50), @json nvarchar(max)
declare @fecs_2 varchar(max), @fecha date

SELECT @fecha = (select max(rfec) from [storage].[ref].[RCALEN001] where RFEC <= @fec and RDIAFER = 0)
--SELECT @fecha
SELECT @calc = iif(@var in(1, 2, 4, 7, 9), 'HNRO', iif(@var in(3, 6, 8, 10), 'HTAPPMES', 'HMDES'))
--SELECT @calc



SELECT RFEC, CONCAT(LEFT(RMESNOM, 3), '. ', RIGHT(RANI, 2)) [NomFec]
INTO #FecList
from [storage].[ref].[RCALEN001]
where RFEC = @fecha
--SELECT RFEC FROM #FecList
----DROP TABLE #FecList

select @ORD = max(ORD)
from storage.[com_act].[WGATH002]
where ORD <= case when @diario = 0 then 100 else 31 end
--select @ORD

/*CABECERAS*/
	if @var = 9
	begin
		select @json=N'[
        {
          "level":1,
          "columns":[
         {
            "columnDef":"DESCR",
            "header":"Producto / Desembolso por Nivel",
            "isdata":1,
            "sticky":true,
            "format":{
              "type":"string"
            },
            "rows":2
         },
         {
            "columnDef":"A1",
            "header":"Encima Tasa M nima",
            "isdata":2,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A2",
            "header":"A la Tasa M nima",
            "isdata":3,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"auto_comerciales",
            "header":"Autonomias Comerciales",
            "cols":4
            
         },
         {
            "columnDef":"A3",
            "header":"Total Autonom as",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A10",
            "header":"Total Operaciones",
            "isdata":9,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"PO",
            "header":"% Operaciones",
            "isdata":10,
            "format":{
              "type":"number"
            },
            "rows":2
         }]
        },
        {
          "level":2,
         "columns":[
          {
            "columnDef":"B1",
            "header":"Administrador",
            "isdata":4,
            "format":{
              "type":"number"
            }
         },
         {
          "columnDef":"B2",
          "header":"Gte. Corredor / R. Negocio Grupal",
          "isdata":5,
          "format":{
            "type":"number"
          }
        },
        {
          "columnDef":"B3",
          "header":"Gte. Territorial",
          "isdata":6,
          "format":{
            "type":"number"
           
          }
        },
        {
          "columnDef":"B4",
          "header":"Gte. Divisi n Comercial",
          "isdata":7,
          "format":{
            "type":"number"
           
          }
        }
         ]
        }
    ]'
	end
	if @var = 10
	begin
		select @json=N'[
        {
          "level":1,
          "columns":[
         {
            "columnDef":"DESCR",
            "header":"Producto / Desembolso por Nivel",
            "isdata":1,
            "sticky":true,
            "format":{
              "type":"string"
            },
            "rows":2
         },
         {
            "columnDef":"A1",
            "header":"Encima Tasa M nima",
            "isdata":2,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A2",
            "header":"A la Tasa M nima",
            "isdata":3,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"auto_comerciales",
            "header":"Autonomias Comerciales",
            "cols":4
            
         },
         {
            "columnDef":"A3",
            "header":"TAPP Autonom as",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A10",
            "header":"TAPP Final",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"TM",
            "header":"TAPP M nima",
            "isdata":9,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"DT",
            "header":"Distancia (en pbs)",
            "isdata":10,
            "format":{
              "type":"number"
            },
            "rows":2
         }]
        },
        {
          "level":2,
         "columns":[
          {
            "columnDef":"B1",
            "header":"Administrador",
            "isdata":4,
            "format":{
              "type":"number"
            }
         },
         {
          "columnDef":"B2",
          "header":"Gte. Corredor / R. Negocio Grupal",
          "isdata":5,
          "format":{
            "type":"number"
          }
        },
        {
          "columnDef":"B3",
          "header":"Gte. Territorial",
          "isdata":6,
          "format":{
            "type":"number"
           
          }
        },
        {
          "columnDef":"B4",
          "header":"Gte. Divisi n Comercial",
          "isdata":7,
          "format":{
            "type":"number"           
          }
        }
        ]
        }
    ]'
	end	
	

SELECT @calc = iif(@var in(9), 'HNRO', iif(@var in(10), 'HTAPPMES', 'HMDES'))

declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)
select @fecs_2 = (select replace(cast(max(hfecpro) as varchar(250)),'-','') from [storage].[com_act].WACLI001)

insert into @tvars	values ('num_cli_stock', null, '166', null, null, null), ('num_ope_sf2', null, '5006', null, null, null)
insert into @tfil	values ('todos', 'fec', ''+@fecs_2+'')
insert into @tconf	values ('level_alias', 'style')
insert into @tfil
exec [piv].[GPIVLEV01] @tip_cod, @cod_rel, @jerar output

select	@fec = max(HFECPRO)
from    storage.[com_act].[WGATH002]
where   ORD = @ORD and RFEC <= @fec

create table #RES (
	ORD int not null identity(1,1)
	, DESCR varchar(50)
	, RFECPRO varchar(50)
	, RDESPROD varchar(50)
	, RVAR varchar(50)
	, ESTILO int
	, DFORMAT varchar(10)
)

--SELECT TOP 10 *
--from storage.[com_act].[WGATH002] A
--where A.HFECPRO in (select rfec from #FecList)

insert into #RES (DESCR, RFECPRO, RDESPROD, RVAR, ESTILO)
--select cast(@fec as varchar), CASE WHEN HMDES < 1000 THEN '01. Entre 0 y 999' WHEN HMDES < 2000 THEN '02. Entre 1,000 y 1,999'
select DISTINCT CASE WHEN HMDES < 1000 THEN '01. Entre 0 y 999' WHEN HMDES < 2000 THEN '02. Entre 1,000 y 1,999'
								   WHEN HMDES < 3000 THEN '03. Entre 2,000 y 2,999' WHEN HMDES < 5000 THEN '04. Entre 3,000 y 4,999'
								   WHEN HMDES < 10000 THEN '05. Entre 5,000 y 9,999' WHEN HMDES < 20000 THEN '06. Entre 10,000 y 19,999'
								   WHEN HMDES < 30000 THEN '07. Entre 20,000 y 29,999' WHEN HMDES < 50000 THEN '08. Entre 30,000 y 49,999'
							  ELSE '09. Mayor a 50,000' END
	, cast(@fec as varchar), CASE WHEN HMDES < 1000 THEN '01. Entre 0 y 999' WHEN HMDES < 2000 THEN '02. Entre 1,000 y 1,999'
								   WHEN HMDES < 3000 THEN '03. Entre 2,000 y 2,999' WHEN HMDES < 5000 THEN '04. Entre 3,000 y 4,999'
								   WHEN HMDES < 10000 THEN '05. Entre 5,000 y 9,999' WHEN HMDES < 20000 THEN '06. Entre 10,000 y 19,999'
								   WHEN HMDES < 30000 THEN '07. Entre 20,000 y 29,999' WHEN HMDES < 50000 THEN '08. Entre 30,000 y 49,999'
							 ELSE '09. Mayor a 50,000' END
	, @calc, 0
--from storage.com_act.RETP003
from storage.[com_act].[WGATH002] A
order by CASE WHEN HMDES < 1000 THEN '01. Entre 0 y 999' WHEN HMDES < 2000 THEN '02. Entre 1,000 y 1,999'
			  WHEN HMDES < 3000 THEN '03. Entre 2,000 y 2,999' WHEN HMDES < 5000 THEN '04. Entre 3,000 y 4,999'
			  WHEN HMDES < 10000 THEN '05. Entre 5,000 y 9,999' WHEN HMDES < 20000 THEN '06. Entre 10,000 y 19,999'
			  WHEN HMDES < 30000 THEN '07. Entre 20,000 y 29,999' WHEN HMDES < 50000 THEN '08. Entre 30,000 y 49,999'
		 ELSE '09. Mayor a 50,000' END

if @var = 9
BEGIN
	update #res set DFORMAT = 'N0'

	insert into #res (DESCR, RFECPRO, RDESPROD, RVAR, ESTILO, DFORMAT)
	values('TOTAL', cast(@fec as varchar), 'TOTAL', 'HNRO', 1,'N0')
END

if @var = 10
BEGIN
	update #res set DFORMAT = 'P'

	insert into #res (DESCR, RFECPRO, RDESPROD, RVAR, ESTILO, DFORMAT)
	values ('TOTAL', cast(@fec as varchar), 'TOTAL', 'HTAPPMES', 1, 'P')
END

--SELECT *
--FROM #RES

--insert into #DES
--exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf-- ,@show_query=1

;
with
cte_a
as
(
SELECT A.HFECPRO, A.RDESUNI, A.HUCAP_FIN, A.HGESTTAS, A.RCODCOR, A.RCODGRU, A.RCODUNI,A.RCODUCO,A.RDESUCO, A.RDESGRU, A.RDESCOR,
   A.RCODTER, A.RDESTER, A.HMDES, A.HTDES, A.HTMIN, A.RCODSEC, A.RDESSEC
   , CASE WHEN HMDES < 1000 THEN '01. Entre 0 y 999' WHEN HMDES < 2000 THEN '02. Entre 1,000 y 1,999'
		  WHEN HMDES < 3000 THEN '03. Entre 2,000 y 2,999' WHEN HMDES < 5000 THEN '04. Entre 3,000 y 4,999'
		  WHEN HMDES < 10000 THEN '05. Entre 5,000 y 9,999' WHEN HMDES < 20000 THEN '06. Entre 10,000 y 19,999'
		  WHEN HMDES < 30000 THEN '07. Entre 20,000 y 29,999' WHEN HMDES < 50000 THEN '08. Entre 30,000 y 49,999'
	 ELSE '09. Mayor a 50,000' END RDESPROD
--INTO #cte_a
from storage.[com_act].[WGATH002] A
--where ORD = @ORD and A.HFECPRO in (select rfec from #FecList)
where ORD = @ORD and case when @var in(7, 8, 9, 10) then A.HFECPRO else '1900-01-01' end = case when @var in(7, 8, 9, 10) then @fec else '1900-01-01' end and A.HFECPRO <= @fec
--SELECT TOP 10 * FROM #cte_a
)
,cte_b
as
(
select isnull(cast(HFECPRO as varchar),'TOTAL') HFECPRO
	, isnull(HUCAP_FIN,'TOTAL') HUCAP_FIN
	, isnull(RDESPROD,'TOTAL') RDESPROD
	, isnull(HGESTTAS,10) HGESTTAS
	, cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)HTAPPMES
	, cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMIN
	, cast(count(*)  as float) HNRO
	, cast(sum(HMDES) as float) HMDES
	, cast(sum(HMDES)/count(*) as float) HTPROM
	, round((
		cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) -
		cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)
	)*10000,0) HDIFTAPPMM
--INTO #cte_b
from cte_a
where case when @tip_cod='7' then 	cast('1' as varchar(10))
		   when @tip_cod='20' then cast(RCODTER as varchar(10))--TERRITORIO
		   when @tip_cod='19' then cast(RCODCOR as varchar(10))--CORREDOR
		   when @tip_cod='21' then cast(RCODGRU as varchar(10))--GRUPO
		   when @tip_cod='18' then cast(RCODUNI as varchar(10))--UNIDAD NEGOCIO
		   when @tip_cod='17' then cast(RCODUCO as varchar(10))--UNIDAD NEGOCIO
		   when @tip_cod='2' then cast(RCODSEC  as varchar(10)) end = case when @tip_cod='7' then '1'
else @cod_rel end and HFECPRO <= @fec
--group by cube(HFECPRO,RDESPROD,HUCAP_FIN,HGESTTAS)
group by HFECPRO, cube(RDESPROD, HUCAP_FIN, HGESTTAS)
UNION ALL
select  'TOTAL' HFECPRO
	, isnull(HUCAP_FIN,'TOTAL') HUCAP_FIN
	, isnull(RDESPROD,'TOTAL') RDESPROD
	, isnull(HGESTTAS,10) HGESTTAS
	, cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)HTAPPMES
	, cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMIN
	, cast(count(*)  as float) HNRO
	, cast(sum(HMDES) as float) HMDES
	, cast(sum(HMDES)/count(*) as float) HTPROM
	, round((
	cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) -
	cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)
	)*10000, 0) HDIFTAPPMM
from cte_a
where case when @tip_cod='7' then 	cast('1' as varchar(10)) 
		   when @tip_cod='20' then cast(RCODTER as varchar(10))--TERRITORIO
		   when @tip_cod='19' then cast(RCODCOR as varchar(10))--CORREDOR
		   when @tip_cod='21' then cast(RCODGRU as varchar(10))--GRUPO
		   when @tip_cod='18' then cast(RCODUNI as varchar(10))--UNIDAD NEGOCIO
		    when @tip_cod='17' then cast(RCODUCO as varchar(10))--UNIDAD NEGOCIO
		   when @tip_cod='2' then cast(RCODSEC  as varchar(10)) end = case when @tip_cod='7' then '1'
	  else @cod_rel end
and HFECPRO between '2020-12-31' and '2021-06-30' and HFECPRO <= @fec
group by cube(RDESPROD,HUCAP_FIN,HGESTTAS)
--SELECT TOP 10 * FROM #cte_b
)
,cte_c
as
(
select A.*,A.HNRO/(B.HNRO*1.) HPARTNRO 
	, A.HMDES/(B.HMDES*1.) HPARTMDES
from cte_b A
left join cte_b B
on      B.HGESTTAS = 10 and B.RDESPROD = 'TOTAL' and B.HUCAP_FIN = 'TOTAL' and A.HFECPRO = B.HFECPRO
)
,cte_d
as
(
select A.*
	, (A.HTAPPMES-B.HTAPPMES)*10000 [HVARTAPPMESHIST]
	, (A.HPARTNRO-B.HPARTNRO)*10000 [HVARPARTNROHIST]
	, (A.HPARTMDES-B.HPARTMDES)*10000 [HVARPARTMDESHIST] 
from cte_c A
left join   cte_c B
on    A.HFECPRO = cast(@fec as varchar) and B.HFECPRO = 'TOTAL' and A.HGESTTAS = B.HGESTTAS and A.HUCAP_FIN = B.HUCAP_FIN and B.RDESPROD = 'TOTAL' and A.RDESPROD = 'TOTAL'

)
select *
into #RESULT
from cte_d A
unpivot(valores for variables in([HTAPPMIN],[HTAPPMES],[HDIFTAPPMM],[HNRO],[HMDES],[HTPROM],[HPARTNRO],[HPARTMDES],[HVARTAPPMESHIST],[HVARPARTNROHIST],[HVARPARTMDESHIST]) ) UNPTV
order by 1,2,3

select *
into #C
from (select * from #RESULT where /*variables=@calc and*/ HUCAP_FIN='TOTAL') A pivot(max(valores) for HGESTTAS in([1],[2],[3],[10])) PVT

select *
into #D
from ( select * from #RESULT where /*variables=@calc and*/ HGESTTAS=10) A pivot(max(valores) for HUCAP_FIN in([Administrador],[Gerente Corredor / R. Negocio Grupal],[Gerente Territorial],[Gte. Divisi n Comercial],[TOTAL])) PVT

--SELECT TOP 10 * FROM #D

----DECLARE @var int = 8, @calc varchar(50)
----SELECT @calc = iif(@var in(1, 2, 4, 7), 'HNRO', iif(@var in(3, 6, 8), 'HTAPPMES', 'HMDES'))

select @json result

select distinct  A.ORD,A.ESTILO as style, A.DESCR
, format(isnull(B.[1],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) A1
, format(isnull(B.[2],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) A2
, format(isnull(C.Administrador,0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) B1
, format(isnull(C.[Gerente Corredor / R. Negocio Grupal],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) B2
, format(isnull(C.[Gerente Territorial],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) B3
, format(isnull(C.[Gte. Divisi n Comercial],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) B4
, format(isnull(B.[3],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) A3
, format(isnull(B.[10],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) A10
, format(isnull(B.[3],0)/(iif(B.[10]=0,null,B.[10])*1.0),'P') PO
, format(D.[10],'N0') TP
, format(isnull(E.[10],0),'P') TM
, format(isnull(F.[10],0),'N0') DT
into #FIN      
from #res A
left join #C B
ON			A.RDESPROD=B.RDESPROD and A.RVAR=B.variables and A.RFECPRO=B.HFECPRO and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(B.HFECPRO as varchar) else 'TOTAL' end
left join #D C
ON			A.RDESPROD=C.RDESPROD and A.RVAR=C.variables and A.RFECPRO=C.HFECPRO and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(C.HFECPRO as varchar) else 'TOTAL' end
left join #C D
ON			A.RDESPROD=D.RDESPROD and A.RVAR not in('HVARTAPPMESHIST','HVARPARTNROHIST','HVARPARTMDESHIST') and D.variables='HTPROM' and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(D.HFECPRO as varchar) else 'TOTAL' end
left join #C E
ON			A.RDESPROD=E.RDESPROD and E.variables='HTAPPMIN' and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(E.HFECPRO as varchar) else 'TOTAL' end
left join #C F
ON			A.RDESPROD=F.RDESPROD and F.variables='HDIFTAPPMM' and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(F.HFECPRO as varchar) else 'TOTAL' end
	
select *
from #FIN A
order by A.ORD



DROP TABLE #FecList, #RES--, #cte_a, #cte_b--, #cte_c, #cte_d
DROP TABLE #RESULT, #C, #D, #FIN


END
