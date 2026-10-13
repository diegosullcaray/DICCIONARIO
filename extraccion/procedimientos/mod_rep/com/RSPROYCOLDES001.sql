-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2024-07-10 11:26:53.307000
 
--  exec [com].[RSPROYCOLDES001] 7,'231'
--drop proc [com].[RSPROYCOLDES001] 
CREATE procedure [com].[RSPROYCOLDES001] 
@tip_cod int,@cod_rel varchar(20), @fec varchar(8)='NOW'  
AS       
begin      
 set nocount on;  
 
  
declare @cf as date,@cf1 as varchar (10)  
declare @fecha_mostrar as date,@hora_mostrar as varchar (20) 
IF OBJECT_ID('storage.[com_act].[VCAH004]' , 'V') IS NOT NULL
		begin  
		  select @fecha_mostrar = hfecpro, @hora_mostrar = max(HHORPRO) from [storage].[com_act].[VCAH004]  where hfecpro = CONVERT (date, GETDATE())group by hfecpro  
		end

 if(@fecha_mostrar is null)  
  Begin  
   select @fecha_mostrar = @cf  
  End  
if(@hora_mostrar = '17')  
  Begin  
   select @hora_mostrar = ' - 05:30 pm'  
  End  
if(@hora_mostrar = '14')  
  Begin  
   select @hora_mostrar = ' - 02:30 pm'  
  End  
if(@hora_mostrar = '10')  
  Begin  
   select @hora_mostrar = ' - 10:30 am'  
  End  
  
  --declare  @cf1 as varchar (10)  
declare @fecha_mostrar0 as date,@hora_mostrar0 as varchar (20)    
 select @fecha_mostrar0 = max(HFECREG), @hora_mostrar0 = max(HHORPRO) from storage.com_act.HBPDR002   where hfecpro = (select max(hfecpro) from storage.com_act.HBPDR002) 

 if(@hora_mostrar0 ='18')  
  Begin  
   select @hora_mostrar0 = ' - 18:00 pm' 
  End 
ELSE if(@hora_mostrar0 = '13')  
  Begin  
   select @hora_mostrar0 = ' - 13:00 pm'  
  End  
