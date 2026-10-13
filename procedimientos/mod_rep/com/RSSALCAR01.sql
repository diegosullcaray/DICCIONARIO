-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-11 09:25:11.203000
--sp_helptext 'com.RSSALCAR01'
--EXEC com.RSSALCAR01 7,'231','20240708'--FC
--EXEC com.RSSALCAR01 21,'1','20240708'--GRUPAL
--EXEC com.RSSALCAR01 20,'1_3','20240708'--TERRITORIO
--EXEC com.RSSALCAR01 19,'20','20240708'--CORREDOR
--EXEC com.RSSALCAR01 18,'141','20240710'--UNIDAD DE NEGOCIO
CREATE PROCEDURE [com].[RSSALCAR01]
@tip_cod int,@cod_rel varchar(20), @fecha date
AS
BEGIN
 set nocount on;
 --declare @tip_cod int =18,@cod_rel varchar(20)=141, @fecha varchar(8)='20240709'
  --declare @tip_cod int =7,@cod_rel varchar(20)=231, @fecha varchar(8)='20240710'

 declare @fec varchar(8);
 declare @defs as rep.TTHCOLDEF;
 declare @w varchar(10)='10%';
 declare @fec_a varchar(8);

 select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)

 select top 1 
@fec_a=RFECTXT 
 from storage.ref.RCALEN001 
 where RFEC<=cast(eomonth(@fec,-1) as date) and RDIAFER=0 
 order by RFEC desc

 --select MONTH(@fec),YEAR(@fec)
 --if(MONTH(@fec)=8 and YEAR(@fec)=2020)
--select @fec_a='20200801'
--SELECT FORMAT(@fec_a,'dd-MMMM') Fecha;
 SET LANGUAGE spanish; 
 insert into @defs
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)values
 (1,1,1,'descripcion','Descripción','string',1)
 insert into @defs
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,THIDDEN,TCOLS,TSTBACKGROUND)values
 (2,2,1,'sal_cap_ant','Saldo Inicial de Cartera<br>'+format(cast(@fec_a as date),'dd-MMM'),'number','.0-0',@w,null,null,null),
 (3,3,1,'sal_cap','Saldo Real a la Fecha','number','.0-0',@w,null,null,null),
 (4,4,1,'meta_cart','Meta de Cartera','number','.0-0',@w,null,null,null),
 (5,5,1,'sem_met_cart','','traffic-light',null,null,1,null,null),
 (6,6,1,'dist_met_cart','Distancia Meta Cartera *','number','.0-0',@w,null,2,'#ce2b2b'),
 (7,7,1,'sal_med_cart','Saldo Medio de Cartera','number','.0-0',@w,null,null,null),
 (8,8,1,'var_cart','Variación de Cartera','number','.0-0',@w,null,null,null),
 (9,9,1,'meta_var_cart','Meta Var Cartera','number','.0-0',@w,null,null,null),
 (10,10,1,'sem_met_var_cart','','traffic-light',null,null,1,null,null),
 (11,11,1,'dist_met_var_cart','Distancia Meta Var Cartera','number','.0-0',@w,null,2,null)
 SET LANGUAGE english; 

 --select * from @defs
 select rep.FFTHCOLDEF(@defs) result;

 declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF

 insert into @tvars values
 ('sal_cap',null,null,null,null,null) 

 insert into @tfil
 values
 ('saldos_stock_1','fec',''+@fec+'')--,

 --declare @tip_cod int=15,@cod_rel varchar(100)='2'

 declare @lvl_cfg varchar(max)= '1'

 declare @jer varchar(100);
 insert into @tfil
 exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output,9,@lvl_cfg

 --EXEC com.RSSALCAR01 7,'231','20240708'--FC 
