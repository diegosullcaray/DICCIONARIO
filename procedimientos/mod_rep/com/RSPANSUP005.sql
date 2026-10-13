-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-14 19:10:33.837000

CREATE procedure [com].[RSPANSUP005] 
@tip_cod int,@cod_rel varchar(20),@cant varchar(2)='1'  --,@pagen int=1
--declare @tip_cod int=11 , @cod_rel varchar(250)='TACOL001', @cant varchar='1'
--declare @tip_cod int=7 , @cod_rel varchar(250)='231', @cant varchar='1'

AS       
begin      
 set nocount on;        
 declare @defs as rep.TTHCOLDEF;  

  insert into @defs        
   
    (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values   
	(1,1,1,'RDESTER','Territorio','string',null,null,null,null),
	(1,1,1,'RDESCOR','Corredor','string',null,null,null,null),     
    (1,1,1,'HDESCLI','Cliente','string',null,null,null,null),
	(2,2,1,'HCTACLI','Cuenta','number',null,null,null,null),   
    (3,3,1,'HCODOPE','Operación','number',null,null,null,null),
	(4,3,1,'HMONDESMN','Monto Desembolsado','number','.0-0',null,null,null),
	(5,3,1,'HFECDESA','Fecha Desembolso','number',null,null,null,null)

	 select rep.FFTHCOLDEF(@defs) result;    

	 
	--declare @tip_cod int=11 , @cod_rel varchar(20)='TEDEM001', @cant varchar='2' 
	--declare @tip_cod int=7 , @cod_rel varchar(20)='231', @cant varchar(2)='2'
	--declare @tip_cod int=15 , @cod_rel varchar(20)='999', @cant varchar(2)='1'
	declare @where_campo1 varchar(20), @where_campo2 varchar(20), @sql varchar(max), @where_HMONDESMN varchar(50), @where_CLINUE varchar(50)

	if(@tip_cod=7)
		Begin select @where_campo1 = '1'  End
	else if (@tip_cod=20)
		Begin select @where_campo1 = 'RCODTER' End
	else if (@tip_cod=19)
		Begin select @where_campo1 = 'RCODCOR' End
	else if (@tip_cod=21)
		Begin select @where_campo1 = 'RCODGRU' End
	else if (@tip_cod=18)
		Begin select @where_campo1 = 'RCODUNI' End

	set @where_campo2 = 
	case when @tip_cod=7 then '=1' else 
	case when @cod_rel = '9999' then 'is null' else '='''+@cod_rel+'''' end
	end

	if(@cant=1)
		Begin select @where_HMONDESMN = 'HMONDESMN >=50000', @where_CLINUE = ''  End
	else
		Begin select @where_HMONDESMN = 'HMONDESMN >= 30000 and HMONDESMN < 50000', @where_CLINUE = 'AND HCLINUE=''NUEVO'' '   End


	set @sql = '
	select B.*,
	C.RDESTER, C.RDESCOR
	--case when OPEPRE = 1 then ''SI'' else ''NO'' end OPEPRE2,
	--case when OPEPOST = 1 then ''SI'' else ''NO'' end OPEPOST2
	from storage.com_act.WSUPDESEM001 B
	LEFT JOIN storage.[ref].WJERCOR03 C
	on B.HCODSEC =  C.RCODSEC and B.HFECPRO=C.RFECPRO and RINDFEC=''ACTUAL'' 
	where '+@where_campo1+'  '+@where_campo2+'
	and SUPERVISADO = 0
	and  '+@where_HMONDESMN+' 	
	  '+@where_CLINUE+' 	
	order by HMONDESMN DESC
	'
	/*
	- Operaciones >= 50 mil ( Nuevo y recurrente )
	- Operaciones >= 30  y < 50 mil ( nuevos) criterio MIS
	*/
	 --print @sql



	
	exec (@sql)
	
end
