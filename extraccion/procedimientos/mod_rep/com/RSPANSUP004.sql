-- Extraído de mish/mod_rep el 2026-10-13 con herramientas/bd.py · modificado en la base: 2022-06-14 18:59:15.220000


CREATE procedure [com].[RSPANSUP004]         
@tip_cod int,@cod_rel varchar(20),@cant varchar(2)='1'  --,@pagen int=1   
  
AS         
begin        
 set nocount on;          
 declare @defs as rep.TTHCOLDEF; 
 
--declare @tip_cod int=11 , @cod_rel varchar(250)='TACOL001', @cant varchar='1'  
--declare @tip_cod int=7 , @cod_rel varchar(250)='231', @cant varchar='1'    
  
  insert into @defs 
	(TORDER,TISDATA,TLEV,TKEY,TDESC,TFORTYP,TFORMOD,THIDDEN,TSTBACKGROUND,TSTDEWIDTH)  values          
    (1,1,1,'descripcion','Descripción','string',null,null,null,null),        
	(2,2,1,'num_ope','Total Desembolsos','number',null,null,null,null),   
	(3,3,1,'pendientes','Pendientes Supervisión','number',null,null,null,null),     
    (4,4,1,'num_ope_pre','Pre Desembolso','number',null,null,null,null),     
    (5,5,1,'num_ope_post','Post Desembolso','number',null,null,null,null)  
  
  select rep.FFTHCOLDEF(@defs) result;      
  
 
 --declare @tip_cod int=7 , @cod_rel varchar(20)='231', @cant varchar='1'  
 --declare @tip_cod int=11 , @cod_rel varchar(20)='TEDEM001', @cant varchar='2'  
 declare @select_campo1 varchar(20), @select_campo2 varchar(20), @select_campo3 varchar(20), @select_campo4 varchar(20),  
 @sql varchar(max),@where_campo1 varchar(20), @where_campo2 varchar(20), @grouping1 varchar(20), @grouping2 varchar(20), @where_HMONDESMN varchar(50), @where_CLINUE varchar(50)  
  
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
  
 if(@cant=1)  
  Begin select @where_HMONDESMN = 'HMONDESMN >=50000', @where_CLINUE = ',count (B.HCODOPE)-sum(supervisado) pendientes '  End  
 else  
  Begin select @where_HMONDESMN = 'HMONDESMN >= 30000 and HMONDESMN < 50000', @where_CLINUE = ',sum(pendiente30) pendientes'   End  
  
 set @sql = '  
 ;with datos as (   
 select   
 isnull('+@select_campo1+',''9999'') id_prin ,max(isnull('+@select_campo2+',''SIN ASIGNAR'')) desc_prin,  
 isnull('+@select_campo3+',''9999'') id_sec ,max(isnull('+@select_campo4+',''SIN ASIGNAR'')) desc_sec,  
  
 count (B.HCODOPE) num_ope,  
 sum(supervisado) supervisado,  
 sum(OPEPRE) num_ope_pre,  
 sum(OPEPOST) num_ope_post  
 '+@where_CLINUE+'   
 from storage.com_act.WSUPDESEM001 B  
 left join (values(7,''FINANCIERA CONFIANZA'')) _FC(RCODEMP,RDESEMP) on B.HFECPRO=B.HFECPRO  
 LEFT JOIN storage.[ref].WJERCOR03 C  
 on B.HCODSEC =  C.RCODSEC and B.HFECPRO=C.RFECPRO and RINDFEC=''ACTUAL''   
 where '+@where_campo1+'  '+@where_campo2+'  
 and  '+@where_HMONDESMN+'    
     
 group by grouping sets((isnull('+@grouping1+',''9999'')),(isnull('+@grouping1+',''9999''),isnull('+@grouping2+',''9999'')))  
 )  
  
  
 select row_number() over(order by id_prin,id_sec) fila,  
   id_prin,id_sec,  
   case when id_sec is not null then 0 when id_prin is not null then 1 end style,  
   case when id_sec is not null then desc_sec  when id_prin is not null then desc_prin  end descripcion,  
   num_ope, supervisado, pendientes, num_ope_pre,num_ope_post from datos     
  
 '  
  
 --print @sql  
 exec (@sql)  
          
      
end
