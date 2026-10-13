-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.480000

/*
  
	exec mod_rep.[com].[GSMODAGEN01] '231',7

 *
 */

CREATE procedure [com].[GSMODAGEN01]
    @cod_rel varchar(10),
    @tip_cod int,
	@tipmeta int = 1,
	@fec date = null
as
begin
	set nocount on

	CREATE TABLE #tmpDATOS(NVAR int, RCODVAR int, RDESPROD varchar(150), RNUM bigint, RNIVEL int, RNOMSUB varchar(250), TORD int, TFEC date, TNOMMES varchar(20), DESVAL varchar(150), VAL float)

	declare @json varchar(max) =
	'[{"variables":"NroClientesGesBT,NroClientesIniBT,NroClientesDesBT,NroClientesIniBT","elementos":[{"TIPCOD":' + convert(varchar(50),@tip_cod) + ',"CODREL":"' + @cod_rel +'","niveles":' + IIF(@tip_cod = 4,'3','2') + '}],"fechas":["CAMP,' + isnull(convert(varchar(8), @fec,112),'') + ',AN"]}]'

	insert into #tmpDATOS
	EXEC mod_rep.[rep].[RCALC] @json
	
	declare @GVariables as table(ORD int identity(1,1), CODG int, NOMG varchar(50))
	insert into @GVariables values
	(6078,'CRÉDITOS AUTOMÁTICOS'),
	(602,'APTOS PARA AMPLIACIÓN 01'),
	(600,'CANCELADOS 01'),
	(701,'APTOS PARA AMPLIACIÓN 02'),
	(601,'CANCELADOS 02')

	declare @SVariables as table(ORD int identity(1,1), CODS int, NOMS varchar(50))
	insert into @SVariables values
	(1,'GESTIÓN'),
	(2,'EFECTIVIDAD')
	
	declare @Variables as table(ORD int identity(1,1), NVAR int, NOMV varchar(50), CODS int)
	insert into @Variables values
	(20,'Clientes gestionados',1),
	(40,'Total clientes',1),
	(41,'% Gestión',1),
	(60,'Clientes desembolsados',2),
	(80,'Total clientes',2),
	(81,'% Efectividad',2)
		
	declare @TVariables as table(ORD int identity(1,1), TORD int, NOMT varchar(50), TFEC varchar(10))
	insert into @TVariables
	select	distinct 
			TORD, IIF(TORD = 102,', mes anterior',''), TFEC
	from	#tmpDATOS
	order by
			1 desc

	select	ORD = row_number() over(order by A.ORD, D.ORD, C.ORD, B.ORD), CODG, NVAR, TORD, D.CODS,
			convert(varchar(4),CODG) + '_'  + convert(varchar(4),NVAR) + '_'  + convert(varchar(4),TORD) CODB, B.NOMV + C.NOMT NOMV
	into	#tmpVariables
	from	@GVariables A, @TVariables C, @Variables B, @SVariables D
	where	((TORD = 102 and NVAR in(41,81)) or TORD = 101)
		and B.CODS = D.CODS

	declare @cCab varchar(max), @N int
	
	select	@cCab = 'NIVEL|' + STRING_AGG(NOMG,'|') within group (order by ORD), @N = MAX(ORD)
	from	@GVariables A

	declare @tTabla as [rep].[TCADS], @tTablaDef as [rep].[TCADS]
	insert into @tTabla
	select	@cCab
	union all
	select	replicate('|' + STRING_AGG(NOMS,';') within group (order by ORD),@N)
	from	@SVariables A
	union all
	select	replicate('|' + STRING_AGG(TFEC,';') within group (order by ORD),@N * 2)
	from	@TVariables A
	union all
	select	'|' + STRING_AGG(NOMV,'|') within group (order by ORD)
	from	(select	ORD = MIN(ORD), NOMV = STRING_AGG(NOMV,';') within group (order by ORD) 
			from	#tmpVariables A
			group by
					CODG, TORD, CODS) A

	insert into @tTablaDef values ('RNOMSUB')
	insert into @tTablaDef select CODB from #tmpVariables order by ORD
	
	declare @coldefs as rep.TTHCOLDEF
	insert into @coldefs(TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, TFORTYP, TDESC, TSTBACKGROUND)
	select	TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, isnull(TFORTYP,'number') TFORTYP, TDESC, IIF(TLEV = 2,'green',null) 
	from	[rep].FCABTABDEF(@tTabla,@tTablaDef)

	select [rep].[FFTHCOLDEF](@coldefs)
	
	declare @piv varchar(max), @cScript varchar(max)
	select	@piv = STRING_AGG('[' + CODB + ']',',') within group (order by ORD)
	from	#tmpVariables
	
	set @cScript = '
		;with cteDatos as(	
			select	style = MAX(RNIVEL) over(partition by TORD) - RNIVEL, convert(int,left(RDESPROD,4)) CODG, NVAR, RNUM, TORD, RNOMSUB, VAL
			from	#tmpDATOS),
		cteDatosF as(
			select	style, CODG, NVAR, RNUM, RNOMSUB, TORD, VAL = FORMAT(VAL,''N0'')
			from	cteDatos
			union all
			select	A.style, A.CODG, A.NVAR + 21, A.RNUM, A.RNOMSUB, A.TORD, FORMAT(IIF(B.VAL <> 0, A.VAL / B.VAL, null),''P'')
			from	cteDatos A
				left join cteDatos B
					on	A.CODG = B.CODG
					and A.NVAR + 20 = B.NVAR
					and A.RNUM = B.RNUM
					and A.TORD = B.TORD
			where	A.NVAR in(20,60))

	select	*
	from	(select	style, convert(varchar(4),CODG) + ''_''  + convert(varchar(4),NVAR) + ''_''  + convert(varchar(4),TORD) CODB, RNUM, RNOMSUB, VAL from cteDatosF) A
		pivot(MAX(VAL) for CODB in(' + @piv + ') ) B
	order by
			RNUM'

	exec(@cScript)

END
