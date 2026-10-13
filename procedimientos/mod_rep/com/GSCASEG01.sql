-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:31.330000

/*
  
	exec mod_rep.[com].[GSCASEG01] '231',7

 *
 */

CREATE procedure [com].[GSCASEG01]
    @cod_rel varchar(10),
    @tip_cod int,
	@tipmeta int = 1,
	@fec date = null
as
begin
	set nocount on
	
	CREATE TABLE #tmpDATOS(NVAR int, RCODVAR int, RDESPROD varchar(150), RNUM bigint, RNIVEL int, RNOMSUB varchar(250), TORD int, TFEC date, TNOMMES varchar(20), DESVAL varchar(150), VAL float)
	
	declare @tReporte as table(ORD int identity(1,1), RVAR varchar(50), RVARA varchar(50))
	declare @Variables varchar(max), @piv varchar(max), @cab varchar(max)
	insert into @tReporte values
	('ASEG_Tot.Seg.Mult.Pol.PCC','Multiriesgo'),
	('ASEG_Tot.Seg.Prot.Pol.PCC','Protección Cuotas'),
	('ASEG_Tot.Seg.MC.Pol.PCC','Múltiple'),
	('MetaSeg','Meta Mensual Seguros'),
	('AvanSeg','Avance Mensual'),
	('ASEG_Nro.CAm','Agrícola Cutas Mensuales'),
	('ASEG_Nro.CAv','Agrícola al vencimiento'),
	('ASEG_Nro.CAf','Agrícola cuotas flexibles'),
	('ASEG_Nro.C','Consumo (personal)'),
	('ASEG_Nro.CE','Crédito Educativo'),
	('ASEG_Tot.Seg.Nro','Total pólizas seguros'),
	('MetaSeg1','Meta Mensual Seguros'),
	('AvanSeg1','Avance Mensual')
	
	select	@Variables = STRING_AGG(RVAR,',') WITHIN GROUP (ORDER BY ORD),
			@piv = STRING_AGG('[' + RVAR + ']',',') WITHIN GROUP (ORDER BY ORD),
			@cab = '|' + STRING_AGG( IIF(ORD <=5, RVARA,null),';') WITHIN GROUP (ORDER BY ORD) + '|' + STRING_AGG( IIF(ORD >5, RVARA,null),';') WITHIN GROUP (ORDER BY ORD)
	from	@tReporte
	
	declare @json varchar(max) = '[{"variables":"' + @Variables + '","elementos":[{"TIPCOD":' + convert(varchar(5),@tip_cod) + ',"CODREL":"' + @cod_rel +'","niveles":' + CONVERT(VARCHAR(5),IIF(@tip_cod = 4,3,2)) + '}],"fechas":[1]}]'
	
	insert into #tmpDATOS  -- DROP TABLE #tmpDATOS
	EXEC [rep].[RCALC] @json

	declare @cfecha varchar(50) = (select top 1 TFEC from #tmpDATOS)
	set @cfecha = replicate('|' + @cfecha,2)
	
	declare @tTabla as [rep].[TCADS], @tTablaDef as [rep].[TCADS]
	insert into @tTabla values
	('Nivel|PYME y C.C.|Otros créditos'),
	(@cfecha),
	(@cab)

	insert into @tTablaDef values ('RNOMSUB')
	insert into @tTablaDef select RVAR from @tReporte order by ORD

	declare @coldefs as rep.TTHCOLDEF
	insert into @coldefs(TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, TFORTYP, TDESC)
	select	TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, isnull(TFORTYP,'number') TFORTYP, TDESC
	from	[rep].FCABTABDEF(@tTabla,@tTablaDef)

	select [rep].[FFTHCOLDEF](@coldefs)

	declare @cScript varchar(max) =	
	';with cteDatos as(
		select	style = MAX(RNIVEL) over(partition by TORD) - RNIVEL, RNUM, RNOMSUB, DESVAL, VAL
		from	#tmpDATOS)
	
	select	*
	from	cteDatos A
		pivot(MAX(VAL) for DESVAL in (' + @piv + ')) B
	order by
			RNUM'

	EXEC(@cScript)

END
