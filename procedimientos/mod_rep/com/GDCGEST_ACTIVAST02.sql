-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-04 04:58:58.150000
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST02] '7', '231', '20221011', 0
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST02] '18', '140', '20221011', 0
CREATE procedure [com].[GDCGEST_ACTIVAST02]
 @tip_cod varchar(10), @cod_rel varchar(10), @fec date, @diario int = 0
as
begin

SET NOCOUNT ON;
----declare @tip_cod varchar(10)=7, @cod_rel varchar(10)='231', @dim int=0,@fec date='20220531',@diario int=0
--declare @tip_cod varchar(10) = 18, @cod_rel varchar(10) = '140', @dim int = 0, @fec date = '20221011', @diario int = 0
declare @fecs varchar(max), @ORD int, @format varchar(10), @calc varchar(50), @json nvarchar(max), @var int = 5--@var int=5
declare @fec_a varchar(8), @MES_ANT_1 varchar(10), @MES_ANT_2 varchar(10), @MES_ANT_3 varchar(10), @MES_ANT_4 varchar(10)
DECLARE @MES_ANT_5 varchar(10), @MES_ANT_6 varchar(10)
declare @defs as rep.TTHCOLDEF;

SELECT top 6 rfec, CONCAT(LEFT(RMESNOM, 3), '. ', RIGHT(RANI, 2)) [NomFec]
into #FecList
FROM [storage].[ref].[RCALEN001]
WHERE (RFEC) <= @fec and RCIEMES = 1
order by rfec desc
--SELECT * FROM #FecList

SELECT TOP 1 @MES_ANT_1 = [NomFec] FROM #FecList WHERE rfec <> @fec ORDER BY rfec
SELECT TOP 2 @MES_ANT_2 = [NomFec] FROM #FecList WHERE rfec <> @fec ORDER BY rfec
SELECT TOP 3 @MES_ANT_3 = [NomFec] FROM #FecList WHERE rfec <> @fec ORDER BY rfec
SELECT TOP 4 @MES_ANT_4 = [NomFec] FROM #FecList WHERE rfec <> @fec ORDER BY rfec
SELECT TOP 5 @MES_ANT_5 = [NomFec] FROM #FecList WHERE rfec <> @fec ORDER BY rfec
SELECT @MES_ANT_6 = [NomFec] FROM #FecList WHERE rfec = @fec ORDER BY rfec DESC
--SELECT @MES_ANT_1 [@MES_ANT_1], @MES_ANT_2 [@MES_ANT_2], @MES_ANT_3 [@MES_ANT_3], @MES_ANT_4 [@MES_ANT_4], @MES_ANT_5 [@MES_ANT_5], @MES_ANT_6 [@MES_ANT_6]

select @ORD = max(ORD)
from storage.[com_act].[WGATH001]
where ORD <= case when @diario = 0 then 100 else 31 end
--SELECT @ORD

select @format = iif(@var in(2,3,6),'P','N0')
, @calc = iif(@var in (1,2,4), 'HNRO', iif(@var in (3,6), 'HTAPPMES', 'HMDES') )
--SELECT @calc

/*CABECERAS*/
SET LANGUAGE spanish;
insert into @defs (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY) values
(1,1,2,1,'USUARIO_BT','Usuario BT Administrador','string',1),
(2,2,2,1,'agrupador','Nombre Administrador','string',1)

insert into @defs (TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TCOLS,THIDDEN) values
(2,2,2,1,'v1',@MES_ANT_1,'percent','.2-2',null,null),
(3,3,2,1,'v2',@MES_ANT_2,'percent','.2-2',null,null),
(4,4,2,1,'v3',@MES_ANT_3,'percent','.2-2',null,null),
(5,5,2,1,'v4',@MES_ANT_4,'percent','.2-2',null,null),
(6,6,2,1,'v5',@MES_ANT_5,'percent','.2-2',null,null),
(7,7,2,1,'v6',@MES_ANT_6,'percent','.2-2',null,null),
(8,8,2,1,'A10','Promedio 3 Meses','number','.0-0',null,null)

SET LANGUAGE english;
select rep.FFTHCOLDEF(@defs) result;

select distinct HFECPRO RFEC
into #FECS
from storage.[com_act].[WGATH001]
where ORD = @ORD and RFEC = @fec

select @fec = max(HFECPRO)
from storage.[com_act].[WGATH001]
where ORD = @ORD and RFEC <= @fec

