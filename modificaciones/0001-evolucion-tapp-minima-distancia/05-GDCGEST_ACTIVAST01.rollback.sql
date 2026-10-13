-- MOD-0001 · ROLLBACK: deja mod_rep.com.GDCGEST_ACTIVAST01 como estaba al 2024-07-04 (versión extraída el 2026-10-13).
-- Solo sirve si 04-verificacion.sql (paso 1) confirmó que esa era la versión de producción.
-- Lo más seguro igual es guardar, ANTES de modificar, el script que da SSMS (clic derecho › Modificar) como respaldo.

USE mod_rep;
GO
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST01] '7','231','1','20240319','1'
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST01] '7', '231', 4, '20230327', 0
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST01] '14','16','0','2','20210809','1'
--EXEC [mod_rep].[com].[GDCGEST_ACTIVAST01] '15','9999','0','1','20210810','1'
ALTER PROCEDURE [com].[GDCGEST_ACTIVAST01]  
	@tip_cod varchar(10),
	@cod_rel varchar(10),
	@var int,
	@fec date,
	@diario int=0
as
begin
	--@var=1 operaciones desembolsadas
	--@var=2 % operaciones desembolsadas
	--@var=3 TAPPM
	--@var=4 hist operaciones desembolsadas
	--@var=5 hist monto desembolsado
	--@var=6 hist TAPPM

  SET NOCOUNT ON;
  --declare @tip_cod varchar(10)=7,	@cod_rel varchar(10)='231',	@dim int=0,@var int=4,@fec date='20230327',@diario int=0
	declare @fecs varchar(max),@ORD int,@format varchar(10),@calc varchar(50),@json nvarchar(max)
