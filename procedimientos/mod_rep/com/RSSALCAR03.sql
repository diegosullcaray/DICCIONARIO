-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-02-27 17:27:18.537000
--EXEC com.RSSALCAR03 7,'231','20200806'
CREATE PROCEDURE [com].[RSSALCAR03] 
@tip_cod int,@cod_rel varchar(20), @fecha date 
AS     
BEGIN
	set nocount on;
	--declare @fecha date='20'
	declare @fec varchar(8);
	select @fec=(select max(RFECTXT) from storage.ref.RCALEN001 where RFEC<=@fecha and RDIAFER=0)
	declare @defs as rep.TTHCOLDEF
	declare @w varchar(10)='14%'
	
	insert into @defs
	(TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TSTICKY)  values
	(1,1,1,'descripcion','Descripción','string',1)
	insert into @defs
	(TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,TSTDEWIDTH,THIDDEN,TCOLS)  values
	(2,2,1,'prod_ind','Productividad Individual','number','.1-1',@w,null,null),
	(3,3,1,'prod_gru','Productividad Grupal','number','.1-1',@w,null,null),
	(4,4,1,'prod_tot','Productividad Total','number','.1-1',@w,null,null),
	(5,5,1,'met_prod_tot','Meta Productividad Total','number','.1-1',@w,null,null),
	(6,6,1,'sem_var','','traffic-light',null,null,1,null),
	(7,7,1,'var','Variación','number','.1-1',@w,null,2)

	--select * from @defs
	select rep.FFTHCOLDEF(@defs) result;

	--declare @fec varchar(8)='20200805'
	declare @tvars as piv.TPIVVAR,@tfil as piv.TPIVFIL,@tconf as piv.TPIVCONF

	insert into @tvars values 
	('num_ope_sf2',null,null,null,null,null),
	('prod_tot',null,null,null,null,null)
	--('num_sec_ws_6',null,null,null,null,null)

	insert into @tfil
	values
	('todos','fec',''+@fec+'')--,
	--('ws_dat_6','SCODCREL02','"1","2"')

	--declare @tip_cod int=15,@cod_rel varchar(100)='2'
	declare @jer varchar(100);
	insert into @tfil
	exec piv.GPIVLEV01 @tip_cod,@cod_rel,@jer output
  

	insert into @tconf
	values
	('level_alias','style')

	--los valores rows y columnas van separados por comas y cada valor entre doble comilla
	--'vars' es la key reservada para hacer referencia a la coleccion de variables y siempre debe estar presente y en solo una ubicacion
	--create table #report (fila int,cod_fc int,cod_ter int,style int,descripcion varchar(100),
	--sal_cap float,sal_cap_1 float,sal_cap_11 float,sal_cap_12 float,sal_cap_13 float,sal_cap_16 float,sal_cap_2 float,
	--sal_cap_3 float,sal_cap_4 float,sal_cap_5 float,sal_cap_6 float,sal_cap_7 float,sal_cap_8 float,sal_cap_9 float)

	--insert into #report
	exec piv.GPIVRES01 @variables=@tvars,@filters=@tfil,@rows=@jer,@columns='"vars"',@config=@tconf--,@show_query=1

	--select fila,cod_fc,cod_ter,style,descripcion,sal_cap_1 sal_agro,sal_cap_2 sal_cc,sal_cap_4 sal_ec,sal_cap_5 sal_icp,sal_cap_6 sal_pdm,
	--sal_cap_3 sal_ce
	--from #report --drop table #report
	
END
