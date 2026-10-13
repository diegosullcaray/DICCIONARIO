-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-08-09 10:31:13.413000

CREATE procedure [com].[RSPROYCOLDES007] 
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
 
      
 declare @defs as rep.TTHCOLDEF;  

 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values  
 
 
 
 (1,1,1,'dia_habil','Día','string',null,null,null,null), 
 (2,2,1,'fecha','Fecha','string',null,null,null,null),
 (3,3,1,'fecha_nombre','Fecha Nom','string',null,null,null,null),      
     
 (4,4,1,'pros_nuevo_nro_op','Prospecto nuevo (Proyectado)','number','.0-0',null,null,null), 
 (5,5,1,'pros_rec_nro_op','Prospecto recurrente  (Proyectado)','number','.0-0',null,null,null), 
     
 (6,6,1,'clixeval_nro_op','Clientes por evaluar  (Proyectado)','number','.0-0',null,null,null), 
 (7,7,1,'clieval_nro_op','Cliente evaluado  (Proyectado)','number','.0-0',null,null,null), 

 (8,8,1,'list_com_nro_op','Listo para comité de créditos  (Proyectado)','number','.0-0',null,null,null), 
 (9,9,1,'list_desemb_nro_op','Listo para desembolso  (Proyectado)','number','.0-0',null,null,null), 
    
 (10,10,1,'tot_proyecciones','TOTAL DE PROYECCIONES','number','.0-0',null,null,null), 
 (11,11,1,'meta','META','number','.0-0',null,null,null), 

 (12,12,1,'desembolsado','DESEMBOLSADO','number','.0-0',null,null,null),      
 (13,13,1,'proyevsmeta','Proyectado vs meta %','percent','.2-2',null,null,null),  ---
     
 (14,14,1,'efec_proyeccion','%Efectividad de proyec (Desembolsado/ Proyectado)','percent','.2-2',null,null,null),     
 (15,15,1,'cumplimiento','% Cumplimiento de Meta ( Desembolsado/ Meta)','percent','.2-2',null,null,null)
 select rep.FFTHCOLDEF(@defs) result;     
 


set language spanish;  

declare @cant int =2, @num_doc varchar(50) 
select  top 1 @num_doc = HCODBT 
	 from  [storage].[gpr].[VPPH001]   
	 where  HNUMDOC=  @cod_rel

exec storage.[com_act].[RSRDM003]  @TIP_COD, @num_doc,@cant
	   

END
