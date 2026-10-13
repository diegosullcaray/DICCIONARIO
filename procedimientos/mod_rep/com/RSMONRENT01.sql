-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2025-09-08 12:57:41.647000
--exec [com].[RSMONRENT01]     7,'231','20250906'
--exec [com].[RSMONRENT01]     21,'1','20250320'
--exec [com].[RSMONRENT01]     20,'1_10','20250320'
--exec [com].[RSMONRENT01]     19,'3','20250320'
--exec [com].[RSMONRENT01]     18,'13','20250320'
--exec [com].[RSMONRENT01]     17,'1013','20250320'
--exec [com].[RSMONRENT01]     1,'TLPOG100','20250320'

CREATE PROCEDURE [com].[RSMONRENT01]      
@tip_cod int, @cod_rel varchar(10), @fec  varchar(8)   
AS      
BEGIN        
 set nocount on;  
  
  
  --declare @tip_cod int =7 , @cod_rel varchar(10)= '231', @fec  varchar(8)  ='20250308' 
  --declare @fec2 date=dateadd(day,-1,@fec)
  declare @fec2 date=@fec
 declare @HCLIREAL_MANT as int
 --select  @HCLIREAL_MANT= HCLIREAL  from storage.com_act.wjas005 where HFECPRO = (select max(rfec) from storage.ref.RCALEN001 where rfec <= @fec and RCIEBT = 1)
  select  @HCLIREAL_MANT= HNUMCLI  from storage.com_act.wjas001 where HFECPRO = (select max(rfec) from storage.ref.RCALEN001 where rfec <= @fec and RCIEBT = 1)

 and HTIPCOD = @tip_cod and HCODREL=@cod_rel
 
 
  declare @val FLOAT, @diff FLOAT, @umb FLOAT
  select @val = 0.95
  --select @diff = 0.95-@val
  select @umb=0.05
  --si la dif > verde entonces1 sino (si el resultado llega al 95% o mas entonces amarillo sino rojo)  
  --select  iif( @diff > 0, 1, iif( 1 - case when @val=0 then 0 else ABS(@diff/@val)end >= ( 1-@umb ), 0, -1))  

 --select 1 fila, 'Stock de Clientes' 'lbl', HCLIREAL 'val', -99 'tl', 'number' 'typ',  'Avance mes' 'lbl2', HCLIREAL - @HCLIREAL_MANT   'val2' into #cabecera from storage.com_act.wjas005 where HFECPRO = @fec2 and HTIPCOD = @tip_cod and HCODREL=@cod_rel
 select 1 fila, 'Stock de Clientes' 'lbl', HNUMCLI 'val', -99 'tl', 'number' 'typ',  'Avance mes' 'lbl2', HNUMCLI - @HCLIREAL_MANT    'val2' into #cabecera from storage.com_act.wjas001 where  HFECPRO = @fec2 and HTIPCOD = @tip_cod and HCODREL = @cod_rel
 union
 select 2 fila, 'Salidas en el mes' 'lbl', HCLISAL1M 'val', -99 'tl', 'number' 'typ',  NULL 'lbl2'/*diamesant*/,  NULL 'val2' from storage.com_act.wjas005 where HFECPRO = @fec2 and HTIPCOD = @tip_cod and HCODREL=@cod_rel
 union
 --select 3 fila, 'Retención de clientes Mes' 'lbl', HCLISAL1M 'val', -99 'tl', 'number' 'typ',  NULL 'lbl2'/*diamesant*/,  NULL 'val2' from storage.com_act.wjas005 where HFECPRO = @fec2 and HTIPCOD = @tip_cod and HCODREL=@cod_rel
 --union
 select 3 fila, 'Salidas en los ultimos 3M' 'lbl', HCLISAL3M 'val', -99 'tl', 'number' 'typ',  NULL 'lbl2',  NULL 'val2' from storage.com_act.wjas005 where HFECPRO = @fec2 and HTIPCOD = @tip_cod and HCODREL=@cod_rel
 union
 select 4 fila, 'Retención de clientes 3M' 'lbl', HRATRET 'val',  
  iif( (HRATRET-@val) > 0, 1, iif( 1 - case when @val=0 then 0 else ABS( (HRATRET-@val) /@val)end >= ( 1-@umb ), 0, -1))  
 'tl', 'percent' 'typ',  'Meta' 'lbl2',  0.95 'val2' from storage.com_act.wjas005 where HFECPRO = @fec2 and HTIPCOD = @tip_cod and HCODREL=@cod_rel
 union
 select 5 fila, 'Clientes por vencer al cierre de mes' 'lbl', HCLIVENC 'val', -99 'tl', 'number' 'typ',  NULL 'lbl2',  NULL 'val2' from storage.com_act.wjas005 where HFECPRO = @fec2 and HTIPCOD = @tip_cod and HCODREL=@cod_rel
 

 select   * from  #cabecera order by fila asc
 
 declare @cf1 as varchar(10)  =@fec2  
 


 create table #det (
