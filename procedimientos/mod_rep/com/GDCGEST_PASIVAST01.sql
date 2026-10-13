-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-08-18 08:43:52.973000
--exec [com].[GDCGEST_PASIVAST01] 7,'231',102,1,1,'20210630'
CREATE procedure [com].[GDCGEST_PASIVAST01]  
@tipcod int,@codrel varchar(20) ,@var varchar(5), @agr int = 1, @calc int = 1,@fec date  
as
begin
 SET NOCOUNT ON;       
--declare @tipcod int=7,@codrel varchar(5)='231',@fec date='2021-06-30',@var varchar(10)=102,@agr int=1,@calc int=1
select @fec=max(HFECPRO) from storage.com_pas.WBAUT001 where HFECPRO<=@fec

exec strategos.[mod_rep_com_act].[CABGDCGEST_PASIVASTAPI01] @tipcod,@codrel,@var,@agr,@calc,@fec

declare @tppm_nro_part varchar(10),@format varchar(10)

select @tppm_nro_part=iif(@calc=1,'HTPPM',iif(@calc=2,'NRO','PART'))
select @format=iif(@calc=1,'P','N0')
select @var=iif(@var=101,'RED',iif(@var=102,'BP','TES'))

create table #RES(
VAR1 int,
ORD int,
HPLAZO varchar(50),
HTRAMO varchar(50),
HMODA varchar(50),
HTPER varchar(50),
HDESC varchar(50), 
HSTYLE int,
HVARIABLES varchar(10),
HFORMAT varchar(10)
)

insert into #RES (VAR1,ORD,HPLAZO,HTRAMO,HMODA,HTPER,HDESC,HSTYLE)
values

(1,2,'TOTAL','TOTAL','TOTAL','Fisica','P. NATURAL',2)
,(1,3,'TOTAL','TOTAL','SOL','Fisica','SOLES',1)
,(1,4,'[0 - 30]','TOTAL','SOL','Fisica','[0 - 30]',0)
,(1,5,'[31 - 90]','TOTAL','SOL','Fisica','[31 - 90]',0)
,(1,6,'[91 - 180]','TOTAL','SOL','Fisica','[91 - 180]',0)
,(1,7,'[181 - 360]','TOTAL','SOL','Fisica','[181 - 360]',0)
,(1,8,'[361 - 720]','TOTAL','SOL','Fisica','[361 - 720]',0)
,(1,9,'[721 - 1,080]','TOTAL','SOL','Fisica','[721 - 1,080]',0)
,(1,10,'[1,081 - más]','TOTAL','SOL','Fisica','[1,081 - más]',0)
,(1,11,'TOTAL','TOTAL','Dolar Americano','Fisica','DOLARES',1)
,(1,12,'[0 - 30]','TOTAL','Dolar Americano','Fisica','[0 - 30]',0)
,(1,13,'[31 - 90]','TOTAL','Dolar Americano','Fisica','[31 - 90]',0)
,(1,14,'[91 - 180]','TOTAL','Dolar Americano','Fisica','[91 - 180]',0)
,(1,15,'[181 - 360]','TOTAL','Dolar Americano','Fisica','[181 - 360]',0)
,(1,16,'[361 - 720]','TOTAL','Dolar Americano','Fisica','[361 - 720]',0)
,(1,17,'[721 - 1,080]','TOTAL','Dolar Americano','Fisica','[721 - 1,080]',0)
,(1,18,'[1,081 - más]','TOTAL','Dolar Americano','Fisica','[1,081 - más]',0)
,(1,19,'TOTAL','TOTAL','TOTAL','Juridica','P. JURIDICA',2)
,(1,20,'TOTAL','TOTAL','SOL','Juridica','SOLES',1)
,(1,21,'[0 - 180]','TOTAL','SOL','Juridica','[0 - 180]',0)
,(1,22,'[181 - 360]','TOTAL','SOL','Juridica','[181 - 360]',0)
,(1,23,'[361 - más]','TOTAL','SOL','Juridica','[361 - más]',0)
,(1,28,'TOTAL','TOTAL','Dolar Americano','Juridica','DOLARES',1)
,(1,29,'[0 - 180]','TOTAL','Dolar Americano','Juridica','[0 - 180]',0)
,(1,30,'[181 - 360]','TOTAL','Dolar Americano','Juridica','[181 - 360]',0)
,(1,31,'[361 - más]','TOTAL','Dolar Americano','Juridica','[361 - más]',0)
,(1,32,'TOTAL','TOTAL','TOTAL','TOTAL','TOTAL',2)
--
,(2,2,'TOTAL','TOTAL','TOTAL','Fisica','P. NATURAL',2)
,(2,3,'TOTAL','TOTAL','SOL','Fisica','SOLES',1)
,(2,4,'TOTAL','[0 - 100>','SOL','Fisica','[0 - 100>',0)
,(2,5,'TOTAL','[100 - 10,000>','SOL','Fisica','[100 - 10,000>',0)
,(2,6,'TOTAL','[10,000 - 100,000>','SOL','Fisica','[10,000 - 100,000>',0)
,(2,7,'TOTAL','[100,000 - 500,000>','SOL','Fisica','[100,000 - 500,000>',0)
,(2,8,'TOTAL','[500,000 - más>','SOL','Fisica','[500,000 - más>',0)
,(2,9,'TOTAL','TOTAL','Dolar Americano','Fisica','DOLARES',1)
,(2,10,'TOTAL','[0 - 100>','Dolar Americano','Fisica','[0 - 100>',0)
,(2,11,'TOTAL','[100 - 25,000>','Dolar Americano','Fisica','[100 - 25,000>',0)
,(2,12,'TOTAL','[25,000 - 100,000>','Dolar Americano','Fisica','[25,000 - 100,000>',0)
,(2,13,'TOTAL','[100,000 - más>','Dolar Americano','Fisica','[100,000 - más>',0)
,(2,14,'TOTAL','TOTAL','TOTAL','Juridica','P. JURIDICA',2)
,(2,15,'TOTAL','TOTAL','SOL','Juridica','SOLES',1)
,(2,16,'TOTAL','[0 - 200,000>','SOL','Juridica','[0 - 200,000>',0)
,(2,17,'TOTAL','[200,000 - más>','SOL','Juridica','[200,000 - más>',0)
,(2,18,'TOTAL','TOTAL','Dolar Americano','Juridica','DOLARES',1)
,(2,19,'TOTAL','[0 - 100,000>','Dolar Americano','Juridica','[0 - 100,000>',0)
,(2,20,'TOTAL','[100,000 - más>','Dolar Americano','Juridica','[100,000 - más>',0)
,(2,21,'TOTAL','TOTAL','TOTAL','TOTAL','TOTAL',2)