DECLARE @fecha date, @fecs_2 varchar(max)
  
  select @ORD=max(ORD)
	from storage.[com_act].[WGATH002]
	where ORD<= case when @diario=0 then 100 else 31 end

	select @format=iif(@var in(2,3,6),'P','N0'), @calc=iif(@var in(1,2,4),'HNRO',iif(@var in(3,6),'HTAPPMES','HMDES'))

	 
	/*CABECERAS*/
	if @var = 1
	begin
		select @json=N'[
        {
          "level":1,
          "columns":[
         {
            "columnDef":"DESCR",
            "header":"Producto / Desembolso por Nivel",
            "isdata":1,
            "sticky":true,
            "format":{
              "type":"string"
            },
            "rows":2
         },
         {
            "columnDef":"A1",
            "header":"Encima Tasa M nima",
            "isdata":2,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A2",
            "header":"A la Tasa M nima",
            "isdata":3,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"auto_comerciales",
            "header":"Autonomias Comerciales",
            "cols":4
            
         },
         {
            "columnDef":"A3",
            "header":"Total Autonom as",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A10",
            "header":"Total Operaciones",
            "isdata":9,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"PO",
            "header":"% Operaciones",
            "isdata":10,
            "format":{
              "type":"number"
            },
            "rows":2
         }]
        },
        {
          "level":2,
         "columns":[
          {
            "columnDef":"B1",
            "header":"Administrador",
            "isdata":4,
            "format":{
              "type":"number"
            }
         },
         {
          "columnDef":"B2",
          "header":"Gte. Corredor / R. Negocio Grupal",
          "isdata":5,
          "format":{
            "type":"number"
          }
        },
        {
          "columnDef":"B3",
          "header":"Gte. Territorial",
          "isdata":6,
          "format":{
            "type":"number"
           
          }
        },
        {
          "columnDef":"B4",
          "header":"Gte. Divisi n Comercial",
          "isdata":7,
          "format":{
            "type":"number"
           
          }
        }
         ]
        }
    ]'
	end
	if @var = 2
	begin
		select @json=N'[
        {
          "level":1,
          "columns":[
         {
            "columnDef":"DESCR",
            "header":"Producto / Desembolso por Nivel",
            "isdata":1,
            "sticky":true,
            "format":{
              "type":"string"
            },
            "rows":2
         },
         {
            "columnDef":"A1",
            "header":"Encima Tasa M nima",
            "isdata":2,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A2",
            "header":"A la Tasa M nima",
            "isdata":3,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         
         {
            "columnDef":"auto_comerciales",
            "header":"Autonom as Comerciales",
            "cols":4
            
         },{
            "columnDef":"A3",
            "header":"Total Autonom as",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A10",
            "header":"Total Operaciones",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         }]
        },
        {
          "level":2,
         "columns":[
          {
            "columnDef":"B1",
            "header":"Administrador",
            "isdata":4,
            "format":{
              "type":"number"
            }
         },
         {
          "columnDef":"B2",
          "header":"Gte. Corredor / R. Negocio Grupal",
          "isdata":5,
          "format":{
            "type":"number"
          }
        },
        {
          "columnDef":"B3",
          "header":"Gte. Territorial",
          "isdata":6,
          "format":{
            "type":"number"
           
          }
        },
        {
          "columnDef":"B4",
          "header":"Gte. Divisi n Comercial",
          "isdata":7,
          "format":{
            "type":"number"
           
          }
        }
        ]
        }
    ]'
	end
	if @var = 3
	begin
		select @json=N'[
        {
          "level":1,
          "columns":[
         {
            "columnDef":"DESCR",
            "header":"Producto / Desembolso por Nivel",
            "isdata":1,
            "sticky":true,
            "format":{
              "type":"string"
            },
            "rows":2
         },
         {
            "columnDef":"A1",
            "header":"Encima Tasa M nima",
            "isdata":2,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A2",
            "header":"A la Tasa M nima",
            "isdata":3,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"auto_comerciales",
            "header":"Autonomias Comerciales",
            "cols":4
            
         },
         {
            "columnDef":"A3",
            "header":"TAPP Autonom as",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A10",
            "header":"TAPP Final",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"TM",
            "header":"TAPP M nima",
            "isdata":9,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {"columnDef":"FF","header":"","isdata":10,"hidden":true,"format":{"type":"traffic-light"}}, 
         {"columnDef":"DT",
            "header":"Distancia (en pbs)",
            "isdata":11,
            "format":{
              "type":"number"
            },
            "cols":2,
            "rows":2
         }
         ]
        },
        {
          "level":2,
         "columns":[
          {
            "columnDef":"B1",
            "header":"Administrador",
            "isdata":4,
            "format":{
              "type":"number"
            }
         },
         {
          "columnDef":"B2",
          "header":"Gte. Corredor / R. Negocio Grupal",
          "isdata":5,
          "format":{
            "type":"number"
          }
        },
        {
          "columnDef":"B3",
          "header":"Gte. Territorial",
          "isdata":6,
          "format":{
            "type":"number"
           
          }
        },
        {
          "columnDef":"B4",
          "header":"Gte. Divisi n Comercial",
          "isdata":7,
          "format":{
            "type":"number"           
          }
        }
        ]
        }
    ]'
	end	
	if @var = 4
	begin
		select @json=N'[
        {
          "level":1,
          "columns":[
         {
            "columnDef":"DESCR",
            "header":"fecha",
            "isdata":1,
            "sticky":true,
            "format":{
              "type":"string"
            },
            "rows":2
         },
         {
            "columnDef":"A1",
            "header":"Encima Tasa M nima",
            "isdata":2,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A2",
            "header":"A la Tasa M nima",
            "isdata":3,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"auto_comerciales",
            "header":"Autonomias Comerciales",
            "cols":4
            
         },
         {
            "columnDef":"A3",
            "header":"Total Autonom as",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A10",
            "header":"Total",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"PO",
            "header":"% Uso de Autonom as",
            "isdata":9,
            "format":{
              "type":"number"
            },
            "rows":2
         }]
        },
        {
          "level":2,
         "columns":[
          {
            "columnDef":"B1",
            "header":"Administrador",
            "isdata":4,
            "format":{
              "type":"number"
            }
         },
         {
          "columnDef":"B2",
          "header":"Gte. Corredor / R. Negocio Grupal",
          "isdata":5,
          "format":{
            "type":"number"
          }
        },
        {
          "columnDef":"B3",
          "header":"Gte. Territorial",
          "isdata":6,
          "format":{
            "type":"number"
           
          }
        },
        {
          "columnDef":"B4",
          "header":"Gte. Divisi n Comercial",
          "isdata":7,
          "format":{
            "type":"number"
           
          }
        }
        ]
        }
    ]'
	end
	if @var = 5
	begin
		select @json=N'[
        {
          "level":1,
          "columns":[
         {
            "columnDef":"DESCR",
            "header":"Fecha",
            "isdata":1,
            "sticky":true,
            "format":{
              "type":"string"
            },
            "rows":2
         },
         {
            "columnDef":"A1",
            "header":"Encima Tasa M nima",
            "isdata":2,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A2",
            "header":"A la Tasa M nima",
            "isdata":3,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"auto_comerciales",
            "header":"Autonomias Comerciales",
            "cols":4
            
         },
         {
            "columnDef":"A3",
            "header":"Total Autonom as",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A10",
            "header":"Total",
            "isdata":9,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"PO",
            "header":"% Uso de Autonom as",
            "isdata":10,
            "format":{
              "type":"number"
            },
            "rows":2
         }]
        },
        {
          "level":2,
         "columns":[
          {
            "columnDef":"B1",
            "header":"Administrador",
            "isdata":4,
            "format":{
              "type":"number"
            }
         },
         {
          "columnDef":"B2",
          "header":"Gte. Corredor / R. Negocio Grupal",
          "isdata":5,
          "format":{
            "type":"number"
          }
        },
        {
          "columnDef":"B3",
          "header":"Gte. Territorial",
          "isdata":6,
          "format":{
            "type":"number"
           
          }
        },
        {
          "columnDef":"B4",
          "header":"Gte. Divisi n Comercial",
          "isdata":7,
          "format":{
            "type":"number"
           
          }
        }
        ]
        }
    ]'
	end
	if @var = 6
	begin
		select @json=N'[
        {
          "level":1,
          "columns":[
         {
            "columnDef":"DESCR",
            "header":"Fecha",
            "isdata":1,
            "sticky":true,
            "format":{
              "type":"string"
            },
            "rows":2
         },
         {
            "columnDef":"A1",
            "header":"Encima Tasa M nima",
            "isdata":2,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A2",
            "header":"A la Tasa M nima",
            "isdata":3,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"auto_comerciales",
            "header":"Autonomias Comerciales",
            "cols":4
            
         },
         {
            "columnDef":"A3",
            "header":"TAPP Total Autonom as",
            "isdata":8,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"A10",
            "header":"TAPP Final",
            "isdata":9,
            "format":{
              "type":"number"
            },
            "rows":2
         },
         {
            "columnDef":"TP",
            "header":"Ticket Promedio",
            "isdata":10,
            "format":{
              "type":"number"
            },
            "rows":2
         }]
        },
        {
          "level":2,
         "columns":[
          {
            "columnDef":"B1",
            "header":"Administrador",
            "isdata":4,
            "format":{
              "type":"number"
            }
         },
         {
          "columnDef":"B2",
          "header":"Gte. Corredor / R. Negocio Grupal",
          "isdata":5,
          "format":{
            "type":"number"
          }
        },
        {
          "columnDef":"B3",
          "header":"Gte. Territorial",
          "isdata":6,
          "format":{
            "type":"number"
          }
        },
        {
          "columnDef":"B4",
          "header":"Gte. Divisi n Comercial",
          "isdata":7,
          "format":{
            "type":"number"
           
          }
        }
        ]
        }
    ]'
	end

	 


	select distinct HFECPRO RFEC
	into #FECS
	from storage.[com_act].[WGATH002]
	where ORD=@ORD and RFEC<=@fec