fila int,
id_prin	 varchar(20),
id_sec	 varchar(20),
style	 int,
descripcion	varchar(200),
HCLISAL1M int,	
HMONDES1M float,
HCLISAL3M	int,	
HMONDES3M	float,
HTOTCLI	int,	
HCLIREAL	int,	
HCLIRET3M	int,	
HRATRET	float,
HCLIVENC int,
HRATRET1M float)


 --declare @tip_cod int=7 , @cod_rel varchar(20)='231', @cf1 varchar(10)='20250206'
    --declare @tip_cod int=21 , @cod_rel varchar(20)='1', @cf1 varchar(10)='20250206'
	--declare @tip_cod int=17 , @cod_rel varchar(20)='1013', @cf1 varchar(10)='20250206'
	declare @select_campo1 varchar(20), @select_campo2 varchar(20), @select_campo3 varchar(20), @select_campo4 varchar(20),
	@sql varchar(max),@where_campo1 varchar(20), @where_campo2 varchar(20), @grouping1 varchar(20), @grouping2 varchar(20), @where_HMONDESMN varchar(50)
	, @tipcod2 varchar(20)
	if(@tip_cod=7)
		Begin
		select @select_campo1 ='_FC.RCODEMP', @select_campo2 ='_FC.RDESEMP',@select_campo3 ='RCODGRU',@select_campo4 ='RDESGRU',
		@where_campo1 = '1', @grouping1='_FC.RCODEMP', @grouping2='RCODGRU', @tipcod2 ='21'
		End
	else if (@tip_cod=21)
		Begin
		select @select_campo1 ='RCODGRU', @select_campo2 ='RDESGRU',@select_campo3 ='RCODTER',@select_campo4 ='RDESTER',
		@where_campo1 = 'RCODGRU', @grouping1='RCODGRU', @grouping2='RCODTER', @tipcod2 ='20'
		End
	else if (@tip_cod=20)
		Begin 
		select @select_campo1 ='RCODTER', @select_campo2 ='RDESTER',@select_campo3 ='RCODCOR',@select_campo4 ='RDESCOR',
		@where_campo1 = 'RCODTER', @grouping1='RCODTER', @grouping2='RCODCOR', @tipcod2 ='19'
		End
	else if (@tip_cod=19)
		Begin
		select @select_campo1 ='RCODCOR', @select_campo2 ='RDESCOR',@select_campo3 ='RCODUNI',@select_campo4 ='RDESUNI',
		@where_campo1 = 'RCODCOR', @grouping1='RCODCOR', @grouping2='RCODUNI', @tipcod2 ='18'
		End
	else if (@tip_cod=18)
		Begin
		select @select_campo1 ='RCODUNI', @select_campo2 ='RDESUNI',@select_campo3 ='RCODSEC',@select_campo4 ='RDESSEC',
		@where_campo1 ='RCODUNI', @grouping1='RCODUNI', @grouping2='RCODSEC' , @tipcod2 ='1'
		End 
    else if (@tip_cod=1)
		Begin
		select @select_campo1 ='RCODSEC', @select_campo2 ='RDESSEC',@select_campo3 ='RCODSEC',@select_campo4 ='RDESSEC',
		@where_campo1 ='RCODSEC', @grouping1='RCODSEC', @grouping2='RCODSEC' , @tipcod2 ='1'
		End 

		set @where_campo2 = 
	case when @tip_cod=7 then '=1' else 
	case when @cod_rel = '9999' then 'is null' else '='''+@cod_rel+'''' end
	end
	 

   set @sql = '

   
 ;with SAL1M as (
 select HFECPRO,case when (haseoper =null OR haseoper = ''--'' OR haseoper = ''NULL'') then NULL else HASEOPER  end HASEOPER, 
 COUNT(distinct HNUMCON)HCLISAL1M, SUM(HMONDESMN) HMONDES1M  from 
 storage.com_act.HSCM001 where HFECPRO = '''+@cf1+'''
 group by HFECPRO,case when (haseoper =null OR haseoper = ''--'' OR haseoper = ''NULL'')  then NULL else HASEOPER  end
 ) 
 ,SAL3M as (
 select HFECPRO, case when (haseoper =null OR haseoper = ''--'' OR haseoper = ''NULL'') then NULL else HASEOPER  end HASEOPER, 
 COUNT(distinct HNUMCON)HCLISAL3M, SUM(HMONDESMN) HMONDES3M  from 
 storage.com_act.HSCM002 where HFECPRO = '''+@cf1+'''
 group by HFECPRO,case when (haseoper =null OR haseoper = ''--'' OR haseoper = ''NULL'')  then NULL else HASEOPER  end
 )
 ,RET3M as (
 select HFECPRO,  case when (haseoper =null OR haseoper = ''--'' OR haseoper = ''NULL'') then NULL else HASEOPER  end HASEOPER,  
 HTOTCLI,HCLIREAL,HCLI3M   
 from
 storage.com_act.HRCI001 where HFECPRO = '''+@cf1+'''
 )
 ,RET1M as (
 select HFECPRO,  case when (haseoper =null OR haseoper = ''--'' OR haseoper = ''NULL'') then NULL else HASEOPER  end HASEOPER,  
 HCLIREAL HCLIREAL1M, HCLI3M  HCLI1M  
 from
 storage.com_act.HRCI001 where HFECPRO = '''+@cf1+'''
 )
 ,CLIVEN as (
 select hfecpro, haseoper, COUNT(distinct concat_ws(''-'',HNUMDOC,HTIPDOC,HPAIS))HCLIVENC from storage.com_act.HCDA001 where HFECPRO  = '''+@cf1+'''
 and eomonth(HULTVEN) = EOMONTH('''+@cf1+''') group by hfecpro, haseoper
 )
 ,ASESOR as (
 select distinct HASEOPER,HFECPRO from SAL1M 
 union
 select distinct HASEOPER,HFECPRO from SAL3M 
 union
 select distinct HASEOPER,HFECPRO from RET3M 
 union
 select distinct HASEOPER,HFECPRO from CLIVEN 
 )
 ,b as (
 select A.HFECPRO, A.HASEOPER HCODSEC, 
 HCLISAL1M,HMONDES1M,HCLISAL3M,HMONDES3M,HTOTCLI,HCLIREAL,HCLI3M,HCLIVENC ,HCLIREAL1M,HCLI1M
 from   ASESOR A
  left join RET3M B on A.HFECPRO = B.HFECPRO and isnull(A.HASEOPER,0) = isnull(B.HASEOPER,0)
  left join SAL1M D on A.HFECPRO = D.HFECPRO and isnull(A.HASEOPER,0) =  isnull(D.HASEOPER,0)
  left join SAL3M E on A.HFECPRO = E.HFECPRO and isnull(A.HASEOPER,0) =  isnull(E.HASEOPER,0)
  left join CLIVEN F on A.HFECPRO = F.HFECPRO and isnull(A.HASEOPER,0) =  isnull(F.HASEOPER,0)
  left join RET1M G on A.HFECPRO = G.HFECPRO and isnull(A.HASEOPER,0) = isnull(G.HASEOPER,0)
  ) 

	, datos as ( 
	select 
	isnull('+@select_campo1+',''9999'') id_prin ,max(isnull('+@select_campo2+',''SIN ASIGNAR'')) desc_prin,
	isnull('+@select_campo3+',''9999'') id_sec ,max(isnull('+@select_campo4+',''SIN ASIGNAR'')) desc_sec,

	sum(HCLISAL1M)HCLISAL1M,	
 sum(HMONDES1M)HMONDES1M,
 sum(HCLISAL3M)HCLISAL3M,	
 sum(HMONDES3M)HMONDES3M,	
 sum(HTOTCLI)HTOTCLI,	
 sum(HCLIREAL)HCLIREAL,
 sum(HCLI3M)HCLIRET3M,
 sum(cast(HCLIREAL1M as float))/ sum(HCLI1M)HRATRET1M,
 sum(cast(HCLIREAL as float))/ sum(HCLI3M)HRATRET,
 SUM(HCLIVENC)HCLIVENC

  
	from b B
	left join (values(7,''FINANCIERA CONFIANZA'')) _FC(RCODEMP,RDESEMP) on B.HFECPRO=B.HFECPRO
	LEFT JOIN storage.[ref].WJERCOR03 C
	on B.HCODSEC =  C.RCODSEC and B.HFECPRO=C.RFECPRO and C.RINDFEC = ''actual''
	where b.hfecpro = '''+@cf1+'''   and '+@where_campo1+'  '+@where_campo2+'
	  
	--group by grouping sets((isnull('+@grouping1+',''9999'')),(isnull('+@grouping1+',''9999''),isnull('+@grouping2+',''9999'')))
	group by grouping sets((isnull('+@grouping1+',''9999'')),(isnull('+@grouping1+',''9999''),isnull('+@grouping2+',''9999'')))
	)


	select row_number() over(order by id_prin,id_sec) fila,
			id_prin,id_sec,
			case when id_sec is not null then 0 when id_prin is not null then 1 end style,
			case when id_sec is not null then desc_sec  when id_prin is not null then desc_prin  end descripcion,
			HCLISAL1M,HMONDES1M, HCLISAL3M,HMONDES3M,HTOTCLI,HCLIREAL,  HCLIRET3M,HRATRET,HCLIVENC,HRATRET1M

			from datos   '

	    print @sql
 insert into #det
	exec (@sql)


	 select @tipcod2  tipcod2, * into #det1 from #det where style = 0

 

 select tipcod2   tip_cod, id_sec cod_rel,descripcion  'desc' , HCLISAL1M sali1, HRATRET1M ret1m,HCLISAL3M sali3,HRATRET ret,  HCLIVENC clive 
  from #det1 

 

END