update #RES
set		HVARIABLES=@tppm_nro_part,HFORMAT=@format

insert into #RES (VAR1,ORD,HPLAZO,HTRAMO,HMODA,HTPER,HDESC,HSTYLE,HVARIABLES,HFORMAT)
values
(iif(@calc=1,1,null),33,'TOTAL','TOTAL','TOTAL','TOTAL','TASA MÁX.',2,iif(@calc=1,'HTPPMAX',null),@format)
,(iif(@calc=1,1,null),34,'TOTAL','TOTAL','TOTAL','TOTAL','VAR. (PBS)',2,iif(@calc=1,'HPBS',null),'N0')
,(iif(@calc=1,2,null),22,'TOTAL','TOTAL','TOTAL','TOTAL','TASA MÁX.',2,iif(@calc=1,'HTPPMAX',null),@format)
,(iif(@calc=1,2,null),23,'TOTAL','TOTAL','TOTAL','TOTAL','VAR. (PBS)',2,iif(@calc=1,'HPBS',null),'N0')

select		*
into		#JER 
from		storage.ref.VJERCOR03 A
where		case when @tipcod=7 then 1 
				when @tipcod=15 then RCODTER
				when @tipcod=14 then RCODCOR
				when @tipcod=12 then RCODMAT end = case when @tipcod=7 then 1
														else @codrel end

select		isnull(HTDPER,'TOTAL')HTDPER
			,isnull(HMONED,'TOTAL')HMONED
			,isnull(HPLAZO1,'TOTAL')HPLAZO1
			,isnull(HTRAMO1,'TOTAL')HTRAMO1
			,'TOTAL' HUCAPR2
			,isnull(CODGEST1,10)CODGEST1
			,cast(count(*) as float) NRO
			,cast(sum(HMAPER*HAOTASA/100.0)/case when sum(HMAPER)=0 then null else sum(HMAPER) end as float) HTPPM
			,cast(sum(HMAPER*HTMAXI/100.0)/case when sum(HMAPER)=0 then null else sum(HMAPER) end as float) HTPPMAX
			,cast((sum(HMAPER*HAOTASA/100.0)/case when sum(HMAPER)=0 then null else sum(HMAPER) end - sum(HMAPER*HTMAXI/100.0)/case when sum(HMAPER)=0 then null else sum(HMAPER) end )*10000 as float) HPBS
into		#A
from		storage.com_pas.WBAUT001  A
join		#JER B
on			A.HCOFIC=B.RCODAGE
where		HFECPRO=@fec and HRENOV='NO'
			AND HDMODU='DEPÓSITOS A PLAZO FIJO' and CANAL=@var