SELECT @fecha = (select max(rfec) from [storage].[ref].[RCALEN001] where RFEC <= @fec and RDIAFER = 0)

SELECT RFEC, CONCAT(LEFT(RMESNOM, 3), '. ', RIGHT(RANI, 2)) [NomFec]
INTO #FecList
from [storage].[ref].[RCALEN001]
where RFEC = @fecha

declare @tvars as piv.TPIVVAR, @tfil as piv.TPIVFIL, @tconf as piv.TPIVCONF, @jerar varchar(100)
select @fecs_2=(select replace(cast(max(hfecpro) as varchar(250)),'-','') from [storage].[com_act].WACLI001)

insert into @tvars values ('num_cli_stock', null, '166', null, null, null), ('num_ope_sf2', null, '5006', null, null, null)
insert into @tfil values ('todos', 'fec', ''+@fecs_2+'')
insert into @tconf values ('level_alias', 'style')
insert into @tfil
exec [piv].[GPIVLEV01] @tip_cod, @cod_rel, @jerar output

  select  @fec=max(HFECPRO)
	from    storage.[com_act].[WGATH002]
	where   ORD=@ORD and RFEC<=@fec

	select @fecs=string_agg(RFEC,',')
	from #FECS A
  
	create table #res
	(
		ORD int not null identity(1,1),
		DESCR varchar(50),
    RFECPRO varchar(50),
		RDESPROD varchar(50),
		RVAR varchar(50),
		ESTILO int,
		DFORMAT varchar(10)
	)

	if @var in (1,2,3)
	begin
		insert into #res
			(DESCR,RFECPRO,RDESPROD,RVAR,ESTILO)
		select distinct case when RDESGRU01 in('Productos NO CORE','Productos No Vigentes') or RCODPROD in(16,17,20,21) then 'OTROS' else RDESPROD end
            ,cast(@fec as varchar), case when RDESGRU01 in('Productos NO CORE','Productos No Vigentes') or RCODPROD in(16,17,20,21) then 'OTROS' else RDESPROD end, @calc, 0
		from storage.com_act.RETP003
		order by 1

		if @var=1
    begin

    update #res
    set DFORMAT='N0'
    
	  insert into #res
			(DESCR,RFECPRO,RDESPROD,RVAR,ESTILO,DFORMAT)
		values('TOTAL',cast(@fec as varchar), 'TOTAL', 'HNRO', 1,'N0')
    end

		if @var=2
    begin
    update #res
    set DFORMAT='P' 

	  insert into #res
			(DESCR,RFECPRO,RDESPROD,RVAR,ESTILO,DFORMAT)
		values('TOTAL',cast(@fec as varchar), 'TOTAL', 'HPARTNRO', 1,'P')			    
    
    end
		if @var=3
    begin
    update #res
    set DFORMAT='P' 

	insert into #res
			(DESCR,RFECPRO,RDESPROD,RVAR,ESTILO,DFORMAT)
		values('TOTAL', cast(@fec as varchar),'TOTAL', 'HTAPPMES', 1,'P')
    end
	end

	if @var in (4,5,6)
	begin
		insert into #res
			(DESCR,RFECPRO,RDESPROD,RVAR,ESTILO)
		select cast(RFEC as varchar), cast(RFEC as varchar),'TOTAL', @calc, 0
		from #FECS
		order by RFEC asc
    
    if @var=4
    begin
    update #res
    set DFORMAT='N0' 

    insert into #res
			(DESCR,RFECPRO,RDESPROD,RVAR,ESTILO,DFORMAT)
		values (cast(@fec as varchar)+ ' (%)',cast(@fec as varchar),'TOTAL','HPARTNRO', 1,'P')
    --,('Promedio(dic.20-jun.21) (%)','TOTAL','TOTAL','HPARTNRO', 1,'P')
    ,('Var Abs (pbs)',cast(@fec as varchar),'TOTAL','HVARPARTNROHIST', 1,'N0')    
    end

    if @var=5
    begin
    update #res
    set DFORMAT='N0' 

    insert into #res
			(DESCR,RFECPRO,RDESPROD,RVAR,ESTILO,DFORMAT)
		values (cast(@fec as varchar)+ ' (%)',cast(@fec as varchar),'TOTAL','HPARTMDES', 1,'P')
    --,('Promedio(dic.20-jun.21) (%)','TOTAL','TOTAL','HPARTMDES', 1,'P')
    ,('Var Abs (pbs)',cast(@fec as varchar),'TOTAL','HVARPARTMDESHIST', 1,'N0')    
    end

    if @var=6
    begin
    update #res
    set DFORMAT='P' 

    insert into #res
			(DESCR,RFECPRO,RDESPROD,RVAR,ESTILO,DFORMAT)
		values (cast(@fec as varchar)+ ' (%)',cast(@fec as varchar),'TOTAL','HTAPPMES', 1,'P')
    --,('Promedio(dic.20-jun.21) (%)','TOTAL','TOTAL','HTAPPMES', 1,'P')
    ,('Var Abs (pbs)',cast(@fec as varchar),'TOTAL','HVARTAPPMESHIST', 1,'N0')    
    end
	end
	;
	with
		cte_a
		as

		(
			select A.*, case when RDESGRU01 in('Productos NO CORE','Productos No Vigentes') then 'OTROS' else RDESPROD end RDESPROD
			from storage.[com_act].[WGATH002] A
				left join storage.com_act.RETP001 C
				on			A.HMOD=C.RCODMOD and A.HTOPE=C.RTIPOPE
				left join storage.com_act.RETP002 D
				on			A.HMOD=D.RCODMOD and A.HTOPE=D.RTIPOPE and A.HSUBTIP=D.RSUBTIP
				left join storage.com_act.RETP003 E
				on			isnull(D.RCODPROD,C.RCODPROD)=E.RCODPROD
			where		ORD=@ORD and case when @var in(1,2,3) then A.HFECPRO else '1900-01-01' end = case when @var in(1,2,3) then @fec else '1900-01-01' end and A.HFECPRO<=@fec
		)
		,cte_b
		as

		(
			select isnull(cast(HFECPRO as varchar),'TOTAL')HFECPRO
			, isnull(HUCAP_FIN,'TOTAL') HUCAP_FIN
			, isnull(RDESPROD,'TOTAL') RDESPROD
			, isnull(HGESTTAS,10) HGESTTAS
			, cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)HTAPPMES
			, cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMIN
			, cast(count(*)  as float) HNRO
			, cast(sum(HMDES) as float) HMDES
      , cast(sum(HMDES)/count(*) as float) HTPROM
      , round((
		cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) -
		cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)
	   )*10000,0) HDIFTAPPMM
			from cte_a
      where case when @tip_cod='7' then 	cast('1' as varchar(10)) 
				                when @tip_cod='20' then cast(RCODTER as varchar(10))--TERRITORIO
				                when @tip_cod='19' then cast(RCODCOR as varchar(10))--CORREDOR
								when @tip_cod='21' then cast(RCODGRU as varchar(10))--GRUPO
				                when @tip_cod='18' then cast(RCODUNI as varchar(10))--UNIDAD NEGOCIO
				                when @tip_cod='17' then cast(RCODUCO as varchar(10))--COORDINADOR
								when @tip_cod='2' then cast(RCODSEC  as varchar(10)) end = case when @tip_cod='7' then '1'
												else @cod_rel  end and HFECPRO<=@fec
      --group by cube(HFECPRO,RDESPROD,HUCAP_FIN,HGESTTAS)
			group by HFECPRO,cube(RDESPROD,HUCAP_FIN,HGESTTAS)
      UNION 
      select  'TOTAL' HFECPRO
			, isnull(HUCAP_FIN,'TOTAL') HUCAP_FIN
			, isnull(RDESPROD,'TOTAL') RDESPROD
			, isnull(HGESTTAS,10) HGESTTAS
			, cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)HTAPPMES
			, cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) HTAPPMIN
			, cast(count(*)  as float) HNRO
			, cast(sum(HMDES) as float) HMDES
      , cast(sum(HMDES)/count(*) as float) HTPROM
      , round((
		cast(sum(convert(float,HMDES)*convert(float,HTDES)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float) -
		cast(sum(convert(float,HMDES)*convert(float,HTMIN)/100)/case when sum(convert(float,HMDES)) = 0 then null else sum(convert(float,HMDES)) end  as float)
	   )*10000,0) HDIFTAPPMM
			from cte_a
      where case when @tip_cod='7' then 	cast('1' as varchar(10)) 
				                when @tip_cod='20' then cast(RCODTER as varchar(10))--TERRITORIO
				                when @tip_cod='19' then cast(RCODCOR as varchar(10))--CORREDOR
								when @tip_cod='21' then cast(RCODGRU as varchar(10))--GRUPO
				                when @tip_cod='18' then cast(RCODUNI as varchar(10))--UNIDAD NEGOCIO
				                when @tip_cod='17' then cast(RCODUCO as varchar(10))--COORDINADOR
								when @tip_cod='2' then cast(RCODSEC  as varchar(10)) end = case when @tip_cod='7' then '1'
												else @cod_rel  end and HFECPRO between '2020-12-31' and '2021-06-30' and HFECPRO<=@fec
      group by cube(RDESPROD,HUCAP_FIN,HGESTTAS)                        
		)
		,
		cte_c
		as
		(
			select A.*,A.HNRO/(B.HNRO*1.) HPARTNRO 
            ,A.HMDES/(B.HMDES*1.) HPARTMDES
			from cte_b A
      left join cte_b B
      on      B.HGESTTAS=10 and B.RDESPROD='TOTAL' and B.HUCAP_FIN='TOTAL' and A.HFECPRO=B.HFECPRO
     	WHERE	case when @var in(4,5,6) then A.RDESPROD else '' end = case when @var in(4,5,6) then 'TOTAL' else '' end
      
		)
    ,cte_d as(
      select A.*
            ,(A.HTAPPMES-B.HTAPPMES)*10000 [HVARTAPPMESHIST]
            ,(A.HPARTNRO-B.HPARTNRO)*10000 [HVARPARTNROHIST]
            ,(A.HPARTMDES-B.HPARTMDES)*10000 [HVARPARTMDESHIST] 
      from cte_c A
      left join   cte_c B
      on    A.HFECPRO=cast(@fec as varchar) and B.HFECPRO='TOTAL' and A.HGESTTAS=B.HGESTTAS and A.HUCAP_FIN=B.HUCAP_FIN and B.RDESPROD='TOTAL' and A.RDESPROD='TOTAL'

    )
	select *
	into #RESULT
	from cte_d A
	 unpivot(valores for variables in([HTAPPMIN],[HTAPPMES],[HDIFTAPPMM],[HNRO],[HMDES],[HTPROM],[HPARTNRO],[HPARTMDES],[HVARTAPPMESHIST],[HVARPARTNROHIST],[HVARPARTMDESHIST]) ) UNPTV
	order by 1,2,3

	select *
	into #C
	from( select *
		from #RESULT
		where /*variables=@calc and*/ HUCAP_FIN='TOTAL') A pivot(max(valores) for HGESTTAS in([1],[2],[3],[10])) PVT

	select *
	into #D
	from( select *
		from #RESULT
		where /*variables=@calc and*/ HGESTTAS=10) A pivot(max(valores) for HUCAP_FIN in([Administrador],[Gerente Corredor / R. Negocio Grupal],[Gerente Territorial],[Gte. Divisi n Comercial],[TOTAL])) PVT
 --select * from #C
 --select * from #D
	select @json result
  --select * from #res
	select distinct  A.ORD,A.ESTILO as style,A.DESCR
				, format(isnull(B.[1],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) A1
				, format(isnull(B.[2],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) A2
				, format(isnull(C.Administrador,0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) B1
				, format(isnull(C.[Gerente Corredor / R. Negocio Grupal],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) B2
				, format(isnull(C.[Gerente Territorial],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) B3
				, format(isnull(C.[Gte. Divisi n Comercial],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) B4
				, format(isnull(B.[3],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) A3
				, format(isnull(B.[10],0)/iif(@var=2,iif(B.[10]=0,null,B.[10]),1.0),A.DFORMAT) A10
        , format(isnull(B.[3],0)/(iif(B.[10]=0,null,B.[10])*1.0),'P') PO
        , format(D.[10],'N0') TP
        , format(isnull(E.[10],0),'P') TM
        , format(isnull(F.[10],0),'N0') DT
  into #FIN      
	from #res A
		left join #C B
		ON			A.RDESPROD=B.RDESPROD and A.RVAR=B.variables and A.RFECPRO=B.HFECPRO and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(B.HFECPRO as varchar) else 'TOTAL' end
		left join #D C
		ON			A.RDESPROD=C.RDESPROD and A.RVAR=C.variables and A.RFECPRO=C.HFECPRO and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(C.HFECPRO as varchar) else 'TOTAL' end
    left join #C D
		ON			A.RDESPROD=D.RDESPROD and A.RVAR not in('HVARTAPPMESHIST','HVARPARTNROHIST','HVARPARTMDESHIST') and D.variables='HTPROM' and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(D.HFECPRO as varchar) else 'TOTAL' end
    left join #C E
		ON			A.RDESPROD=E.RDESPROD and E.variables='HTAPPMIN' and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(E.HFECPRO as varchar) else 'TOTAL' end
    left join #C F
		ON			A.RDESPROD=F.RDESPROD and F.variables='HDIFTAPPMM' and case when @var in(4,5,6) then A.RFECPRO else 'TOTAL' end = case when @var in(4,5,6) then cast(F.HFECPRO as varchar) else 'TOTAL' end
	
  select * from #FIN A
  order by	A.ORD

END
GO
