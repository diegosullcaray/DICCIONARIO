-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-08-21 11:36:11.643000
--exec [com].[GSEGUIINC001] 7,'231'
CREATE PROCEDURE [com].[GSEGUIINC001]
@tip_cod int,@cod_rel varchar(20),
@fec varchar(10)='NOW'
AS
BEGIN
	SET NOCOUNT ON;

	declare @cfec date
	select @cfec=RFEC
	from storage.util.FVECFEC01(dateadd(day,-1,getdate()),'hoy')
	if(@fec<>'NOW')
	begin
		set @cfec=@fec
	end

	select *
	into #jer
	from storage.ref.FJERCOR02(@cfec)

	create table #tbl (SLVLHIER varchar(250),STIPCOD varchar(250),SCODREL varchar(250),SDESREL varchar(250),SLBLHIER varchar(250))

	declare @p varchar(250) = '{"key":"fec","val":"'+format(@cfec,'yyyyMMdd')+'"}'

	insert into #tbl
	exec mod_sys_admin.dbo.GLEVHIER01 @tip_cod,@cod_rel,11,6,@p

	declare @tbl_l as table(cod_sec varchar(20),des_sec varchar(200),des_uni varchar(200),des_cor varchar(200),des_ter varchar(200),des_car varchar(200),des_gru varchar(200))

	;with a as (
	select distinct HASEOPER HCODSEC
	from storage.com_act.HCDA001
	where HFECPRO=@cfec
	)
	insert into @tbl_l
	select A.SCODREL cod_sec,A.SDESREL des_sec,C.RDESUNI des_uni,C.RDESCOR des_cor,C.RDESTER des_ter,D.HDESCAR des_car,C.RDESGRU des_gru
	from #tbl A
	join a B
	on B.HCODSEC=A.SCODREL
	left join #jer C
	on C.RFECPRO=@cfec
	and A.SCODREL=C.RCODSEC
	left join storage.gpr.VPPH001 D
	on D.HCODBT=A.SCODREL
	order by 1

	select '[{}]';

	;with a as (
	select 
	A.cod_sec,
	iif(HSALMET is null,1,0) sal_fmet,
	isnull(HSALMET,0) sal_met,
	isnull(HSALINI,0) sal_ini,
	isnull(HSALCIEN,0) sal_cie,
	isnull(HSALCIENO,0) sal_tra,
	isnull(HSALCIEND,0) sal_her,

	iif(HCLIMET is null,1,0) cli_fmet,
	isnull(HCLIMET,0) cli_met,
	isnull(HCLIINI,0) cli_ini,
	isnull(HCLICIEN,0) cli_cie,
	isnull(HCLICIENO,0) cli_tra,
	isnull(HCLICIEND,0) cli_her,

	iif(HEFEC01MET is null,1,0) efec1_fmet,
	iif(HEBINI01 is null,1,0) efec1_fini,
	isnull(HEFEC01MET,0) efec1_met,
	isnull(HEBINI01,0) efec1_ini,
	isnull(HEBREC01,0)+isnull(HEBMAE01,0) efec1_rec,
	isnull(HEBDET01,0)+isnull(HEBMAV01,0) efec1_rel,
	isnull(HEBCAS01,0) efec1_cas,

	iif(HEFEC02MET is null,1,0) efec2_fmet,
	iif(HEBINI02 is null,1,0) efec2_fini,
	isnull(HEFEC02MET,0) efec2_met,
	isnull(HEBINI02,0) efec2_ini,
	isnull(HEBREC02,0)+isnull(HEBMAE02,0) efec2_rec,
	isnull(HEBDET02,0)+isnull(HEBMAV02,0) efec2_rel,
	isnull(HEBCAS02,0) efec2_cas,

	isnull(HMDESN,0)+isnull(HMDESNO,0)-isnull(HMDESND,0) mon_des,
	isnull(HITMESN,0)+isnull(HITMESNO,0)-isnull(HITMESND,0) it_mes,
	isnull(HITMINN,0)+isnull(HITMINNO,0)-isnull(HITMINND,0) it_min
	from @tbl_l A
	left join storage.com_act.HRESINC001 B
	on A.cod_sec=B.HCODREL and B.HFECPRO=@cfec and HTIPCOD=1
	where des_gru='INDIVIDUAL'
	),
	b as (
	select *,
	sal_cie-sal_ini+sal_tra-sal_her var_sal,
	cli_cie-cli_ini+cli_tra-cli_her var_cli,
	cast(case when efec1_fini=1 and efec2_fini=0 then 1 when efec1_fini=1 and efec2_fini=1 then 0 else efec1_rec/efec1_ini end as numeric(5,4)) efec1_cie,
	cast(case when efec2_fini=1 and efec1_fini=0 then 1 when efec1_fini=1 and efec2_fini=1 then 0 else efec2_rec/efec2_ini end as numeric(5,4)) efec2_cie,
	round(iif(mon_des>0,it_mes/mon_des,0)/100.0,4) tasa_mes,
	round(iif(mon_des>0,it_min/mon_des,0)/100.0,4) tasa_min
	from a
	),
	c as (
	select *,
	case when sal_fmet=1 then 0 when sal_met=0 and var_sal>=0 then 1 else iif(sal_met=0,0,var_sal/sal_met) end cob_sal,
	case when cli_fmet=1 then 0 when cli_met=0 and var_cli>=0 then 1 else iif(cli_met=0,0,cast(var_cli as float)/cli_met) end cob_cli,
	round(case when efec1_fmet=1 then 0 when efec1_met=0 and efec1_cie>=0 then 1 else efec1_cie/efec1_met end,4) cob_efec1,
	round(case when efec2_fmet=1 then 0 when efec2_met=0 and efec2_cie>=0 then 1 else efec2_cie/efec2_met end,4) cob_efec2
	from b
	)
    select 
	cod_sec,
	cob_sal,var_sal,
	cob_cli,var_cli,
	cob_efec1,efec1_cie,
	cob_efec2,efec2_cie,
	tasa_mes,tasa_min
	into #tbl2
	from c A

	declare @json varchar(max)

	select @json='['+string_agg('{"cod_sec":"'+cast(cod_sec as varchar(max))+
	'","var_sal":'+cast(var_sal as varchar(max))+
	',"var_cli":'+cast(var_cli as varchar(max))+
	',"efec_1":'+cast(efec1_cie as varchar(max))+
	',"efec_2":'+cast(efec2_cie as varchar(max))+
	',"t_mes":'+cast(tasa_mes as varchar(max))+
	',"t_min":'+cast(tasa_min as varchar(max))+'}',',')+']'
	from #tbl2
	
	create table #tbl3 (
	HCODSEC varchar(10),
	HBOBSAL numeric(17,2),
	HBOPSAL numeric(17,2),
	HBOBCLI numeric(17,2),
	HBOPCLI numeric(17,2),
	HBOBEFE1 numeric(17,2),
	HBOPEFE1 numeric(17,2),
	HBOBEFE2 numeric(17,2),
	HBOPEFE2 numeric(17,2),
	HBOSTAS numeric(17,2),
	HBOSCLI numeric(17,2)
	)

	exec mod_app.inc.FMCALCINC01 @json,'#tbl3',@fec

	;with e as (
	select A.cod_sec,A.cob_sal,A.cob_cli,A.cob_efec1,A.cob_efec2,
	B.HBOBSAL+B.HBOBCLI+HBOBEFE1+HBOBEFE2 bob,
	B.HBOPSAL+B.HBOPCLI+HBOPEFE1+HBOPEFE2 bop,
	B.HBOSCLI+(B.HBOBSAL+B.HBOBCLI+HBOBEFE1+HBOBEFE2+B.HBOPSAL+B.HBOPCLI+HBOPEFE1+HBOPEFE2)*B.HBOSTAS bos
	from #tbl2 A
	left join #tbl3 B
	on A.cod_sec=B.HCODSEC
	)
	select A.*,des_uni,des_ter,des_cor,des_sec,des_car,
	iif(iif(cob_sal>=1,1,0)+iif(cob_cli>=1,1,0)+iif(cob_efec1>=1,1,0)+iif(cob_efec2>=1,1,0)>=2,bop+bob+bos,0) bot,
	iif(iif(cob_sal>=1,1,0)+iif(cob_cli>=1,1,0)+iif(cob_efec1>=1,1,0)+iif(cob_efec2>=1,1,0)>=2,1,0) dis,
	'circle' smf
	from e A
	left join @tbl_l B
	on A.cod_sec=B.cod_sec 
	order by 1



	drop table #tbl,#tbl2,#tbl3,#jer
END
