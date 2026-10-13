-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.250000

/*
	exec mod_rep.[com].[GRESCAMIMP01] '231',7
	exec mod_rep.[com].[GRESTOPIMP01] '231',7

	INSERT INTO [mod_rep].[rep].[RREGREP01]
	SELECT 'GRESCAMIMP_02','Top Imparables','{"name":"mod_rep.com.GRESTOPIMP01","params":[{"order":1,"name":"cod_rel"},{"order":2,"name":"tip_cod"}]}'
	select * from [mod_rep].[rep].[RREGREP01] 
	delete from [mod_rep].[rep].[RREGREP01]  where RCODREP='GRESCAMIMP_02'

 *
 */

CREATE procedure [com].[GRESTOPIMP01]
    @cod_rel varchar(10),
    @tip_cod int,
	@tipmeta int = 1,
	@fec date = null
as
begin
	set nocount on
	--declare @cod_rel varchar(10)='231',@tip_cod int=7, @fec date=null
	declare @nivel int=IIF(@tip_cod=7,4,IIF(@tip_cod=6,3,IIF(@tip_cod=5,2,IIF(@tip_cod=4,1,null))));
	set @fec='20200416'
	CREATE TABLE #tmpDATOS1(NVAR int, RCODVAR int, RDESPROD varchar(150), RNUM bigint, RNIVEL int, RNOMSUB varchar(250), TORD int, TFEC date, TNOMMES varchar(20), DESVAL varchar(150), VAL float)

	declare @json varchar(max) =
	'[{"variables":"NroClientesGesReac,NroClientesIniReac,NroClientesDesReac,NroClientesIniReac","elementos":[{"TIPCOD":' + convert(varchar(50),@tip_cod) + ',"CODREL":"' + @cod_rel +'","niveles":"' + convert(varchar(50),@nivel) +'"}],"fechas":[1]}]'
	--print(@json)
	insert into #tmpDATOS1
	EXEC mod_rep.[rep].[RCALC] @json
	
	CREATE TABLE #tmpDATOS2(NVAR int, RCODVAR int, RDESPROD varchar(150), RNUM bigint, RNIVEL int, RNOMSUB varchar(250), TORD int, TFEC date, TNOMMES varchar(20), DESVAL varchar(150), VAL float)
	
	declare @json1 varchar(max) =
	'[{"variables":"NroClientesCont,NroClientesRepro","elementos":[{"TIPCOD":' + convert(varchar(50),@tip_cod) + ',"CODREL":"' + @cod_rel +'","niveles":"' + convert(varchar(50),@nivel) +'"}],"fechas":[1]}]'

	insert into #tmpDATOS2
	EXEC mod_rep.[rep].[RCALC] @json1
		
	SELECT	* INTO	#tmpDATOS FROM	#tmpDATOS1	where RNIVEL=@nivel
	UPDATE	#tmpDATOS2 SET 	NVAR = NVAR + 80	
	INSERT INTO #tmpDATOS SELECT * 	FROM #tmpDATOS2 where RNIVEL=@nivel
	
	declare @Variables as table(ORD int, NVAR int, NOMV varchar(50), CODS int)
	insert into @Variables values
	(0,201,'Puesto',1),
	--(20,'Clientes gestionados',1),
	--(40,'Total Créd. Reactivados',1),
	(2,41,'Agencia',1),
	--(60,'Clientes desembolsados',2),
	--(80,'Total Créd. Reactivados',2),
	(3,81,'Efectividad Créd. Reactivados (%)',2),
	--(100,'Clientes contactados',2),
	--(120,'Total clientes reprogramados',2),
	(4,121,'Contactabilidad reprogramados (%)',2),
	(5,200,'Puntaje',2)
	

	declare @tTabla as [rep].[TCADS], @tTablaDef as [rep].[TCADS]
	insert into @tTabla
	select	'Puesto|' + STRING_AGG(NOMV,'|') within group (order by ORD)
	from	@Variables
	/*UNION all
	select	distinct 
			replicate('|' +  convert(varchar(10),TFEC,103), (SELECT count(*) FROM @Variables ) )
	from	#tmpDATOS*/

	;with a as (
	select 2 as A,cast('RNOMSUB' as varchar(250)) B
	),
	b as (
	select ORD,cast(NVAR  as varchar(250)) NVAR
	from @Variables
	UNION
	select * from a
	)
	insert into @tTablaDef 
	select NVAR 
	from b order by ORD
	
	declare @coldefs as rep.TTHCOLDEF
	insert into @coldefs(TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, TFORTYP, TDESC,TSTDEWIDTH)
	select	TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, isnull(TFORTYP,'string') TFORTYP, TDESC,IIF(TISDATA>1,'100px',null) 
	from	[rep].FCABTABDEF(@tTabla,@tTablaDef)
	where TLEV<>2 and TKEY NOT IN ('41','81','121')

	update @coldefs
	set TSTDEWIDTH=case TKEY when '201' then 20 when '200' then 20 end


	select [rep].[FFTHCOLDEF](@coldefs)
	
	declare @piv varchar(max), @cScript varchar(max)
	select	@piv = STRING_AGG('[' + convert(varchar(10),NVAR) + ']',',') within group (order by ORD)
	from	@Variables
	
	set @cScript = '
		;with cteDatos as(	
			select	style = MAX(RNIVEL) over(partition by TORD) - RNIVEL, NVAR, RNUM, TORD, RNOMSUB, cast(VAL as float) VAL
			from	#tmpDATOS),
		cteDatosF as(
			/*select	style, NVAR, RNUM, RNOMSUB, TORD, VAL = FORMAT(VAL,''N0'')
			from	cteDatos
			union all*/
			select	A.style, A.NVAR + 21 NVAR, A.RNUM, A.RNOMSUB, A.TORD,A.VAL as d1,B.VAL as d2,VAL=IIF(B.VAL <> 0,cast(A.VAL as float) /cast(B.VAL as float), null)
			from	cteDatos A
				left join cteDatos B
					on	A.NVAR + 20 = B.NVAR
					and A.RNUM = B.RNUM
					and A.TORD = B.TORD
			where	A.NVAR in(20,60,100))
	select	top 10 style,RNUM,RNOMSUB,FORMAT((ISNULL([41],0)+ISNULL([81],0)+ISNULL([121],0))/3,''P'') as [200],
	row_number() over(order by (ISNULL([41],0)+ISNULL([81],0)+ISNULL([121],0))/3 desc) [201]
	from	(select	style, NVAR, RNUM, RNOMSUB, VAL from cteDatosF) A
		pivot(MAX(VAL) for NVAR in(' + @piv + ') ) B' 

	exec(@cScript)

END
