-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-08-18 08:24:57.880000

CREATE procedure [com].[RSPROYCOLDES006] 
 @tip_cod int, @cod_rel varchar(20), @fec varchar(8)='NOW'  
AS       
begin      
 set nocount on;   
	
	--declare @num_doc varchar(50)='43174685', @fec varchar(8)='NOW' 
   declare @cf as date,@cf1 as varchar (10)

 select @cf=dateadd(day,-1,getdate())             
 if(@fec='NOW')          
 begin          
  select @cf=MAX(RFEC) FROM [storage].[ref].[RCALEN001]  where RDIAFER=0 AND RFEC < CONVERT (date, GETDATE())  --dateadd(day,-1,getdate())    
  end          
 else          
 begin          
  select @cf=@fec          
 end   
 select @cf1=@cf 
       
 
 declare @fecha_mostrar as date,@hora_mostrar as varchar (5)  
 select @fecha_mostrar = hfecpro, @hora_mostrar = max(HHORPRO) from [storage].[com_act].[VCAH004]  where hfecpro = CONVERT (date, GETDATE())group by hfecpro

if(@fecha_mostrar is null) Begin select @fecha_mostrar = @cf End
if(@hora_mostrar = '17') Begin select @hora_mostrar = ' hora: 05:30 pm' End
if(@hora_mostrar = '14') Begin select @hora_mostrar = ' hora: 02:30 pm' End
if(@hora_mostrar = '10') Begin select @hora_mostrar = ' hora: 10:30 am' End


 declare @defs as rep.TTHCOLDEF;  


  declare @head as table(ord int,color nvarchar(20),name nvarchar(200),cols int)      
 insert into @head values   
 (0,null,concat ('Fecha: ',@fecha_mostrar,' ',@hora_mostrar),4),
 (1,null,' ',11)

 insert into @defs       
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)       
 select ord,1,'h1_'+CAST(ord as varchar(10)),name,cols,null,IIF(ord=0,1,0)      
 from @head      


 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values      
 (1,1,2,'dia_habil','Día',null,2,1,'string',null), 
 (2,2,2,'fecha','Fecha',null,2,1,'string',null), 
 (3,3,2,'fecha_nombre','Fecha Nom',null,2,1,'string',null), 
     
 (4,4,2,'pros_nuevo_nro_op','Prospecto nuevo (Proyectado)',null,2,1,'number','.0-0'), 
 (5,5,2,'pros_rec_nro_op','Prospecto recurrente  (Proyectado)',null,2,1,'number','.0-0'), 
     
 (6,6,2,'clixeval_nro_op','Clientes por evaluar  (Proyectado)',null,2,1,'number','.0-0'), 
 (7,7,2,'clieval_nro_op','Cliente evaluado  (Proyectado)',null,2,1,'number','.0-0'), 

 (8,8,2,'list_com_nro_op','Listo para comité de créditos  (Proyectado)',null,2,1,'number','.0-0'), 
 (9,9,2,'list_desemb_nro_op','Listo para desembolso  (Proyectado)',null,2,1,'number','.0-0'), 
    
 (10,10,2,'tot_proyecciones','TOTAL DE PROYECCIONES',null,2,1,'number','.0-0'), 
 (11,11,2,'meta','META',null,2,1,'number','.0-0'), 

 (12,12,2,'desembolsado','DESEMBOLSADO',null,2,1,'number','.0-0'), 
 (13,13,2,'esf_comercial','% Esfuerzo comercial Proyeccción/ Meta',null,2,1,'percent','.2-2'),  
     
 (14,14,2,'efec_proyeccion','%Efectividad de proyec (Desembolsado/ Proyectado)',null,2,1,'percent','.2-2'),
 (15,15,2,'cumplimiento','% Cumplimiento de Meta ( Desembolsado/ Meta)',null,2,1,'percent','.2-2')

  




 select rep.FFTHCOLDEF(@defs) result;     


set language spanish;  

declare @cant int =1, @num_doc varchar(50) -- @TIP_COD int =2, @cod_rel varchar (10)

select  top 1 @num_doc = HCODBT 
	 from  [storage].[gpr].[VPPH001]   
	 where  HNUMDOC=  @cod_rel

exec storage.[com_act].[RSRDM003]  @TIP_COD, @num_doc,@cant
	



END