else 
  Begin  
   select @hora_mostrar0 = ''--' - 06:00 am'  
  End 


 SELECT @cf1=MAX(hfecreg) FROM storage.com_act.WPROYDES001
 
       
 declare @defs as rep.TTHCOLDEF;  

 declare @head1 as table(ord int,color nvarchar(20),name nvarchar(200),cols int,background nvarchar(20))        
 insert into @head1 values     
 (0,null,concat ('Corte Proyección: ',@cf1,' ',@hora_mostrar0),3,null),  
 (1,null,concat ('Corte Desemb: ',@fecha_mostrar,' ',@hora_mostrar),2,null),
 (2,null,' ',6,null) 
 
 declare @head as table(ord int,color nvarchar(20),name nvarchar(200),cols int,background nvarchar(20) )      
 insert into @head values   
 (0,null,'Tipo Evento',null,null),   
 (1,null,'Prospecto nuevo (Proyectado)',2,null),
 (2,null,'Prospecto recurrente  (Proyectado)',2,'#e3bd42'),
 --(3,null,'Clientes por evaluar  (Proyectado)',2,'#e3bd42'),
 --(4,null,'Cliente evaluado  (Proyectado)',2,'#1f8c26'),
 (5,null,'Listo para comité de créditos  (Proyectado)',2,'#1f8c26'),
 (6,null,'Listo para desembolso  (Proyectado)',2,'#1f8c26'),
 (7,null,'TOTAL DE PROYECCIONES',2,'#1f8c26')

      
 insert into @defs       
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)     
 select ord,1,'h1_'+CAST(ord as varchar(10)),name,cols,background,IIF(ord=0,1,0)      
 from @head1
 union
 select ord,2,'h2_'+CAST(ord as varchar(10)),name,cols,background,IIF(ord=0,1,0)      
 from @head      
  
 --select * from  #goal      
  --select * from @defs order by TLEV,TORDER      
  
 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTBACKGROUND)  values      
 (1,1,3,'descripcion','Descripción',null,1,1,'string',null,null),  
     
 (2,2,3,'pros_nuevo_nro_cli','Nro Clientes',null,2,null,'number','.0-0',null),      
 (3,3,3,'pros_nuevo_monto','Monto',null,2,null,'number','.0-0',null),  
     
 (4,4,3,'pros_rec_nro_cli','Nro Clientes',null,2,null,'number','.0-0','#e3bd42'),      
 (5,5,3,'pros_rec_monto','Monto',null,2,null,'number','.0-0','#e3bd42'), 
 
 --(6,6,3,'clixeval_nro_op','Nro Op',null,2,null,'number','.0-0','#e3bd42'), 
 --(7,7,3,'clixeval_monto','Monto',null,2,null,'number','.0-0','#e3bd42'), 

 --(8,8,3,'clieval_nro_op','Nro Op',null,2,null,'number','.0-0','#1f8c26'), 
 --(9,9,3,'clieval_monto','Monto',null,2,null,'number','.0-0','#1f8c26'), 

 (10,10,3,'list_com_nro_cli','Nro Clientes',null,2,null,'number','.0-0','#1f8c26'), 
 (11,11,3,'list_com_monto','Monto',null,2,null,'number','.0-0','#1f8c26'), 

 (12,12,3,'list_desemb_nro_cli','Nro Clientes',null,2,null,'number','.0-0','#1f8c26'), 
 (13,13,3,'list_desemb_monto','Monto',null,2,null,'number','.0-0','#1f8c26'), 

 (14,14,3,'tot_proyecciones','Nro Clientes',null,2,null,'number','.0-0','#1f8c26'),
 (15,15,3,'tot_proyecciones_monto','Monto',null,2,null,'number','.0-0','#1f8c26')

	 select rep.FFTHCOLDEF(@defs) result;    
 
	--declare @tip_cod int=7 , @cod_rel varchar(20)='231', @cf1 varchar(10)='2022-01-08'
	--declare @tip_cod int=18 , @cod_rel varchar(20)='65', @cf1 varchar(10)='2022-06-03'

	--declare @tip_cod int=17 , @cod_rel varchar(20)='1141', @cf1 varchar(10)='2024-07-09'
	declare @select_campo1 varchar(20), @select_campo2 varchar(20), @select_campo3 varchar(20), @select_campo4 varchar(20),
	@sql varchar(max),@where_campo1 varchar(20), @where_campo2 varchar(20), @grouping1 varchar(20), @grouping2 varchar(20), @where_HMONDESMN varchar(50)

	if(@tip_cod=7)
		Begin
		select @select_campo1 ='_FC.RCODEMP', @select_campo2 ='_FC.RDESEMP',@select_campo3 ='RCODGRU',@select_campo4 ='RDESGRU',
		@where_campo1 = '1', @grouping1='_FC.RCODEMP', @grouping2='RCODGRU'
		End
	else if (@tip_cod=21)
		Begin
		select @select_campo1 ='RCODGRU', @select_campo2 ='RDESGRU',@select_campo3 ='RCODTER',@select_campo4 ='RDESTER',
		@where_campo1 = 'RCODGRU', @grouping1='RCODGRU', @grouping2='RCODTER'
		End
	else if (@tip_cod=20)
		Begin 
		select @select_campo1 ='RCODTER', @select_campo2 ='RDESTER',@select_campo3 ='RCODCOR',@select_campo4 ='RDESCOR',
		@where_campo1 = 'RCODTER', @grouping1='RCODTER', @grouping2='RCODCOR'
		End
	else if (@tip_cod=19)
		Begin
		select @select_campo1 ='RCODCOR', @select_campo2 ='RDESCOR',@select_campo3 ='RCODUNI',@select_campo4 ='RDESUNI',
		@where_campo1 = 'RCODCOR', @grouping1='RCODCOR', @grouping2='RCODUNI'
		End
	else if (@tip_cod=18)
		Begin
		select @select_campo1 ='RCODUNI', @select_campo2 ='RDESUNI',@select_campo3 ='RCODUCO',@select_campo4 ='RDESUCO',
		@where_campo1 ='RCODUNI', @grouping1='RCODUNI', @grouping2='RCODUCO'
		End
    else if (@tip_cod=17)    
		Begin    
		select @select_campo1 ='RCODUCO', @select_campo2 ='RDESUCO',@select_campo3 ='RCODSEC',@select_campo4 ='RDESSEC',    
		@where_campo1 ='RCODUCO', @grouping1='RCODUCO', @grouping2='RCODSEC'    
		End     
		

		set @where_campo2 = 
	case when @tip_cod=7 then '=1' else 
	case when @cod_rel = '9999' then 'is null' else '='''+@cod_rel+'''' end
	end

   set @sql = '
	;with datos as ( 
	select 
	isnull('+@select_campo1+',''9999'') id_prin ,max(isnull('+@select_campo2+',''SIN ASIGNAR'')) desc_prin,
	isnull('+@select_campo3+',''9999'') id_sec ,max(isnull('+@select_campo4+',''SIN ASIGNAR'')) desc_sec,
	SUM(pros_nuevo_nro_op) pros_nuevo_nro_cli, SUM(pros_nuevo_nro_op) pros_nuevo_nro_op, SUM(pros_nuevo_monto)pros_nuevo_monto,
	SUM(pros_rec_nro_op) pros_rec_nro_cli, SUM(pros_rec_nro_op) pros_rec_nro_op, SUM(pros_rec_monto) pros_rec_monto,
	SUM(clixeval_nro_op) clixeval_nro_cli, SUM(clixeval_nro_op) clixeval_nro_op, SUM(clixeval_monto) clixeval_monto,
	SUM(clieval_nro_op) clieval_nro_cli, SUM(clieval_nro_op) clieval_nro_op, SUM(clieval_monto) clieval_monto,
	SUM(list_com_nro_op) list_com_nro_cli, SUM(list_com_nro_op) list_com_nro_op, SUM(list_com_monto) list_com_monto,
	SUM(list_desemb_nro_op) list_desemb_nro_cli, SUM(list_desemb_nro_op) list_desemb_nro_op, SUM(list_desemb_monto) list_desemb_monto,
	SUM(tot_proyecciones) tot_proyecciones,  SUM(tot_proyecciones_monto) tot_proyecciones_monto

	from STORAGE.com_act.WPROYDES001 B
	left join (values(7,''FINANCIERA CONFIANZA'')) _FC(RCODEMP,RDESEMP) on B.HFECPRO=B.HFECPRO
	LEFT JOIN storage.[ref].WJERCOR03 C
	on B.HASESOR =  C.RCODSEC and B.HFECPRO=C.RFECPRO 
	where b.hfecreg = '''+@cf1+''' and HTIPPRO = ''C'' and '+@where_campo1+'  '+@where_campo2+'
	  
	group by grouping sets((isnull('+@grouping1+',''9999'')),(isnull('+@grouping1+',''9999''),isnull('+@grouping2+',''9999'')))
	)


	select row_number() over(order by id_prin,id_sec) fila,
			id_prin,id_sec,
			case when id_sec is not null then 0 when id_prin is not null then 1 end style,
			case when id_sec is not null then desc_sec  when id_prin is not null then desc_prin  end descripcion,
			pros_nuevo_nro_cli, pros_nuevo_nro_op,pros_nuevo_monto,	   pros_rec_nro_cli,pros_rec_nro_op, pros_rec_monto,  
			clixeval_nro_cli, clixeval_nro_op, clixeval_monto,   clieval_nro_cli, clieval_nro_op, clieval_monto,  
			list_com_nro_cli, list_com_nro_op,list_com_monto,    list_desemb_nro_cli, list_desemb_nro_op, list_desemb_monto,
			tot_proyecciones,tot_proyecciones_monto
			from datos   '

	 print @sql

	exec (@sql)
        
    
end
