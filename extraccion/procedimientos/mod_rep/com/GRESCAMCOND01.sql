-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-05-28 18:35:30.980000
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
-- exec [com].[GRESCAMCOND01] 7,231,'Monto','Flujo','DIAMES',1
  
--select * from [storage].[com_act].HCCO002  
  
CREATE procedure [com].[GRESCAMCOND01]  
 @tip_cod int,  
 @cod_rel varchar(10),      
 @tdcrMonto varchar(20),  
 @tdcrMoti varchar(20),
 @diariomes varchar(20) = '',
 @vista int = 2, 
 @tipmeta int = 1,  
 @fec date = null  
as  
begin  
 set nocount on  
  
 declare @dFechaMax date = (select MAX(SFECPRO) from [storage].[com_act].[SCCO001])
 
 if(@tdcrMonto='MontoMotivo' and @tdcrMoti='Stock')  
 begin  
  CREATE TABLE #tmpDATOS1(NVAR int, RCODVAR int, RDESPROD varchar(150), RNUM bigint, RNIVEL int, RNOMSUB varchar(250), TORD int, TFEC date, TNOMMES varchar(20), DESVAL varchar(150), VAL float)  
  
	declare @json varchar(max) =
	'[{"variables":"OpeCondTotMoti,OpeCondTot","elementos":[{"TIPCOD":' + convert(varchar(50),@tip_cod) + ',"CODREL":"' + @cod_rel +'","niveles":2}],"fechas":[' + IIF(@diariomes = '','2','1') + ']}]'  
  
  insert into #tmpDATOS1  
  EXEC mod_rep.[rep].[RCALC] @json,null,2 
       
  CREATE TABLE #tmpDATOS2S(NVAR int, RCODVAR int, RDESPROD varchar(150), RNUM bigint, RNIVEL int, RNOMSUB varchar(250), TORD int, TFEC date, TNOMMES varchar(20), DESVAL varchar(150), VAL float)  
    
  SELECT * INTO #tmpDATOS FROM #tmpDATOS1 WHERE (TORD <> 44101 AND @diariomes = '') OR @diariomes <> ''
  
   declare @Variables as table(ORD int identity(1,1), NVAR int, NOMV varchar(250), CODS int)  
  insert into @Variables values  
  (4,'ENFERMEDAD TERMINAL DEL CLIENTE Y/O FAMILIAR DIRECTO',1),  
  (8,'POR NEGOCIACION ANTE DEBIL POSICION ACREEDORA',1),  
  (7,'FUGADO Y TERCERO ASUME LA DEUDA',1),  
  (6,'EVENTO SOCIALES Y CLIMATICOS EN LA ZONA',1),  
  (5,'ESTAFA, FRAUDE O ROBO',1),  
  (3,'COVID-19',1),  
  (10,'OTROS',1),  
  (0,'Total',1)
    
  declare @tTabla as [rep].[TCADS], @tTablaDef as [rep].[TCADS]  
  insert into @tTabla  
  select 'NIVEL|' + STRING_AGG(NOMV,'|') within group (order by ORD)  
  from @Variables
  
  insert into @tTablaDef values ('RNOMSUB')  
  insert into @tTablaDef select NVAR from @Variables order by ORD  
   
  declare @coldefs as rep.TTHCOLDEF  
  insert into @coldefs(TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, TFORTYP, TDESC, TSTBACKGROUND,TSTDEWIDTH)  
  select TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, isnull(TFORTYP,'number') TFORTYP, TDESC, IIF(TLEV = 2,'green',IIF(TDESC LIKE '%[]%','#049ce4',null)),IIF(TISDATA>1,'100px',null)   
  from [rep].FCABTABDEF(@tTabla,@tTablaDef)  
  
  select [rep].[FFTHCOLDEF](@coldefs)  
   
  declare @piv varchar(max), @cScript varchar(max)  
  select @piv = STRING_AGG('[' + convert(varchar(10),NVAR) + ']',',') within group (order by ORD)  
  from @Variables  
   
  set @cScript = '  
   ;with cteDatos as(   
    select style = MAX(RNIVEL) over(partition by TORD) - RNIVEL, RNUM, B.HMCON, RNOMSUB,CONVERT(VARCHAR,CAST(VAL AS MONEY),1) as VAL  
    from #tmpDATOS A  
     left join (select  * 
				from	[storage].[com_act].HCCO002
				union all
				select  0, ''Total'') B  
      on A.RDESPROD = B.HDMCON)
  
  select *  
  from cteDatos A  
   pivot(MAX(VAL) for HMCON in(' + @piv + ') ) B  
  order by  
    RNUM'  
  
  exec(@cScript)
 end  
  
 if	(@tdcrMonto in('Monto','Ncredito') and @tdcrMoti in('Flujo','Stock')) 
 begin  
    declare @niveles int, @desglo int = 1  
	IF  (@vista = 2)
    	SET @niveles = 2
	IF  (@vista = 1)
    	SET @niveles = 1
	IF  (@vista = 3)
	begin
    	SET @niveles = 2
    	SET @desglo = 0
    end
	 
	CREATE TABLE #tmpDATOSS1S(NVAR int, RCODVAR int, RDESPROD varchar(150), RNUM bigint, RNIVEL int, RNOMSUB varchar(250), TORD int, TFEC date, TNOMMES varchar(20), DESVAL varchar(150), VAL float)  
	DECLARE @cvariables varchar(50)

	declare @jsonS varchar(max) =  
	'[{"variables":"' + IIF(@tdcrMonto='Ncredito',IIF(@tdcrMoti='Stock',IIF(@desglo = 1,'OpeCondCap,OpeCondInter,OpeCondCom,OpeCondTot','OpeCondTot'), 
																		IIF( @desglo = 1, IIF( @diariomes <> '','NumCondCapFlujo,NumCondInterFlujo,NumCondComFlujo' + IIF(@niveles = 2,',NumCondTotFlujoAcum',',NumCondTotFlujo,NumCondCapFlujoAcum,NumCondInterFlujoAcum,NumCondComFlujoAcum,NumCondTotFlujoAcum'),'NumCondCapFlujoAcum,NumCondInterFlujoAcum,NumCondComFlujoAcum,NumCondTotFlujoAcum') ,
																						  IIF( @diariomes <> '','NumCondTotFlujo,NumCondTotFlujoAcum','NumCondTotFlujoAcum')  )),
												IIF(@tdcrMoti='Stock',IIF(@desglo = 1,'MontCondCap,MontCondInter,MontCondCom,MontCondTot','MontCondTot'),
																		IIF( @desglo = 1, IIF( @diariomes <> '','MontCondCapFlujo,MontCondInterFlujo,MontCondComFlujo' + IIF(@niveles = 2,',MontCondTotFlujoAcum',',MontCondTotFlujo,MontCondCapFlujoAcum,MontCondInterFlujoAcum,MontCondComFlujoAcum,MontCondTotFlujoAcum'),'MontCondCapFlujoAcum,MontCondInterFlujoAcum,MontCondComFlujoAcum,MontCondTotFlujoAcum') ,
																						  IIF( @diariomes <> '','MontCondTotFlujo,MontCondTotFlujoAcum','MontCondTotFlujoAcum')))) + 
												'","elementos":[{"TIPCOD":' + convert(varchar(50),@tip_cod) + ',"CODREL":"' + @cod_rel +'","niveles":' + convert(varchar(15),@niveles) +'}],"fechas":[' + IIF(@diariomes = '','5','"' + @diariomes + '"') + ']}]'
	
	insert into #tmpDATOSS1S 
	EXEC mod_rep.[rep].[RCALC] @jsonS, 0,2
	
	DELETE FROM #tmpDATOSS1S WHERE NOT ((TORD <> 44101 AND @diariomes = '') OR @diariomes <> '') OR TFEC > @dFechaMax

	DECLARE @mintord int = (select MIN(TORD) from #tmpDATOSS1S)

	select 	distinct  
    		TORD, TNOMMES, TFEC
	into 	#tmpDATOSSFech  
	from 	#tmpDATOSS1S
 
  declare @VariablesS as table(ORD int identity(1,1), NVAR int, NOMV varchar(250))
  
  IF (@desglo = 1)
  BEGIN
	insert into @VariablesS values  
	(20,'COND.CAPITAL'),  
	(40,'COND.INTERES'), 
	(60,'COND.COMISIONES')
	insert into @VariablesS
	select 80, IIF(@niveles = 2, 'Total a '+ (select TNOMMES from #tmpDATOSSFech WHERE TORD = (SELECT MIN(TORD) FROM #tmpDATOSSFech)),'CONDONACION TOTAL') 
  end
  ELSE
  begin
  	insert into @VariablesS values (20,'CONDONACION TOTAL')

	if (@tdcrMoti='Flujo' and @diariomes <> '')
	insert into @VariablesS values (40,'TOTAL MES')	
  end
   
 declare @tTablaS as [rep].[TCADS]  
 
	IF (@niveles = 2)
		insert into @tTablaS  
		select 'NIVEL|' + STRING_AGG(NOMV,'|') within group (order by ORD)  
		from @VariablesS  
		union all  
		select replicate('|' +  STRING_AGG(TNOMMES,';') within group (order by TFEC),(SELECT IIF(@desglo = 1,count(*) - 1,1) FROM @VariablesS )) + IIF(@tdcrMoti='Flujo' and @diariomes <> '','|','')  
		from #tmpDATOSSFech
	ELSE
		insert into @tTablaS
		select 'RUBRO CONTABLE|' + (STRING_AGG(TNOMMES,'|') within group (order by TFEC) ) + IIF(@tdcrMoti='Flujo' and @diariomes <> '','|TOTAL MES','') 
		from #tmpDATOSSFech			
  
  CREATE TABLE #tmpVariabless(ORD int, CODB varchar(25))

	IF (@niveles = 2)  
		INSERT INTO #tmpVariabless
		select  ORD = row_number() over(order by A.ORD, B.TFEC asc),  
				convert(varchar(4),NVAR) + '_'  + convert(varchar(15),TORD) CODB
		FROM	@VariablesS A, #tmpDATOSSFech B
		where	NOT( A.NVAR = IIF(@desglo = 1,80,40) and B.TORD <> @mintord)
	ELSE
	begin
		INSERT INTO #tmpVariabless
		select  ORD = row_number() over(order BY TFEC asc), convert(varchar(15),TORD) CODB
		FROM	#tmpDATOSSFech
		
		if (@tdcrMoti='Flujo' and @diariomes <> '')
			insert into #tmpVariabless
			select 999, 0
	end

  declare  @tTablaDefS as [rep].[TCADS]  
  insert into @tTablaDefS values ('NOM')  
  insert into @tTablaDefS select CODB from #tmpVariabless order by ORD  
 
  declare @coldefsS as rep.TTHCOLDEF  
  insert into @coldefsS(TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, TFORTYP, TDESC, TSTBACKGROUND,TSTDEWIDTH) 
  select TORDER, TKEY, TLEV, TISDATA, TCOLS, TROWS, TSTICKY, IIF( (TDESC = 'TOTAL MES' or TFORTYP is null) and TKEY <> 'NOM' ,'number','string') TFORTYP, TDESC, IIF(TLEV = 2,'green',IIF(TDESC LIKE '%[]%','#049ce4',null)), IIF( (TDESC = 'TOTAL MES' or TFORTYP is null) and TKEY <> 'NOM' ,'100px','160px')  
  from [rep].FCABTABDEF(@tTablaS,@tTablaDefS)
 
  select [rep].[FFTHCOLDEF](@coldefsS)  
   
  declare @pivS varchar(max), @cScriptS varchar(max)  
  select @pivS = (STRING_AGG('[' + CODB + ']',',') within group (order by ORD) )
  from #tmpVariabless

  select style = IIF(IIF(@niveles = 2,RNOMSUB,B.NOMV) = 'CONDONACION TOTAL',1, MAX(RNIVEL) over(partition by TORD) - RNIVEL), IIF(@niveles = 2, RNUM, B.ORD) ORD, IIF(@niveles = 2,RNOMSUB,B.NOMV) NOM, 
  		replace(convert(varchar,convert(Money, round(val,0)),1),'.00','')  as VAL , 
		IIF(A.NVAR <= 80,IIF(@niveles = 2, convert(varchar(4),A.NVAR) + '_','') + convert(varchar(15),TORD),'0') CODB
  INTO	#tmpDatosF
  from #tmpDATOSS1S A
	join @VariablesS B
		on A.NVAR = B.NVAR
		or (A.NVAR = B.NVAR + 80 and A.TORD = @mintord)
  
   set @cScriptS = '
  
   select *  
   from #tmpDatosF A  
    pivot(MAX(VAL) for CODB in(' + @pivS + ') ) B  
   order by  
     ORD'
  
  exec(@cScriptS)  
 end  

END
