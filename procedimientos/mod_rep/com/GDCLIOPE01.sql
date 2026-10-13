-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-11 08:18:35.197000
--EXEC [mod_rep].[com].[GDCLIOPE01] '7', '231'  
CREATE procedure [com].[GDCLIOPE01]  
@tip_cod int, @cod_rel varchar(20)  
----------------------------------------------------------------------------------  
as  
begin  
--declare @tip_cod int =7, @cod_rel varchar(20) = '231'  
SET NOCOUNT ON;  
declare @fecs varchar(max)declare @fec_a varchar(8);  
declare @defs as rep.TTHCOLDEF;   
  
SET LANGUAGE spanish;  
insert into @defs  
(TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TSTICKY) values  
(1,1,2,1,'descripcion','Descripción','string',1)  
  
insert into @defs  
(TORDER,TISDATA,TROWS,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TCOLS,THIDDEN) values  
(2,2,2,1,'stock_cli','Stock de Clientes','number',null,null,null),  
(3,3,2,1,'var_cli','Variación de Clientes','number',null,null,null),  
(4,4,2,1,'meta_var_cli','Meta','number','.0-0',null,null),  
(5,5,2,1,'sem_var_cli','','traffic-light',null,null,'true'),  
(6,6,2,1,'dist_meta_var_cli','Distancia Meta','number','.0-0',2,null),  
(7,7,2,1,'ope_desem','Nro. Oper. Desembolsadas','number',null,null,null),  
(8,8,2,1,'meta_ope_desem','Meta','number',null,null,null),  
(9,9,2,1,'sem_ope_desem','','traffic-light',null,null,'true'),  
(10,10,2,1,'dist_meta_ope_desem','Distancia Meta','string',null,2,null)  
  
 SET LANGUAGE english;  
 select rep.FFTHCOLDEF(@defs) result;  
  
 select @fecs=(select replace(cast(max(hfecpro) as varchar(250)),'-','') from [storage].[com_act].WACLI001)  
  
 select top 1  
 @fec_a=max(RFECTXT)   
 from storage.ref.RCALEN001  
 where RFEC<=cast(eomonth(@fecs,-1) as date) and RDIAFER=0  
  
 --select  @fec_a
  
declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)  
  
  
  
  
insert into @tvars  
values ('num_cli_stock', null, '166', null, null, null), ('num_ope_sf2', null, '5006', null, null, null)  
  
  
insert into @tfil values ('todos', 'fec', ''+@fecs+'')  
insert into @tconf values ('level_alias', 'style')  
  
insert into @tfil  
exec [piv].[GPIVLEV01] @tip_cod,@cod_rel,@jerar output   
    
/*  
drop table #DES  
drop table #DESAN  
drop table #Result000   
*/  
  
create table #DES (fila int null, cod_fc varchar(250)null,cod_cter varchar(250)null,style int null,descripcion varchar(max)null,[166CLI] float null,[5006] float null)  
insert into #DES  
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf-- ,@show_query=1  
  
   
delete from @tfil where TKEYFIL='fec' insert into @tfil values ('todos', 'fec', @fec_a)  
  
create table #DESAN (fila int null, cod_fc varchar(250)null,cod_cter varchar(250)null,style int null,descripcion varchar(max)null,[166CLI] float null,[5006] float null)  
insert into #DESAN  
exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jerar,@columns='"vars"',@config=@tconf-- ,@show_query=1  
   
-- select * from #DES   
alter table #DES  
add [166] float null  
-- select * from #DESAN  
alter table #DESAN  
add [166] float null  
 --select HNUMCLI from storage.com_act.WJAS001 where hfecpro='2021-03-22' and htipcod=7   
-- declare @fecs varchar(10)= '2022-06-18', @tip_cod int=7, @cod_rel varchar(10)='231',@fec_a varchar(10)= '2022-05-31'  
update a set a.[166]=b.HNUMCLI  
from #Des a left join (select* from storage.com_act.WJAS001 where hfecpro=cast(@fecs as date)) b  
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel  
  
  
update a set a.[166]=b.HNUMCLI  
from #Des a left join (select* from storage.com_act.WJAS001 where hfecpro=cast(@fecs as date)) b   
on case when @tip_cod=7 then '21'--fc--gru   
 when @tip_cod=21 then '20'--gru-terr  
 when @tip_cod=20 then '19' --terr-corr  
 when @tip_cod=19 then '18'   --corr-uni  
 when @tip_cod=18 then '17' --coordinador
 when @tip_cod=17 then '1' end=b.HTIPCOD and a.cod_cter=b.hcodrel --uni-asec  
where a.style<>1  
  
-- declare @fec_a varchar(10)= '2022-05-31', @tip_cod int=7, @cod_rel varchar(10)='231'  
-- select * from #DESAN  
update a set a.[166]=b.HNUMCLI  
from #DESAN a left join (select* from storage.com_act.WJAS001 where hfecpro=cast(@fec_a as date)) b  
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel  
  
