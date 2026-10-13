-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:33.937000

-- use mod_rep

/*
 EXEC [rep].GSREVA01 '20200218', 11, '',3
 EXEC [rep].GSREVA01 '20200218', 12, '',4
 EXEC [rep].GSREVA01 '20200218', 9, '',5
 
EXEC [rep].GSREVA01 '20200218', 11, 'TDRAT001', 3 


EXEC [rep].GSREVA01 '20200228', 11, '', 3

use mod_rep
EXEC [rep].GSREVA01 '20200223', 12, '', 4

use mod_rep
EXEC [rep].GSREVA01 '20200301', 9, '', 5
 
*/

--declare @Fecha date = '20191231', @tipcod int = 11, @codrel varchar(50) = '', @codmod smallint = 3

create PROCEDURE [rep].[GSREVA01](@Fecha date, @tipcod int = -1, @codrel varchar(50), @codmod smallint = -1)
AS
begin
	set nocount on
	
	select	@tipcod = IIF(@tipcod <> -1, @tipcod,STIPCOD),
			@codmod = IIF(@codmod <> -1, @codmod,
			case STIPCOD 
				when 11 then 3
				when 12 then 4
				else 5
			end)
	from	(select distinct STIPCOD, SCODSUB from mod_rep.[rep].[SDECCOM01] where STIPCOD in(11,12,9)) A	
	where	SCODSUB = @codrel
	
	CREATE TABLE #tmpDATOS(NVAR int, RCODVAR int, RDESPROD varchar(150), RNUM bigint, RNIVEL int, RNOMSUB varchar(250), TORD int, TFEC date, TNOMMES varchar(20), DESVAL varchar(150), VAL float)
	
	declare @json varchar(max)

	select  @json = (
	select	B.RALIVAR variable, isnull(A.SAMBGRU, B.RAMBGRU) tipo, SAMBFIL filtro, isnull(SDESVAR,RDESVAR) alias, 
			'elementos' = (select tipcod = @tipcod, codrel = @codrel for json path),
			'fechas' = '~[2]~','meta' = 'COM'
	from	[reva].[SVARREVA01] A
		join mod_rep.[rep].[RREGVAR01] B
			on	A.SCODVAR = B.RCODVAR
			and A.SCODMOD = @codmod
	order by
			A.SORDREV
	for json path)

	set @json = replace(replace(replace(@json,'"~',''),'~"',''),'`\','')
	
--	print @json
	
	insert into #tmpDATOS
	EXEC [rep].[RCALC] @json
	
	update #tmpDATOS set TORD = (TORD - 1) % 2 + 1 from #tmpDATOS
	
	exec [rep].[FTHEACOLS01] 'GSREVA01'
	
	;with cteDatos as(
		SELECT	TORD FORD, RNUM, NVAR, RCODVAR, VAL
		FROM	#tmpDATOS A
		where	RDESPROD <> 'Meta'
		union all
		SELECT	0 FORD, RNUM, NVAR, RCODVAR, VAL
		FROM	#tmpDATOS A
		where	RDESPROD = 'Meta'
			and TORD = 1),
	cteAdic as(
		SELECT  RNUM, NVAR, RCODVAR, [2],[1],[1] - [2] [-12], [0],
				[100] = [rep].[FUMB](IIF(RCODVAR between 150 and 151,[1] - [2], [1]) - [0],[0],RCODVAR,DEFAULT),
				IIF(RCODVAR between 150 and 151,[1] - [2], [1]) - [0] [-10]
		FROM	cteDatos A
			pivot(MAX(VAL) for FORD in([1],[2],[0])) B),
	cteFupvt as(
		SELECT	RNUM, NVAR, RCODVAR, FDESVAL, FVAL, convert(int,FDESVAL) IFDESVAL
		FROM	cteAdic A
			unpivot(FVAL for FDESVAL in([2],[1],[-12],[0],[100],[-10])) B),
	cteFormat as(
		SELECT	A.RNUM, A.NVAR, A.FDESVAL, [rep].[FFORMAT](A.FVAL,E.RFORV01,A.IFDESVAL,E.RFORV02) FVAL
		FROM	cteFupvt A
			join mod_rep.[rep].[RREGVAR01] E
				on A.RCODVAR = E.RCODVAR),
	cteAdic2 as(
		SELECT	*
		FROM	cteFormat A
			pivot(MAX(FVAL) for FDESVAL in([2],[1],[-12],[0],[100],[-10])) B)

	SELECT	A.RNUM, C.RNOMSUB, B.DESVAL, [2],[1],[-12],[0],[100],[-10]
	FROM	cteAdic2 A
		left join (select distinct NVAR, DESVAL from #tmpDATOS) B
			on 	A.NVAR = B.NVAR
		left join (select distinct RNUM, RNOMSUB from #tmpDATOS) C
			on 	A.RNUM = C.RNUM
	order by
			A.RNUM, A.NVAR

end
