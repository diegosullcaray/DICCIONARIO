-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2023-05-04 21:10:29.747000

--EXEC [mod_rep].[com].[RSPROYCOLDES003] '7','231'

 


CREATE procedure [com].[RSPROYCOLDES003]  
@tip_cod int,@cod_rel varchar(20) , @fec varchar(8)='NOW'     
AS         
begin        
 set nocount on;     
   
 -- declare @tip_cod int=7 , @cod_rel varchar(20)='231', @fec varchar(8)='20230503' --'NOW'      
 declare @cf as date,@cf1 as varchar (10)    
  
 if(@fec='NOW')            
 begin            
  select @cf=MAX(RFEC) FROM [storage].[ref].[RCALEN001]  where RDIAFER=0 AND RFEC < CONVERT (date, GETDATE())  --dateadd(day,-1,getdate())            
  end            
 else            
 begin            
  select @cf=@fec            
 end     
 select @cf1=@cf 
 
 
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
  
 declare @fecha_mostrar0 as date,@hora_mostrar0 as varchar (20)    
 select @fecha_mostrar0 = max(HFECREG), @hora_mostrar0 = max(HHORPRO) from storage.com_act.HBPDR002   where hfecpro = @cf 
 
   


 if(@hora_mostrar0 ='18')  
  Begin  
   select @hora_mostrar0 = ' - 18:00 pm' 
  End  
else if(@hora_mostrar0 = '13')  
  Begin  
   select @hora_mostrar = ' - 13:00 pm'  
  End  
else 
  Begin  
   select @hora_mostrar0 = ''--' - 06:00 am'  
  End 





  declare @defs as rep.TTHCOLDEF;    
  
  
 declare @head as table(ord int,color nvarchar(20),name nvarchar(200),cols int,background nvarchar(20))        
 insert into @head values     
 (0,null,concat ('Corte Proyec: ',@fecha_mostrar0,' ',@hora_mostrar0),4,null),  
 (1,null,concat ('Corte Desemb: ',@fecha_mostrar,' ',@hora_mostrar),2,null),
 (2,null,' ',7,null)
  
 insert into @defs         
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)         
 select ord,1,'h1_'+CAST(ord as varchar(10)),name,cols,background,IIF(ord=0,1,0)
 from @head        
  
  
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD,TSTBACKGROUND)  values        
 (1,1,2,'dia_habil','Día',null,2,1,'string',null,null),   
 (2,2,2,'fecha','Fecha',null,2,1,'string',null,null),   
 (3,3,2,'fecha_nombre','Fecha Nom',null,2,1,'string',null,null),   
       
 (4,4,2,'pros_nuevo_nro_op','Prospecto nuevo (Proyectado)',null,2,1,'number','.0-0',null),   
 (5,5,2,'pros_rec_nro_op','Prospecto recurrente  (Proyectado)',null,2,1,'number','.0-0','#e3bd42'),   
       
 --(6,6,2,'clixeval_nro_op','Clientes por evaluar  (Proyectado)',null,2,1,'number','.0-0','#e3bd42'),   
 --(7,7,2,'clieval_nro_op','Cliente evaluado  (Proyectado)',null,2,1,'number','.0-0','#1f8c26'),   
  
 (8,8,2,'list_com_nro_op','Listo para comité de créditos  (Proyectado)',null,2,1,'number','.0-0','#1f8c26'),   
 (9,9,2,'list_desemb_nro_op','Listo para desembolso  (Proyectado)',null,2,1,'number','.0-0','#1f8c26'),   
      
 (10,10,2,'tot_proyecciones','TOTAL DE PROYECCIONES',null,2,1,'number','.0-0','#1f8c26'),   
 (11,11,2,'meta','META',null,2,1,'number','.0-0',null),   
  
 (12,12,2,'desembolsado','DESEMBOLSADO',null,2,1,'number','.0-0',null),   
 (13,13,2,'esf_comercial','% Esfuerzo comercial Proyeccción/ Meta',null,2,1,'percent','.2-2',null),    
       
 (14,14,2,'efec_proyeccion','%Efectividad de proyec (Desembolsado/ Proyectado)',null,2,1,'percent','.2-2',null),  
 (15,15,2,'cumplimiento','% Cumplimiento de Meta ( Desembolsado/ Meta)',null,2,1,'percent','.2-2',null)  
  
  
 select rep.FFTHCOLDEF(@defs) result;       
  
  
set language spanish;    
  
  
declare @cant int =1  
exec [com].[RSRDM002]  @TIP_COD, @cod_rel,@cant  
  
END