--EXEC com.RSSALCAR01 18,'141','20240710'--UNIDAD DE NEGOCIO
  

 insert into @tconf
 values
 ('level_alias','style')

 

 --create table #ract (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),sal_cap float)
 --insert into #ract
 --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1


 	 --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1


 create table #ract0 (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),sal_cap float)
 create table #ract1 (fila int,cod_n1 varchar(100),cod_n2 varchar(100),cod_n3 varchar(100),style int,descripcion varchar(100),sal_cap float)

  if (@tip_cod <>18) begin
	 insert into #ract0
	 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1
  end

  if (@tip_cod =18) begin
	 insert into #ract1
	 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1
  end 
  select fila ,cod_n1 ,cod_n2,cast(NULL as varchar) cod_n3 ,style ,descripcion ,sal_cap into #ract   from #ract0
  union
  select  fila ,cod_n1 ,cod_n2, cod_n3,style ,descripcion ,sal_cap   from #ract1





 
 delete from @tfil where TKEYFIL = 'fec'
 insert into @tfil values ('saldos_stock_1','fec',''+@fec_a+'')

 --create table #rant (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),sal_cap float)
 --insert into #rant
 --exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1


 create table #rant0 (fila int,cod_n1 varchar(100),cod_n2 varchar(100),style int,descripcion varchar(100),sal_cap float)
 create table #rant1 (fila int,cod_n1 varchar(100),cod_n2 varchar(100),cod_n3 varchar(100),style int,descripcion varchar(100),sal_cap float)

  if (@tip_cod <>18) begin
	 insert into #rant0
	 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1
  end

  if (@tip_cod =18) begin
	 insert into #rant1
	 exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1
  end 
  select fila ,cod_n1 ,cod_n2, cast(NULL as varchar) cod_n3 ,style ,descripcion ,sal_cap into #rant   from #rant0
  union
  select  fila ,cod_n1 ,cod_n2,cod_n3 ,style ,descripcion ,sal_cap   from #rant1















   

--EXEC com.RSSALCAR01 17,'1141','20240709'--UNIDAD DE NEGOCIO

--declare @fec date = '20240709',@tip_cod int=7
 declare @fec_d date=@fec--'20200808'
 ;with cte_m as (
select HTIPCOD,HCODREL,[100] meta_cart,[8000] meta_var_cart
from (
select HCODVAR,HTIPCOD,iif(HCODREL='231' AND HTIPCOD = 7,'7',HCODREL) HCODREL,HVALVAR
from storage.[com].[VDMCOM01]
where HFECPRO=eomonth(@fec_d) and HCODVAR in (100,8000)
and HTIPCOD in (@tip_cod, iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1)) ,2)
) as p
pivot (
max(HVALVAR) FOR HCODVAR IN ([100],[8000])
) as pv
),
 cte_act as (
 select * from #ract --drop table #report
 ),
 cte_ant as (
 select * from #rant
 )
 select r.*,b.sal_cap sal_cap_ant, 
 m.meta_cart,isnull(r.sal_cap,0)-isnull(m.meta_cart,0) dist_met_cart,m.meta_var_cart,
 isnull(r.sal_cap,0)-isnull(b.sal_cap,0) var_cart,(isnull(r.sal_cap,0)-isnull(b.sal_cap,0))-isnull(meta_var_cart,0) dist_met_var_cart,
 case
when m.meta_cart is null then null
when r.sal_cap>m.meta_cart then 1
when r.sal_cap>m.meta_cart*95/100.0 then 0
else -1 end sem_met_cart,
case
when m.meta_var_cart is null then null
when (isnull(r.sal_cap,0)-isnull(b.sal_cap,0))>isnull(meta_var_cart,0) then 1
when (isnull(r.sal_cap,0)-isnull(b.sal_cap,0))>isnull(meta_var_cart,0)*95/100.0 then 0
else -1 end sem_met_var_cart

,b.descripcion,r.descripcion
,iif(r.cod_n2 is null,@tip_cod,iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1))),m.HTIPCOD
,isnull(isnull(r.cod_n3,r.cod_n2),r.cod_n1),m.HCODREL
,r.cod_n1,r.cod_n2,r.cod_n3
 from cte_act r
 left join cte_ant b on b.descripcion=r.descripcion
 left join cte_m m on 
 iif(r.cod_n3 is null,  iif(r.cod_n2 is null,@tip_cod,iif(@tip_cod=7,21,iif(@tip_cod=17,2,@tip_cod-1)))  ,2) =m.HTIPCOD
 and isnull(isnull(r.cod_n3,r.cod_n2),r.cod_n1)=m.HCODREL
 order by r.fila


 
 drop table #ract,#ract0,#ract1,#rant,#rant0,#rant1 


end
