-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.290000

/*
  
  exec mod_rep.[com].[GSCAMP01] '231',7, 1, 1

 *
 */

CREATE procedure [com].[GSCAMP01]
    @cod_rel varchar(10),
    @tip_cod int,
	@ind int,
	@sem int = 0,
	@tipmeta int = 1,
	@fec date = null,
	@CONFIG varchar(100) = 'RDA'	
as
begin
	set nocount on

	declare @tFecs as [rep].[TFECMES]
	insert into @tFecs values(1,isnull(@fec,dateadd(day,-1,getdate())),'1')

	select @fec = TFEC from [rep].[FFECMES](@tFecs)

-- declare @cod_rel varchar(10)='TJPAV001',@fec date='2019-07-31',@tip_cod int=8, @tipmeta int = 1, @ind int = 1 
		
	IF @tip_cod = 2 
	BEGIN	
		select  distinct
				isnull(A.HCODASE, B.RCODSUB) SCODSEC, B.RCODPAR HAGE, 
				isnull(A.HPART,'NO') HPART, IIF(A.HDCARGO like '%MUJER%',2,1) IND
		INTO	#tmpAse  --- drop table #tmpAse
		from	[storage].[com].[FTRAGEASE](2,'',1) B
			left join storage.[com_act].[HACA001] A --select top 10 * 
				on	B.RCODSUB = A.HCODASE
				and A.HFECPRO = (	select  MAX(HFECPRO)
					      		from	storage.[com_act].[HACA001] where HFECPRO <= @fec)
	
		declare @hCodBT varchar(50)
		set @hCodBT=(select max(hcodbt) from [storage].[gpr].[HPPC001] where HNUMDOC = @cod_rel)
	
		set @ind = (select IND from #tmpAse where scodsec = @hCodBT)
	END
	
	--------- Configurando Parametros -------------------
	
	set @cod_rel = IIF(@ind in(3,4),'',@cod_rel)
	set @tip_cod = IIF(@ind in(3,4),2,@tip_cod)
	set @ind = CASE @ind
					when 3 then 1
					when 4 then 2
					else @ind
			   end
	
	declare @indt int, @FechaIniS date, @dFechaIni date, @fecaux date = @fec
	select  @fec = FechaFinS, @indt = Periodo,  @FechaIniS = FechaIniS, @dFechaIni = FechaIni
	from 	[storage].[com].[FCAMPFEC](@fec,@sem)

	if @indt is null
		select  @indt = Periodo
		from 	[storage].[com].[FCAMPFEC](eomonth(@fecaux),@sem)
	
	select  distinct RNUM, RNIVEL, RCODPAR, RCODSUB, RNOMPAR, RNOMSUB, RCODSUB2, TIPCOD, RDESNIV
	INTO	#tmpDATOSPAR
	FROM	storage.[com].[FTRAGEASE](@tip_cod,@cod_rel,IIF(@CONFIG = 'RDA', IIF(@tip_cod = 4,3,2),6))
	
	---------- CALCULOS ------------
	-------- Temporales ------------
	
	select 	FORD, [storage].[com].[FCAMPFEC2](A.FFEC, @indt) FFEC
	into	#tmpFec
	from	[storage].[com].[FCMGFEC](@fec,1) A
	WHERE	A.FORD in(4,6)
	
	select  B.RNUM, IIF(C.FORD = 6, A.SDESVAL, D.DESVARNOM_AN) DESVAR, A.SVAL VAL,
			IIF(A.SDESVAL like 'DIV_%',1,0) INDPORC
	INTO	#tmpDatos
	from	storage.[com_act].[SABT001] A
		join #tmpDATOSPAR B
			on 	A.STIPCOD = IIF(B.TIPCOD = -1,2,B.TIPCOD)
			and A.SCODREL = B.RCODSUB
		join #tmpFec C
			on 	A.SFECPRO = C.FFEC
			and C.FORD in(4,6)
		left join storage.[com].[FVARCAMP](@indt, @ind) D
			on 	A.SDESVAL = D.DESVAR_AN
	WHERE	A.SINDPDM = @ind
		and ( C.FORD = 6 OR (C.FORD = 4 AND D.DESVAR_AN is not null) )
		
	-------------- Formateo de datos
	
	if @cod_rel <> ''
	BEGIN
		
		select  A.RCODPAR r1, A.RCODSUB r2, 
				MAX(A.RNIVEL) over(partition by '') - A.RNIVEL estilo,
				A.RNUM, A.RNOMSUB + CASE 
										when A.TIPCOD = 4 then '(M)'
										when A.TIPCOD = 8 then '(C)'
										else ''
									END descripcion
		INTO	#tmpdesc
		FROM	#tmpDATOSPAR A	
		
		create index idx_desc on #tmpdesc(RNUM)		
		
		select	B.descripcion, A.DESVAR, 
				CASE
					when A.INDPORC = 1 then CONVERT(varchar(50),convert(money, round(A.VAL * 100,2)),1) + '%'
					else replace(CONVERT(varchar(50), convert(money, round(A.VAL,0)), 1),'.00','')
				end VAL
		into	#tmpNoPiv
		from	#tmpDatos A right join #tmpdesc B on A.RNUM = B.RNUM where (A.VAL is not null or B.RNUM < 0)
		
		--------------------------------------------------------------------------------------------
		
		declare @tCADS as [rep].[TCADS] insert into @tCADS select TCADINI from storage.[com].[FINDPDM](@indt) where IND = @ind
		declare @cFechas as varchar(50) = (select STRING_AGG(FORMAT(FFEC, 'dd-MM-yyyy'),';') WITHIN GROUP (ORDER BY FORD) from 	#tmpFec B)

		declare @tTabla as [rep].[TCADS], @tTablaDef as [rep].[TCADS]
		insert into @tTabla
		select TCAD
		from	(select	[1] = 'Hitos de la semana ' + convert(varchar(10),@indt) + '|' + STRING_AGG(A.cDatAdic,'|') WITHIN GROUP (ORDER BY B.TNC), 
						[2] = 'Descripción|' + STRING_AGG(A.cVariable,'|') WITHIN GROUP (ORDER BY B.TNC),
						[3] =  replicate('|' + @cFechas,count(Variable)),
						[4] = '|' + STRING_AGG(AN + '|'+  isnull(EXT + ';','') + isnull(ACU + ';','') +  NUM + ';' + DEN + ';' + DIV,'|') WITHIN GROUP (ORDER BY B.TNC)
				from 	storage.[com].[FVARCAMP](@indt,@ind) A
					join [rep].[FSPLITG](@tCADS,',') B
						on	A.Variable = B.TCAD) C
			unpivot(TCAD for level in([1],[2],[3],[4])) D
		order by
				level
	
		insert into @tTablaDef values('descripcion')	
		insert into @tTablaDef select TCAD from storage.[com].[FCABCAMP](@indt,null,@ind) order by nOrd

		declare @coldefs as rep.TTHCOLDEF
		insert into @coldefs(TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, TFORTYP, TDESC, TSTBACKGROUND)
		select	TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, isnull(TFORTYP,IIF(TKEY like 'DIV_%','percent','number')) TFORTYP, TDESC, IIF(TLEV = 1,'green',null) 
		from	[rep].FCABTABDEF(@tTabla,@tTablaDef)

		select [rep].[FFTHCOLDEF](@coldefs)
		
		------------------------------------------------------------------------------------------------------------------
		declare @cDesc varchar(max) = (	select	STRING_AGG(TCAD,',') WITHIN GROUP (ORDER BY TN) from @tTablaDef where TCAD <> 'descripcion')

		declare @cScript varchar(max) = '
		;with ctePiv as(
			SELECT	*			
			FROM	#tmpNoPiv A
				pivot(MAX(VAL) for DESVAR in(' + @cDesc + ')) B)

		select	A.estilo style, B.*
		FROM	#tmpdesc A
			join ctePiv B
				on 	A.descripcion = B.descripcion
		order by A.RNUM'
		
		EXEC(@cScript)
		
	end
	else
	BEGIN
		
		;with cteAge as(
			select  distinct
					TIPCOD, RCODPAR, RCODSUB, RNOMPAR, RNOMSUB
			from	storage.[com].[FTRAGEASE](4,'',2)),
		cteNom as(
			select  A.RCODSUB, A.RNOMSUB NOMAGE, B.RNOMPAR NOMREG
			from	cteAge A
				join cteAge B
					on	A.TIPCOD = 3
					and B.TIPCOD = 4
					and A.RCODPAR = B.RCODSUB)
		
		select  top 100
				row_number() over(order by B.VAL desc) Orden, A.RNOMSUB, B.VAL, C.NOMAGE, C.NOMREG
		FROM	#tmpDATOSPAR A
			join #tmpDatos B
				on 	A.RNUM = B.RNUM
				and B.DESVAR = 'PONDERADO'
			left join cteNom C
				on	A.RCODPAR = C.RCODSUB
		order BY
				1

	end

END