group by    CUBE(HTDPER,HMONED,HPLAZO1,HTRAMO1,CODGEST1)

select		isnull(HTDPER,'TOTAL')HTDPER
			,isnull(HMONED,'TOTAL')HMONED
			,isnull(HPLAZO1,'TOTAL')HPLAZO1
			,isnull(HTRAMO1,'TOTAL')HTRAMO1
			,isnull(HUCAPR2,'TOTAL')HUCAPR2
			,10 CODGEST1
			,cast(count(*) as float) NRO
			,cast(sum(HMAPER*HAOTASA/100.0)/case when sum(HMAPER)=0 then null else sum(HMAPER) end as float) HTPPM
			,cast(sum(HMAPER*HTMAXI/100.0)/case when sum(HMAPER)=0 then null else sum(HMAPER) end as float) HTPPMAX
			,cast((sum(HMAPER*HAOTASA/100.0)/case when sum(HMAPER)=0 then null else sum(HMAPER) end - sum(HMAPER*HTMAXI/100.0)/case when sum(HMAPER)=0 then null else sum(HMAPER) end )*10000 as float) HPBS
into		#B
from		storage.com_pas.WBAUT001  A
join		#JER B
on			A.HCOFIC=B.RCODAGE
where		HFECPRO=@fec and HRENOV='NO'
			AND HDMODU='DEPÓSITOS A PLAZO FIJO' and CANAL=@var
group by    CUBE(HTDPER,HMONED,HPLAZO1,HTRAMO1,HUCAPR2)

select * into  #C from #A  unpivot (valores for variables in (HTPPM,HTPPMAX,HPBS,NRO)) UNPVT order by 1,2,3
select * into  #D from #B  unpivot (valores for variables in (HTPPM,HTPPMAX,HPBS,NRO)) UNPVT order by 1,2,3

select * 
into	#E 
from	(select HTDPER,HPLAZO1,HTRAMO1,HMONED,variables,valores,CODGEST1,HUCAPR2 from #C /*where variables=@tppm_nro_part and HUCAPR2='TOTAL'*/ ) A pivot (max(valores) for CODGEST1 in([1],[2],[3],[10])) PVT

select * 
into	#F 
from	(select HTDPER,HPLAZO1,HTRAMO1,HMONED,variables,valores,CODGEST1,HUCAPR2 from #D /*where variables=@tppm_nro_part and HUCAPR2<>'TOTAL' and CODGEST1<>10*/ ) A pivot (max(valores) for HUCAPR2 in([Administrador],[Ejecutivo de Banca Preferente],[Gerente Corredor],[Gerente Territorial],[Tesoreria],[TOTAL])) PVT
--select * from #B order by 1,2,3,4
--select * from #C order by 1,2,3,4
--select * from #D order by 1,2,3,4
;with cte_a as(
select		A.HPLAZO1,A.HTRAMO1,A.HTDPER,A.HMONED,A.variables,A.[3],A.[2]
			,B.[Administrador],B.[Ejecutivo de Banca Preferente]
			,B.[Gerente Corredor],B.[Gerente Territorial],B.[Tesoreria]
			,A.[1],A.[10]
from		#E A
left join	#F B
on			A.HPLAZO1=B.HPLAZO1 and A.HTRAMO1=B.HTRAMO1 and A.HTDPER=B.HTDPER and A.HMONED=B.HMONED and A.variables=B.variables
)
select		A.HSTYLE style,A.HDESC
			,format(isnull(B.[3],0),HFORMAT) [3]
			,format(isnull(B.[2],0),HFORMAT) [2]
			,format(isnull(B.[Administrador],0),HFORMAT) [Admin]
			,format(isnull(B.[Gerente Corredor],0),HFORMAT) [GerenteCorredor]
			,format(isnull(B.[Gerente Territorial],0),HFORMAT) [GerenteTerritorial]
			,format(isnull(B.[Ejecutivo de Banca Preferente],0),HFORMAT) [EjBancaPref.]
			,format(isnull(B.[Tesoreria],0),HFORMAT) [Tesoreria]
			,format(isnull(B.[1],0),HFORMAT) [1]
			,format(isnull(B.[10],0),HFORMAT) [10]
from		#RES A
left join	cte_a B
on			A.HPLAZO=B.HPLAZO1 and B.HTRAMO1=A.HTRAMO and B.HTDPER=A.HTPER and A.HMODA=B.HMONED and A.HVARIABLES=B.variables
where		A.VAR1=@agr and A.ORD is not null
order by	A.ORD

drop table #A
drop table #B
drop table #C
drop table #D
drop table #E
drop table #F
drop table #JER
drop table #RES

end
