-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-06 20:34:27.153000
CREATE procedure [com].[RSPROYCOLDES002] 
@tip_cod int,@cod_rel varchar(20), @fec varchar(8)='NOW'      
   
AS         
begin        
 set nocount on;    
   
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
         
 declare @defs as rep.TTHCOLDEF;    
    
 declare @head as table(ord int,color nvarchar(20),name nvarchar(200),cols int)        
 insert into @head values     
 (0,null,' ',null),     
 (1,null,'Tramo -30 a 0 ',2),  
 (2,null,'Tramo 1 a 30',2)  
  
  insert into @defs         
 (TORDER,TLEV,TKEY,TDESC,TCOLS,TSTBACKGROUND,TSTICKY)         
 select ord,1,'h1_'+CAST(ord as varchar(10)),name,cols,null,IIF(ord=0,1,0)        
 from @head        
    
  
 insert into @defs        
 (TORDER,TISDATA,TLEV,TKEY,TDESC,TCOLS,TROWS,TSTICKY,TFORTYP,TFORMOD)  values        
 (1,1,4,'descripcion','Descripción',null,2,1,'string',null),    
       
 (2,2,4,'proytramo1_nro_op','Nro Op',null,2,null,'number','.0-0'),        
 (3,3,4,'tot_proyecciones_monto1','Monto',null,2,null,'number','.0-0'),    
       
 (4,4,4,'proytramo2_nro_op','Nro Op',null,2,null,'number','.0-0'),        
 (5,5,4,'tot_proyecciones_monto2','Monto',null,2,null,'number','.0-0')  
  
  select rep.FFTHCOLDEF(@defs) result;      
   
    
 --declare @tip_cod int=7 , @cod_rel varchar(20)='231', @cf1 varchar(10)='2021-08-04'  
 --declare @tip_cod int=11 , @cod_rel varchar(20)='TSBEG002', @cf1 varchar(10)='2021-08-04'  
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
		select @select_campo1 ='RCODUNI', @select_campo2 ='RDESUNI',@select_campo3 ='RCODSEC',@select_campo4 ='RDESSEC',
		@where_campo1 ='RCODUNI', @grouping1='RCODUNI', @grouping2='RCODSEC'
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
  
 SUM(case when  HIDTRAM=1 then tot_proyecciones_rec else null end) proytramo1_nro_op,      
 SUM(case when  HIDTRAM=1 then  tot_proyecciones_monto_rec else 0 end) tot_proyecciones_monto1,  
  
 SUM(case when  HIDTRAM=2 then tot_proyecciones_rec else null end) proytramo2_nro_op,      
 SUM(case when  HIDTRAM=2 then tot_proyecciones_monto_rec else 0 end) tot_proyecciones_monto2  
  
 from STORAGE.com_act.WPROYDES001 B  
 left join (values(7,''FINANCIERA CONFIANZA'')) _FC(RCODEMP,RDESEMP) on B.HFECPRO=B.HFECPRO  
 LEFT JOIN storage.[ref].WJERCOR03 C  
 on B.HASESOR =  C.RCODSEC and B.HFECPRO=C.RFECPRO 
 where  b.hfecreg = '''+@cf1+''' and HTIPPRO = ''R'' and '+@where_campo1+'  '+@where_campo2+'  
     
 group by grouping sets((isnull('+@grouping1+',''9999'')),(isnull('+@grouping1+',''9999''),isnull('+@grouping2+',''9999'')))  
 )  
  
  
 select row_number() over(order by id_prin,id_sec) fila,  
   id_prin,id_sec,  
   case when id_sec is not null then 0 when id_prin is not null then 1 end style,  
   case when id_sec is not null then desc_sec  when id_prin is not null then desc_prin  end descripcion,  
   proytramo1_nro_op,tot_proyecciones_monto1,  proytramo2_nro_op, tot_proyecciones_monto2  
   from datos   '  
  
 --print @sql  
  
 exec (@sql)  
          
      
end