create table #res (
ORD int not null identity(1,1),
DESCR varchar(50),
RFECPRO varchar(50),
RDESPROD varchar(50),
RVAR varchar(50),
ESTILO int,
DFORMAT varchar(10)
)

insert into #res (DESCR,RFECPRO,RDESPROD,RVAR,ESTILO)
select cast(RFEC as varchar), cast(RFEC as varchar),'TOTAL', @calc, 0
--select cast(RFEC as varchar), cast(RFEC as varchar),'TOTAL', 'HMDES', 0
from #FecList--#FECS
order by RFEC asc

update #res set DFORMAT = 'N0'

if(@tip_cod = 18)
BEGIN
	--SELECT GETDATE()

;
with
cte_a
as
(
 --select A.HFECPRO, A.RCODSEC, A.RDESADM, A.HUCAP_FIN, A.HGESTTAS, A.HMDES,A.RCODTER, A.RCODCOR, A.RCODGRU, A.RCODADM
 SELECT A.HFECPRO, A.RCODSEC, A.RDESUNI, A.HUCAP_FIN, A.HGESTTAS, A.HMDES,A.RCODTER, A.RCODCOR, A.RCODGRU, A.RCODUNI,a.RCODUCO
, B.RDESGRU, B.RDESTER, B.RDESCOR, B.RDESSEC
 from storage.[com_act].[WGATH001] A
 LEFT JOIN storage.[ref].WJERCOR03 B ON A.RCODSEC = B.RCODSEC AND RINDFEC = 'ACTUAL' AND B.RFECPRO = @fec
 where ORD = @ORD and A.HFECPRO in (select rfec from #FecList)
 --LEFT JOIN storage.[ref].WJERCOR01 B ON A.RCODSEC = B.RCODSEC AND RINDFEC = 'ACTUAL' AND B.RFECPRO = '20220531'
 --where ORD = 100 and A.HFECPRO in (select rfec from #FecList)
 --SELECT TOP 10 * from storage.[com_act].[WGATH001] WHERE HFECPRO = '20221010'
 --SELECT TOP 10 * from storage.[ref].WJERCOR03
)
,cte_b
as
(
 select '0' ORDI ,isnull(cast(HFECPRO as varchar),'TOTAL') HFECPRO
 --, 'USUARIO BT' [USUARIO_BT]
 --, CAST(0 AS INT) [USUARIO_BT]
 , RCODSEC [USUARIO_BT]
 , case when @tip_cod='7' THEN 'FINANCIERA CONFIANZA'
 --when @tip_cod='15' THEN RDESTER
 --when @tip_cod='14' THEN RDESCOR
 --when @tip_cod='13' THEN RDESGRU
 --when @tip_cod='11' THEN RDESADM
 when @tip_cod = '20' THEN RDESTER--TERRITORIO
 when @tip_cod = '19' THEN RDESCOR--CORREDOR
 when @tip_cod = '21' THEN RDESGRU--GRUPO
 --when @tip_cod = '18' THEN RCODSEC--UNIDAD NEGOCIO
  when @tip_cod = '18' THEN RDESUNI--UNIDAD NEGOCIO
 when @tip_cod = '17' THEN RDESUCO
 WHEN @TIP_COD= '2' THEN RDESSEC--UNIDAD NEGOCIO
 END [AGRUPADOR]
 , isnull(HUCAP_FIN,'TOTAL') HUCAP_FIN
 , isnull(HGESTTAS,10) HGESTTAS
 , cast(count(*)as float) HNRO
 , cast(sum(HMDES) as float) HMDES
 from cte_a
 where case
--when @tip_cod = '7' then cast('1' as varchar(10))
--when @tip_cod = '15' then cast(RCODTER as varchar(10))
--when @tip_cod = '14' then cast(RCODCOR as varchar(10))
--when @tip_cod = '13' then cast(RCODGRU as varchar(10))
--when @tip_cod = '11' then cast(RCODADM as varchar(10)) end =
when @tip_cod = '7' then cast('1' as varchar(10))
when @tip_cod = '20' then cast(RCODTER as varchar(10))
when @tip_cod = '19' then cast(RCODCOR as varchar(10))
when @tip_cod = '21' then cast(RCODGRU as varchar(10))
when @tip_cod = '18' then cast(RCODUNI as varchar(10)) 
when @tip_cod = '17' then cast(RCODUCO as varchar(10))end =
 case when @tip_cod = '7' then '1' else @cod_rel end and HFECPRO<=@fec
 group by HFECPRO
 , RCODSEC
 , case when @tip_cod='7' THEN 'FINANCIERA CONFIANZA'
 --when @tip_cod='15' THEN RDESTER
 --when @tip_cod='14' THEN RDESCOR
 --when @tip_cod='13' THEN RDESGRU
 --when @tip_cod='11' THEN RDESADM
 when @tip_cod = '20' THEN RDESTER
 when @tip_cod = '19' THEN RDESCOR
 when @tip_cod = '21' THEN RDESGRU
 when @tip_cod = '18' THEN RDESUNI
 when @tip_cod = '17' THEN RDESUCO
 WHEN @TIP_COD= '2' THEN RDESSEC
 END
 ,cube(HUCAP_FIN,HGESTTAS)
 union all
 select '1',isnull(cast(HFECPRO as varchar),'TOTAL') [HFECPRO]--
 --, RCODADM [USUARIO_BT]
 --, RDESADM [AGRUPADOR]
 , CAST(RCODUNI AS VARCHAR) [USUARIO_BT]
 , RDESUNI [AGRUPADOR]
 , isnull(HUCAP_FIN,'TOTAL') [HUCAP_FIN]--
 , isnull(HGESTTAS,10) [HGESTTAS]--
 , cast(count(*)as float) [HNRO]--
 , cast(sum(HMDES) as float) [HMDES]--
 from cte_a
 where case when @tip_cod='7' then cast('1' as varchar(10))
 --when @tip_cod='15' then cast(RCODTER as varchar(10))
 --when @tip_cod='14' then cast(RCODCOR as varchar(10))
 --when @tip_cod='13' then cast(RCODGRU as varchar(10))
 --when @tip_cod='11' then cast(RCODADM as varchar(10)) end = case when @tip_cod='7' then '1'
 when @tip_cod = '20' then cast(RCODTER as varchar(10))
 when @tip_cod = '19' then cast(RCODCOR as varchar(10))
 when @tip_cod = '21' then cast(RCODGRU as varchar(10))
 when @tip_cod = '18' then cast(RCODUNI as varchar(10))
 when @tip_cod = '17' then cast(RCODUCO as varchar(10)) end = case when @tip_cod='7' then '1'
 else @cod_rel end and HFECPRO<=@fec
 group by HFECPRO
 --, RCODADM
 --, RDESADM
 , RCODUNI
 , RDESUNI
 ,cube(HUCAP_FIN,HGESTTAS)
)
,
cte_c
as
(
select A.*,A.HNRO/(B.HNRO*1.) HPARTNRO
 ,A.HMDES/(B.HMDES*1.) HPARTMDES
from cte_b A
left join cte_b B on B.HGESTTAS = 10 and B.HUCAP_FIN = 'TOTAL' and A.HFECPRO = B.HFECPRO
)
select *
into #RESULT
from cte_c A
unpivot(valores for variables in([HNRO], [HMDES], [HPARTNRO], [HPARTMDES]) ) UNPTV
order by 1, 2, 3
--SELECT TOP 20 * FROM #RESULT1

select *
into #C
from (
 select *
 from #RESULT
 where /*variables=@calc and*/ HUCAP_FIN = 'TOTAL'
 ) A
pivot ( max(valores) for HGESTTAS in([1],[2],[3],[10]) ) PVT
--select * from #res



select distinct A.ESTILO as style, B.[USUARIO_BT], B.AGRUPADOR, B.ORDI, A.RFECPRO, A.ORD
 , (isnull(B.[3], 0) / (iif(B.[10] = 0, null, B.[10])*1.0) ) PO-- format(isnull(B.[3],0)/(iif(B.[10]=0,null,B.[10])*1.0),'P') PO
 --, (isnull(B.[10], 0) / iif(@var = 2, iif(B.[10] = 0, null, B.[10]), 1.0) ) A10
 , (isnull(B.[10], 0) / iif(5 = 2, iif(B.[10] = 0, null, B.[10]), 1.0) ) A10
into #FIN
from #res A --SELECT * FROM #C
left join #C B ON A.RVAR = B.variables and A.RFECPRO = B.HFECPRO

UPDATE #FIN SET [A10] = 0 WHERE [A10] IS NULL

alter table #FIN add A10N float null
--alter table #FIN add FiltroProm VARCHAR(20) null

--SELECT * FROM #FIN where agrupador IN ('HUAMAN NU EZ DUNIA BETSABE', 'AMESQUITA MADUE O JUNIOR DOMENICK') ORder BY agrupador, ord, [A10]-- < 1

update a
set a.A10N = b.A10N
from #FIN a
inner join (
 select agrupador,sum(ISNULL(a10,0))/3 A10N from #FIN where ord in(6,5,4) group by agrupador
) b
on a.agrupador = b.agrupador

--UPDATE #FIN SET [A10N] = 0 WHERE [A10N] IS NULL

CREATE TABLE #Result1
(
ORDI int null,
[USUARIO_BT] varchar(20) null,
agrupador varchar(max) null,
A10 float null,
v1 float null,
v2 float null,
v3 float null,
v4 float null,
v5 float null,
v6 float null
)

DECLARE @Query NVARCHAR(MAX)
--Primero ponemos las columnas sobre las cuales agruparemos
SET @Query = N'SELECT ORDI, USUARIO_BT, AGRUPADOR, A10N' + NCHAR(10)
--Despu s colocamos las columnas que vamos a transponer
+ (SELECT REPLACE( N', sum(CASE WHEN ORD = <<ORD>> THEN PO END) AS V<<ORD>>', N'<<ORD>>', ORD)+ NCHAR(10)
FROM #FIN
--Eliminamos duplicados usando GROUP BY
GROUP BY ORD
--Definimos el orden de las columnas
-- ORDER BY RORD asc
--Usamos esta instrucci n para concatenar los valores
FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')
--Ponemos el resto de la consulta
+ N'FROM #FIN
group by USUARIO_BT, AGRUPADOR, ORDI, A10N
order by ORDI asc
'

insert into #Result1
EXEC sp_Executesql @Query;

--DELETE #Result1 WHERE ORDI = 0
DELETE #Result1 WHERE A10 IS NULL

SELECT TOP 50 *
FROM #Result1
WHERE agrupador IS NOT NULL
ORDER BY ORDI desc
--ORDER BY ORDI,[v6] DESC


DROP TABLE #C, #FIN, #RESULT, #Result1


END


if(@tip_cod <> 18)
BEGIN

;  
with  
cte_a  
as  
(  
 --select A.HFECPRO, A.RCODSEC, A.RDESADM, A.HUCAP_FIN, A.HGESTTAS, A.HMDES,A.RCODTER, A.RCODCOR, A.RCODGRU, A.RCODADM  
 SELECT A.HFECPRO, A.RCODSEC, A.RDESUNI, A.HUCAP_FIN, A.HGESTTAS, A.HMDES,A.RCODTER, A.RCODCOR, A.RCODGRU, A.RCODUNI ,A.RCODUCO,A.RDESUCO 
  , B.RDESGRU, B.RDESTER, B.RDESCOR    
 from storage.[com_act].[WGATH001] A    
 LEFT JOIN storage.[ref].WJERCOR03 B ON A.RCODSEC = B.RCODSEC AND RINDFEC = 'ACTUAL' AND B.RFECPRO = @fec  
 where ORD = @ORD and A.HFECPRO in (select rfec from #FecList)  
 --LEFT JOIN storage.[ref].WJERCOR01 B ON A.RCODSEC = B.RCODSEC AND RINDFEC = 'ACTUAL' AND B.RFECPRO = '20220531'  
 --where ORD = 100 and A.HFECPRO in (select rfec from #FecList)  
 --SELECT TOP 10 * from storage.[com_act].[WGATH001] WHERE HFECPRO = '20221010'  
 --SELECT TOP 10 * from storage.[ref].WJERCOR03  
)  
,cte_b  
as  
(  
 select '0' ORDI ,isnull(cast(HFECPRO as varchar),'TOTAL') HFECPRO  
 --, 'USUARIO BT' [USUARIO_BT]  
 , CAST(0 AS INT) [USUARIO_BT]  
 , case when @tip_cod='7' THEN 'FINANCIERA CONFIANZA'  
 --when @tip_cod='15' THEN RDESTER  
 --when @tip_cod='14' THEN RDESCOR  
 --when @tip_cod='13' THEN RDESGRU  
 --when @tip_cod='11' THEN RDESADM  
 when @tip_cod = '20' THEN RDESTER--TERRITORIO  
 when @tip_cod = '19' THEN RDESCOR--CORREDOR  
 when @tip_cod = '21' THEN RDESGRU--GRUPO  
 when @tip_cod = '18' THEN RDESUNI--UNIDAD NEGOCIO  
 when @tip_cod = '17' THEN RDESUCO--UNIDAD NEGOCIO  
 when @tip_cod = '2' THEN RDESSEC--UNIDAD NEGOCIO  
 --when @tip_cod = '18' THEN RCODSEC--UNIDAD NEGOCIO  
 END [AGRUPADOR]  
 , isnull(HUCAP_FIN,'TOTAL') HUCAP_FIN  
 , isnull(HGESTTAS,10) HGESTTAS  
 , cast(count(*)as float) HNRO  
 , cast(sum(HMDES) as float) HMDES  
 from cte_a  
 where case  
  --when @tip_cod = '7' then cast('1' as varchar(10))   
  --when @tip_cod = '15' then cast(RCODTER as varchar(10))  
  --when @tip_cod = '14' then cast(RCODCOR as varchar(10))  
  --when @tip_cod = '13' then cast(RCODGRU as varchar(10))  
  --when @tip_cod = '11' then cast(RCODADM as varchar(10)) end =  
  when @tip_cod = '7' then cast('1' as varchar(10))   
  when @tip_cod = '20' then cast(RCODTER as varchar(10))  
  when @tip_cod = '19' then cast(RCODCOR as varchar(10))  
  when @tip_cod = '21' then cast(RCODGRU as varchar(10))  
  when @tip_cod = '18' then cast(RCODUNI as varchar(10))
  when @tip_cod = '17' then cast(RCODUCO as varchar(10)) end =  
 case when @tip_cod = '7' then '1' else @cod_rel end and HFECPRO<=@fec  
 group by HFECPRO  
 , case when @tip_cod='7' THEN 'FINANCIERA CONFIANZA'  
 --when @tip_cod='15' THEN RDESTER  
 --when @tip_cod='14' THEN RDESCOR  
 --when @tip_cod='13' THEN RDESGRU  
 --when @tip_cod='11' THEN RDESADM  
 when @tip_cod = '20' THEN RDESTER  
 when @tip_cod = '19' THEN RDESCOR  
 when @tip_cod = '21' THEN RDESGRU  
  when @tip_cod = '18' THEN RDESUNI--UNIDAD NEGOCIO  
 when @tip_cod = '17' THEN RDESUCO--UNIDAD NEGOCIO  
 when @tip_cod = '2' THEN RDESSEC--UNIDAD NEGOCIO  
 --when @tip_cod = '18' THEN RCODSEC  
 END  
 ,cube(HUCAP_FIN,HGESTTAS)   
 union all  
 select '1',isnull(cast(HFECPRO as varchar),'TOTAL') [HFECPRO]--  
 --, RCODADM [USUARIO_BT]  
 --, RDESADM [AGRUPADOR]  
 , RCODUNI [USUARIO_BT]  
 , RDESUNI [AGRUPADOR]  
 , isnull(HUCAP_FIN,'TOTAL') [HUCAP_FIN]--  
 , isnull(HGESTTAS,10) [HGESTTAS]--  
 , cast(count(*)as float) [HNRO]--  
 , cast(sum(HMDES) as float) [HMDES]--  
 from cte_a  
 where case when @tip_cod='7' then cast('1' as varchar(10))   
 --when @tip_cod='15' then cast(RCODTER as varchar(10))  
 --when @tip_cod='14' then cast(RCODCOR as varchar(10))  
 --when @tip_cod='13' then cast(RCODGRU as varchar(10))  
 --when @tip_cod='11' then cast(RCODADM as varchar(10)) end = case when @tip_cod='7' then '1'  
 when @tip_cod = '20' then cast(RCODTER as varchar(10))  
 when @tip_cod = '19' then cast(RCODCOR as varchar(10))  
 when @tip_cod = '21' then cast(RCODGRU as varchar(10))  
 when @tip_cod = '18' then cast(RCODUNI as varchar(10)) end = case when @tip_cod='7' then '1'  
 else @cod_rel end and HFECPRO<=@fec  
 group by HFECPRO  
 --, RCODADM  
 --, RDESADM  
 , RCODUNI  
 , RDESUNI  
 ,cube(HUCAP_FIN,HGESTTAS)   
)  
,  
cte_c  
as  
(  
select A.*,A.HNRO/(B.HNRO*1.) HPARTNRO   
 ,A.HMDES/(B.HMDES*1.) HPARTMDES  
from cte_b A  
left join cte_b B on B.HGESTTAS = 10 and B.HUCAP_FIN = 'TOTAL' and A.HFECPRO = B.HFECPRO  
)  
select *  
into #RESULT_G
from cte_c A  
unpivot(valores for variables in([HNRO], [HMDES], [HPARTNRO], [HPARTMDES]) ) UNPTV  
order by 1, 2, 3  
--SELECT TOP 20 * FROM #RESULT1  
  
select *  
into #C_G
from (  
 select *  
 from #RESULT_G  
 where /*variables=@calc and*/ HUCAP_FIN = 'TOTAL'  
 ) A  
pivot ( max(valores) for HGESTTAS in([1],[2],[3],[10]) ) PVT  
--select * from #res  
  
select distinct A.ESTILO as style, B.[USUARIO_BT], B.AGRUPADOR, B.ORDI, A.RFECPRO, A.ORD   
 , (isnull(B.[3], 0) / (iif(B.[10] = 0, null, B.[10])*1.0) ) PO-- format(isnull(B.[3],0)/(iif(B.[10]=0,null,B.[10])*1.0),'P') PO  
 --, (isnull(B.[10], 0) / iif(@var = 2, iif(B.[10] = 0, null, B.[10]), 1.0) ) A10  
 , (isnull(B.[10], 0) / iif(5 = 2, iif(B.[10] = 0, null, B.[10]), 1.0) ) A10  
into #FIN_G
from #res A --SELECT * FROM #C  
left join #C_G B ON A.RVAR = B.variables and A.RFECPRO = B.HFECPRO  
  
UPDATE #FIN_G SET [A10] = 0 WHERE [A10] IS NULL  
   
alter table #FIN_G add A10N float null  
--alter table #FIN add FiltroProm VARCHAR(20) null  
  
--SELECT * FROM #FIN where agrupador IN ('HUAMAN NU EZ DUNIA BETSABE', 'AMESQUITA MADUE O JUNIOR DOMENICK') ORder BY agrupador, ord, [A10]-- < 1  
   
update a  
set a.A10N = b.A10N  
from #FIN_G a   
inner join (  
 select agrupador,sum(ISNULL(a10,0))/3 A10N from #FIN_G where ord in(6,5,4) group by agrupador  
) b  
on a.agrupador = b.agrupador  
  
--UPDATE #FIN SET [A10N] = 0 WHERE [A10N] IS NULL  
  
CREATE TABLE #Result1_G
(  
ORDI int null,  
[USUARIO_BT] varchar(20) null,  
agrupador varchar(max) null,  
A10 float null,  
v1 float null,  
v2 float null,  
v3 float null,  
v4 float null,  
v5 float null,  
v6 float null  
)  
  
DECLARE @Query_G NVARCHAR(MAX)  
--Primero ponemos las columnas sobre las cuales agruparemos  
SET @Query_G = N'SELECT ORDI, USUARIO_BT, AGRUPADOR, A10N' + NCHAR(10)  
--Despu s colocamos las columnas que vamos a transponer  
+ ( SELECT REPLACE( N', sum(CASE WHEN ORD = <<ORD>> THEN PO END) AS V<<ORD>>', N'<<ORD>>', ORD)+ NCHAR(10)  
FROM #FIN_G
--Eliminamos duplicados usando GROUP BY  
GROUP BY ORD  
--Definimos el orden de las columnas  
-- ORDER BY RORD asc  
--Usamos esta instrucci n para concatenar los valores  
FOR XML PATH(''), TYPE).value('./text()[1]', 'varchar(max)')  
--Ponemos el resto de la consulta  
+ N'FROM #FIN_G
group by USUARIO_BT, AGRUPADOR, ORDI, A10N  
order by ORDI asc  
'  
  
insert into #Result1_G  
EXEC sp_Executesql @Query_G;  
  
--DELETE #Result1 WHERE ORDI = 0  
DELETE #Result1_G WHERE A10 IS NULL  
  
SELECT TOP 50 *  
FROM #Result1_G  
WHERE agrupador IS NOT NULL  
ORDER BY ORDI desc
--ORDER BY ORDI,[v6] DESC


DROP TABLE #C_G, #FIN_G, #RESULT_G, #Result1_G


END



END
