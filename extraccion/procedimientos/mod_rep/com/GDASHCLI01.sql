-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-01-06 11:24:15.450000
--exec com.GDASHCLI01 '{"uni":1,"tip_cod":7,"cod_rel":"231"}','{"gen":"-","pais":604,"edad":5,"ent":2}'
CREATE PROCEDURE [com].[GDASHCLI01]
@uni_cfg varchar(max),
@sel_cfg varchar(max)
AS
BEGIN

	SET NOCOUNT ON;

	create table #VARS(HORD int,HCODNIV int,HVAR varchar(50),HVARDES varchar(100))
	insert into #VARS
	values
	(1,1,'HNUMCLI','Total Unidad'),
	(1,2,'HNUMCLI','Total Selección'),
	(1,3,'HNUMCLI','Total %'),
	(2,1,'HCLINUE','Nuevos Unidad'),
	(2,2,'HCLINUE','Nuevos Selección'),
	(2,3,'HCLINUE','Nuevos %'),
	(3,1,'HPROMCON','Contratos Prom. Unidad'),
	(3,2,'HPROMCON','Contratos Prom. Selección'),
	(3,3,'HPROMCON','Contratos Prom. Variación')

	declare @uni int,@tip_cod int,@cod_rel varchar(250)

	select @uni=uni,@tip_cod=tip_cod,@cod_rel=cod_rel
	from openjson(@uni_cfg)
	with(uni int,tip_cod int,cod_rel varchar(250))

	declare @nuecol varchar(50)
	set @nuecol=iif(@uni=0,'HNUETOT','HNUEUNI')

	declare @gen varchar(10),@pais int,@edad int,@ent int

	select @gen=gen,@pais=pais,@edad=edad,@ent=ent
	from openjson(@sel_cfg)
	with(gen varchar(10),pais int,edad int,ent int)

	create table #BASE (HFECPRO date,HCODNIV int,HNUMCLI int,HNUMCON int,HCLINUE int)

	declare @sql varchar(max)

	set @sql='
	select HFECPRO,1 HCODNIV,HNUMCLI,HNUMCONT,isnull('+@nuecol+',0) HCLINUE
	from [storage].[com].[WBCLI01]
	where HTIPCOD='''+cast(@tip_cod as varchar)+''' and HCODREL='''+cast(@cod_rel as varchar)+''' 
	and HCODUNI='+cast(@uni as varchar)+'
	and HGENPER=''T'' and HPAIS=-1 and HCODENT=0 and HRANANT=0
	'
	insert into #BASE
	exec(@sql)

	set @sql='
	select HFECPRO,2 HCODNIV,HNUMCLI,HNUMCONT,isnull('+@nuecol+',0) HCLINUE
	from [storage].[com].[WBCLI01]
	where HTIPCOD='''+cast(@tip_cod as varchar)+''' and HCODREL='''+cast(@cod_rel as varchar)+''' 
	and HCODUNI='+cast(@uni as varchar)+'
	and HGENPER='''+cast(@gen as varchar)+''' and HPAIS='+cast(@pais as varchar)+' 
	and HCODENT='+cast(@ent as varchar)+' and HRANANT='+cast(@edad as varchar)+'
	'
	insert into #BASE
	exec(@sql)

	print(@sql)

	;with a as (
	select dense_rank() over(order by HFECPRO) HROW,HFECPRO,HCODNIV,cast(HNUMCLI as float) HNUMCLI,
	cast(HCLINUE as float) HCLINUE,round(iif(HNUMCLI=0,0,cast(HNUMCON as float)/cast(HNUMCLI as float)),4) HPROMCON
	from #BASE
	),
	b as (
	select concat('HCOL',HROW) HROW,HCODNIV,HVAR,HVAL
	from (
	select * from a
	) q
	unpivot (
	HVAL for HVAR in (HNUMCLI,HPROMCON,HCLINUE)
	) up
	)
	select HVAR,HCODNIV,HCOL1,HCOL2,HCOL3,HCOL4,HCOL5,HCOL6
	into #A
	from (
	select * from b
	) q
	pivot (
	max(HVAL) for HROW in (HCOL1,HCOL2,HCOL3,HCOL4,HCOL5,HCOL6)
	) p

	declare @headers varchar(max)='[{"label":"Variable","key":"var_des"},'
	;with a as (
	select distinct HFECPRO
	from #BASE 
	),
	b as (
	select row_number() over(order by HFECPRO) R,HFECPRO F from a
	)
	select @headers+string_agg('{"label":"'+format(F,'dd-MMM-yyyy')+'","key":"col_'+cast(R as varchar)+'","type":"custom_r"}',',')+
	',{"label":"Var. Mensual","key":"var_mensual","type":"custom_r"},{"label":"Var. Anual","key":"var_anual","type":"custom_r"},{"label":"Var. Interanual","key":"var_interanual","type":"custom_r"}]' hdefs
	from b

	;with a as (
	select *
	from #A
	where HCODNIV=1
	),
	b as (
	select *
	from #A
	where HCODNIV=2
	),
	c as (
	select *
	from #A
	UNION
	select A.HVAR,3,
	round(iif(A.HVAR='HPROMCON',B.HCOL1-A.HCOL1,iif(A.HCOL1=0,0,B.HCOL1/A.HCOL1)),4),
	round(iif(A.HVAR='HPROMCON',B.HCOL2-A.HCOL2,iif(A.HCOL2=0,0,B.HCOL2/A.HCOL2)),4),
	round(iif(A.HVAR='HPROMCON',B.HCOL3-A.HCOL3,iif(A.HCOL3=0,0,B.HCOL3/A.HCOL3)),4),
	round(iif(A.HVAR='HPROMCON',B.HCOL4-A.HCOL4,iif(A.HCOL4=0,0,B.HCOL4/A.HCOL4)),4),
	round(iif(A.HVAR='HPROMCON',B.HCOL5-A.HCOL5,iif(A.HCOL5=0,0,B.HCOL5/A.HCOL5)),4),
	round(iif(A.HVAR='HPROMCON',B.HCOL6-A.HCOL6,iif(A.HCOL6=0,0,B.HCOL6/A.HCOL6)),4)
	from a A
	join b B
	on A.HVAR=B.HVAR
	)
	select B.HORD var_ord,B.HCODNIV var_niv,B.HVARDES var_des,
	isnull(A.HCOL1,0) col_1,
	isnull(A.HCOL2,0) col_2,
	isnull(A.HCOL3,0) col_3,
	isnull(A.HCOL4,0) col_4,
	isnull(A.HCOL5,0) col_5,
	isnull(A.HCOL6,0) col_6
	from #VARS B
	left join c A
	on A.HVAR=B.HVAR and A.HCODNIV=B.HCODNIV
	order by 1,2

	
END
