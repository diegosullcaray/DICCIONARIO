-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2021-08-10 08:52:58.960000
--  exec mod_rep.[com].[RSPROYCOLDES008] 2,'70542035' --TDTOG001
CREATE procedure [com].[RSPROYCOLDES008] 
 @tip_cod int, @cod_rel varchar(20), @fec varchar(8)='NOW'  
AS       
begin      
 set nocount on;   
 
 --declare @tip_cod int=7 , @cod_rel varchar(20)='231', @fec varchar(8)='NOW'    
 declare @cf as date

 if(@fec='NOW')          
 begin          
  select @cf=MAX(RFEC) FROM [storage].[ref].[RCALEN001]  where RDIAFER=0 AND RFEC < CONVERT (date, GETDATE())  --dateadd(day,-1,getdate())          
  end          
 else          
 begin          
  select @cf=@fec          
 end   
 

--declare  @fec date = '20210803',@tip_cod int = 7,@cod_rel varchar(20)='231'
       
 declare @defs as rep.TTHCOLDEF;  
  
 declare @head as table(ord int,color nvarchar(20),name nvarchar(200),cols int)      
 insert into @head values   
 (0,null,' ',3),   
 (1,null,'Tramo -30 a 0 ',2),
 (2,null,'Tramo 1 a 30',2)

 insert into @defs       
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)       
 select ord,1,'h1_'+CAST(ord as varchar(10)),name,cols,null,IIF(ord=0,1,0)      
 from @head    

 insert into @defs      
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values        
 (1,1,2,'dia_habil','Día','string',null,null,null,null), 
 (2,2,2,'fecha','Fecha','string',null,null,null,null),
 (3,3,2,'fecha_nombre','Fecha Nom','string',null,null,null,null),      
     
 (4,4,2,'proytramo1_nro_op','Nro Op','number','.0-0',null,null,null),    
 (5,5,2,'tot_proyecciones_monto1','Monto','number','.0-0',null,null,null),      
     
 (6,6,2,'proytramo2_nro_op','Nro Op','number','.0-0',null,null,null),          
 (7,7,2,'tot_proyecciones_monto2','Monto','number','.0-0',null,null,null)
 select rep.FFTHCOLDEF(@defs) result;     



set language spanish;  


declare @cant int =3, @num_doc varchar(50) -- @TIP_COD int =2, @cod_rel varchar (10)
select  top 1 @num_doc = HCODBT 
	 from  [storage].[gpr].[VPPH001]   
	 where  HNUMDOC=  @cod_rel

exec storage.[com_act].[RSRDM003]  @TIP_COD, @num_doc,@cant
	
	       
end
