-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-02-06 20:20:50.963000

CREATE PROCEDURE [com].[GMOVCLI01]
AS
BEGIN

	SET NOCOUNT ON;

	declare @headers varchar(max)='[{"label":"Concepto","key":"des","sticky": true},'
	;with a as (
	select distinct HFECPRO
	from storage.com.WBCLI02 
	),
	b as (
	select row_number() over(order by HFECPRO) R,HFECPRO F from a
	)
	select @headers+string_agg('{"label":"'+format(F,'dd-MMM-yyyy')+'","key":"col_'+cast(R as varchar)+'","type":"number"}',',')+']' hdefs
	from b

	create table #descs (gru int,cod varchar(50),des varchar(250),bold bit)
	insert into #descs
	values
	(1,'01','Stock Inicial',0),
	(1,'02','+ Clientes Nuevos 1/',0),
	(1,'03','+ Clientes Recapturados 2/',0),
	(1,'04','- Salida Clientes (Cancelaciones y Pre-Pagos) 3/',0),
	(1,'05','- Salida Clientes (Cancelaciones) ',0),
	(1,'06','- Salida Clientes (Pre-Pagos)',0),
	(1,'07','- Clientes Castigados',0),
	(1,'08','Stock Final',1),
	(1,'09','Variación Mes',0),
	(2,'01','Stock Inicial',1),
	(2,'02','+ Clientes Nuevos del mes 4/',0),
	(2,'03','- Salida Clientes',0),
	(2,'04','Stock Cierre',1),
	(2,'05','Clientes inactivos 5/',0),
	(2,'06','Clientes inactivos 6/',0),
	(2,'07','Clientes Pasivo Neto 7/',1),
	(2,'08','Variación Mes',0),
	(3,'01','Clientes del Activo Compartidos con Clientes del Pasivo',0),
	(3,'02','Clientes del Activo Compartidos con Clientes del Pasivo inactivos 8/',0),
	(3,'03','Clientes del Activo Compartidos con Clientes del Pasivo Neto 7/',1),
	(4,'01','Clientes Netos',1),
	(4,'02','Variación Mes',0),
	(6,'01','Clientes Mujeres Activo',0),
	(6,'02','Clientes Mujeres Pasivo',0),
	(6,'03','Clientes Mujeres Neto',0),
	(9,'01','Clientes Hombres',0),
	(9,'02','Clientes Mujeres',0),
	(9,'03','Clientes Personas Jurídicas',0),
	(9,'04','Total Clientes',0),
	(10,'01','Clientes Hombres',0),
	(10,'02','Clientes Mujeres',0),
	(10,'03','Clientes Personas Jurídicas',0),
	(10,'04','Total Clientes',0),
	(11,'01','Clientes Rurales',0),
	(11,'02','Clientes No Rurales',0),
	(12,'03','Total Clientes',0)


	;with a as (
	select dense_rank() over(order by HFECPRO) HROW,*
	from storage.com.WBCLI02
	),
	b as (
	select HROW,HIDSEC,HCODCON,HVALCON from a
	),
	c as (
	select HIDSEC gru,HCODCON cod,[1] col_1,[2] col_2,[3] col_3,[4] col_4,[5] col_5,[6] col_6
	from (select * from b) q
	pivot (max(HVALCON) for HROW in ([1],[2],[3],[4],[5],[6])) p
	),
	d as (
	select *
	from c 
	UNION
	select 1,'03.5',null,null,null,null,null,null
	UNION
	select 2,'04.5',null,null,null,null,null,null
	UNION
	select 2,'06.5',null,null,null,null,null,null
	)
	select A.gru,A.cod,isnull(B.des,C.RDESPROD) des,B.bold,A.col_1,A.col_2,A.col_3,A.col_4,A.col_5,A.col_6
	from d A
	left join #descs B
	on A.gru=B.gru and A.cod=B.cod
	left join storage.com_act.RETP003 C
	on format(C.RCODPROD,'000')=A.cod and A.gru in (7,8)
	order by 1,2

	
END