update a set a.[166]=b.HNUMCLI  
from #DESAN a left join (select* from storage.com_act.WJAS001 where hfecpro=cast(@fec_a as date)) b   
on case when @tip_cod=7 then '21'  
 when @tip_cod=21 then '20'  
 when @tip_cod=20 then '19'  
 when @tip_cod=19 then '18'
 when @tip_cod=18 then '17'
 when @tip_cod=17 then '1' end=b.HTIPCOD and a.cod_cter=b.hcodrel  
/*on case when @tip_cod=7 then '15'  
 when @tip_cod=15 then '14'  
 when @tip_cod=13 then '11'   
 when @tip_cod=11 then '1' end=b.HTIPCOD and a.cod_cter=b.hcodrel */   
where a.style<>1  
  
--SELECT A.FILA,A.COD_FC,A.COD_CTER,A.STYLE,A.descripcion,A.[166] as stock_cli,A.[166] - B.[166] as var_cli , A.[5006]  as ope_desem,  
SELECT A.FILA,A.COD_FC,A.COD_CTER,A.STYLE,A.descripcion,A.[166] as stock_cli,isnull(A.[166],0) - isnull(B.[166],0) as var_cli,  
 A.[5006]  as ope_desem, null as meta_var_cli,null as sem_var_cli,null dist_meta_var_cli,null as meta_ope_desem,  
 null as sem_ope_desem,null as dist_meta_ope_desem  
into #Result000  
FROM #DES A left JOIN #DESAN B ON A.descripcion=B.descripcion  
order by style desc  
--select * from #Result000   
  
  
-- declare @fecs varchar(10)= '2022-06-18', @tip_cod int=7, @cod_rel varchar(10)='231'   
update a set a.meta_var_cli=b.hvalvar  
--from #Result000 a left join (select* from [storage].[com].[VDMCOM01] where HCODVAR=166 and hfecpro=eomonth(@fecs)) b  
from #Result000 a left join (select* from [storage].[com].[VDMCOM01] where HCODVAR=10062 and hfecpro=eomonth(@fecs)) b  
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel  
  
update a set a.meta_var_cli=b.hvalvar  
--from #Result000 a left join (select* from [storage].[com].[VDMCOM01] where HCODVAR=166 and hfecpro=eomonth(@fecs)) b  
from #Result000 a left join (select* from [storage].[com].[VDMCOM01] where HCODVAR=10062 and hfecpro=eomonth(@fecs)) b  
on case when @tip_cod=7 then '21'  
 when @tip_cod=21 then '20'  
 when @tip_cod=20 then '19'  
 when @tip_cod=19 then '18'
 when @tip_cod=18 then '17'
 when @tip_cod=17 then '2' end=b.HTIPCOD and isnull(a.cod_cter,'231')=b.hcodrel  
where a.style<>1  
  
-- declare @fecs varchar(10)= '2022-06-18', @tip_cod int=7, @cod_rel varchar(10)='231'   
update a set a.meta_ope_desem=b.hvalvar  
from #Result000 a left join (select* from [storage].[com].[VDMCOM01] where HCODVAR=5006 and hfecpro=eomonth(@fecs)) b  
on b.HTIPCOD=@tip_cod and b.hcodrel=@cod_rel  
  
update a set a.meta_ope_desem=b.hvalvar  
from #Result000 a left join (select* from [storage].[com].[VDMCOM01] where HCODVAR=5006 and hfecpro=eomonth(@fecs)) b  
on case when @tip_cod=7 then '21'  
 when @tip_cod=21 then '20'  
 when @tip_cod=20 then '19'  
 when @tip_cod=19 then '18'
 when @tip_cod=18 then '17'
 when @tip_cod=17 then '2' end=b.HTIPCOD and isnull(a.cod_cter,'231')=b.hcodrel  
where a.style<>1   
-- select * from #Result000  
  
select fila,cod_fc,cod_cter,style,descripcion,  
 util.FFMTVAR(isnull(166,0), isnull(stock_cli,0),null) stock_cli,  
 util.FFMTVAR(isnull(166,0), isnull(var_cli,0),null) var_cli,  
 util.FFMTVAR(isnull(166,0), isnull(ope_desem,0),null) ope_desem,  
 util.FFMTVAR(isnull(166,0), isnull(meta_ope_desem,0),null) meta_ope_desem,  
 meta_var_cli,  
 null sem_var_cli,--cast(util.FSEMVAR(166,isnull(meta_var_cli,0),isnull(stock_cli,0)-isnull(meta_var_cli,0)) as varchar) sem_var_cli,  
 stock_cli - meta_var_cli as dist_meta_var_cli,  
 cast(util.FSEMVAR(5006,isnull(meta_ope_desem,0), isnull(ope_desem,0)-isnull(meta_ope_desem,0)) as varchar) sem_ope_desem,  
 util.FFMTVAR(isnull(166,0),  
 isnull(ope_desem - meta_ope_desem,0),null) as dist_meta_ope_desem  
from #Result000 order by style desc  
  
end
